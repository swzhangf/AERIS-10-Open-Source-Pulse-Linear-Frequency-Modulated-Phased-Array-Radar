################################################################################
# insert_ila_probes.tcl
#
# AERIS-10 Radar FPGA — Post-Synthesis ILA Debug Core Insertion
# Target: XC7A200T-2FBG484I
# Design: radar_system_top (Build 16 frozen netlist)
#
# Usage:
#   vivado -mode batch -source insert_ila_probes.tcl
#
# This script:
#   1. Opens the post-synth DCP from Build 16
#   2. Inserts 4 ILA debug cores across 2 clock domains
#   3. Runs full implementation with Build 16 directives
#   4. Generates bitstream, reports, and .ltx probe file
#
# ILA 0: ADC Capture          — 400 MHz (rx_inst/adc/clk_400m) — up to 9 bits
# ILA 1: DDC Output           — 100 MHz                        — up to 37 bits
# ILA 2: Matched Filter Ctrl  — 100 MHz                        — 4 signals
# ILA 3: Doppler Output       — 100 MHz                        — up to 45 bits
#
# APPROACH: Uses get_nets with -hierarchical wildcards and get_nets -of
# [get_pins ...] to resolve post-synthesis net names. All probe connections
# are fault-tolerant — if a net cannot be found it is logged and skipped,
# rather than aborting the build.
#
# Author: auto-generated for Jason Stone
# Date:   2026-03-18
################################################################################

# ==============================================================================
# 0. Configuration — all paths and parameters in one place
# ==============================================================================

set script_dir     [file dirname [file normalize [info script]]]
set project_root   [file normalize [file join $script_dir "../.."]]
set project_base   [file join $project_root "build"]
set synth_dcp      "${project_base}/aeris10_radar.runs/synth_1/radar_system_top.dcp"
set synth_xdc      [file join $project_root "constraints" "xc7a200t_fbg484.xdc"]
set output_dir     "${project_base}/aeris10_radar.runs/impl_ila"
set top_module     "radar_system_top"
set part           "xc7a200tfbg484-2"

# Timestamp for output file naming
set timestamp      [clock format [clock seconds] -format {%Y%m%d_%H%M%S}]
set run_tag        "build16_ila_${timestamp}"

# ILA parameters
set ila_depth      4096
set trigger_pos    512     ;# 512 pre-trigger samples

# Global counter: total probes actually connected (for final summary)
set total_probes_connected 0

# ==============================================================================
# 1. Helper procedures — fault-tolerant net resolution
# ==============================================================================

# Try a sequence of strategies to find a single net. Returns the net object
# or empty string "" if nothing was found. Never errors out.
#
# Each element in $strategies is itself a list:
#   { method arg }
# where method is one of:
#   "net"   — try exact path first (get_nets -quiet $arg), then hierarchical
#   "pin"   — call  get_nets -quiet -of [get_pins -quiet $arg]
#
# Example:
#   find_net { {net rx_inst/adc/adc_valid} {net *adc_valid*} }
#
proc find_net {strategies} {
    foreach strategy $strategies {
        set method [lindex $strategy 0]
        set arg    [lindex $strategy 1]
        switch $method {
            "net" {
                # Try exact path first (works for fully-qualified hierarchical names)
                set result [get_nets -quiet $arg]
                # Fall back to hierarchical search (works for leaf names and wildcards)
                if {[llength $result] == 0} {
                    set result [get_nets -quiet -hierarchical $arg]
                }
            }
            "pin" {
                set pins [get_pins -quiet $arg]
                if {[llength $pins] == 0} {
                    # Also try hierarchical pin search
                    set pins [get_pins -quiet -hierarchical $arg]
                }
                if {[llength $pins] > 0} {
                    set result [get_nets -quiet -of $pins]
                } else {
                    set result {}
                }
            }
            default {
                set result {}
            }
        }
        if {[llength $result] > 0} {
            # Return the first matching net
            set chosen [lindex $result 0]
            puts "  INFO: Resolved '$arg' ($method) -> $chosen"
            return $chosen
        }
    }
    return ""
}

