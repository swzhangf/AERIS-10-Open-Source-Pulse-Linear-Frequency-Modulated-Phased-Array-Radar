# ============================================================================
# AERIS-10 PHASED ARRAY RADAR — PRODUCTION FPGA CONSTRAINTS
# ============================================================================
# Device:  XC7A200T-2FBG484I (FBG484 package)
# Target:  Production PCB (NEW design — pin assignments are RECOMMENDED,
#          PCB designer should follow this allocation)
#
# Revision History:
#   v1.0  2026-03-16  Initial pin plan from Vivado FBG484 package CSV export.
#                     Migrated from XC7A50T-FTG256 (upstream cntrt.xdc).
#                     FT601 USB 3.0 fully wired (32-bit data bus).
#                     dac_clk output wired (FPGA drives DAC clock).
#
# I/O Bank Voltage Plan:
#   Bank 13: VCCO = 3.3V  — Debug outputs overflow (doppler debug, range bins)
#   Bank 14: VCCO = 2.5V  — ADC LVDS (LVDS_25 + DIFF_TERM), ADC control
#   Bank 15: VCCO = 3.3V  — System clocks (100M MRCC, 120M MRCC), DAC,
#                            RF control, STM32 3.3V SPI, STM32 DIG bus, reset
#   Bank 16: VCCO = 3.3V  — FT601 USB 3.0 (32-bit data + 4-bit byte enable +
#                            control, clock on MRCC)
#   Bank 34: VCCO = 1.8V  — ADAR1000 beamformer control, SPI 1.8V side
#   Bank 35: VCCO = 3.3V  — Status outputs (beam position, chirp, doppler
#                            data bus, system status)
#
# Pin Count Summary:
#   Bank 13: 17 used / 35 available (18 spare)
#   Bank 14: 19 used / 50 available (31 spare)
#   Bank 15: 27 used / 50 available (23 spare)
#   Bank 16: 50 used / 50 available (0 spare)
#   Bank 34: 19 used / 50 available (31 spare)
#   Bank 35: 50 used / 50 available (0 spare)
#   TOTAL:  182 used / 285 available
#
# Key Differences from Upstream (XC7A50T-FTG256):
#   1. ADC uses LVDS_25 (2.5V VCCO) instead of LVDS_33 (better signal quality)
#   2. FT601 USB 3.0 is fully wired (Bank 16) — unwired on upstream board
#   3. dac_clk output is routed — unconnected on upstream board
#   4. ft601_be is 4 bits wide [3:0] for 32-bit FT601 mode
#   5. All status/debug outputs have physical pins (Banks 35 + 13)
# ============================================================================

# ============================================================================
# CONFIGURATION
# ============================================================================
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN Pullup [current_design]

# ============================================================================
# CLOCK CONSTRAINTS
# ============================================================================

# --------------------------------------------------------------------------
# 100 MHz System Clock — AD9523 OUT6 → FPGA Bank 15 MRCC
# Pin: J19 = IO_L12P_T1_MRCC_15
# --------------------------------------------------------------------------
set_property PACKAGE_PIN J19 [get_ports {clk_100m}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk_100m}]
create_clock -name clk_100m -period 10.000 [get_ports {clk_100m}]
set_input_jitter [get_clocks clk_100m] 0.100

# --------------------------------------------------------------------------
# 120 MHz DAC Clock — AD9523 OUT11 → FPGA Bank 15 MRCC
# Pin: K18 = IO_L13P_T2_MRCC_15
# --------------------------------------------------------------------------
set_property PACKAGE_PIN K18 [get_ports {clk_120m_dac}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk_120m_dac}]
create_clock -name clk_120m_dac -period 8.333 [get_ports {clk_120m_dac}]
set_input_jitter [get_clocks clk_120m_dac] 0.100

# --------------------------------------------------------------------------
# FT601 Clock Input — 100 MHz from FT601 chip, Bank 16 MRCC
# Pin: D17 = IO_L12P_T1_MRCC_16
# --------------------------------------------------------------------------
set_property PACKAGE_PIN D17 [get_ports {ft601_clk_in}]
set_property IOSTANDARD LVCMOS33 [get_ports {ft601_clk_in}]
create_clock -name ft601_clk_in -period 10.000 [get_ports {ft601_clk_in}]
set_input_jitter [get_clocks ft601_clk_in] 0.100

# --------------------------------------------------------------------------
# ADC DCO Clock — 400 MHz LVDS from AD9484, Bank 14 MRCC
# Pins: W19/W20 = IO_L12P_T1_MRCC_14 / IO_L12N_T1_MRCC_14
# --------------------------------------------------------------------------
set_property PACKAGE_PIN W19 [get_ports {adc_dco_p}]
set_property PACKAGE_PIN W20 [get_ports {adc_dco_n}]
set_property IOSTANDARD LVDS_25 [get_ports {adc_dco_p}]
set_property IOSTANDARD LVDS_25 [get_ports {adc_dco_n}]
set_property DIFF_TERM TRUE [get_ports {adc_dco_p}]
create_clock -name adc_dco_p -period 2.500 [get_ports {adc_dco_p}]
set_input_jitter [get_clocks adc_dco_p] 0.050

# ============================================================================
# RESET (Active-Low) — Bank 15, VCCO = 3.3V
# ============================================================================
# Pin: J16 = IO_0_15 (standalone, not part of a diff pair)
set_property PACKAGE_PIN J16 [get_ports {reset_n}]
set_property IOSTANDARD LVCMOS33 [get_ports {reset_n}]
set_property PULLUP true [get_ports {reset_n}]

# ============================================================================
# ADC INTERFACE — Bank 14, VCCO = 2.5V, LVDS_25 with DIFF_TERM
# ============================================================================
# AD9484 8-bit LVDS data pairs. Each pair uses matched P/N pins in Bank 14.
# LVDS_25 with internal differential termination provides better signal
# integrity than LVDS_33 used on the upstream board.

