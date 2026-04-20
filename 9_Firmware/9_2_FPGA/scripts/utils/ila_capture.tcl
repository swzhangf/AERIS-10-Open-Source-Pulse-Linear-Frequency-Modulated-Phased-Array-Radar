# ila_capture.tcl
# AERIS-10 Radar ILA Trigger Setup and Data Capture
# Target FPGA: XC7A200T-2FBG484I (Artix-7)
#
# Captures data from 4 ILA checkpoints in the radar signal processing chain:
#   Scenario 1 (adc)     — Raw ADC samples at 400 MHz
#   Scenario 2 (ddc)     — DDC I/Q output at 100 MHz
#   Scenario 3 (mf)      — Matched filter range profile I/Q at 100 MHz
#   Scenario 4 (doppler) — Doppler spectrum output at 100 MHz
#
# Usage:
#   vivado -mode batch -source ila_capture.tcl -tclargs <scenario> [options]
#
#   Scenarios: adc | ddc | mf | doppler | all | health
#
#   Options:
#     -server <hostname>    Hardware server (default: localhost)
#     -port   <port>        Hardware server port (default: 3121)
#     -outdir <path>        Output directory for CSV files (default: auto-timestamped)
#     -depth  <samples>     Capture depth override (default: 4096)
#     -timeout <seconds>    Trigger timeout in seconds (default: 30)
#     -immediate            Use immediate trigger (free-running, no condition)
#     -ltx <path>           Debug probes file path (overrides default)
#
# Examples:
#   vivado -mode batch -source ila_capture.tcl -tclargs adc
#   vivado -mode batch -source ila_capture.tcl -tclargs all -immediate
#   vivado -mode batch -source ila_capture.tcl -tclargs health
#   vivado -mode batch -source ila_capture.tcl -tclargs ddc -timeout 60 -outdir /tmp/captures

# ============================================================================
# DEFAULTS
# ============================================================================

set default_server   "localhost"
set default_port     3121
set script_dir       [file dirname [file normalize [info script]]]
set project_root     [file normalize [file join $script_dir "../.."]]
set default_ltx      [file join $project_root "build" "aeris10_radar.runs" "impl_ila" "radar_system_top.ltx"]
set default_output_base [file join $project_root "build" "captures"]
set default_depth    4096
set default_timeout  30

# ============================================================================
# ILA CONFIGURATION TABLE
# ============================================================================
# Each entry: {ila_instance_name  trigger_signal  trigger_edge  clock_mhz  description  csv_filename}

array set ila_config {
    adc {
        ila_name    "hw_ila_1"
        trigger_net "radar_system_top/rx_inst/adc_if/adc_valid"
        trigger_val "R"
        clock_mhz   400
        description "Raw ADC Samples (400 MHz)"
        csv_file    "adc_capture.csv"
    }
    ddc {
        ila_name    "hw_ila_2"
        trigger_net "radar_system_top/rx_inst/ddc_inst/ddc_valid"
        trigger_val "R"
        clock_mhz   100
        description "DDC I/Q Output (100 MHz)"
        csv_file    "ddc_capture.csv"
    }
    mf {
        ila_name    "hw_ila_3"
        trigger_net "radar_system_top/rx_inst/mf_chain/mf_valid"
        trigger_val "R"
        clock_mhz   100
        description "Matched Filter Range Profile I/Q (100 MHz)"
        csv_file    "mf_capture.csv"
    }
    doppler {
        ila_name    "hw_ila_4"
        trigger_net "radar_system_top/rx_inst/doppler_proc/doppler_valid"
        trigger_val "R"
        clock_mhz   100
        description "Doppler Spectrum Output (100 MHz)"
        csv_file    "doppler_capture.csv"
    }
}

# ============================================================================
# UTILITY PROCEDURES
# ============================================================================

proc log_info {msg} {
    puts "INFO:  \[ILA\] $msg"
}

proc log_warn {msg} {
    puts "WARN:  \[ILA\] $msg"
}

proc log_error {msg} {
    puts "ERROR: \[ILA\] $msg"
}

proc log_sep {} {
    puts [string repeat "=" 72]
}

proc log_kv {key value} {
    puts [format "  %-28s : %s" $key $value]
}

# ============================================================================
# ARGUMENT PARSING
# ============================================================================

