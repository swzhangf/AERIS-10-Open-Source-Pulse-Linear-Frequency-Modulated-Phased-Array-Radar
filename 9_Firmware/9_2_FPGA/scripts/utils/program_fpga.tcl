# program_fpga.tcl
# AERIS-10 Radar FPGA Bitstream Programming Flow
# Target FPGA: XC7A200T-2FBG484I (Artix-7)
#
# Programs the radar_system_top bitstream onto the target device via
# Vivado Hardware Manager and optionally loads ILA debug probes.
#
# Usage:
#   Interactive: source program_fpga.tcl
#   Batch:       vivado -mode batch -source program_fpga.tcl
#   With args:   vivado -mode batch -source program_fpga.tcl -tclargs \
#                    -server 192.168.1.50 -port 3121 -no_probes
#
# Arguments:
#   -server <hostname>   Hardware server hostname (default: localhost)
#   -port   <port>       Hardware server port     (default: 3121)
#   -bit    <path>       Bitstream file path      (overrides default)
#   -ltx    <path>       Debug probes file path   (overrides default)
#   -no_probes           Skip loading debug probes even if .ltx exists
#   -force               Program even if device ID doesn't match expected

# ============================================================================
# DEFAULTS
# ============================================================================

set default_server   "localhost"
set default_port     3121
set script_dir       [file dirname [file normalize [info script]]]
set project_root     [file normalize [file join $script_dir "../.."]]
set default_bit      [file join $project_root "build" "bitstream" "radar_system_top_build21.bit"]
set default_ltx      [file join $project_root "build" "aeris10_radar.runs" "impl_ila" "radar_system_top.ltx"]
set expected_part    "xc7a200t"
set expected_pkg     "fbg484"

# ============================================================================
# ARGUMENT PARSING
# ============================================================================

proc parse_args {} {
    global argc argv
    global default_server default_port default_bit default_ltx
    global hw_server_host hw_server_port bitstream_path probes_path
    global skip_probes force_program

    set hw_server_host $default_server
    set hw_server_port $default_port
    set bitstream_path $default_bit
    set probes_path    $default_ltx
    set skip_probes    0
    set force_program  0

    # In batch mode, argv comes from -tclargs; in interactive it may be empty
    if {[info exists argv]} {
        set args $argv
    } else {
        set args {}
    }

    set i 0
    while {$i < [llength $args]} {
        set arg [lindex $args $i]
        switch -exact -- $arg {
            "-server" {
                incr i
                set hw_server_host [lindex $args $i]
            }
            "-port" {
                incr i
                set hw_server_port [lindex $args $i]
            }
            "-bit" {
                incr i
                set bitstream_path [lindex $args $i]
            }
            "-ltx" {
                incr i
                set probes_path [lindex $args $i]
            }
            "-no_probes" {
                set skip_probes 1
            }
            "-force" {
                set force_program 1
            }
            default {
                puts "WARNING: Unknown argument '$arg' — ignoring."
            }
        }
        incr i
    }
}

# ============================================================================
# UTILITY PROCEDURES
# ============================================================================

proc log_info {msg} {
    puts "INFO:  \[AERIS-10\] $msg"
}

proc log_warn {msg} {
    puts "WARN:  \[AERIS-10\] $msg"
}

proc log_error {msg} {
    puts "ERROR: \[AERIS-10\] $msg"
}

proc log_sep {} {
    puts [string repeat "=" 72]
}

# Print a key-value pair aligned for the summary table
proc log_kv {key value} {
    puts [format "  %-28s : %s" $key $value]
}

# ============================================================================
# PROGRAMMING FLOW
# ============================================================================

