################################################################################
# debug_ila.xdc
#
# AERIS-10 Radar FPGA — mark_debug Constraints for ILA Probe Signals
# Target: XC7A200T-2FBG484I
#
# ALTERNATIVE APPROACH: If the post-synthesis ILA insertion script
# (insert_ila_probes.tcl) encounters net-name resolution issues, add this
# XDC to the Vivado project *before* synthesis. The mark_debug attributes
# will preserve the nets through optimization and make them available for
# ILA insertion in the Setup Debug wizard or via TCL.
#
# Usage:
#   1. Add this file to the Vivado project as a constraint source
#   2. Re-run synthesis (nets will be preserved with MARK_DEBUG)
#   3. Use Vivado GUI: Flow > Set Up Debug, or run insert_ila_probes.tcl
#
# NOTE: mark_debug must be applied to RTL-level signal names. After
# synthesis, Vivado will propagate the attribute to the corresponding
# netlist nets regardless of renaming or flattening.
################################################################################

# ==============================================================================
# ILA 0 — ADC Capture (400 MHz domain)
#
# Raw ADC samples from the AD9484 CMOS interface inside the receiver.
# 8-bit data bus + valid strobe. Clocked at 400 MHz (adc_dco_p derived).
# ==============================================================================

# ADC raw data bus [7:0]
set_property MARK_DEBUG true [get_nets {rx_inst/adc/adc_data_cmos[0]}]
set_property MARK_DEBUG true [get_nets {rx_inst/adc/adc_data_cmos[1]}]
set_property MARK_DEBUG true [get_nets {rx_inst/adc/adc_data_cmos[2]}]
set_property MARK_DEBUG true [get_nets {rx_inst/adc/adc_data_cmos[3]}]
set_property MARK_DEBUG true [get_nets {rx_inst/adc/adc_data_cmos[4]}]
set_property MARK_DEBUG true [get_nets {rx_inst/adc/adc_data_cmos[5]}]
set_property MARK_DEBUG true [get_nets {rx_inst/adc/adc_data_cmos[6]}]
set_property MARK_DEBUG true [get_nets {rx_inst/adc/adc_data_cmos[7]}]

# ADC data valid
set_property MARK_DEBUG true [get_nets {rx_inst/adc/adc_valid}]

# ==============================================================================
# ILA 1 — DDC Output (100 MHz domain)
#
# Digital down-converter baseband I/Q outputs after CIC + FIR decimation.
# 18-bit I + 18-bit Q + valid strobe. Clocked at 100 MHz (clk_100m_buf).
# ==============================================================================

# DDC I-channel [17:0]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_i[0]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_i[1]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_i[2]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_i[3]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_i[4]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_i[5]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_i[6]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_i[7]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_i[8]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_i[9]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_i[10]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_i[11]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_i[12]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_i[13]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_i[14]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_i[15]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_i[16]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_i[17]}]

# DDC Q-channel [17:0]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_q[0]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_q[1]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_q[2]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_q[3]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_q[4]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_q[5]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_q[6]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_q[7]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_q[8]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_q[9]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_q[10]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_q[11]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_q[12]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_q[13]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_q[14]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_q[15]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_q[16]}]
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_out_q[17]}]

# DDC valid strobe
set_property MARK_DEBUG true [get_nets {rx_inst/ddc_valid_i}]

# ==============================================================================
# ILA 2 — Matched Filter Output (100 MHz domain)
#
# Pulse-compression output from the multi-segment matched filter.
# 16-bit I + 16-bit Q + valid + 2-bit segment index.
# ==============================================================================

# Matched filter I-channel [15:0]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_i_w[0]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_i_w[1]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_i_w[2]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_i_w[3]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_i_w[4]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_i_w[5]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_i_w[6]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_i_w[7]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_i_w[8]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_i_w[9]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_i_w[10]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_i_w[11]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_i_w[12]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_i_w[13]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_i_w[14]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_i_w[15]}]

# Matched filter Q-channel [15:0]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_q_w[0]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_q_w[1]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_q_w[2]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_q_w[3]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_q_w[4]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_q_w[5]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_q_w[6]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_q_w[7]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_q_w[8]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_q_w[9]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_q_w[10]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_q_w[11]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_q_w[12]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_q_w[13]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_q_w[14]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_q_w[15]}]

# Matched filter valid
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/pc_valid_w}]

# Matched filter segment request [1:0]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/segment_request[0]}]
set_property MARK_DEBUG true [get_nets {rx_inst/mf_dual/segment_request[1]}]

# ==============================================================================
# ILA 3 — Doppler Processor Output (100 MHz domain)
#
# Range-Doppler map output from FFT-based Doppler processor.
# 32-bit spectrum + valid + 5-bit Doppler bin + 6-bit range bin + frame sync.
# ==============================================================================

# Doppler output spectrum [31:0]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[0]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[1]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[2]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[3]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[4]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[5]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[6]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[7]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[8]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[9]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[10]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[11]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[12]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[13]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[14]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[15]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[16]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[17]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[18]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[19]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[20]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[21]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[22]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[23]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[24]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[25]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[26]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[27]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[28]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[29]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[30]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_output[31]}]

# Doppler valid
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_valid}]

# Doppler bin index [4:0]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_bin[0]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_bin[1]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_bin[2]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_bin[3]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/doppler_bin[4]}]

# Range bin index [5:0]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/range_bin[0]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/range_bin[1]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/range_bin[2]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/range_bin[3]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/range_bin[4]}]
set_property MARK_DEBUG true [get_nets {rx_inst/doppler_proc/range_bin[5]}]

# Frame synchronization pulse
set_property MARK_DEBUG true [get_nets {rx_inst/new_frame_pulse}]