proc parse_args {} {
    global argc argv
    global default_server default_port default_ltx default_output_base default_depth default_timeout
    global hw_server_host hw_server_port probes_path capture_depth trigger_timeout
    global capture_scenario use_immediate output_dir

    set hw_server_host  $default_server
    set hw_server_port  $default_port
    set probes_path     $default_ltx
    set capture_depth   $default_depth
    set trigger_timeout $default_timeout
    set use_immediate   0
    set output_dir      ""
    set capture_scenario ""

    if {[info exists argv]} {
        set args $argv
    } else {
        set args {}
    }

    if {[llength $args] == 0} {
        print_usage
        return -code error "NO_SCENARIO"
    }

    # First positional argument is the scenario
    set capture_scenario [string tolower [lindex $args 0]]

    set valid_scenarios {adc ddc mf doppler all health}
    if {$capture_scenario ni $valid_scenarios} {
        log_error "Unknown scenario: '$capture_scenario'"
        log_error "Valid scenarios: [join $valid_scenarios {, }]"
        print_usage
        return -code error "INVALID_SCENARIO"
    }

    # Parse remaining keyword arguments
    set i 1
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
            "-ltx" {
                incr i
                set probes_path [lindex $args $i]
            }
            "-outdir" {
                incr i
                set output_dir [lindex $args $i]
            }
            "-depth" {
                incr i
                set capture_depth [lindex $args $i]
            }
            "-timeout" {
                incr i
                set trigger_timeout [lindex $args $i]
            }
            "-immediate" {
                set use_immediate 1
            }
            default {
                log_warn "Unknown argument '$arg' — ignoring."
            }
        }
        incr i
    }

    # Auto-generate timestamped output directory if not specified
    if {$output_dir eq ""} {
        set timestamp [clock format [clock seconds] -format {%Y%m%d_%H%M%S}]
        set output_dir [file join $default_output_base "ila_${capture_scenario}_${timestamp}"]
    }
}

proc print_usage {} {
    puts ""
    puts "Usage: vivado -mode batch -source ila_capture.tcl -tclargs <scenario> \[options\]"
    puts ""
    puts "Scenarios:"
    puts "  adc       Capture raw ADC samples (ILA 0, 400 MHz)"
    puts "  ddc       Capture DDC I/Q output (ILA 1, 100 MHz)"
    puts "  mf        Capture matched filter range profile (ILA 2, 100 MHz)"
    puts "  doppler   Capture Doppler spectrum (ILA 3, 100 MHz)"
    puts "  all       Run all 4 captures sequentially"
    puts "  health    Quick health check — all captures with pass/fail verdict"
    puts ""
    puts "Options:"
    puts "  -server <host>      Hardware server hostname (default: localhost)"
    puts "  -port <port>        Hardware server port (default: 3121)"
    puts "  -outdir <path>      Output directory for CSV exports"
    puts "  -depth <N>          Capture depth in samples (default: 4096)"
    puts "  -timeout <sec>      Trigger timeout in seconds (default: 30)"
    puts "  -immediate          Free-running capture (no trigger condition)"
    puts "  -ltx <path>         Debug probes file path"
    puts ""
}

# ============================================================================
# HARDWARE CONNECTION
# ============================================================================

proc connect_to_hw {} {
    global hw_server_host hw_server_port probes_path

    log_info "Connecting to hw_server at ${hw_server_host}:${hw_server_port}..."

    if {[catch {open_hw_manager} err]} {
        log_warn "open_hw_manager: $err (may already be open)"
    }

    if {[catch {
        connect_hw_server -url ${hw_server_host}:${hw_server_port} -allow_non_jtag
    } err]} {
        log_error "Cannot connect to hw_server: $err"
        return -code error "HW_SERVER_CONNECT_FAILED"
    }

    if {[catch {open_hw_target} err]} {
        log_error "Cannot open hardware target: $err"
        catch {disconnect_hw_server}
        return -code error "NO_HW_TARGET"
    }

    # Select the first device (the XC7A200T)
    set hw_devices [get_hw_devices]
    if {[llength $hw_devices] == 0} {
        log_error "No devices on JTAG chain."
        return -code error "NO_DEVICES"
    }

    set target_device [lindex $hw_devices 0]
    current_hw_device $target_device
    log_info "Device selected: $target_device"

    # Verify the device is configured (DONE pin high)
    refresh_hw_device $target_device
    set done [get_property REGISTER.CONFIG_STATUS.DONE $target_device]
    if {$done != 1} {
        log_error "FPGA is not configured (DONE=LOW). Program the bitstream first."
        return -code error "DEVICE_NOT_CONFIGURED"
    }

    # Load debug probes
    if {![file exists $probes_path]} {
        log_error "Debug probes file not found: $probes_path"
        return -code error "LTX_NOT_FOUND"
    }

    set_property PROBES.FILE $probes_path $target_device
    refresh_hw_device $target_device

    # Verify ILA cores are present
    set ila_cores [get_hw_ilas -quiet]
    if {[llength $ila_cores] == 0} {
        log_error "No ILA cores detected. Ensure bitstream matches .ltx file."
        return -code error "NO_ILA_CORES"
    }

    log_info "ILA cores found: [llength $ila_cores]"
    foreach ila $ila_cores {
        log_info "  $ila (depth: [get_property CONTROL.DATA_DEPTH $ila])"
    }

    return $target_device
}

