`timescale 1ns / 1ps

/**
 * radar_system_top_50t.v
 *
 * 50T Production Wrapper for radar_system_top
 *
 * The XC7A50T-FTG256 has only 69 usable IO pins, but radar_system_top
 * declares many port bits (including FT601 USB 3.0, debug outputs, and
 * status signals that have no physical connections on the 50T board).
 *
 * This wrapper exposes the physically-connected ports and ties off unused
 * inputs. Unused outputs remain internally connected so the full radar
 * pipeline is preserved in the netlist.
 *
 * USB: FT2232H (USB 2.0, 8-bit, 245 Synchronous FIFO mode)
 *   - USB_MODE=1 selects the FT2232H interface in radar_system_top
 *   - FT2232H CLKOUT (60 MHz) connected to ft601_clk_in (shared clock port)
 *   - 15 signals on Bank 35 (VCCO=3.3V, LVCMOS33)
 */

module radar_system_top_50t (
    // ===== System Clocks (Bank 15: 3.3V) =====
    input wire clk_100m,
    input wire clk_120m_dac,
    input wire reset_n,

    // ===== DAC Interface (Bank 15: 3.3V) =====
    output wire [7:0] dac_data,
    output wire dac_sleep,

    // ===== RF Control (Bank 15: 3.3V) =====
    output wire fpga_rf_switch,
    output wire rx_mixer_en,
    output wire tx_mixer_en,

    // ===== ADAR1000 Beamformer (Bank 34: 1.8V) =====
    output wire adar_tx_load_1, adar_rx_load_1,
    output wire adar_tx_load_2, adar_rx_load_2,
    output wire adar_tx_load_3, adar_rx_load_3,
    output wire adar_tx_load_4, adar_rx_load_4,
    output wire adar_tr_1, adar_tr_2, adar_tr_3, adar_tr_4,

    // ===== STM32 SPI 3.3V side (Bank 15) =====
    input wire stm32_sclk_3v3,
    input wire stm32_mosi_3v3,
    output wire stm32_miso_3v3,
    input wire stm32_cs_adar1_3v3, stm32_cs_adar2_3v3,
    input wire stm32_cs_adar3_3v3, stm32_cs_adar4_3v3,

    // ===== STM32 SPI 1.8V side (Bank 34) =====
    output wire stm32_sclk_1v8,
    output wire stm32_mosi_1v8,
    input wire stm32_miso_1v8,
    output wire stm32_cs_adar1_1v8, stm32_cs_adar2_1v8,
    output wire stm32_cs_adar3_1v8, stm32_cs_adar4_1v8,

    // ===== ADC Interface (Bank 14: LVDS_25) =====
    input wire [7:0] adc_d_p,
    input wire [7:0] adc_d_n,
    input wire adc_dco_p,
    input wire adc_dco_n,
    output wire adc_pwdn,

    // ===== STM32 Control (Bank 15: 3.3V) =====
    input wire stm32_new_chirp,
    input wire stm32_new_elevation,
    input wire stm32_new_azimuth,
    input wire stm32_mixers_enable,

    // ===== FT2232H USB 2.0 Interface (Bank 35: 3.3V) =====
    input wire ft_clkout,             // 60 MHz from FT2232H CLKOUT (MRCC pin C4)
    inout wire [7:0] ft_data,         // 8-bit bidirectional data bus
    input wire ft_rxf_n,              // RX FIFO not empty (active low)
    input wire ft_txe_n,              // TX FIFO not full (active low)
    output wire ft_rd_n,              // Read strobe (active low)
    output wire ft_wr_n,              // Write strobe (active low)
    output wire ft_oe_n,              // Output enable / bus direction
    output wire ft_siwu,              // Send Immediate / WakeUp

    // ===== FPGA→STM32 GPIO (Bank 15: 3.3V) =====
    output wire gpio_dig5,            // DIG_5 (H11→PD13): AGC saturation flag
    output wire gpio_dig6,            // DIG_6 (G12→PD14): reserved
    output wire gpio_dig7             // DIG_7 (H12→PD15): reserved
);

    // ===== Tie-off wires for unconstrained FT601 inputs (inactive with USB_MODE=1) =====
    wire        ft601_txe_tied    = 1'b0;
    wire        ft601_rxf_tied    = 1'b0;
    wire [1:0]  ft601_srb_tied    = 2'b00;
    wire [1:0]  ft601_swb_tied    = 2'b00;

    // ===== FT601 inout bus — tie to high-Z =====
    wire [31:0] ft601_data_internal;
    assign ft601_data_internal = 32'hZZZZZZZZ;

    // ===== Unconnected output wires (synthesis preserves driving logic) =====
    wire        dac_clk_nc;
    wire [3:0]  ft601_be_nc;
    wire        ft601_txe_n_nc;
    wire        ft601_rxf_n_nc;
    wire        ft601_wr_n_nc;
    wire        ft601_rd_n_nc;
    wire        ft601_oe_n_nc;
    wire        ft601_siwu_n_nc;
    wire        ft601_clk_out_nc;
    wire [5:0]  current_elevation_nc;
    wire [5:0]  current_azimuth_nc;
    wire [5:0]  current_chirp_nc;
    wire        new_chirp_frame_nc;
    wire [31:0] dbg_doppler_data_nc;
    wire        dbg_doppler_valid_nc;
    wire [4:0]  dbg_doppler_bin_nc;
    wire [5:0]  dbg_range_bin_nc;
    wire [3:0]  system_status_nc;

    (* DONT_TOUCH = "TRUE" *)
    radar_system_top #(
        .USB_MODE(1)            // FT2232H (8-bit USB 2.0) for 50T production
    ) u_core (
        // ----- Clocks & Reset -----
        .clk_100m               (clk_100m),
        .clk_120m_dac           (clk_120m_dac),
        .ft601_clk_in           (ft_clkout),         // FT2232H 60 MHz CLKOUT → shared USB clock port
        .reset_n                (reset_n),

        // ----- DAC -----
        .dac_data               (dac_data),
        .dac_clk                (dac_clk_nc),
        .dac_sleep              (dac_sleep),

        // ----- RF -----
        .fpga_rf_switch         (fpga_rf_switch),
        .rx_mixer_en            (rx_mixer_en),
        .tx_mixer_en            (tx_mixer_en),

        // ----- Beamformer -----
        .adar_tx_load_1         (adar_tx_load_1),
        .adar_rx_load_1         (adar_rx_load_1),
        .adar_tx_load_2         (adar_tx_load_2),
        .adar_rx_load_2         (adar_rx_load_2),
        .adar_tx_load_3         (adar_tx_load_3),
        .adar_rx_load_3         (adar_rx_load_3),
        .adar_tx_load_4         (adar_tx_load_4),
        .adar_rx_load_4         (adar_rx_load_4),
        .adar_tr_1              (adar_tr_1),
        .adar_tr_2              (adar_tr_2),
        .adar_tr_3              (adar_tr_3),
        .adar_tr_4              (adar_tr_4),

        // ----- SPI 3.3V -----
        .stm32_sclk_3v3        (stm32_sclk_3v3),
        .stm32_mosi_3v3        (stm32_mosi_3v3),
        .stm32_miso_3v3        (stm32_miso_3v3),
        .stm32_cs_adar1_3v3    (stm32_cs_adar1_3v3),
        .stm32_cs_adar2_3v3    (stm32_cs_adar2_3v3),
        .stm32_cs_adar3_3v3    (stm32_cs_adar3_3v3),
        .stm32_cs_adar4_3v3    (stm32_cs_adar4_3v3),

        // ----- SPI 1.8V -----
        .stm32_sclk_1v8        (stm32_sclk_1v8),
        .stm32_mosi_1v8        (stm32_mosi_1v8),
        .stm32_miso_1v8        (stm32_miso_1v8),
        .stm32_cs_adar1_1v8    (stm32_cs_adar1_1v8),
        .stm32_cs_adar2_1v8    (stm32_cs_adar2_1v8),
        .stm32_cs_adar3_1v8    (stm32_cs_adar3_1v8),
        .stm32_cs_adar4_1v8    (stm32_cs_adar4_1v8),

        // ----- ADC -----
        .adc_d_p                (adc_d_p),
        .adc_d_n                (adc_d_n),
        .adc_dco_p              (adc_dco_p),
        .adc_dco_n              (adc_dco_n),
        .adc_pwdn               (adc_pwdn),

        // ----- STM32 Control -----
        .stm32_new_chirp        (stm32_new_chirp),
        .stm32_new_elevation    (stm32_new_elevation),
        .stm32_new_azimuth      (stm32_new_azimuth),
        .stm32_mixers_enable    (stm32_mixers_enable),

        // ----- FT2232H USB 2.0 (active on 50T, USB_MODE=1) -----
        .ft_data                (ft_data),
        .ft_rxf_n               (ft_rxf_n),
        .ft_txe_n               (ft_txe_n),
        .ft_rd_n                (ft_rd_n),
        .ft_wr_n                (ft_wr_n),
        .ft_oe_n                (ft_oe_n),
        .ft_siwu                (ft_siwu),

        // ----- FT601 (inactive with USB_MODE=1 — generate block ties off) -----
        .ft601_data             (ft601_data_internal),
        .ft601_be               (ft601_be_nc),
        .ft601_txe_n            (ft601_txe_n_nc),
        .ft601_rxf_n            (ft601_rxf_n_nc),
        .ft601_txe              (ft601_txe_tied),
        .ft601_rxf              (ft601_rxf_tied),
        .ft601_wr_n             (ft601_wr_n_nc),
        .ft601_rd_n             (ft601_rd_n_nc),
        .ft601_oe_n             (ft601_oe_n_nc),
        .ft601_siwu_n           (ft601_siwu_n_nc),
        .ft601_srb              (ft601_srb_tied),
        .ft601_swb              (ft601_swb_tied),
        .ft601_clk_out          (ft601_clk_out_nc),

        // ----- Status/Debug (no pins on 50T) -----
        .current_elevation      (current_elevation_nc),
        .current_azimuth        (current_azimuth_nc),
        .current_chirp          (current_chirp_nc),
        .new_chirp_frame        (new_chirp_frame_nc),
        .dbg_doppler_data       (dbg_doppler_data_nc),
        .dbg_doppler_valid      (dbg_doppler_valid_nc),
        .dbg_doppler_bin        (dbg_doppler_bin_nc),
        .dbg_range_bin          (dbg_range_bin_nc),
        .system_status          (system_status_nc),

        // ----- FPGA→STM32 GPIO (DIG_5..DIG_7) -----
        .gpio_dig5              (gpio_dig5),
        .gpio_dig6              (gpio_dig6),
        .gpio_dig7              (gpio_dig7)
    );

endmodule
