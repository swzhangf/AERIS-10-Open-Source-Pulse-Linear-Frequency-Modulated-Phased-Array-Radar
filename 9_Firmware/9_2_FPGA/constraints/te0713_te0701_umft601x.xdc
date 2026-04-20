# ============================================================================
# AERIS-10  FT601 via FMC LPC: TE0713 + TE0701 + UMFT601X-B
# ============================================================================
# Target: XC7A200T-2FBG484C (TE0713-03) on TE0701-06 carrier
# FT601 board: UMFT601X-B (32-bit FT601 eval, FMC LPC)
#
# Signal chain:
#   FPGA ball → TE0713 B2B → TE0701 carrier → FMC LPC J10 → UMFT601X-B FT601
#
# Bank split:
#   Bank 15 (VCCO = VIOTB): DATA[31:0], D_CLK (33 pins)
#   Bank 16 (VCCO = VIOTB): BE_N[3:0], OE_N, RD_N, WR_N, TXE_N, RXF_N,
#                            SIWU_N, RESET_N, WAKEUP_N, GPIO0, GPIO1 (14 pins)
#
# CRITICAL SETUP:
#   1. TE0701 VIOTB must be set to 3.3V (jumper J16/J17/J21 configuration)
#      OR FMC_VADJ (DIP S4) set to 3.3V with VIOTB routed to FMC_VADJ
#   2. UMFT601X-B VCCIO jumper set to 3.3V
#   3. This XDC replaces the FT601 section of xc7a200t_fbg484.xdc (production
#      PCB pinout) — do NOT use both simultaneously
#
# Source mapping:
#   UMFT601X-B: DS_UMFT60x.pdf Table 2.7 (CN4 FMC connector, FT601 column)
#   TE0701→TE0713: TE0701_FMC_PINOUT.xlsx (FMC J10 → B2B → FPGA pin)
#
# Verified: 2026-03-19
# ============================================================================

# --------------------------------------------------------------------------
# FT601 Clock Input — 100 MHz from FT601 chip
# FMC: LA18_P_CC → FPGA J20 (Bank 15, IO_L11P_T1_SRCC_15)
# SRCC is sufficient for 100 MHz FIFO clock via IBUF→BUFG
# --------------------------------------------------------------------------
set_property PACKAGE_PIN J20 [get_ports {ft601_clk_in}]
set_property IOSTANDARD LVCMOS33 [get_ports {ft601_clk_in}]
create_clock -name ft601_clk_in -period 10.000 [get_ports {ft601_clk_in}]
set_input_jitter [get_clocks ft601_clk_in] 0.100