# Try a sequence of strategies to find a bus (vector) of nets.
# Returns a Tcl list of net objects. The list may be shorter than requested
# if some bits were optimised away.
#
# Each element in $strategies is { method pattern } where pattern may contain
# a literal '*' or a specific glob. The procedure evaluates ALL strategies
# as a batch and picks the first one that returns >= 1 net.
#
proc find_bus {strategies} {
    foreach strategy $strategies {
        set method [lindex $strategy 0]
        set arg    [lindex $strategy 1]
        switch $method {
            "net" {
                # Try exact path first (works for fully-qualified hierarchical paths)
                set result [get_nets -quiet $arg]
                # Fall back to hierarchical search (leaf names, wildcards)
                if {[llength $result] == 0} {
                    set result [get_nets -quiet -hierarchical $arg]
                }
            }
            "pin" {
                set pins [get_pins -quiet $arg]
                if {[llength $pins] == 0} {
                    # Also try hierarchical pin search
                    set pins [get_pins -quiet -hierarchical $arg]
                }
                if {[llength $pins] > 0} {
                    set result [get_nets -quiet -of $pins]
                } else {
                    set result {}
                }
            }
            default {
                set result {}
            }
        }
        if {[llength $result] > 0} {
            puts "  INFO: Bus resolved via '$arg' ($method) -> [llength $result] nets"
            return $result
        }
    }
    return {}
}

# Connect a list of nets to the next available probe port on an ILA core.
# If the net list is empty, logs a warning and returns the same probe index
# (no probe port is consumed).
#
# ila_name:    e.g. u_ila_0
# probe_index: current probe port index (0 for PROBE0, etc.)
# net_list:    Tcl list of net objects to connect
# label:       human-readable description for log messages
#
# Returns the next available probe index.
#
proc connect_probe {ila_name probe_index net_list label} {
    global total_probes_connected

    set width [llength $net_list]
    if {$width == 0} {
        puts "  WARNING: No nets found for '$label' — skipping probe${probe_index} on $ila_name"
        return $probe_index
    }

    puts "  INFO: Connecting $width nets to ${ila_name}/probe${probe_index} ($label)"

    if {$probe_index > 0} {
        create_debug_port $ila_name probe
    }

    set_property port_width $width [get_debug_ports ${ila_name}/probe${probe_index}]
    connect_debug_port ${ila_name}/probe${probe_index} $net_list

    incr total_probes_connected $width
    return [expr {$probe_index + 1}]
}

# Deferred ILA creation — create the debug core, set properties, connect clock,
# and wire up all resolved probes in one shot. If no probes resolved, the ILA
# is NOT created at all (avoids dangling probe0 error).
#
# ila_name:     e.g. u_ila_0
# clk_net:      clock net object
# probe_list:   list of {label net_list} pairs (pre-resolved)
# depth:        ILA sample depth
#
# Returns the number of probe ports actually connected.
#
proc create_ila_deferred {ila_name clk_net probe_list depth} {
    global total_probes_connected

    # Filter to only probes that have at least 1 net
    set valid_probes {}
    foreach probe_entry $probe_list {
        set label    [lindex $probe_entry 0]
        set net_list [lindex $probe_entry 1]
        if {[llength $net_list] > 0} {
            lappend valid_probes [list $label $net_list]
        } else {
            puts "  WARNING: No nets found for '$label' on $ila_name — skipping"
        }
    }

    if {[llength $valid_probes] == 0} {
        puts "  WARNING: ALL probes failed for $ila_name — ILA core NOT created (avoiding dangling probe0)"
        return 0
    }

    # Now create the debug core — we know we have at least 1 probe
    puts "  INFO: Creating $ila_name with [llength $valid_probes] probe(s)"
    create_debug_core $ila_name ila
    set_property ALL_PROBE_SAME_MU    true  [get_debug_cores $ila_name]
    set_property ALL_PROBE_SAME_MU_CNT 2    [get_debug_cores $ila_name]
    set_property C_ADV_TRIGGER        false [get_debug_cores $ila_name]
    set_property C_DATA_DEPTH         $depth [get_debug_cores $ila_name]
    set_property C_EN_STRG_QUAL       true  [get_debug_cores $ila_name]
    set_property C_INPUT_PIPE_STAGES  0     [get_debug_cores $ila_name]
    set_property C_TRIGIN_EN          false [get_debug_cores $ila_name]
    set_property C_TRIGOUT_EN         false [get_debug_cores $ila_name]

    # Connect the clock
    set_property port_width 1 [get_debug_ports ${ila_name}/clk]
    connect_debug_port ${ila_name}/clk [get_nets $clk_net]

    # Connect each resolved probe
    set probe_idx 0
    foreach probe_entry $valid_probes {
        set label    [lindex $probe_entry 0]
        set net_list [lindex $probe_entry 1]
        set probe_idx [connect_probe $ila_name $probe_idx $net_list $label]
    }

    return $probe_idx
}