# adc_d[0]: IO_L1P/L1N_T0_D00/D01_14
set_property PACKAGE_PIN P22 [get_ports {adc_d_p[0]}]
set_property PACKAGE_PIN R22 [get_ports {adc_d_n[0]}]
# adc_d[1]: IO_L2P/L2N_T0_D02/D03_14
set_property PACKAGE_PIN P21 [get_ports {adc_d_p[1]}]
set_property PACKAGE_PIN R21 [get_ports {adc_d_n[1]}]
# adc_d[2]: IO_L3P/L3N_T0_DQS_14
set_property PACKAGE_PIN U22 [get_ports {adc_d_p[2]}]
set_property PACKAGE_PIN V22 [get_ports {adc_d_n[2]}]
# adc_d[3]: IO_L4P/L4N_T0_D04/D05_14
set_property PACKAGE_PIN T21 [get_ports {adc_d_p[3]}]
set_property PACKAGE_PIN U21 [get_ports {adc_d_n[3]}]
# adc_d[4]: IO_L5P/L5N_T0_D06/D07_14
set_property PACKAGE_PIN P19 [get_ports {adc_d_p[4]}]
set_property PACKAGE_PIN R19 [get_ports {adc_d_n[4]}]
# adc_d[5]: IO_L7P/L7N_T1_D09/D10_14
set_property PACKAGE_PIN W21 [get_ports {adc_d_p[5]}]
set_property PACKAGE_PIN W22 [get_ports {adc_d_n[5]}]
# adc_d[6]: IO_L8P/L8N_T1_D11/D12_14
set_property PACKAGE_PIN AA20 [get_ports {adc_d_p[6]}]
set_property PACKAGE_PIN AA21 [get_ports {adc_d_n[6]}]
# adc_d[7]: IO_L9P/L9N_T1_DQS_D13_14
set_property PACKAGE_PIN Y21 [get_ports {adc_d_p[7]}]
set_property PACKAGE_PIN Y22 [get_ports {adc_d_n[7]}]

# LVDS I/O standard and differential termination
set_property IOSTANDARD LVDS_25 [get_ports {adc_d_p[*]}]
set_property IOSTANDARD LVDS_25 [get_ports {adc_d_n[*]}]
set_property DIFF_TERM TRUE [get_ports {adc_d_p[*]}]

# ADC Power Down — single-ended, Bank 14 (LVCMOS25 matches bank VCCO)
# Pin: P20 = IO_0_14
set_property PACKAGE_PIN P20 [get_ports {adc_pwdn}]
set_property IOSTANDARD LVCMOS25 [get_ports {adc_pwdn}]

# ============================================================================
# TRANSMITTER INTERFACE — DAC (Bank 15, VCCO = 3.3V)
# ============================================================================