# --------------------------------------------------------------------------
# FT601 Data Bus [31:0] — bidirectional, 3.3V LVCMOS
# All data pins in Bank 15
# --------------------------------------------------------------------------
# FMC LA32_N → L21
set_property PACKAGE_PIN L21 [get_ports {ft601_data[0]}]
# FMC LA33_N → N20
set_property PACKAGE_PIN N20 [get_ports {ft601_data[1]}]
# FMC LA32_P → M21
set_property PACKAGE_PIN M21 [get_ports {ft601_data[2]}]
# FMC LA33_P → M20
set_property PACKAGE_PIN M20 [get_ports {ft601_data[3]}]
# FMC LA30_N → M13
set_property PACKAGE_PIN M13 [get_ports {ft601_data[4]}]
# FMC LA31_N → N22
set_property PACKAGE_PIN N22 [get_ports {ft601_data[5]}]
# FMC LA30_P → L13
set_property PACKAGE_PIN L13 [get_ports {ft601_data[6]}]
# FMC LA31_P → M22
set_property PACKAGE_PIN M22 [get_ports {ft601_data[7]}]
# FMC LA28_N → H18
set_property PACKAGE_PIN H18 [get_ports {ft601_data[8]}]
# FMC LA29_N → K17
set_property PACKAGE_PIN K17 [get_ports {ft601_data[9]}]
# FMC LA28_P → H17
set_property PACKAGE_PIN H17 [get_ports {ft601_data[10]}]
# FMC LA29_P → J17
set_property PACKAGE_PIN J17 [get_ports {ft601_data[11]}]
# FMC LA24_N → L15
set_property PACKAGE_PIN L15 [get_ports {ft601_data[12]}]
# FMC LA25_N → J15
set_property PACKAGE_PIN J15 [get_ports {ft601_data[13]}]
# FMC LA24_P → L14
set_property PACKAGE_PIN L14 [get_ports {ft601_data[14]}]
# FMC LA25_P → H15
set_property PACKAGE_PIN H15 [get_ports {ft601_data[15]}]
# FMC LA27_N → G13
set_property PACKAGE_PIN G13 [get_ports {ft601_data[16]}]
# FMC LA26_N → G15
set_property PACKAGE_PIN G15 [get_ports {ft601_data[17]}]
# FMC LA27_P → H13
set_property PACKAGE_PIN H13 [get_ports {ft601_data[18]}]
# FMC LA26_P → G16
set_property PACKAGE_PIN G16 [get_ports {ft601_data[19]}]
# FMC LA21_N → G18
set_property PACKAGE_PIN G18 [get_ports {ft601_data[20]}]
# FMC LA22_N → L18
set_property PACKAGE_PIN L18 [get_ports {ft601_data[21]}]
# FMC LA21_P → G17
set_property PACKAGE_PIN G17 [get_ports {ft601_data[22]}]
# FMC LA22_P → M18
set_property PACKAGE_PIN M18 [get_ports {ft601_data[23]}]
# FMC LA23_N → H14
set_property PACKAGE_PIN H14 [get_ports {ft601_data[24]}]
# FMC LA23_P → J14
set_property PACKAGE_PIN J14 [get_ports {ft601_data[25]}]
# FMC LA19_N → N18
set_property PACKAGE_PIN N18 [get_ports {ft601_data[26]}]
# FMC LA19_P → N19
set_property PACKAGE_PIN N19 [get_ports {ft601_data[27]}]
# FMC LA20_N → K14
set_property PACKAGE_PIN K14 [get_ports {ft601_data[28]}]
# FMC LA20_P → K13
set_property PACKAGE_PIN K13 [get_ports {ft601_data[29]}]
# FMC LA17_N_CC → H19
set_property PACKAGE_PIN H19 [get_ports {ft601_data[30]}]
# FMC LA17_P_CC → J19
set_property PACKAGE_PIN J19 [get_ports {ft601_data[31]}]

set_property IOSTANDARD LVCMOS33 [get_ports {ft601_data[*]}]
set_property SLEW FAST [get_ports {ft601_data[*]}]
set_property DRIVE 8 [get_ports {ft601_data[*]}]