# ==============================================================================
# 2. Open the synthesized checkpoint
# ==============================================================================

puts "======================================================================"
puts " AERIS-10 ILA Insertion — Starting at [clock format [clock seconds]]"
puts "======================================================================"

# Create output directory
file mkdir $output_dir

# Open the frozen Build 13 post-synth DCP
puts "\nINFO: Opening post-synth DCP: $synth_dcp"
open_checkpoint $synth_dcp

# Verify the part
set loaded_part [get_property PART [current_design]]
puts "INFO: Design part = $loaded_part"
if {$loaded_part ne $part} {
    puts "WARNING: Expected part '$part', got '$loaded_part'. Continuing anyway."
}

# Read the synthesis-only constraints (pin assignments, clocks, etc.)
puts "INFO: Reading XDC: $synth_xdc"
read_xdc $synth_xdc

# ==============================================================================
# 3. Resolve clock nets
# ==============================================================================

puts "\n--- Resolving clock nets ---"

# 400 MHz clock — inside ADC interface (confirmed resolved to rx_inst/clk_400m)
set clk_400m_net [find_net {
    {net  rx_inst/clk_400m}
    {net  rx_inst/adc/clk_400m}
    {net  *adc*/clk_400m}
    {net  *clk_400m*}
}]
if {$clk_400m_net eq ""} {
    error "FATAL: Cannot find 400 MHz clock net. Cannot insert ILA 0."
}
puts "INFO: 400 MHz clock net = $clk_400m_net"

# 100 MHz system clock
set clk_100m_net [find_net {
    {net  clk_100m_IBUF_BUFG}
    {net  clk_100m_buf}
    {net  clk_100m_BUFG}
    {net  *clk_100m*}
}]
if {$clk_100m_net eq ""} {
    error "FATAL: Cannot find 100 MHz clock net. Cannot insert ILA 1/2/3."
}
puts "INFO: 100 MHz clock net = $clk_100m_net"

# ==============================================================================
# 4. ILA 0 — ADC Capture (400 MHz domain)
#
# Monitors raw ADC data at the CMOS interface output.
# Probes: ADC data [7:0] + ADC valid = up to 9 bits.
# 4096 samples at 400 MHz => ~10.24 us capture window.
#
# Uses DEFERRED creation: probes are resolved first, ILA is only created
# if at least one probe has nets.  This avoids dangling probe0 errors.
# ==============================================================================

puts "\n====== ILA 0: ADC Capture (400 MHz) ======"

# Probe 0: ADC data [7:0]
# Post-synth register name is adc_data_400m_reg_reg (double "reg" from synthesis).
# Bit 7 is inverted: adc_data_400m_reg_reg[7]_inv.
# Use pin-based discovery which catches both normal and _inv variants.
set adc_data_nets [find_bus {
    {pin  rx_inst/adc/adc_data_400m_reg_reg[*]/Q}
    {net  rx_inst/adc/adc_data_400m_reg_reg[*]}
    {pin  rx_inst/adc/adc_data_400m_reg[*]/Q}
    {net  rx_inst/adc/A[*]}
    {pin  rx_inst/adc/adc_data_cmos_reg[*]/Q}
    {net  rx_inst/adc/adc_data_400m[*]}
    {net  rx_inst/adc/adc_data_cmos[*]}
}]