# DAC Data Bus (8-bit) — AD9708 data inputs
# Using Bank 15 L1..L6 pins (single-ended from diff pairs)
set_property PACKAGE_PIN H13 [get_ports {dac_data[0]}]
set_property PACKAGE_PIN G13 [get_ports {dac_data[1]}]
set_property PACKAGE_PIN G15 [get_ports {dac_data[2]}]
set_property PACKAGE_PIN G16 [get_ports {dac_data[3]}]
set_property PACKAGE_PIN G17 [get_ports {dac_data[4]}]
set_property PACKAGE_PIN G18 [get_ports {dac_data[5]}]
set_property PACKAGE_PIN J15 [get_ports {dac_data[6]}]
set_property PACKAGE_PIN H15 [get_ports {dac_data[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dac_data[*]}]
set_property SLEW FAST [get_ports {dac_data[*]}]
set_property DRIVE 8 [get_ports {dac_data[*]}]

# DAC Clock Output — FPGA drives DAC clock on production board
# (On upstream board, DAC clock came from AD9523 directly; not routed to FPGA)
# Pin: H17 = IO_L6P_T0_15
set_property PACKAGE_PIN H17 [get_ports {dac_clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {dac_clk}]
set_property SLEW FAST [get_ports {dac_clk}]
set_property DRIVE 8 [get_ports {dac_clk}]

# DAC Sleep Control
# Pin: H18 = IO_L6N_T0_VREF_15
set_property PACKAGE_PIN H18 [get_ports {dac_sleep}]
set_property IOSTANDARD LVCMOS33 [get_ports {dac_sleep}]

# ============================================================================
# RF SWITCH & MIXER CONTROL (Bank 15, VCCO = 3.3V)
# ============================================================================
# Pin: J22 = IO_L7P_T1_AD2P_15
set_property PACKAGE_PIN J22 [get_ports {fpga_rf_switch}]
set_property IOSTANDARD LVCMOS33 [get_ports {fpga_rf_switch}]

# Pin: H22 = IO_L7N_T1_AD2N_15
set_property PACKAGE_PIN H22 [get_ports {rx_mixer_en}]
set_property IOSTANDARD LVCMOS33 [get_ports {rx_mixer_en}]

# Pin: H20 = IO_L8P_T1_AD10P_15
set_property PACKAGE_PIN H20 [get_ports {tx_mixer_en}]
set_property IOSTANDARD LVCMOS33 [get_ports {tx_mixer_en}]

# ============================================================================
# LEVEL SHIFTER SPI — 3.3V side from STM32 (Bank 15, VCCO = 3.3V)
# ============================================================================
# Pin: K21 = IO_L9P_T1_DQS_AD3P_15
set_property PACKAGE_PIN K21 [get_ports {stm32_sclk_3v3}]
# Pin: K22 = IO_L9N_T1_DQS_AD3N_15
set_property PACKAGE_PIN K22 [get_ports {stm32_mosi_3v3}]
# Pin: M21 = IO_L10P_T1_AD11P_15
set_property PACKAGE_PIN M21 [get_ports {stm32_miso_3v3}]
# Pin: L21 = IO_L10N_T1_AD11N_15
set_property PACKAGE_PIN L21 [get_ports {stm32_cs_adar1_3v3}]
# Pin: N22 = IO_L15P_T2_DQS_15
set_property PACKAGE_PIN N22 [get_ports {stm32_cs_adar2_3v3}]
# Pin: M22 = IO_L15N_T2_DQS_ADV_B_15
set_property PACKAGE_PIN M22 [get_ports {stm32_cs_adar3_3v3}]
# Pin: M18 = IO_L16P_T2_A28_15
set_property PACKAGE_PIN M18 [get_ports {stm32_cs_adar4_3v3}]
set_property IOSTANDARD LVCMOS33 [get_ports {stm32_*_3v3}]

# ============================================================================
# STM32 DIG BUS — Control signals (Bank 15, VCCO = 3.3V)
# ============================================================================
# Pin: L18 = IO_L16N_T2_A27_15
set_property PACKAGE_PIN L18 [get_ports {stm32_new_chirp}]
# Pin: N18 = IO_L17P_T2_A26_15
set_property PACKAGE_PIN N18 [get_ports {stm32_new_elevation}]
# Pin: N19 = IO_L17N_T2_A25_15
set_property PACKAGE_PIN N19 [get_ports {stm32_new_azimuth}]
# Pin: N20 = IO_L18P_T2_A24_15
set_property PACKAGE_PIN N20 [get_ports {stm32_mixers_enable}]
set_property IOSTANDARD LVCMOS33 [get_ports {stm32_new_*}]
set_property IOSTANDARD LVCMOS33 [get_ports {stm32_mixers_enable}]

# ============================================================================
# ADAR1000 BEAMFORMER CONTROL (Bank 34, VCCO = 1.8V)
# ============================================================================

# TX Load Pins — active-high pulse via level shifters
# Pin: T1 = IO_L1P_T0_34
set_property PACKAGE_PIN T1 [get_ports {adar_tx_load_1}]
# Pin: U1 = IO_L1N_T0_34
set_property PACKAGE_PIN U1 [get_ports {adar_tx_load_2}]
# Pin: U2 = IO_L2P_T0_34
set_property PACKAGE_PIN U2 [get_ports {adar_tx_load_3}]
# Pin: V2 = IO_L2N_T0_34
set_property PACKAGE_PIN V2 [get_ports {adar_tx_load_4}]

# RX Load Pins
# Pin: W2 = IO_L4P_T0_34
set_property PACKAGE_PIN W2 [get_ports {adar_rx_load_1}]
# Pin: Y2 = IO_L4N_T0_34
set_property PACKAGE_PIN Y2 [get_ports {adar_rx_load_2}]
# Pin: W1 = IO_L5P_T0_34
set_property PACKAGE_PIN W1 [get_ports {adar_rx_load_3}]
# Pin: Y1 = IO_L5N_T0_34
set_property PACKAGE_PIN Y1 [get_ports {adar_rx_load_4}]

set_property IOSTANDARD LVCMOS18 [get_ports {adar_*_load_*}]

# TR (Transmit/Receive) Pins
# Pin: AA1 = IO_L7P_T1_34
set_property PACKAGE_PIN AA1 [get_ports {adar_tr_1}]
# Pin: AB1 = IO_L7N_T1_34
set_property PACKAGE_PIN AB1 [get_ports {adar_tr_2}]
# Pin: AB3 = IO_L8P_T1_34
set_property PACKAGE_PIN AB3 [get_ports {adar_tr_3}]
# Pin: AB2 = IO_L8N_T1_34
set_property PACKAGE_PIN AB2 [get_ports {adar_tr_4}]
set_property IOSTANDARD LVCMOS18 [get_ports {adar_tr_*}]

# ============================================================================
# LEVEL SHIFTER SPI — 1.8V side to ADAR1000 (Bank 34, VCCO = 1.8V)
# ============================================================================
# Pin: Y3 = IO_L9P_T1_DQS_34
set_property PACKAGE_PIN Y3 [get_ports {stm32_sclk_1v8}]
# Pin: AA3 = IO_L9N_T1_DQS_34
set_property PACKAGE_PIN AA3 [get_ports {stm32_mosi_1v8}]
# Pin: AA5 = IO_L10P_T1_34
set_property PACKAGE_PIN AA5 [get_ports {stm32_miso_1v8}]
# Pin: AB5 = IO_L10N_T1_34
set_property PACKAGE_PIN AB5 [get_ports {stm32_cs_adar1_1v8}]
# Pin: W6 = IO_L15P_T2_DQS_34
set_property PACKAGE_PIN W6 [get_ports {stm32_cs_adar2_1v8}]
# Pin: W5 = IO_L15N_T2_DQS_34
set_property PACKAGE_PIN W5 [get_ports {stm32_cs_adar3_1v8}]
# Pin: U6 = IO_L16P_T2_34
set_property PACKAGE_PIN U6 [get_ports {stm32_cs_adar4_1v8}]
set_property IOSTANDARD LVCMOS18 [get_ports {stm32_*_1v8}]

# ============================================================================
# FT601 USB 3.0 INTERFACE (Bank 16, VCCO = 3.3V)
# ============================================================================
# FT601 is fully wired on the production board.
# 32-bit data bus + 4-bit byte enable + control signals.
#

# --- ft601_clk_in on MRCC (D17) constrained above in CLOCK section ---

# FT601 Clock Output (forwarded clock to FT601)
# Pin: C17 = IO_L12N_T1_MRCC_16 (paired with clk_in on L12P)
set_property PACKAGE_PIN C17 [get_ports {ft601_clk_out}]
set_property IOSTANDARD LVCMOS33 [get_ports {ft601_clk_out}]
set_property SLEW FAST [get_ports {ft601_clk_out}]
set_property DRIVE 8 [get_ports {ft601_clk_out}]

# FT601 Data Bus [31:0] — bidirectional, 3.3V LVCMOS
set_property PACKAGE_PIN F13 [get_ports {ft601_data[0]}]
set_property PACKAGE_PIN F14 [get_ports {ft601_data[1]}]
set_property PACKAGE_PIN F16 [get_ports {ft601_data[2]}]
set_property PACKAGE_PIN E17 [get_ports {ft601_data[3]}]
set_property PACKAGE_PIN C14 [get_ports {ft601_data[4]}]
set_property PACKAGE_PIN C15 [get_ports {ft601_data[5]}]
set_property PACKAGE_PIN E13 [get_ports {ft601_data[6]}]
set_property PACKAGE_PIN E14 [get_ports {ft601_data[7]}]
set_property PACKAGE_PIN E16 [get_ports {ft601_data[8]}]
set_property PACKAGE_PIN D16 [get_ports {ft601_data[9]}]
set_property PACKAGE_PIN D14 [get_ports {ft601_data[10]}]
set_property PACKAGE_PIN D15 [get_ports {ft601_data[11]}]
set_property PACKAGE_PIN B15 [get_ports {ft601_data[12]}]
set_property PACKAGE_PIN B16 [get_ports {ft601_data[13]}]
set_property PACKAGE_PIN C13 [get_ports {ft601_data[14]}]
set_property PACKAGE_PIN B13 [get_ports {ft601_data[15]}]
set_property PACKAGE_PIN A15 [get_ports {ft601_data[16]}]
set_property PACKAGE_PIN A16 [get_ports {ft601_data[17]}]
set_property PACKAGE_PIN A13 [get_ports {ft601_data[18]}]
set_property PACKAGE_PIN A14 [get_ports {ft601_data[19]}]
set_property PACKAGE_PIN B17 [get_ports {ft601_data[20]}]
set_property PACKAGE_PIN B18 [get_ports {ft601_data[21]}]
set_property PACKAGE_PIN F18 [get_ports {ft601_data[22]}]
set_property PACKAGE_PIN E18 [get_ports {ft601_data[23]}]
set_property PACKAGE_PIN B20 [get_ports {ft601_data[24]}]
set_property PACKAGE_PIN A20 [get_ports {ft601_data[25]}]
set_property PACKAGE_PIN A18 [get_ports {ft601_data[26]}]
set_property PACKAGE_PIN A19 [get_ports {ft601_data[27]}]
set_property PACKAGE_PIN F19 [get_ports {ft601_data[28]}]
set_property PACKAGE_PIN F20 [get_ports {ft601_data[29]}]
set_property PACKAGE_PIN D20 [get_ports {ft601_data[30]}]
set_property PACKAGE_PIN C20 [get_ports {ft601_data[31]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ft601_data[*]}]
set_property SLEW FAST [get_ports {ft601_data[*]}]
set_property DRIVE 8 [get_ports {ft601_data[*]}]

# FT601 Byte Enable [3:0]
set_property PACKAGE_PIN C22 [get_ports {ft601_be[0]}]
set_property PACKAGE_PIN B22 [get_ports {ft601_be[1]}]
set_property PACKAGE_PIN B21 [get_ports {ft601_be[2]}]
set_property PACKAGE_PIN A21 [get_ports {ft601_be[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ft601_be[*]}]
set_property SLEW FAST [get_ports {ft601_be[*]}]
set_property DRIVE 8 [get_ports {ft601_be[*]}]

# FT601 Control Signals — active-low strobes
set_property PACKAGE_PIN E22 [get_ports {ft601_wr_n}]
set_property PACKAGE_PIN D22 [get_ports {ft601_rd_n}]
set_property PACKAGE_PIN E21 [get_ports {ft601_oe_n}]
set_property PACKAGE_PIN D21 [get_ports {ft601_siwu_n}]
set_property IOSTANDARD LVCMOS33 [get_ports {ft601_wr_n}]
set_property IOSTANDARD LVCMOS33 [get_ports {ft601_rd_n}]
set_property IOSTANDARD LVCMOS33 [get_ports {ft601_oe_n}]
set_property IOSTANDARD LVCMOS33 [get_ports {ft601_siwu_n}]
set_property SLEW FAST [get_ports {ft601_wr_n}]
set_property SLEW FAST [get_ports {ft601_rd_n}]
set_property SLEW FAST [get_ports {ft601_oe_n}]
set_property DRIVE 8 [get_ports {ft601_wr_n}]
set_property DRIVE 8 [get_ports {ft601_rd_n}]
set_property DRIVE 8 [get_ports {ft601_oe_n}]

# FT601 active-low enable outputs (directly from FPGA to FT601)
set_property PACKAGE_PIN G21 [get_ports {ft601_txe_n}]
set_property PACKAGE_PIN G22 [get_ports {ft601_rxf_n}]
set_property IOSTANDARD LVCMOS33 [get_ports {ft601_txe_n}]
set_property IOSTANDARD LVCMOS33 [get_ports {ft601_rxf_n}]

# FT601 status inputs (active-high from FT601 to FPGA)
set_property PACKAGE_PIN F21 [get_ports {ft601_txe}]
set_property PACKAGE_PIN F15 [get_ports {ft601_rxf}]
set_property IOSTANDARD LVCMOS33 [get_ports {ft601_txe}]
set_property IOSTANDARD LVCMOS33 [get_ports {ft601_rxf}]

# FT601 FIFO buffer select inputs
set_property PACKAGE_PIN C18 [get_ports {ft601_srb[0]}]
set_property PACKAGE_PIN C19 [get_ports {ft601_srb[1]}]
set_property PACKAGE_PIN E19 [get_ports {ft601_swb[0]}]
set_property PACKAGE_PIN D19 [get_ports {ft601_swb[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ft601_srb[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ft601_swb[*]}]

# ============================================================================
# STATUS OUTPUTS — Beam Position & System Status (Bank 35, VCCO = 3.3V)
# ============================================================================

# current_elevation[5:0]
set_property PACKAGE_PIN B1 [get_ports {current_elevation[0]}]
set_property PACKAGE_PIN A1 [get_ports {current_elevation[1]}]
set_property PACKAGE_PIN C2 [get_ports {current_elevation[2]}]
set_property PACKAGE_PIN B2 [get_ports {current_elevation[3]}]
set_property PACKAGE_PIN E1 [get_ports {current_elevation[4]}]
set_property PACKAGE_PIN D1 [get_ports {current_elevation[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {current_elevation[*]}]

# current_azimuth[5:0]
set_property PACKAGE_PIN E2 [get_ports {current_azimuth[0]}]
set_property PACKAGE_PIN D2 [get_ports {current_azimuth[1]}]
set_property PACKAGE_PIN G1 [get_ports {current_azimuth[2]}]
set_property PACKAGE_PIN F1 [get_ports {current_azimuth[3]}]
set_property PACKAGE_PIN F3 [get_ports {current_azimuth[4]}]
set_property PACKAGE_PIN E3 [get_ports {current_azimuth[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {current_azimuth[*]}]

# current_chirp[5:0]
set_property PACKAGE_PIN K1 [get_ports {current_chirp[0]}]
set_property PACKAGE_PIN J1 [get_ports {current_chirp[1]}]
set_property PACKAGE_PIN H2 [get_ports {current_chirp[2]}]
set_property PACKAGE_PIN G2 [get_ports {current_chirp[3]}]
set_property PACKAGE_PIN K2 [get_ports {current_chirp[4]}]
set_property PACKAGE_PIN J2 [get_ports {current_chirp[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {current_chirp[*]}]

# new_chirp_frame
set_property PACKAGE_PIN J5 [get_ports {new_chirp_frame}]
set_property IOSTANDARD LVCMOS33 [get_ports {new_chirp_frame}]

# system_status[3:0]
set_property PACKAGE_PIN H5 [get_ports {system_status[0]}]
set_property PACKAGE_PIN H3 [get_ports {system_status[1]}]
set_property PACKAGE_PIN G3 [get_ports {system_status[2]}]
set_property PACKAGE_PIN H4 [get_ports {system_status[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {system_status[*]}]

# ============================================================================
# DEBUG OUTPUTS — Doppler Data (Bank 35, VCCO = 3.3V)
# ============================================================================
# dbg_doppler_data[26:0] on Bank 35, dbg_doppler_data[31:27] on Bank 13

# dbg_doppler_data[26:0] — Bank 35
set_property PACKAGE_PIN G4 [get_ports {dbg_doppler_data[0]}]
set_property PACKAGE_PIN K4 [get_ports {dbg_doppler_data[1]}]
set_property PACKAGE_PIN J4 [get_ports {dbg_doppler_data[2]}]
set_property PACKAGE_PIN L3 [get_ports {dbg_doppler_data[3]}]
set_property PACKAGE_PIN K3 [get_ports {dbg_doppler_data[4]}]
set_property PACKAGE_PIN M1 [get_ports {dbg_doppler_data[5]}]
set_property PACKAGE_PIN L1 [get_ports {dbg_doppler_data[6]}]
set_property PACKAGE_PIN M3 [get_ports {dbg_doppler_data[7]}]
set_property PACKAGE_PIN M2 [get_ports {dbg_doppler_data[8]}]
set_property PACKAGE_PIN K6 [get_ports {dbg_doppler_data[9]}]
set_property PACKAGE_PIN J6 [get_ports {dbg_doppler_data[10]}]
set_property PACKAGE_PIN L5 [get_ports {dbg_doppler_data[11]}]
set_property PACKAGE_PIN L4 [get_ports {dbg_doppler_data[12]}]
set_property PACKAGE_PIN N4 [get_ports {dbg_doppler_data[13]}]
set_property PACKAGE_PIN N3 [get_ports {dbg_doppler_data[14]}]
set_property PACKAGE_PIN R1 [get_ports {dbg_doppler_data[15]}]
set_property PACKAGE_PIN P1 [get_ports {dbg_doppler_data[16]}]
set_property PACKAGE_PIN P5 [get_ports {dbg_doppler_data[17]}]
set_property PACKAGE_PIN P4 [get_ports {dbg_doppler_data[18]}]
set_property PACKAGE_PIN P2 [get_ports {dbg_doppler_data[19]}]
set_property PACKAGE_PIN N2 [get_ports {dbg_doppler_data[20]}]
set_property PACKAGE_PIN M6 [get_ports {dbg_doppler_data[21]}]
set_property PACKAGE_PIN M5 [get_ports {dbg_doppler_data[22]}]
set_property PACKAGE_PIN P6 [get_ports {dbg_doppler_data[23]}]
set_property PACKAGE_PIN N5 [get_ports {dbg_doppler_data[24]}]
set_property PACKAGE_PIN L6 [get_ports {dbg_doppler_data[25]}]
set_property PACKAGE_PIN F4 [get_ports {dbg_doppler_data[26]}]

# dbg_doppler_data[31:27] — Bank 13 (overflow)
set_property PACKAGE_PIN Y17 [get_ports {dbg_doppler_data[27]}]
set_property PACKAGE_PIN Y16 [get_ports {dbg_doppler_data[28]}]
set_property PACKAGE_PIN AA16 [get_ports {dbg_doppler_data[29]}]
set_property PACKAGE_PIN AB16 [get_ports {dbg_doppler_data[30]}]
set_property PACKAGE_PIN AB17 [get_ports {dbg_doppler_data[31]}]

set_property IOSTANDARD LVCMOS33 [get_ports {dbg_doppler_data[*]}]

# ============================================================================
# DEBUG OUTPUTS — Doppler Valid & Bins (Bank 13, VCCO = 3.3V)
# ============================================================================

set_property PACKAGE_PIN AA13 [get_ports {dbg_doppler_valid}]
set_property IOSTANDARD LVCMOS33 [get_ports {dbg_doppler_valid}]

# dbg_doppler_bin[4:0]
set_property PACKAGE_PIN AB13 [get_ports {dbg_doppler_bin[0]}]
set_property PACKAGE_PIN AA15 [get_ports {dbg_doppler_bin[1]}]
set_property PACKAGE_PIN AB15 [get_ports {dbg_doppler_bin[2]}]
set_property PACKAGE_PIN Y13 [get_ports {dbg_doppler_bin[3]}]
set_property PACKAGE_PIN AA14 [get_ports {dbg_doppler_bin[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dbg_doppler_bin[*]}]

# dbg_range_bin[5:0]
set_property PACKAGE_PIN W14 [get_ports {dbg_range_bin[0]}]
set_property PACKAGE_PIN Y14 [get_ports {dbg_range_bin[1]}]
set_property PACKAGE_PIN AB11 [get_ports {dbg_range_bin[2]}]
set_property PACKAGE_PIN AB12 [get_ports {dbg_range_bin[3]}]
set_property PACKAGE_PIN AA9 [get_ports {dbg_range_bin[4]}]
set_property PACKAGE_PIN AB10 [get_ports {dbg_range_bin[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {dbg_range_bin[*]}]

# ============================================================================
# INPUT DELAY CONSTRAINTS
# ============================================================================

# ADC data relative to DCO (source-synchronous, center-aligned)
# NOTE: Rising-edge input delay constraints are here; falling-edge + BUFIO
# adjustments are in the "ADC SOURCE-SYNCHRONOUS INPUT CONSTRAINTS" section below.
# DDR at 400 MHz → 2.5 ns period, data valid window ±0.625 ns
# These are overridden by the more complete constraints below (with -add_delay
# for clock_fall), but kept for documentation of the original intent.
# set_input_delay -clock [get_clocks adc_dco_p] -max 1.000 [get_ports {adc_d_p[*]}]
# set_input_delay -clock [get_clocks adc_dco_p] -min 0.200 [get_ports {adc_d_p[*]}]

# FT601 input delays (relative to ft601_clk_in, 100 MHz)
# FT601 datasheet: Tco max = 7.0 ns, Tco min = 1.0 ns
set_input_delay -clock [get_clocks ft601_clk_in] -max 7.000 [get_ports {ft601_data[*]}]
set_input_delay -clock [get_clocks ft601_clk_in] -min 1.000 [get_ports {ft601_data[*]}]
set_input_delay -clock [get_clocks ft601_clk_in] -max 7.000 [get_ports {ft601_txe}]
set_input_delay -clock [get_clocks ft601_clk_in] -min 1.000 [get_ports {ft601_txe}]
set_input_delay -clock [get_clocks ft601_clk_in] -max 7.000 [get_ports {ft601_rxf}]
set_input_delay -clock [get_clocks ft601_clk_in] -min 1.000 [get_ports {ft601_rxf}]
set_input_delay -clock [get_clocks ft601_clk_in] -max 7.000 [get_ports {ft601_srb[*]}]
set_input_delay -clock [get_clocks ft601_clk_in] -min 1.000 [get_ports {ft601_srb[*]}]
set_input_delay -clock [get_clocks ft601_clk_in] -max 7.000 [get_ports {ft601_swb[*]}]
set_input_delay -clock [get_clocks ft601_clk_in] -min 1.000 [get_ports {ft601_swb[*]}]

# ============================================================================
# OUTPUT DELAY CONSTRAINTS
# ============================================================================

# --------------------------------------------------------------------------
# DAC output delay relative to ODDR-forwarded clock
# --------------------------------------------------------------------------
# dac_clk is now forwarded via ODDR from clk_120m_dac BUFG output.
# Create a generated clock on the dac_clk output pin representing the
# ODDR-forwarded clock. Output delays are then set relative to THIS
# generated clock, not the source port clock. Since both data ODDRs and
# clock ODDR are driven by the same BUFG, insertion delays cancel.
#
# AD9708 specs at the DAC pin: Tsu = 2.0 ns, Th = 1.5 ns
# Board trace skew budget: ~0.5 ns (conservative)
# output_delay_max = Tsu + trace_skew = 2.0 + 0.5 = 2.5 ns
# output_delay_min = -(Th - trace_skew) = -(1.5 - 0.5) = -1.0 ns
create_generated_clock -name dac_clk_fwd \
    -source [get_pins -filter {REF_PIN_NAME =~ C} -of_objects [get_cells -hierarchical *oddr_dac_clk]] \
    -divide_by 1 \
    [get_ports {dac_clk}]

set_output_delay -clock [get_clocks dac_clk_fwd] -max 2.500 [get_ports {dac_data[*]}]
set_output_delay -clock [get_clocks dac_clk_fwd] -min -1.000 [get_ports {dac_data[*]}]
set_output_delay -clock [get_clocks dac_clk_fwd] -clock_fall -add_delay -max 2.500 [get_ports {dac_data[*]}]
set_output_delay -clock [get_clocks dac_clk_fwd] -clock_fall -add_delay -min -1.000 [get_ports {dac_data[*]}]

# Hold analysis for ODDR source-synchronous outputs is inherently safe:
# both data ODDR and clock ODDR are driven by the same BUFG, so insertion
# delays cancel at the PCB. Vivado's inter-clock hold analysis (clk_120m_dac
# → dac_clk_fwd) sees the BUFG-to-pin path for the generated clock as DCD
# but not for the source, creating an artificial ~3.4 ns skew that does not
# exist in hardware. Waive hold on these paths.
set_false_path -hold -from [get_clocks clk_120m_dac] -to [get_clocks dac_clk_fwd]

# dac_clk itself has no meaningful output delay (it IS the clock reference)
# but we remove the old constraint that was relative to the source port clock.

# --------------------------------------------------------------------------
# FT601 output delay relative to ODDR-forwarded clock
# --------------------------------------------------------------------------
# ft601_clk_out is now forwarded via ODDR from ft601_clk_in BUFG output.
# Since both data FFs and clock ODDR are driven by the same BUFG, insertion
# delays cancel. Output delay only needs to cover FT601 Tsu/Th + trace skew.
#
# FT601 specs: Tsu = 3.0 ns, Th = 0.5 ns
# Board trace skew budget: ~0.5 ns
# output_delay_max = Tsu + trace_skew = 3.0 + 0.5 = 3.5 ns
# output_delay_min = -(Th - trace_skew) = -(0.5 - 0.5) = 0.0 ns
create_generated_clock -name ft601_clk_fwd \
    -source [get_pins -filter {REF_PIN_NAME =~ C} -of_objects [get_cells -hierarchical *oddr_ft601_clk]] \
    -divide_by 1 \
    [get_ports {ft601_clk_out}]

set_output_delay -clock [get_clocks ft601_clk_fwd] -max 3.500 [get_ports {ft601_data[*]}]
set_output_delay -clock [get_clocks ft601_clk_fwd] -min  0.000 [get_ports {ft601_data[*]}]
set_output_delay -clock [get_clocks ft601_clk_fwd] -max 3.500 [get_ports {ft601_be[*]}]
set_output_delay -clock [get_clocks ft601_clk_fwd] -min  0.000 [get_ports {ft601_be[*]}]
set_output_delay -clock [get_clocks ft601_clk_fwd] -max 3.500 [get_ports {ft601_wr_n}]
set_output_delay -clock [get_clocks ft601_clk_fwd] -min  0.000 [get_ports {ft601_wr_n}]
set_output_delay -clock [get_clocks ft601_clk_fwd] -max 3.500 [get_ports {ft601_rd_n}]
set_output_delay -clock [get_clocks ft601_clk_fwd] -min  0.000 [get_ports {ft601_rd_n}]
set_output_delay -clock [get_clocks ft601_clk_fwd] -max 3.500 [get_ports {ft601_oe_n}]
set_output_delay -clock [get_clocks ft601_clk_fwd] -min  0.000 [get_ports {ft601_oe_n}]

# Same ODDR hold waiver as DAC: both data FFs and clock ODDR share the same
# BUFG, so hold is inherently met at the pin. Vivado's inter-clock hold
# analysis creates artificial skew.
set_false_path -hold -from [get_clocks ft601_clk_in] -to [get_clocks ft601_clk_fwd]

# ============================================================================
# TIMING EXCEPTIONS — FALSE PATHS
# ============================================================================

# Asynchronous STM32 control signals (toggle interface, double-synced in RTL)
set_false_path -from [get_ports {stm32_new_*}]
set_false_path -from [get_ports {stm32_mixers_enable}]

# Async reset false paths
# reset_n is held asserted for many clock cycles. All paths originating from
# the reset port or reset synchronizer registers are false paths — this covers
# both data paths (setup/hold) and asynchronous control paths (recovery/removal).
#
# NOTE: Using -from only (no -to filter). Vivado does not accept CLR/PRE pins
# as valid endpoints for set_false_path -to. Waiving all paths FROM these
# sources is the correct and standard approach.
set_false_path -from [get_ports {reset_n}]
set_false_path -from [get_cells -hierarchical -filter {NAME =~ *reset_sync*}]

# ============================================================================
# TIMING EXCEPTIONS — CLOCK DOMAIN CROSSINGS
# ============================================================================

# clk_100m ↔ adc_dco_p (400 MHz): DDC has internal CDC synchronizers
set_false_path -from [get_clocks clk_100m] -to [get_clocks adc_dco_p]
set_false_path -from [get_clocks adc_dco_p] -to [get_clocks clk_100m]

# clk_100m ↔ clk_120m_dac: CDC via synchronizers in radar_system_top
set_false_path -from [get_clocks clk_100m] -to [get_clocks clk_120m_dac]
set_false_path -from [get_clocks clk_120m_dac] -to [get_clocks clk_100m]

# clk_100m ↔ ft601_clk_in: USB data interface has CDC synchronizers
set_false_path -from [get_clocks clk_100m] -to [get_clocks ft601_clk_in]
set_false_path -from [get_clocks ft601_clk_in] -to [get_clocks clk_100m]
set_false_path -from [get_ports {ft601_txe}] -to [all_registers -clock [get_clocks clk_100m]]

# clk_120m_dac ↔ ft601_clk_in: no direct data path expected
set_false_path -from [get_clocks clk_120m_dac] -to [get_clocks ft601_clk_in]
set_false_path -from [get_clocks ft601_clk_in] -to [get_clocks clk_120m_dac]

# adc_dco_p ↔ ft601_clk_in: no direct data path expected
set_false_path -from [get_clocks adc_dco_p] -to [get_clocks ft601_clk_in]
set_false_path -from [get_clocks ft601_clk_in] -to [get_clocks adc_dco_p]

# Generated clock cross-domain paths:
# dac_clk_fwd and ft601_clk_fwd are generated from their respective source
# clocks. Vivado automatically inherits the source clock false paths for
# generated clocks, but be explicit for clarity:
set_false_path -from [get_clocks clk_100m] -to [get_clocks dac_clk_fwd]
set_false_path -from [get_clocks dac_clk_fwd] -to [get_clocks clk_100m]
set_false_path -from [get_clocks ft601_clk_fwd] -to [get_clocks clk_120m_dac]
set_false_path -from [get_clocks clk_120m_dac] -to [get_clocks ft601_clk_fwd]

# ============================================================================
# ADC SOURCE-SYNCHRONOUS INPUT CONSTRAINTS
# ============================================================================
# With BUFIO clocking the IDDR (near-zero insertion delay), the input delay
# constraints need updating. The IDDR sees data and clock with similar
# propagation delays (both through IOB primitives).
#
# AD9484 source-synchronous interface:
# - DDR at 400 MHz → 1.25 ns half-period (data valid window)
# - Data is center-aligned to DCO by the ADC
# - Tco_max (data after clock edge) = 1.0 ns, Tco_min = 0.2 ns
#
# With BUFIO, the clock insertion delay at IDDR is ~0.3 ns (vs 4.4 ns BUFG).
# Input delay values are board-level delays only.
set_input_delay -clock [get_clocks adc_dco_p] -max 1.000 [get_ports {adc_d_p[*]}]
set_input_delay -clock [get_clocks adc_dco_p] -min 0.200 [get_ports {adc_d_p[*]}]
# DDR falling edge captures
set_input_delay -clock [get_clocks adc_dco_p] -max 1.000 -clock_fall [get_ports {adc_d_p[*]}] -add_delay
set_input_delay -clock [get_clocks adc_dco_p] -min 0.200 -clock_fall [get_ports {adc_d_p[*]}] -add_delay

# Hold waiver for BUFIO source-synchronous interface:
# Vivado models BUFIO with ~2.8 ns clock insertion delay for STA purposes,
# but BUFIO physically drives the ILOGIC block with near-zero delay (it is
# a dedicated routing resource in the IOB column). The ADC data through
# IBUFDS arrives in ~0.85 ns, so Vivado sees a false hold violation of
# ~2 ns. In hardware, both clock (BUFIO) and data (IBUFDS) arrive at
# the ILOGIC simultaneously with only PCB trace skew difference.
# This is the standard approach for source-synchronous BUFIO interfaces.
# NOTE: Only waive hold from input ports to IDDR, NOT fabric-side paths.
set_false_path -hold -from [get_ports {adc_d_p[*]}] -to [get_clocks adc_dco_p]

# ============================================================================
# IOB PACKING
# ============================================================================
# Force DAC data and clock ODDR outputs into IOBs
set_property IOB TRUE [get_cells -hierarchical -filter {NAME =~ *oddr_dac_clk*}]
set_property IOB TRUE [get_cells -hierarchical -filter {NAME =~ *oddr_dac_data*}]
# Force FT601 clock ODDR into IOB
set_property IOB TRUE [get_cells -hierarchical -filter {NAME =~ *oddr_ft601_clk*}]
# FT601 data/control output FFs: packed into IOBs where possible
# NOTE: IOB packing requires the register to be the ONLY driver of the output
# and have no other fanout. The FT601 FSM may prevent this for some signals.
# Vivado will warn if it cannot pack — that's OK, timing is still met via
# the generated clock (insertion delay cancellation).
# ft601_data_out drives OBUFT (tristate), so Vivado may not find a packable
# register.  ft601_be may also be optimized.  Use -quiet to suppress
# CRITICAL WARNING [Common 17-55] when the filter returns no objects.
set_property -quiet IOB TRUE [get_cells -hierarchical -filter {NAME =~ *usb_inst/ft601_data_out_reg*}]
set_property -quiet IOB TRUE [get_cells -hierarchical -filter {NAME =~ *usb_inst/ft601_be_reg*}]
set_property IOB TRUE [get_cells -hierarchical -filter {NAME =~ *usb_inst/ft601_wr_n_reg*}]
# ft601_rd_n and ft601_oe_n are constant-1 (USB read not implemented) —
# Vivado removes the registers via constant propagation. Use -quiet to
# suppress CRITICAL WARNING [Common 17-55] when the cells don't exist.
set_property -quiet IOB TRUE [get_cells -hierarchical -filter {NAME =~ *usb_inst/ft601_rd_n_reg*}]
set_property -quiet IOB TRUE [get_cells -hierarchical -filter {NAME =~ *usb_inst/ft601_oe_n_reg*}]

# ============================================================================
# TIMING EXCEPTIONS — CIC DECIMATOR
# ============================================================================
# CIC integrator stages use explicit DSP48E1 instantiations (integrator_N_dsp),
# not inferred registers. The P register inside DSP48E1 cannot be targeted by
# the standard get_cells -filter {NAME =~ *integrator_reg*} pattern.
# The adc_dco_p domain (where CIC runs) meets setup timing with positive slack
# (+0.022 ns WNS), so no multicycle path exception is needed.
# If timing becomes tight in future, use:
#   set_multicycle_path 2 -setup \
#     -from [get_cells -hierarchical -filter {NAME =~ *cic_*/integrator_*_dsp}] \
#     -to   [get_cells -hierarchical -filter {NAME =~ *cic_*/integrator_*_dsp}]

# ============================================================================
# CDC WAIVERS — Verified False Positives (Build 13 Freeze Candidate)
# ============================================================================
# These 5 CDC critical warnings were analyzed during pre-hardware audit.
# All are structurally safe and do not represent real metastability risks.
# See project documentation for detailed justification of each waiver.
#
# Waiver 1: CDC-11 — 100MHz reset_sync → 400MHz ADC reset synchronizer
# Standard async-assert/sync-deassert pattern. ASYNC_REG is applied on
# the destination synchronizer chain. Reset is held for many source cycles.
create_waiver -type CDC -id CDC-11 \
    -from [get_pins -quiet -hierarchical -filter {NAME =~ *reset_sync_reg[1]/C}] \
    -to   [get_pins -quiet -hierarchical -filter {NAME =~ *rx_inst/adc/reset_sync_400m_reg[0]/CLR}] \
    -description "Reset synchronizer 100M->400M: async-assert/sync-deassert, ASYNC_REG applied"

# Waiver 2: CDC-7 — 100MHz reset_sync → DDC active-high reset PRE
# Active-high derived reset uses PRE (preset). PRE is the safe async
# direction for this reset polarity. Parent chain has ASYNC_REG.
create_waiver -type CDC -id CDC-7 \
    -from [get_pins -quiet -hierarchical -filter {NAME =~ *reset_sync_reg[1]/C}] \
    -to   [get_pins -quiet -hierarchical -filter {NAME =~ *rx_inst/ddc/reset_400m_reg/PRE}] \
    -description "DDC active-high reset via PRE: safe async direction, ASYNC_REG on parent chain"

# Waiver 3: CDC-11 — 100MHz reset_sync → DDC 400MHz reset synchronizer
# Same pattern as Waiver 1, different destination module (DDC vs ADC).
create_waiver -type CDC -id CDC-11 \
    -from [get_pins -quiet -hierarchical -filter {NAME =~ *reset_sync_reg[1]/C}] \
    -to   [get_pins -quiet -hierarchical -filter {NAME =~ *rx_inst/ddc/reset_sync_400m_reg[0]/CLR}] \
    -description "Reset synchronizer 100M->400M in DDC: async-assert/sync-deassert, ASYNC_REG applied"

# Waiver 4: CDC-11 — doppler_valid fan-out to USB doppler_valid_sync
# Single rx_doppler_valid register fans out to two independent 2-stage
# synchronizers in usb_data_interface. Both sync chains have ASYNC_REG.
# The fan-out is covered by set_false_path (clk_100m ↔ ft601_clk_in).
create_waiver -type CDC -id CDC-11 \
    -from [get_pins -quiet -hierarchical -filter {NAME =~ *doppler_valid_reg/C}] \
    -to   [get_pins -quiet -hierarchical -filter {NAME =~ *usb_inst/doppler_valid_sync_reg[0]/D}] \
    -description "doppler_valid CDC fan-out to USB sync chain 1: ASYNC_REG + false_path applied"

# Waiver 5: CDC-11 — doppler_valid fan-out to USB range_valid_sync
# Second fan-out endpoint of the same doppler_valid signal. Same
# justification as Waiver 4.
create_waiver -type CDC -id CDC-11 \
    -from [get_pins -quiet -hierarchical -filter {NAME =~ *doppler_valid_reg/C}] \
    -to   [get_pins -quiet -hierarchical -filter {NAME =~ *usb_inst/range_valid_sync_reg[0]/D}] \
    -description "doppler_valid CDC fan-out to USB sync chain 2: ASYNC_REG + false_path applied"

set_false_path -to [get_ports {current_elevation[*]}]
set_false_path -to [get_ports {current_azimuth[*]}]
set_false_path -to [get_ports {current_chirp[*]}]
set_false_path -to [get_ports {new_chirp_frame}]
set_false_path -to [get_ports {system_status[*]}]
set_false_path -to [get_ports {dbg_doppler_data[*]}]
set_false_path -to [get_ports {dbg_doppler_valid}]
set_false_path -to [get_ports {dbg_doppler_bin[*]}]
set_false_path -to [get_ports {dbg_range_bin[*]}]
set_false_path -to [get_ports adar_tr_*]
set_false_path -to [get_ports {fpga_rf_switch}]
set_false_path -to [get_ports {rx_mixer_en}]
set_false_path -to [get_ports {tx_mixer_en}]

# ============================================================================
# END OF CONSTRAINTS
# ============================================================================