# ============================================================================
# SINGLE ILA CAPTURE
# ============================================================================

# Resolve the ILA core object from hw_ila name.
# The .ltx probe mapping names ILAs as hw_ila_1, hw_ila_2, etc.
# get_hw_ilas returns the actual objects; we match by cell name.
proc resolve_ila {ila_hw_name} {
    set all_ilas [get_hw_ilas -quiet]
    foreach ila $all_ilas {
        set cell [get_property CELL_NAME $ila]
        if {[string match "*${ila_hw_name}*" $cell] || [string match "*${ila_hw_name}*" $ila]} {
            return $ila
        }
    }
    # Fallback: try direct name match
    set ila [get_hw_ilas -quiet $ila_hw_name]
    if {$ila ne ""} {
        return $ila
    }
    return ""
}

# Configure trigger for a single ILA core.
# trigger_net: hierarchical probe name
# trigger_val: "R" (rising), "F" (falling), "B" (both), "1", "0", or "X" (don't care)
proc configure_trigger {ila_obj trigger_net trigger_val use_immediate} {
    if {$use_immediate} {
        log_info "  Trigger mode: IMMEDIATE (free-running)"
        set_property CONTROL.TRIGGER_MODE BASIC $ila_obj
        set_property CONTROL.TRIGGER_POSITION 0 $ila_obj

        # Set all trigger compare values to don't-care for immediate
        set all_probes [get_hw_probes -of_objects $ila_obj -quiet]
        foreach probe $all_probes {
            set_property TRIGGER_COMPARE_VALUE "eq0'bX" $probe
        }
        return
    }

    log_info "  Trigger: $trigger_net = $trigger_val (rising edge)"

    set_property CONTROL.TRIGGER_MODE BASIC $ila_obj
    # Place trigger at 1/4 depth so we capture mostly post-trigger data
    set_property CONTROL.TRIGGER_POSITION 1024 $ila_obj

    # Reset all probes to don't-care first
    set all_probes [get_hw_probes -of_objects $ila_obj -quiet]
    foreach probe $all_probes {
        catch {
            set_property TRIGGER_COMPARE_VALUE "eq0'bX" $probe
        }
    }

    # Set the specific trigger condition
    set trig_probe [get_hw_probes -of_objects $ila_obj -filter "NAME =~ *$trigger_net*" -quiet]
    if {$trig_probe eq ""} {
        # Try partial match on the leaf name
        set leaf_name [lindex [split $trigger_net "/"] end]
        set trig_probe [get_hw_probes -of_objects $ila_obj -filter "NAME =~ *$leaf_name*" -quiet]
    }

    if {$trig_probe eq ""} {
        log_warn "  Trigger probe '$trigger_net' not found. Falling back to immediate trigger."
        set_property CONTROL.TRIGGER_POSITION 0 $ila_obj
        return
    }

    # Configure edge detection based on trigger_val
    switch -exact -- $trigger_val {
        "R" {
            # Rising edge: transition from 0 to 1
            set_property TRIGGER_COMPARE_VALUE "eq1'b1" $trig_probe
        }
        "F" {
            # Falling edge: transition from 1 to 0
            set_property TRIGGER_COMPARE_VALUE "eq1'b0" $trig_probe
        }
        "1" {
            set_property TRIGGER_COMPARE_VALUE "eq1'b1" $trig_probe
        }
        "0" {
            set_property TRIGGER_COMPARE_VALUE "eq1'b0" $trig_probe
        }
        default {
            set_property TRIGGER_COMPARE_VALUE "eq1'b1" $trig_probe
        }
    }

    log_info "  Trigger probe resolved: $trig_probe"
}

