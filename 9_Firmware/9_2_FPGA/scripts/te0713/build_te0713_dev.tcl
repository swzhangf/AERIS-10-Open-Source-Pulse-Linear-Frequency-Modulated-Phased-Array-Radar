# build_te0713_dev.tcl
#
# Vivado batch build for Trenz TE0713/TE0701 split target.
#
# Usage:
#   vivado -mode batch -source scripts/build_te0713_dev.tcl

set script_dir [file dirname [file normalize [info script]]]
set project_root [file normalize [file join $script_dir "../.."]]

set project_name "aeris10_te0713_dev"
set build_dir [file join $project_root "vivado_te0713_dev"]
set reports_dir [file join $build_dir "reports"]

set top_file [file join $project_root "radar_system_top_te0713_dev.v"]
set xdc_file [file join $project_root "constraints" "te0713_te0701_minimal.xdc"]

file mkdir $build_dir
file mkdir $reports_dir

create_project -force $project_name $build_dir -part xc7a200tfbg484-2
set_property target_language Verilog [current_project]

add_files -norecurse $top_file
add_files -fileset constrs_1 -norecurse $xdc_file

set_property top radar_system_top_te0713_dev [current_fileset]
update_compile_order -fileset sources_1

puts "INFO: Launching implementation to bitstream..."
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1

set impl_status [get_property STATUS [get_runs impl_1]]
puts "INFO: impl_1 status: $impl_status"

if {![string match "*Complete*" $impl_status]} {
    error "Implementation did not complete successfully. Status: $impl_status"
}

open_run impl_1

report_clocks -file [file join $reports_dir "clocks.rpt"]
report_clock_interaction -file [file join $reports_dir "clock_interaction.rpt"]
report_timing_summary -report_unconstrained -max_paths 100 -file [file join $reports_dir "timing_summary.rpt"]
report_cdc -details -file [file join $reports_dir "cdc.rpt"]
report_exceptions -file [file join $reports_dir "exceptions.rpt"]
report_drc -file [file join $reports_dir "drc.rpt"]
report_utilization -file [file join $reports_dir "utilization.rpt"]

set bit_file [get_property BITSTREAM.FILE [current_design]]

puts "INFO: Build complete."
puts "INFO: Bitstream: $bit_file"
puts "INFO: Reports:   $reports_dir"
