# ============================================================================
# AERIS-10 TE0713/TE0701 DEV TARGET (MINIMAL SPLIT)
# ============================================================================
# Target part: XC7A200T-2FBG484C (TE0713-03-82C46-A)
# Board: TE0701-06 carrier
#
# This XDC is intentionally minimal and is used with:
#   top = radar_system_top_te0713_dev
#
# Notes:
# - TE0713 clock routing differs from TE0712. This target uses FIFO0CLK net at
#   package pin U20 as primary fabric clock for initial bring-up.
# - No external reset is used in this minimal top to avoid uncertain reset pin
#   assumptions between TE0712/TE0713 revisions.
# ============================================================================

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN Pullup [current_design]

# Clock IOSTANDARD
set_property IOSTANDARD LVCMOS15 [get_ports {clk_100m}]

# Status/output IO standards
# These outputs are exported to TE0701 FMC LA lines (not onboard LEDs).
# Bank 16 VCCO = VIOTB on TE0701, set to 3.3V for FT601 compatibility.
set_property IOSTANDARD LVCMOS33 [get_ports {user_led[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {system_status[*]}]

# Clock constraint (TE0713 FIFO0CLK source observed as 50 MHz)
create_clock -name clk_100m -period 20.000 [get_ports {clk_100m}]
set_input_jitter [get_clocks clk_100m] 0.100

# --------------------------------------------------------------------------
# TE0713 package pin mapping
# --------------------------------------------------------------------------
set_property PACKAGE_PIN U20 [get_ports {clk_100m}]

# --------------------------------------------------------------------------
# TE0701 FMC export mapping (B16 bank mappings align with TE0712 flow)
# user_led[0..3]  -> FMC_LA14_N/P, FMC_LA13_N/P
# system_status[] -> FMC_LA5_N/P,  FMC_LA6_N/P
# --------------------------------------------------------------------------
set_property PACKAGE_PIN A19 [get_ports {user_led[0]}]
set_property PACKAGE_PIN A18 [get_ports {user_led[1]}]
set_property PACKAGE_PIN F20 [get_ports {user_led[2]}]
set_property PACKAGE_PIN F19 [get_ports {user_led[3]}]

set_property PACKAGE_PIN F18 [get_ports {system_status[0]}]
set_property PACKAGE_PIN E18 [get_ports {system_status[1]}]
set_property PACKAGE_PIN C22 [get_ports {system_status[2]}]
set_property PACKAGE_PIN B22 [get_ports {system_status[3]}]

# --------------------------------------------------------------------------
# Keep implementation checks strict.
# report_timing_summary -report_unconstrained
# report_drc
