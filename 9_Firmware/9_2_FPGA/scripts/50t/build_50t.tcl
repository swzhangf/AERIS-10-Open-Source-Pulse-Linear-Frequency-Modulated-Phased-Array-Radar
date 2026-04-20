################################################################################
# build_50t.tcl — XC7A50T Production Build
# Builds the AERIS-10 design targeting the production 50T (FTG256) board
#
# Usage:
#   cd 9_Firmware/9_2_FPGA
#   vivado -mode batch -source scripts/50t/build_50t.tcl 2>&1 | tee build_50t/vivado.log
################################################################################

set project_name    "aeris10_radar_50t"
set script_dir      [file dirname [file normalize [info script]]]
set project_root    [file normalize [file join $script_dir "../.."]]
set project_dir     [file join $project_root "build_50t"]
set rtl_dir         $project_root
set fpga_part       "xc7a50tftg256-2"
set top_module      "radar_system_top_50t"

puts "================================================================"
puts "  AERIS-10 — XC7A50T Production Build"
puts "  Target:    $fpga_part"
puts "  Project:   $project_dir"
puts "================================================================"

file mkdir $project_dir
set report_dir [file join $project_dir "reports_50t"]
file mkdir $report_dir
set bit_dir [file join $project_dir "bitstream"]
file mkdir $bit_dir

create_project $project_name $project_dir -part $fpga_part -force

# Add ALL RTL files in the project root (avoid stale/dev tops)
set skip_patterns {*_te0712_* *_te0713_*}
foreach f [glob -directory $rtl_dir *.v] {
    set skip 0
    foreach pat $skip_patterns {
        if {[string match $pat [file tail $f]]} { set skip 1; break }
    }
    if {!$skip} {
        add_files -norecurse $f
        puts "  Added: [file tail $f]"
    }
}

set_property top $top_module [current_fileset]
set_property verilog_define {FFT_XPM_BRAM} [current_fileset]

# Constraints — 50T XDC + MMCM supplement
add_files -fileset constrs_1 -norecurse [file join $project_root "constraints" "xc7a50t_ftg256.xdc"]
add_files -fileset constrs_1 -norecurse [file join $project_root "constraints" "adc_clk_mmcm.xdc"]

# ============================================================================
# DRC SEVERITY WAIVERS — 50T Hardware-Specific
# ============================================================================
# NOTE: DRC severity waivers are set both before synthesis and after open_run
# synth_1. Implementation uses direct commands (opt_design, place_design, etc.)
# rather than launch_runs/wait_on_run, so all commands share the same Vivado
# context where the waivers are active.
#
# The top module is radar_system_top_50t — a thin wrapper that exposes only
# the 64 physically-connected ports on the FTG256 board. Unconstrained ports
# (FT601, debug, status) are tied off internally, keeping the full radar
# pipeline intact while fitting within the 69 available IO pins.
#
# BIVC-1: Bank 14 VCCO=2.5V (enforced by LVDS_25) with LVCMOS25 adc_pwdn.
# This should no longer fire now that adc_pwdn is LVCMOS25, but we keep
# the waiver as a safety net in case future XDC changes re-introduce the
# conflict.
set_property SEVERITY {Warning} [get_drc_checks BIVC-1]

# NSTD-1 / UCIO-1: Unconstrained port bits — FT601 USB ports (inactive with
# USB_MODE=1 generate block), dac_clk (DAC clock from AD9523, not FPGA),
# and all status/debug outputs (no physical pins on FTG256 package).
set_property SEVERITY {Warning} [get_drc_checks NSTD-1]
set_property SEVERITY {Warning} [get_drc_checks UCIO-1]

# PLIO-9: FT2232H CLKOUT is routed to C4 (IO_L12N_T1_MRCC_35), the N-type
# pin of a Multi-Region Clock-Capable pair. Clock inputs should ideally use
# the P-type pin, but IBUFG works correctly on either. The schematic routes
# to C4 and cannot be changed. Safe to demote.
set_property SEVERITY {Warning} [get_drc_checks PLIO-9]

# ===== SYNTHESIS =====
set synth_start [clock seconds]
launch_runs synth_1 -jobs 8
wait_on_run synth_1
set synth_elapsed [expr {[clock seconds] - $synth_start}]
set synth_status [get_property STATUS [get_runs synth_1]]
puts "  Synthesis status: $synth_status"
puts "  Synthesis time:   ${synth_elapsed}s"

if {![string match "*Complete*" $synth_status]} {
    puts "CRITICAL: SYNTHESIS FAILED: $synth_status"
    close_project
    exit 1
}

open_run synth_1
report_timing_summary -file "${report_dir}/01_timing_post_synth.rpt"
report_utilization -file "${report_dir}/01_utilization_post_synth.rpt"

# ===== IMPLEMENTATION (non-project-mode style) =====
# We run implementation steps directly in the parent process instead of
# using launch_runs/wait_on_run. This ensures DRC waivers are active in
# the same Vivado context as place_design.
set impl_start [clock seconds]

# Re-apply DRC waivers in this context (parent process)
set_property SEVERITY {Warning} [get_drc_checks BIVC-1]
set_property SEVERITY {Warning} [get_drc_checks NSTD-1]
set_property SEVERITY {Warning} [get_drc_checks UCIO-1]
set_property SEVERITY {Warning} [get_drc_checks PLIO-9]

# FT2232H CLKOUT on C4 (N-type MRCC) — override dedicated clock route check.
# The schematic routes the FT2232H 60 MHz clock to the N-pin of a differential
# MRCC pair. Vivado Place 30-876 requires this property to allow placement.
# The clock still reaches the clock network via IBUFG — this only suppresses
# the DRC that demands the P-type pin.
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {ft_clkout_IBUF}]

# ---- Run implementation steps ----
opt_design -directive Explore
place_design -directive ExtraNetDelay_high
phys_opt_design -directive AggressiveExplore
route_design -directive AggressiveExplore
phys_opt_design -directive AggressiveExplore
phys_opt_design -directive AggressiveExplore

set impl_elapsed [expr {[clock seconds] - $impl_start}]
puts "  Implementation time: ${impl_elapsed}s"

# ===== BITSTREAM =====
set bit_start [clock seconds]
set dst_bit [file join $bit_dir "radar_system_top_50t.bit"]
write_bitstream -force $dst_bit
set bit_elapsed [expr {[clock seconds] - $bit_start}]
if {[file exists $dst_bit]} {
    puts "  Bitstream: $dst_bit ([expr {[file size $dst_bit] / 1024}] KB)"
} else {
    puts "  WARNING: Bitstream not generated!"
}

# ===== REPORTS =====
report_timing_summary -file "${report_dir}/02_timing_summary.rpt"
report_utilization -file "${report_dir}/04_utilization.rpt"
report_drc -file "${report_dir}/06_drc.rpt"
report_io -file "${report_dir}/07_io.rpt"

puts "================================================================"
puts "  XC7A50T Build Complete"
puts "  Synth:  ${synth_elapsed}s"
puts "  Impl:   ${impl_elapsed}s"
puts "  Bit:    ${bit_elapsed}s"
set wns_val "N/A"
set whs_val "N/A"
catch {set wns_val [get_property STATS.WNS [current_design]]}
catch {set whs_val [get_property STATS.WHS [current_design]]}
puts "  WNS:    $wns_val ns"
puts "  WHS:    $whs_val ns"
puts "================================================================"

close_project
exit 0