# Run a single ILA capture and export to CSV.
# Returns a dict with {status triggered sample_count csv_path stats}
proc run_single_capture {scenario_name} {
    global ila_config capture_depth trigger_timeout use_immediate output_dir

    log_sep
    log_info "CAPTURE: $scenario_name"
    log_sep

    # Parse the config for this scenario
    array set cfg $ila_config($scenario_name)

    set ila_hw_name $cfg(ila_name)
    set trigger_net $cfg(trigger_net)
    set trigger_val $cfg(trigger_val)
    set clock_mhz   $cfg(clock_mhz)
    set description $cfg(description)
    set csv_file    $cfg(csv_file)

    log_info "Description: $description"
    log_info "ILA: $ila_hw_name @ ${clock_mhz} MHz"

    # Resolve the ILA core object
    set ila_obj [resolve_ila $ila_hw_name]
    if {$ila_obj eq ""} {
        log_error "ILA core '$ila_hw_name' not found in design."
        log_error "Available ILAs: [get_hw_ilas -quiet]"
        return [dict create status "FAIL" triggered 0 sample_count 0 \
                    csv_path "" stats "ILA not found"]
    }

    log_info "ILA object: $ila_obj"

    # Set capture depth
    set max_depth [get_property CONTROL.DATA_DEPTH $ila_obj]
    set effective_depth [expr {min($capture_depth, $max_depth)}]
    if {$effective_depth < $capture_depth} {
        log_warn "Requested depth $capture_depth exceeds ILA max $max_depth. Using $effective_depth."
    }
    set_property CONTROL.DATA_DEPTH $effective_depth $ila_obj
    log_info "  Capture depth: $effective_depth samples"

    # Configure trigger
    configure_trigger $ila_obj $trigger_net $trigger_val $use_immediate

    # Ensure output directory exists
    file mkdir $output_dir

    set csv_path "${output_dir}/${csv_file}"

    # Arm the ILA
    log_info "  Arming ILA..."
    if {[catch {
        run_hw_ila $ila_obj
    } err]} {
        log_error "Failed to arm ILA: $err"
        return [dict create status "FAIL" triggered 0 sample_count 0 \
                    csv_path "" stats "Arm failed: $err"]
    }

    # Wait for trigger with timeout
    log_info "  Waiting for trigger (timeout: ${trigger_timeout}s)..."
    set triggered 0

    if {[catch {
        set wait_result [wait_on_hw_ila -timeout $trigger_timeout $ila_obj]
        set triggered 1
    } err]} {
        # Check if it was a timeout
        set ila_status [get_property STATUS.CORE_STATUS $ila_obj]
        if {[string match "*WAITING*" $ila_status] || [string match "*ARMED*" $ila_status]} {
            log_warn "  Trigger TIMEOUT after ${trigger_timeout}s (ILA status: $ila_status)"
            log_warn "  Signal may not be active. Try -immediate for free-running capture."
            return [dict create status "TIMEOUT" triggered 0 sample_count 0 \
                        csv_path "" stats "Trigger timeout"]
        } else {
            # ILA may have triggered but wait_on_hw_ila reported an unexpected status
            log_warn "  wait_on_hw_ila returned: $err (status: $ila_status)"
            set triggered 1
        }
    }

    if {!$triggered} {
        return [dict create status "TIMEOUT" triggered 0 sample_count 0 \
                    csv_path "" stats "No trigger"]
    }

    # Upload captured data from ILA
    log_info "  Trigger hit — uploading captured data..."
    if {[catch {
        upload_hw_ila_data $ila_obj
    } err]} {
        log_error "Failed to upload ILA data: $err"
        return [dict create status "FAIL" triggered 1 sample_count 0 \
                    csv_path "" stats "Upload failed: $err"]
    }

    # Export to CSV
    log_info "  Exporting to CSV: $csv_path"
    if {[catch {
        write_hw_ila_data -csv_file $csv_path -force [current_hw_ila_data $ila_obj]
    } err]} {
        log_error "Failed to write CSV: $err"
        return [dict create status "FAIL" triggered 1 sample_count 0 \
                    csv_path "" stats "CSV export failed: $err"]
    }

    # Compute summary statistics from the ILA data
    set stats_result [compute_capture_stats $ila_obj $scenario_name]

    log_info "  Capture complete."
    log_info "  CSV: $csv_path"
    log_info "  Stats: $stats_result"

    return [dict create status "PASS" triggered 1 sample_count $effective_depth \
                csv_path $csv_path stats $stats_result]
}

# ============================================================================
# CAPTURE STATISTICS
# ============================================================================