# Probe 1: ADC valid
# Net confirmed as rx_inst/adc/adc_valid
# Pin confirmed as rx_inst/adc/adc_data_valid_400m_reg_reg/Q (double "reg")
set adc_valid_net [find_net {
    {net  rx_inst/adc/adc_valid}
    {pin  rx_inst/adc/adc_data_valid_400m_reg_reg/Q}
    {pin  rx_inst/adc/adc_valid_reg/Q}
    {net  *adc/adc_valid*}
}]
if {$adc_valid_net ne ""} {
    set adc_valid_list [list $adc_valid_net]
} else {
    set adc_valid_list {}
}

# Deferred creation: only create ILA if at least 1 probe resolves
set ila0_probes [list \
    [list "ADC data"  $adc_data_nets] \
    [list "ADC valid" $adc_valid_list] \
]
set ila0_count [create_ila_deferred u_ila_0 $clk_400m_net $ila0_probes $ila_depth]
puts "INFO: ILA 0 — $ila0_count probe ports on 400 MHz clock"

# ==============================================================================
# 5. ILA 1 — DDC Output (100 MHz domain)
#
# Monitors the digital down-converter output after CIC+FIR decimation.
# Probes: DDC I [17:1] + DDC Q [17:1] + DDC valid = up to 35 bits.
# Bit 0 is optimized away in synthesis.
#
# Uses DEFERRED creation to avoid dangling probe0 errors.
# ==============================================================================

puts "\n====== ILA 1: DDC Output (100 MHz) ======"

# Probe 0: ddc_out_i — DDC I-channel baseband output
# Nets confirmed as rx_inst/ddc/ddc_out_i[1] through [17] (bit 0 optimized away)
# Use exact path WITHOUT -hierarchical, then fall back to pin-based and hierarchical
set ddc_i_nets [find_bus {
    {net  rx_inst/ddc/ddc_out_i[*]}
    {pin  rx_inst/ddc/ddc_out_i_reg[*]/Q}
    {net  *ddc/ddc_out_i[*]}
}]

# Probe 1: ddc_out_q — DDC Q-channel baseband output
# Nets confirmed as rx_inst/ddc/ddc_out_q[1] through [17] (bit 0 optimized away)
set ddc_q_nets [find_bus {
    {net  rx_inst/ddc/ddc_out_q[*]}
    {pin  rx_inst/ddc/ddc_out_q_reg[*]/Q}
    {net  *ddc/ddc_out_q[*]}
}]

# Probe 2: DDC output valid
# Confirmed nets: rx_inst/ddc_valid_q, rx_inst/ddc/baseband_valid_q
set ddc_valid_net [find_net {
    {net  rx_inst/ddc_valid_q}
    {net  rx_inst/ddc/baseband_valid_q}
    {net  rx_inst/ddc/fir_valid}
    {pin  rx_inst/ddc/baseband_valid_q_reg/Q}
    {net  *ddc*valid*}
}]
if {$ddc_valid_net ne ""} {
    set ddc_valid_list [list $ddc_valid_net]
} else {
    set ddc_valid_list {}
}

# Deferred creation: only create ILA if at least 1 probe resolves
set ila1_probes [list \
    [list "DDC I"     $ddc_i_nets] \
    [list "DDC Q"     $ddc_q_nets] \
    [list "DDC valid" $ddc_valid_list] \
]
set ila1_count [create_ila_deferred u_ila_1 $clk_100m_net $ila1_probes $ila_depth]
puts "INFO: ILA 1 — $ila1_count probe ports on 100 MHz clock"

# ==============================================================================
# 6. ILA 2 — Matched Filter Control (100 MHz domain)
#
# Reduced probe set: only control/status signals that are confirmed to exist
# in the post-synthesis netlist. Data nets (pc_i_w, pc_q_w) do NOT exist
# post-synth due to hierarchy flattening.
#
# Probes: range_profile_valid + mf_valid_out + segment_request[1:0] = 4 bits.
#
# Uses DEFERRED creation to avoid dangling probe0 errors.
# ==============================================================================

puts "\n====== ILA 2: Matched Filter Control (100 MHz) ======"

# Probe 0: range_profile_valid
# Confirmed nets: rx_inst/mf_dual/range_profile_valid,
#                 rx_inst/mf_dual/m_f_p_c/range_profile_valid,
#                 rx_inst/range_decim/range_profile_valid
set rpv_net [find_net {
    {net  rx_inst/mf_dual/range_profile_valid}
    {net  rx_inst/mf_dual/m_f_p_c/range_profile_valid}
    {net  rx_inst/range_decim/range_profile_valid}
    {pin  rx_inst/mf_dual/range_profile_valid_reg/Q}
    {net  *mf_dual/range_profile_valid*}
}]
if {$rpv_net ne ""} {
    set rpv_list [list $rpv_net]
} else {
    set rpv_list {}
}

