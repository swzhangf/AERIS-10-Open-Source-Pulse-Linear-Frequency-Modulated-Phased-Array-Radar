# ============================================================================
# AERIS-10 TE0712/TE0701 DEV TARGET (MINIMAL SPLIT)
# ============================================================================
# Target part: XC7A200T-2FBG484I (TE0712-03-82I36-A)
# Board: TE0701-06 carrier
#
# This XDC is intentionally minimal and is used with:
#   top = radar_system_top_te0712_dev
#
# Replace PACKAGE_PIN assignments with the exact TE0701-06 net mapping from
# the Trenz schematics/board files before hardware programming.
# ============================================================================

set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN Pullup [current_design]

# Clock/reset IO standards
# TE0712 reference design mapping:
#   CLK1B[0] -> R4 (50 MHz, LVCMOS15)
#   reset    -> T3 (LVCMOS15)
# We keep the top-level port name as clk_100m in the dev wrapper for now,
# but it is physically sourced from the 50 MHz CLK1B net on TE0712.
set_property IOSTANDARD LVCMOS15 [get_ports {clk_100m}]
set_property IOSTANDARD LVCMOS15 [get_ports {reset_n}]
set_property PULLUP true [get_ports {reset_n}]

# Status/output IO standards
# These outputs are currently exported to TE0701 FMC LA lines (not onboard LEDs).
# Assumption: FMC VADJ/VCCIO16 is set for 2.5V signaling.
set_property IOSTANDARD LVCMOS25 [get_ports {user_led[*]}]
set_property IOSTANDARD LVCMOS25 [get_ports {system_status[*]}]

# Clock constraint
create_clock -name clk_100m -period 20.000 [get_ports {clk_100m}]
set_input_jitter [get_clocks clk_100m] 0.100

# --------------------------------------------------------------------------
# Known-good TE0712 package pin mapping from official reference design
# --------------------------------------------------------------------------
set_property PACKAGE_PIN R4 [get_ports {clk_100m}]
set_property PACKAGE_PIN T3 [get_ports {reset_n}]

# --------------------------------------------------------------------------
# TE0701 FMC export mapping (derived from TE0701 FMC map + TE0712 B16 mapping)
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