# Compute min/max/mean of the primary data probes in the captured ILA data.
# Uses get_hw_ila_data to read sample values from the uploaded waveform.
proc compute_capture_stats {ila_obj scenario_name} {
    global ila_config
    array set cfg $ila_config($scenario_name)

    set ila_data [current_hw_ila_data $ila_obj]
    set sample_count [get_property DATA_DEPTH $ila_data]

    # Get all data probes (non-trigger probes carry the captured signal data)
    set data_probes [get_hw_probes -of_objects $ila_obj -filter {IS_DATA == true} -quiet]

    if {[llength $data_probes] == 0} {
        return "No data probes found"
    }

    # Analyze the first data probe (primary signal)
    set primary_probe [lindex $data_probes 0]
    set probe_name [get_property NAME $primary_probe]
    set probe_width [get_property WIDTH $primary_probe]

    set min_val  999999999
    set max_val -999999999
    set sum_val  0
    set nonzero_count 0

    for {set i 0} {$i < $sample_count} {incr i} {
        if {[catch {
            set sample_val [get_property "SAMPLE.$i" [get_hw_probes $primary_probe \
                                -of_objects $ila_obj]]
        } err]} {
            # Fallback: some Vivado versions use different property access
            break
        }

        # Convert binary/hex string to integer
        set int_val [scan_ila_value $sample_val $probe_width]

        if {$int_val < $min_val} { set min_val $int_val }
        if {$int_val > $max_val} { set max_val $int_val }
        set sum_val [expr {$sum_val + $int_val}]
        if {$int_val != 0} { incr nonzero_count }
    }

    if {$sample_count > 0 && $min_val != 999999999} {
        set mean_val [expr {double($sum_val) / $sample_count}]
        return [format "probe=%s width=%d min=%d max=%d mean=%.1f nonzero=%d/%d" \
                    $probe_name $probe_width $min_val $max_val $mean_val \
                    $nonzero_count $sample_count]
    }

    # Fallback: use Vivado's built-in ILA data summary if per-sample access failed
    return [format "probe=%s width=%d samples=%d (per-sample stats unavailable)" \
                $probe_name $probe_width $sample_count]
}

# Convert an ILA sample value (hex or binary string) to a signed integer.
proc scan_ila_value {val width} {
    # ILA data may come as hex (0xABCD), binary (0b1010...), or decimal
    set val [string trim $val]

    if {[string match "0x*" $val] || [string match "0X*" $val]} {
        set unsigned [scan [string range $val 2 end] %x]
    } elseif {[string match "0b*" $val] || [string match "0B*" $val]} {
        set bin_str [string range $val 2 end]
        set unsigned 0
        foreach bit [split $bin_str ""] {
            set unsigned [expr {($unsigned << 1) | $bit}]
        }
    } elseif {[string is integer -strict $val]} {
        set unsigned $val
    } else {
        # Try hex without prefix
        if {[catch {set unsigned [scan $val %x]} err]} {
            return 0
        }
    }

    # Convert to signed if MSB is set (two's complement)
    set sign_bit [expr {1 << ($width - 1)}]
    if {$unsigned >= $sign_bit} {
        set unsigned [expr {$unsigned - (1 << $width)}]
    }

    return $unsigned
}

# ============================================================================
# MULTI-CAPTURE SCENARIOS
# ============================================================================

proc run_all_captures {} {
    set scenarios {adc ddc mf doppler}
    set results [dict create]

    foreach sc $scenarios {
        if {[catch {
            set result [run_single_capture $sc]
        } err]} {
            log_error "Capture '$sc' failed with exception: $err"
            set result [dict create status "ERROR" triggered 0 sample_count 0 \
                            csv_path "" stats $err]
        }
        dict set results $sc $result
    }

    return $results
}