# Probe 1: mf_valid_out (internal MF output valid)
# Confirmed nets: rx_inst/mf_dual/m_f_p_c/mf_inst/mf_valid_out,
#                 rx_inst/mf_dual/m_f_p_c/mf_valid_in
set mfv_net [find_net {
    {net  rx_inst/mf_dual/m_f_p_c/mf_inst/mf_valid_out}
    {net  rx_inst/mf_dual/m_f_p_c/mf_valid_in}
    {pin  rx_inst/mf_dual/m_f_p_c/mf_inst/mf_valid_out_reg/Q}
    {net  *mf_inst/mf_valid_out*}
}]
if {$mfv_net ne ""} {
    set mfv_list [list $mfv_net]
} else {
    set mfv_list {}
}

# Probe 2: segment_request[1:0] (confirmed in net dump)
set seg_nets [find_bus {
    {pin  rx_inst/mf_dual/segment_request_reg[*]/Q}
    {net  rx_inst/mf_dual/segment_request[*]}
    {net  *mf_dual/segment_request[*]}
}]

# Deferred creation: only create ILA if at least 1 probe resolves
set ila2_probes [list \
    [list "MF range_profile_valid" $rpv_list] \
    [list "MF mf_valid_out"        $mfv_list] \
    [list "MF segment_request"     $seg_nets] \
]
set ila2_count [create_ila_deferred u_ila_2 $clk_100m_net $ila2_probes $ila_depth]
puts "INFO: ILA 2 — $ila2_count probe ports on 100 MHz clock (control signals only)"

# ==============================================================================
# 7. ILA 3 — Doppler Output (100 MHz domain)
#
# Monitors the Doppler processor output (post-FFT).
# Probes: doppler_data OBUF [31:0] + doppler_valid + doppler_bin [4:0]
#         + range_bin [5:0] + new_frame_pulse = up to 45 bits.
# Uses _OBUF net variants which are guaranteed to exist at top-level I/O.
#
# Uses DEFERRED creation to avoid dangling probe0 errors.
# ==============================================================================

puts "\n====== ILA 3: Doppler Output (100 MHz) ======"

# Probe 0: Doppler output data [31:0]
# Use _OBUF variants (top-level output buffer nets) which are guaranteed
# to exist. Fall back to register Q pins if OBUFs are not present.
set dop_data_nets [find_bus {
    {net  dbg_doppler_data_OBUF[*]}
    {pin  rx_inst/doppler_proc/doppler_output_reg[*]/Q}
    {net  *doppler_data_OBUF[*]}
    {net  *doppler_output[*]}
}]

# Probe 1: Doppler valid
set dop_valid_net [find_net {
    {net  dbg_doppler_valid_OBUF}
    {net  rx_inst/doppler_proc/dbg_doppler_valid_OBUF}
    {pin  rx_inst/doppler_proc/doppler_valid_reg/Q}
    {net  *doppler_valid*}
}]
if {$dop_valid_net ne ""} {
    set dop_valid_list [list $dop_valid_net]
} else {
    set dop_valid_list {}
}

# Probe 2: Doppler bin [4:0]
set dop_bin_nets [find_bus {
    {pin  rx_inst/doppler_proc/doppler_bin_reg[*]/Q}
    {net  rx_inst/doppler_bin_reg[*]}
    {net  *doppler_bin_OBUF[*]}
    {net  *doppler_bin[*]}
}]

# Probe 3: Range bin [5:0]
set rng_bin_nets [find_bus {
    {pin  rx_inst/doppler_proc/range_bin_reg[*]/Q}
    {net  rx_inst/range_bin_reg[*]}
    {net  *range_bin_OBUF[*]}
    {net  *range_bin[*]}
}]

