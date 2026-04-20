# run_cdc_and_netlist.tcl
# Opens the routed design and runs:
#   1. report_cdc — detailed CDC analysis to investigate TIMING-9
#   2. write_verilog — post-synthesis functional simulation netlist
#
# Usage: vivado -mode batch -source run_cdc_and_netlist.tcl

set script_dir   [file dirname [file normalize [info script]]]
set project_root [file normalize [file join $script_dir "../.."]]
set project_dir  [file join $project_root "build"]
set report_dir   "${project_dir}/reports_impl"
file mkdir $report_dir

# Open the routed checkpoint
open_checkpoint ${project_dir}/aeris10_radar.runs/impl_1/radar_system_top_routed.dcp

# ============================================================================
# 1. report_cdc — identify all CDC crossings and the TIMING-9 source
# ============================================================================
puts "INFO: Running report_cdc..."
report_cdc -details -file ${report_dir}/cdc_report.txt

# ============================================================================
# 2. Write post-synthesis functional simulation netlist
# ============================================================================
puts "INFO: Writing post-synthesis functional sim netlist..."

# Post-synthesis (from synth checkpoint) — simpler, no routing delays
open_checkpoint ${project_dir}/aeris10_radar.runs/synth_1/radar_system_top.dcp
write_verilog -force -mode funcsim \
    ${project_dir}/sim/post_synth_funcsim.v

# Also write SDF for timing sim (from routed checkpoint)
open_checkpoint ${project_dir}/aeris10_radar.runs/impl_1/radar_system_top_routed.dcp
write_verilog -force -mode timesim \
    ${project_dir}/sim/post_impl_timesim.v
write_sdf -force \
    ${project_dir}/sim/post_impl_timesim.sdf

puts "INFO: All reports and netlists generated."
puts "INFO: CDC report:      ${report_dir}/cdc_report.txt"
puts "INFO: Post-synth sim:  ${project_dir}/sim/post_synth_funcsim.v"
puts "INFO: Post-impl sim:   ${project_dir}/sim/post_impl_timesim.v"
puts "INFO: SDF:             ${project_dir}/sim/post_impl_timesim.sdf"