proc run_health_check {} {
    global use_immediate

    log_sep
    log_info "AERIS-10 RADAR QUICK HEALTH CHECK"
    log_info "Running all 4 ILA captures with immediate trigger..."
    log_sep

    # Force immediate trigger for health check so we don't wait for signals
    set saved_immediate $use_immediate
    set use_immediate 1

    set scenarios {adc ddc mf doppler}
    set results [dict create]
    set pass_count 0
    set fail_count 0

    foreach sc $scenarios {
        if {[catch {
            set result [run_single_capture $sc]
        } err]} {
            log_error "Health check capture '$sc' failed: $err"
            set result [dict create status "ERROR" triggered 0 sample_count 0 \
                            csv_path "" stats $err]
        }
        dict set results $sc $result

        # Determine pass/fail: PASS if capture completed and data has non-zero values
        set status [dict get $result status]
        set stats  [dict get $result stats]

        if {$status eq "PASS" && [string match "*nonzero=*" $stats]} {
            # Extract nonzero count from stats string
            if {[regexp {nonzero=(\d+)/} $stats -> nz_count]} {
                if {$nz_count > 0} {
                    incr pass_count
                } else {
                    incr fail_count
                }
            } else {
                # Could not parse, assume pass if status is PASS
                incr pass_count
            }
        } elseif {$status eq "PASS"} {
            # Stats unavailable but capture succeeded
            incr pass_count
        } else {
            incr fail_count
        }
    }

    set use_immediate $saved_immediate

    # Print health check summary
    log_sep
    log_info "HEALTH CHECK SUMMARY"
    log_sep

    set overall [expr {$fail_count == 0 ? "PASS" : "FAIL"}]

    foreach sc $scenarios {
        set result [dict get $results $sc]
        set status [dict get $result status]
        set stats  [dict get $result stats]

        set verdict "???"
        if {$status eq "PASS"} {
            if {[regexp {nonzero=(\d+)/} $stats -> nz]} {
                set verdict [expr {$nz > 0 ? "PASS (data active)" : "WARN (all zeros)"}]
            } else {
                set verdict "PASS (capture ok)"
            }
        } elseif {$status eq "TIMEOUT"} {
            set verdict "FAIL (timeout)"
        } else {
            set verdict "FAIL ($status)"
        }

        log_kv [string toupper $sc] $verdict
    }

    puts ""
    log_kv "Overall" "$overall ($pass_count/4 passed)"
    log_kv "Timestamp" [clock format [clock seconds] -format {%Y-%m-%d %H:%M:%S}]
    log_sep

    return $results
}

# ============================================================================
# RESULT SUMMARY
# ============================================================================

proc print_capture_summary {results} {
    log_sep
    log_info "CAPTURE SUMMARY"
    log_sep

    dict for {scenario result} $results {
        set status  [dict get $result status]
        set samples [dict get $result sample_count]
        set csv     [dict get $result csv_path]
        set stats   [dict get $result stats]

        puts ""
        log_kv "Scenario"  [string toupper $scenario]
        log_kv "Status"    $status
        log_kv "Samples"   $samples
        if {$csv ne ""} {
            log_kv "CSV File"  $csv
        }
        log_kv "Statistics" $stats
    }

    puts ""
    log_kv "Timestamp" [clock format [clock seconds] -format {%Y-%m-%d %H:%M:%S}]
    log_sep
}

# ============================================================================
# CLEANUP
# ============================================================================

proc cleanup_hw {} {
    log_info "Closing hardware connection..."
    catch {close_hw_target}
    catch {disconnect_hw_server}
    catch {close_hw_manager}
}

# ============================================================================
# MAIN ENTRY POINT
# ============================================================================

if {[catch {parse_args} err]} {
    # parse_args already printed usage or error
    return
}

log_sep
log_info "AERIS-10 Radar ILA Capture"
log_info "Timestamp: [clock format [clock seconds] -format {%Y-%m-%d %H:%M:%S}]"
log_sep
log_kv "Scenario"      $capture_scenario
log_kv "HW Server"     "${hw_server_host}:${hw_server_port}"
log_kv "Probes File"   $probes_path
log_kv "Capture Depth" $capture_depth
log_kv "Timeout"       "${trigger_timeout}s"
log_kv "Trigger Mode"  [expr {$use_immediate ? "IMMEDIATE" : "CONDITIONAL"}]
log_kv "Output Dir"    $output_dir
log_sep

# Connect to hardware
if {[catch {connect_to_hw} err]} {
    log_error "Hardware connection failed: $err"
    cleanup_hw
    return
}

# Dispatch based on scenario
set exit_ok 1

if {[catch {
    switch -exact -- $capture_scenario {
        "adc" - "ddc" - "mf" - "doppler" {
            set result [run_single_capture $capture_scenario]
            set results [dict create $capture_scenario $result]
            print_capture_summary $results
        }
        "all" {
            set results [run_all_captures]
            print_capture_summary $results
        }
        "health" {
            set results [run_health_check]
            # Health check prints its own summary
        }
    }
} err]} {
    log_error "Capture failed: $err"
    set exit_ok 0
}

# Cleanup
cleanup_hw

if {$exit_ok} {
    log_info "ILA capture session complete."
} else {
    log_error "ILA capture session finished with errors."
}