# Probe 4: new_frame_pulse — frame synchronization
set frame_net [find_net {
    {net  rx_inst/new_frame_pulse}
    {net  *new_frame_pulse*}
    {pin  rx_inst/new_frame_pulse_reg/Q}
    {net  *frame_pulse*}
}]
if {$frame_net ne ""} {
    set frame_list [list $frame_net]
} else {
    set frame_list {}
}

# Deferred creation: only create ILA if at least 1 probe resolves
set ila3_probes [list \
    [list "Doppler data"      $dop_data_nets] \
    [list "Doppler valid"     $dop_valid_list] \
    [list "Doppler bin"       $dop_bin_nets] \
    [list "Range bin"         $rng_bin_nets] \
    [list "Frame sync pulse"  $frame_list] \
]
set ila3_count [create_ila_deferred u_ila_3 $clk_100m_net $ila3_probes $ila_depth]
puts "INFO: ILA 3 — $ila3_count probe ports on 100 MHz clock"

# ==============================================================================
# 8. Pre-implementation validation
# ==============================================================================

puts "\n--- Pre-implementation ILA summary ---"
puts "INFO: Total probe bits connected across all ILAs: $total_probes_connected"

# Sanity check: make sure we connected SOMETHING
if {$total_probes_connected == 0} {
    error "FATAL: No probe nets were connected to any ILA. Check net names against the post-synth netlist."
}

# List all debug cores for the log
set created_cores [get_debug_cores -quiet]
if {[llength $created_cores] > 0} {
    foreach core $created_cores {
        puts "  DEBUG CORE: $core"
    }
} else {
    puts "  WARNING: No debug cores found (this should not happen if total_probes_connected > 0)"
}

# ==============================================================================
# 9. Implement the modified design (Build 13 directives)
# ==============================================================================

puts "\n======================================================================"
puts " Implementation — matching Build 13 directives"
puts "======================================================================"

# Save the post-ILA-insertion checkpoint for reference
set ila_dcp "${output_dir}/${top_module}_ila_inserted.dcp"
write_checkpoint -force $ila_dcp
puts "INFO: Saved ILA-inserted checkpoint: $ila_dcp"

# --- opt_design (Explore) ---
puts "\n--- opt_design -directive Explore ---"
opt_design -directive Explore

write_checkpoint -force "${output_dir}/${top_module}_opt.dcp"

# --- place_design (ExtraTimingOpt) ---
puts "\n--- place_design -directive ExtraTimingOpt ---"
place_design -directive ExtraTimingOpt

write_checkpoint -force "${output_dir}/${top_module}_placed.dcp"

# Post-place timing estimate
report_timing_summary -file "${output_dir}/timing_post_place.rpt" -max_paths 20

# --- phys_opt_design (AggressiveExplore) — post-place ---
puts "\n--- phys_opt_design -directive AggressiveExplore (post-place) ---"
phys_opt_design -directive AggressiveExplore

write_checkpoint -force "${output_dir}/${top_module}_physopt.dcp"

# --- route_design (AggressiveExplore) ---
puts "\n--- route_design -directive AggressiveExplore ---"
route_design -directive AggressiveExplore

write_checkpoint -force "${output_dir}/${top_module}_routed.dcp"

# Post-route timing check
report_timing_summary -file "${output_dir}/timing_post_route.rpt" -max_paths 50

# --- post-route phys_opt_design (AggressiveExplore) ---
puts "\n--- phys_opt_design -directive AggressiveExplore (post-route) ---"
phys_opt_design -directive AggressiveExplore

# Final routed + physopt checkpoint
set final_dcp "${output_dir}/${top_module}_postroute_physopt.dcp"
write_checkpoint -force $final_dcp
puts "INFO: Final checkpoint: $final_dcp"

# ==============================================================================
# 10. Generate reports for comparison with Build 13
# ==============================================================================

puts "\n======================================================================"
puts " Reports"
puts "======================================================================"

# Timing summary (compare WNS/TNS/WHS/THS against Build 13)
report_timing_summary \
    -file "${output_dir}/timing_summary_final.rpt" \
    -max_paths 100 \
    -report_unconstrained

# Per-clock-domain timing (critical for multi-clock radar design)
report_timing \
    -file "${output_dir}/timing_per_clock.rpt" \
    -max_paths 20 \
    -sort_by group