proc program_fpga {} {
    global hw_server_host hw_server_port bitstream_path probes_path
    global skip_probes force_program expected_part expected_pkg

    set result "FAIL"
    set probes_loaded "N/A"
    set device_name "unknown"

    log_sep
    log_info "AERIS-10 Radar FPGA Programming Flow"
    log_info "Timestamp: [clock format [clock seconds] -format {%Y-%m-%d %H:%M:%S}]"
    log_sep

    # ------------------------------------------------------------------
    # Step 1: Validate bitstream file exists
    # ------------------------------------------------------------------
    log_info "Step 1/7: Validating bitstream file..."

    if {![file exists $bitstream_path]} {
        log_error "Bitstream not found: $bitstream_path"
        log_error "Ensure the build completed successfully and the file is accessible."
        return -code error "BITSTREAM_NOT_FOUND"
    }
    set bit_size [file size $bitstream_path]
    log_info "Bitstream: $bitstream_path ([expr {$bit_size / 1024}] KB)"

    # ------------------------------------------------------------------
    # Step 2: Open Hardware Manager
    # ------------------------------------------------------------------
    log_info "Step 2/7: Opening Vivado Hardware Manager..."

    if {[catch {open_hw_manager} err]} {
        # Hardware manager may already be open in interactive mode
        log_warn "open_hw_manager returned: $err (may already be open)"
    }

    # ------------------------------------------------------------------
    # Step 3: Connect to hardware server
    # ------------------------------------------------------------------
    log_info "Step 3/7: Connecting to hw_server at ${hw_server_host}:${hw_server_port}..."

    if {[catch {
        connect_hw_server -url ${hw_server_host}:${hw_server_port} -allow_non_jtag
    } err]} {
        log_error "Failed to connect to hardware server: $err"
        log_error "Troubleshooting:"
        log_error "  1. Ensure hw_server is running: hw_server -d"
        log_error "  2. Check that the JTAG cable is connected and powered"
        log_error "  3. Verify firewall allows port $hw_server_port"
        log_error "  4. For remote: vivado -mode batch -source program_fpga.tcl -tclargs -server <ip>"
        return -code error "HW_SERVER_CONNECT_FAILED"
    }
    log_info "Connected to hw_server."

    # ------------------------------------------------------------------
    # Step 4: Open JTAG target and auto-detect device
    # ------------------------------------------------------------------
    log_info "Step 4/7: Scanning JTAG chain for target device..."

    if {[catch {
        open_hw_target
    } err]} {
        log_error "Failed to open hardware target: $err"
        log_error "No JTAG targets found. Check cable and board power."
        catch {disconnect_hw_server}
        return -code error "NO_HW_TARGET"
    }

    # Enumerate devices on the chain
    set hw_devices [get_hw_devices]
    if {[llength $hw_devices] == 0} {
        log_error "No devices detected on JTAG chain."
        catch {close_hw_target}
        catch {disconnect_hw_server}
        return -code error "NO_DEVICES"
    }

    log_info "Devices on JTAG chain: $hw_devices"

    # ------------------------------------------------------------------
    # Step 5: Identify and verify the target XC7A200T
    # ------------------------------------------------------------------
    log_info "Step 5/7: Verifying target device is $expected_part..."

    set target_device ""
    foreach dev $hw_devices {
        set part_name [string tolower [get_property PART $dev]]
        log_info "  Found device: $dev (part: $part_name)"

        if {[string match "${expected_part}*" $part_name]} {
            set target_device $dev
            set device_name $part_name
            break
        }
    }

    if {$target_device eq ""} {
        if {$force_program} {
            log_warn "Expected $expected_part not found. -force specified, using first device."
            set target_device [lindex $hw_devices 0]
            set device_name [get_property PART $target_device]
        } else {
            log_error "Target device $expected_part not found on JTAG chain."
            log_error "Found devices: $hw_devices"
            log_error "Use -force to program a different device."
            catch {close_hw_target}
            catch {disconnect_hw_server}
            return -code error "DEVICE_MISMATCH"
        }
    }

    # Make this the current device
    current_hw_device $target_device
    log_info "Target device selected: $target_device ($device_name)"

    # ------------------------------------------------------------------
    # Step 6: Program the bitstream
    # ------------------------------------------------------------------
    log_info "Step 6/7: Programming bitstream..."

    # Set the programming file
    set_property PROGRAM.FILE $bitstream_path $target_device

    # If probes file exists and not skipped, associate it now so ILA cores
    # are recognized immediately after programming
    if {!$skip_probes && [file exists $probes_path]} {
        log_info "Associating debug probes: $probes_path"
        set_property PROBES.FILE $probes_path $target_device
    }

    # Execute programming
    if {[catch {
        program_hw_devices $target_device
    } err]} {
        log_error "Bitstream programming FAILED: $err"
        log_error "Possible causes:"
        log_error "  - Bitstream built for a different part/package"
        log_error "  - JTAG communication error (check cable)"
        log_error "  - Board power supply issue"
        log_error "  - Bitstream file corruption"
        catch {close_hw_target}
        catch {disconnect_hw_server}
        return -code error "PROGRAMMING_FAILED"
    }

    # ------------------------------------------------------------------
    # Step 7: Verify DONE pin
    # ------------------------------------------------------------------
    log_info "Step 7/7: Verifying DONE pin status..."

    # Refresh device status registers
    refresh_hw_device $target_device

    set done_status [get_property REGISTER.CONFIG_STATUS.DONE $target_device]
    set init_status [get_property REGISTER.CONFIG_STATUS.INIT_COMPLETE $target_device]

    if {$done_status == 1} {
        log_info "DONE pin is HIGH — device configured successfully."
        set result "PASS"
    } else {
        log_error "DONE pin is LOW — configuration may have failed."
        log_error "CONFIG_STATUS.INIT_COMPLETE: $init_status"
        set result "FAIL"
    }

    # ------------------------------------------------------------------
    # Optional: Load debug probes (ILA)
    # ------------------------------------------------------------------
    if {!$skip_probes && [file exists $probes_path]} {
        log_info "Loading ILA debug probes..."

        if {[catch {
            # Probes were already associated before programming.
            # Refresh to enumerate ILA cores.
            refresh_hw_device $target_device

            set ila_cores [get_hw_ilas -quiet]
            if {[llength $ila_cores] > 0} {
                log_info "ILA cores detected: [llength $ila_cores]"
                foreach ila $ila_cores {
                    set ila_name [get_property DESCRIPTION $ila]
                    set ila_depth [get_property CONTROL.DATA_DEPTH $ila]
                    log_info "  $ila : depth=$ila_depth"
                }
                set probes_loaded "YES ([llength $ila_cores] ILAs)"
            } else {
                log_warn "No ILA cores found in the design. Probes file may not match bitstream."
                set probes_loaded "NO (no ILA cores detected)"
            }
        } err]} {
            log_warn "Debug probe loading encountered an issue: $err"
            set probes_loaded "ERROR"
        }
    } elseif {$skip_probes} {
        set probes_loaded "SKIPPED (-no_probes)"
    } elseif {![file exists $probes_path]} {
        log_info "No .ltx probes file found at: $probes_path"
        set probes_loaded "NO (.ltx not found)"
    }

    # ------------------------------------------------------------------
    # Summary
    # ------------------------------------------------------------------
    log_sep
    log_info "PROGRAMMING SUMMARY"
    log_sep
    log_kv "Result"            $result
    log_kv "Target Device"     $device_name
    log_kv "Bitstream"         [file tail $bitstream_path]
    log_kv "Bitstream Size"    "[expr {[file size $bitstream_path] / 1024}] KB"
    log_kv "DONE Pin"          [expr {$done_status == 1 ? "HIGH (OK)" : "LOW (FAIL)"}]
    log_kv "INIT_COMPLETE"     $init_status
    log_kv "Debug Probes"      $probes_loaded
    log_kv "HW Server"         "${hw_server_host}:${hw_server_port}"
    log_kv "Timestamp"         [clock format [clock seconds] -format {%Y-%m-%d %H:%M:%S}]
    log_sep

    if {$result eq "FAIL"} {
        return -code error "PROGRAMMING_VERIFICATION_FAILED"
    }

    return $result
}

# ============================================================================
# MAIN ENTRY POINT
# ============================================================================

parse_args

log_info "Configuration:"
log_kv "HW Server"   "${hw_server_host}:${hw_server_port}"
log_kv "Bitstream"   $bitstream_path
log_kv "Probes"      [expr {$skip_probes ? "DISABLED" : $probes_path}]
log_kv "Force Mode"  [expr {$force_program ? "YES" : "NO"}]

if {[catch {program_fpga} err]} {
    log_error "Programming flow terminated with error: $err"
    # In batch mode, exit with non-zero status
    if {[string match "batch" [get_property MODE [current_hw_server -quiet]]]} {
        exit 1
    }
} else {
    log_info "Programming flow completed successfully."
}