# --------------------------------------------------------------------------
# FT601 Byte Enable [3:0] — active-low, bidirectional
# BE_N[0:1] in Bank 16, BE_N[2:3] in Bank 16
# --------------------------------------------------------------------------
# FMC LA15_N → B20
set_property PACKAGE_PIN B20 [get_ports {ft601_be[0]}]
# FMC LA15_P → A20
set_property PACKAGE_PIN A20 [get_ports {ft601_be[1]}]
# FMC LA09_N → D16
set_property PACKAGE_PIN D16 [get_ports {ft601_be[2]}]
# FMC LA09_P → E16
set_property PACKAGE_PIN E16 [get_ports {ft601_be[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {ft601_be[*]}]
set_property SLEW FAST [get_ports {ft601_be[*]}]
set_property DRIVE 8 [get_ports {ft601_be[*]}]

# --------------------------------------------------------------------------
# FT601 Control Signals — active-low strobes (Bank 16)
# --------------------------------------------------------------------------
# FMC LA00_P_CC → C17 (OE_N)
set_property PACKAGE_PIN C17 [get_ports {ft601_oe_n}]
# FMC LA00_N_CC → D17 (RD_N)
set_property PACKAGE_PIN D17 [get_ports {ft601_rd_n}]
# FMC LA08_P → E13 (WR_N)
set_property PACKAGE_PIN E13 [get_ports {ft601_wr_n}]
# FMC LA08_N → E14 (SIWU_N)
set_property PACKAGE_PIN E14 [get_ports {ft601_siwu_n}]

set_property IOSTANDARD LVCMOS33 [get_ports {ft601_oe_n}]
set_property IOSTANDARD LVCMOS33 [get_ports {ft601_rd_n}]
set_property IOSTANDARD LVCMOS33 [get_ports {ft601_wr_n}]
set_property IOSTANDARD LVCMOS33 [get_ports {ft601_siwu_n}]
set_property SLEW FAST [get_ports {ft601_oe_n}]
set_property SLEW FAST [get_ports {ft601_rd_n}]
set_property SLEW FAST [get_ports {ft601_wr_n}]
set_property DRIVE 8 [get_ports {ft601_oe_n}]
set_property DRIVE 8 [get_ports {ft601_rd_n}]
set_property DRIVE 8 [get_ports {ft601_wr_n}]

# --------------------------------------------------------------------------
# FT601 Status Signals (Bank 16)
# --------------------------------------------------------------------------
# On UMFT601X-B, FT601 drives TXE_N and RXF_N (active-low) to FPGA.
# In the production RTL (usb_data_interface.v):
#   - ft601_txe  (input, active-HIGH) — FSM checks `!ft601_txe` for "can write"
#   - ft601_txe_n (output reg) — driven to 1, unused (production PCB artifact)
#   - ft601_rxf  (input, active-HIGH) — not used in write-only FSM
#   - ft601_rxf_n (output reg) — driven to 1, unused (production PCB artifact)
#
# On UMFT601X-B FMC path:
#   - TXE_N from FT601 is LOW when FIFO ready → wire to ft601_txe RTL input
#   - The FSM checks `!ft601_txe`: !LOW = 1 = proceed. Polarity is CORRECT.
#   - ft601_txe_n output and ft601_rxf_n output have no FMC connection (leave
#     unconstrained or tie off in RTL wrapper).
#
# FMC LA07_N → E17 (TXE_N from FT601 — wire to RTL port ft601_txe)
set_property PACKAGE_PIN E17 [get_ports {ft601_txe}]
# FMC LA07_P → F16 (RXF_N from FT601 — wire to RTL port ft601_rxf)
set_property PACKAGE_PIN F16 [get_ports {ft601_rxf}]

set_property IOSTANDARD LVCMOS33 [get_ports {ft601_txe}]
set_property IOSTANDARD LVCMOS33 [get_ports {ft601_rxf}]

# --------------------------------------------------------------------------
# FT601 Reset and Wake (Bank 16) — active-low
# These are FPGA-to-FT601 control signals, active-low.
# NOTE: The RTL port ft601_reset_n is an internal synchronized reset INPUT,
# not a pin output. This FMC pin drives the FT601 chip's RESET_N.
# Use a separate port name (ft601_chip_reset_n) to avoid collision.
# --------------------------------------------------------------------------
# FMC LA10_N → A14 (RESET_N — FPGA drives FT601 reset)
set_property PACKAGE_PIN A14 [get_ports {ft601_chip_reset_n}]
# FMC LA10_P → A13 (WAKEUP_N — FPGA drives FT601 wakeup)
set_property PACKAGE_PIN A13 [get_ports {ft601_wakeup_n}]

set_property IOSTANDARD LVCMOS33 [get_ports {ft601_chip_reset_n}]
set_property IOSTANDARD LVCMOS33 [get_ports {ft601_wakeup_n}]

# --------------------------------------------------------------------------
# FT601 GPIO (Bank 16) — directly on FMC, active by default on UMFT601X-B
# --------------------------------------------------------------------------
# FMC LA14_P → A18 (GPIO0)
set_property PACKAGE_PIN A18 [get_ports {ft601_gpio0}]
# FMC LA14_N → A19 (GPIO1)
set_property PACKAGE_PIN A19 [get_ports {ft601_gpio1}]

set_property IOSTANDARD LVCMOS33 [get_ports {ft601_gpio0}]
set_property IOSTANDARD LVCMOS33 [get_ports {ft601_gpio1}]

# --------------------------------------------------------------------------
# FT601 Clock Output (forwarded clock to FT601)
# --------------------------------------------------------------------------
# NOTE: The UMFT601X-B provides its own 100 MHz clock via D_CLK (ft601_clk_in
# above). The production design forwards a clock back via ODDR. On the FMC
# path, there is NO dedicated return-clock LA pin on the UMFT601X-B.
#
# The FT601 FIFO interface is source-synchronous from the FT601 perspective:
# the FT601 provides D_CLK and the FPGA samples/drives data relative to it.
# For WRITE operations the FPGA drives data on D_CLK edges (no separate
# forwarded clock needed). ft601_clk_out is NOT used on the FMC path.
#
# If the RTL requires ft601_clk_out as a port, constrain it to an unused pin
# or remove it from the top-level for the FMC build variant.
# --------------------------------------------------------------------------

# --------------------------------------------------------------------------
# FT601 input delays (relative to ft601_clk_in, 100 MHz)
# FT601 datasheet (245 Sync FIFO mode): Tco max = 7.0 ns, Tco min = 1.0 ns
# NOTE: ft601_data is bidirectional — input delay applies during READ ops.
# ft601_be is output-only in this write-only design; no set_input_delay.
# --------------------------------------------------------------------------
set_input_delay -clock [get_clocks ft601_clk_in] -max 7.000 [get_ports {ft601_data[*]}]
set_input_delay -clock [get_clocks ft601_clk_in] -min 1.000 [get_ports {ft601_data[*]}]
set_input_delay -clock [get_clocks ft601_clk_in] -max 7.000 [get_ports {ft601_txe}]
set_input_delay -clock [get_clocks ft601_clk_in] -min 1.000 [get_ports {ft601_txe}]
set_input_delay -clock [get_clocks ft601_clk_in] -max 7.000 [get_ports {ft601_rxf}]
set_input_delay -clock [get_clocks ft601_clk_in] -min 1.000 [get_ports {ft601_rxf}]
# ft601_be[*] is output-only — removed erroneous set_input_delay (was causing
# critical warnings and dropped constraints in previous build)

# --------------------------------------------------------------------------
# FT601 output timing — source-synchronous, datapath-only constraints
# --------------------------------------------------------------------------
# The FT601 provides its own 100 MHz clock (D_CLK) and samples data on
# the next rising edge of that same clock. The FPGA receives D_CLK through
# IBUF→BUFG (~5 ns insertion), but this insertion delay is COMMON to both
# the data launch (register clocked by BUFG output) and the data capture
# (FT601 sampling on the same physical clock edge).
#
# Using set_output_delay with the real clock creates a false ~5 ns skew
# penalty. Using a virtual clock doesn't help because Vivado still sees
# the IBUF+BUFG insertion on the source side.
#
# Instead, we use set_max_delay -datapath_only to constrain the
# register-to-pad delay directly. The budget is:
#   Tperiod(10 ns) - Tsu(2.0 ns) - Tboard_margin(0.5 ns) = 7.5 ns
# This ensures data arrives at the FT601 pad with 2.5 ns margin before
# the next clock edge.
#
# For hold (min delay): We use set_min_delay. The FT601 Th = 0.5 ns.
# The data must not change until 0.5 ns after the CURRENT clock edge.
# Since the register launches on the clock edge and the pad delay is
# always positive (>= 1 ns), hold is inherently met. We set min = 0
# to be safe.
# --------------------------------------------------------------------------

# Remove any output_delay on these ports (clean slate — the constraints
# below supersede them)
# Data bus
set_max_delay -datapath_only -from [get_clocks ft601_clk_in] -to [get_ports {ft601_data[*]}] 7.500
set_min_delay -from [get_clocks ft601_clk_in] -to [get_ports {ft601_data[*]}] 0.000
# Byte enable
set_max_delay -datapath_only -from [get_clocks ft601_clk_in] -to [get_ports {ft601_be[*]}] 7.500
set_min_delay -from [get_clocks ft601_clk_in] -to [get_ports {ft601_be[*]}] 0.000
# Write strobe
set_max_delay -datapath_only -from [get_clocks ft601_clk_in] -to [get_ports {ft601_wr_n}] 7.500
set_min_delay -from [get_clocks ft601_clk_in] -to [get_ports {ft601_wr_n}] 0.000
# Read strobe
set_max_delay -datapath_only -from [get_clocks ft601_clk_in] -to [get_ports {ft601_rd_n}] 7.500
set_min_delay -from [get_clocks ft601_clk_in] -to [get_ports {ft601_rd_n}] 0.000
# Output enable
set_max_delay -datapath_only -from [get_clocks ft601_clk_in] -to [get_ports {ft601_oe_n}] 7.500
set_min_delay -from [get_clocks ft601_clk_in] -to [get_ports {ft601_oe_n}] 0.000

# --------------------------------------------------------------------------
# Note: Input delays still reference ft601_clk_in (correct for inputs,
# where the FT601 drives data relative to its clock and the FPGA samples
# after IBUF+BUFG insertion — the pessimistic direction Vivado handles
# correctly).
# --------------------------------------------------------------------------

# --------------------------------------------------------------------------
# IOB packing for timing — same strategy as production XDC
# Use -quiet because register names depend on synthesis elaboration;
# a -quiet miss is non-fatal, but the constraint logs should be checked.
# --------------------------------------------------------------------------
set_property -quiet IOB TRUE [get_cells -hierarchical -filter {NAME =~ *usb_inst/ft601_data_out_reg*}]
set_property -quiet IOB TRUE [get_cells -hierarchical -filter {NAME =~ *usb_inst/ft601_be_reg*}]
set_property -quiet IOB TRUE [get_cells -hierarchical -filter {NAME =~ *usb_inst/ft601_wr_n_reg*}]
set_property -quiet IOB TRUE [get_cells -hierarchical -filter {NAME =~ *usb_inst/ft601_rd_n_reg*}]
set_property -quiet IOB TRUE [get_cells -hierarchical -filter {NAME =~ *usb_inst/ft601_oe_n_reg*}]
set_property -quiet IOB TRUE [get_cells -hierarchical -filter {NAME =~ *usb_inst/ft601_siwu_n_reg*}]

# --------------------------------------------------------------------------
# Async / false paths — chip reset and wakeup are not timing-critical
# --------------------------------------------------------------------------
set_false_path -to [get_ports {ft601_chip_reset_n}]
set_false_path -to [get_ports {ft601_wakeup_n}]
set_false_path -to [get_ports {ft601_gpio0}]
set_false_path -to [get_ports {ft601_gpio1}]

# --------------------------------------------------------------------------
# NOTES ON RTL ADAPTATION FOR FMC BUILD
# --------------------------------------------------------------------------
# The production RTL (usb_data_interface.v) has these ports that need
# handling for the FMC dev build:
#
# 1. ft601_clk_out (output) — ODDR forwarded clock. No FMC return path
#    on UMFT601X-B. Leave unconnected or assign to an unused Bank 16 pin.
#
# 2. ft601_txe_n (output reg) — Production PCB artifact. Driven to 1,
#    never functionally used. Leave unconstrained (no FMC connection).
#
# 3. ft601_rxf_n (output reg) — Same as txe_n. Leave unconstrained.
#
# 4. ft601_srb[1:0] (input) — FIFO buffer select. Not on UMFT601X-B FMC.
#    Tie to 2'b00 in RTL wrapper or via pulldown.
#
# 5. ft601_swb[1:0] (input) — Same as srb. Tie to 2'b00.
#
# 6. ft601_txe (input) — Wired to UMFT601X-B TXE_N (active-low from FT601).
#    Polarity works: FSM checks `!ft601_txe` → !LOW=1 → proceed when ready.
#
# 7. ft601_rxf (input) — Wired to UMFT601X-B RXF_N (active-low from FT601).
#    Not used in current write-only FSM but correct for future read path.
#
# 8. ft601_reset_n (input in RTL at port level, but also used as
#    ft601_reset_n on UMFT601X-B FMC LA10_N). The XDC above constrains
#    ft601_reset_n — this is an OUTPUT from FPGA to reset the FT601 chip,
#    not the RTL's synchronized reset input. The RTL's ft601_reset_n input
#    should be driven by internal logic (e.g., system reset synchronized to
#    ft601_clk_in). The FMC pin ft601_reset_n should be a separate port.
#
# RECOMMENDED: Create a thin FMC wrapper module that:
#   - Instantiates usb_data_interface with existing port names
#   - Ties ft601_srb/ft601_swb to 2'b00
#   - Leaves ft601_txe_n/ft601_rxf_n unconnected
#   - Assigns ft601_clk_out to an unused pin or removes it
#   - Adds ft601_reset_n, ft601_wakeup_n, ft601_gpio0/1 as new top ports
# --------------------------------------------------------------------------