# Utilization (expect ~2-4% increase from ILA cores on XC7A200T)
report_utilization \
    -file "${output_dir}/utilization.rpt"

report_utilization \
    -file "${output_dir}/utilization_hierarchical.rpt" \
    -hierarchical

# DRC
report_drc \
    -file "${output_dir}/drc.rpt"

# Clock interaction / CDC (important with 400 MHz <-> 100 MHz crossing)
report_clock_interaction \
    -file "${output_dir}/clock_interaction.rpt" \
    -delay_type min_max

# Clock networks (verify BUFG usage)
report_clock_networks \
    -file "${output_dir}/clock_networks.rpt"

# Power estimate
report_power \
    -file "${output_dir}/power.rpt"

# ILA core summary
report_debug_core \
    -file "${output_dir}/debug_core_summary.rpt"

puts "INFO: All reports written to $output_dir"

# ==============================================================================
# 11. Write debug probes file (.ltx) for Vivado Hardware Manager
# ==============================================================================

puts "\n--- Writing debug probes .ltx file ---"

set ltx_file "${output_dir}/${top_module}.ltx"
write_debug_probes -force $ltx_file
puts "INFO: Debug probes file: $ltx_file"

# Also copy the .ltx next to the bitstream for convenience
file copy -force $ltx_file "${output_dir}/debug_nets.ltx"

# ==============================================================================
# 12. Generate bitstream
# ==============================================================================

puts "\n======================================================================"
puts " Bitstream Generation"
puts "======================================================================"

set bitstream_file "${output_dir}/${top_module}.bit"

write_bitstream -force $bitstream_file

puts "INFO: Bitstream written: $bitstream_file"

# Also generate a .bin file for SPI flash programming if needed
write_cfgmem -force \
    -format BIN \
    -size 32 \
    -interface SPIx4 \
    -loadbit "up 0x0 $bitstream_file" \
    "${output_dir}/${top_module}.bin"

puts "INFO: SPI flash image: ${output_dir}/${top_module}.bin"

# ==============================================================================
# 13. Final summary
# ==============================================================================

puts "\n======================================================================"
puts " AERIS-10 ILA Insertion Complete"
puts "======================================================================"
puts ""
puts " Output directory:  $output_dir"
puts " Final DCP:         $final_dcp"
puts " Bitstream:         $bitstream_file"
puts " Debug probes:      $ltx_file"
puts " Run tag:           $run_tag"
puts ""
puts " ILA Cores Inserted (only cores with resolved probes):"
if {$ila0_count > 0} {
    puts "   u_ila_0 : ADC Capture       (400 MHz, depth=$ila_depth, ${ila0_count} probes)"
} else {
    puts "   u_ila_0 : ADC Capture       — SKIPPED (no probes resolved)"
}
if {$ila1_count > 0} {
    puts "   u_ila_1 : DDC Output        (100 MHz, depth=$ila_depth, ${ila1_count} probes)"
} else {
    puts "   u_ila_1 : DDC Output        — SKIPPED (no probes resolved)"
}
if {$ila2_count > 0} {
    puts "   u_ila_2 : MF Control        (100 MHz, depth=$ila_depth, ${ila2_count} probes)"
} else {
    puts "   u_ila_2 : MF Control        — SKIPPED (no probes resolved)"
}
if {$ila3_count > 0} {
    puts "   u_ila_3 : Doppler Output    (100 MHz, depth=$ila_depth, ${ila3_count} probes)"
} else {
    puts "   u_ila_3 : Doppler Output    — SKIPPED (no probes resolved)"
}
puts "   Total probe bits connected: $total_probes_connected"
puts ""
puts " Compare these reports against Build 13 baseline:"
puts "   - timing_summary_final.rpt  (WNS/TNS/WHS/THS)"
puts "   - utilization.rpt           (BRAM/LUT/FF overhead)"
puts "   - clock_interaction.rpt     (CDC paths)"
puts ""
puts " To load in Hardware Manager:"
puts "   1. Program bitstream: $bitstream_file"
puts "   2. Load probes file:  $ltx_file"
puts "   3. Set trigger position to $trigger_pos for pre/post capture"
puts ""
puts " Finished at [clock format [clock seconds]]"
puts "======================================================================"

close_design
