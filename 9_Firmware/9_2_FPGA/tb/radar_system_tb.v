`timescale 1ns / 1ps

/**
 * radar_system_tb.v
 * 
 * Comprehensive Testbench for Radar System Top Module
 * Tests:
 * - Transmitter chirp generation
 * - Receiver signal processing
 * - USB data transfer via FT601
 * - STM32 control interface
 */

module radar_system_tb;

// ============================================================================
// PARAMETERS
// ============================================================================

// Clock periods
parameter CLK_100M_PERIOD = 10.0;        // 100MHz = 10ns
parameter CLK_120M_PERIOD = 8.333;       // 120MHz = 8.333ns
parameter FT601_CLK_PERIOD = 10.0;       // 100MHz = 10ns
parameter ADC_DCO_PERIOD = 2.5;          // 400MHz = 2.5ns

// Simulation time
parameter SIM_TIME = 500_000;            // 500us simulation

// Test parameters
parameter NUM_CHIRPS = 64;                // Number of chirps to simulate
parameter ENABLE_DOPPLER = 1;             // Enable Doppler processing
parameter ENABLE_CFAR = 1;                 // Enable CFAR detection
parameter ENABLE_USB = 1;                  // Enable USB interface

// ============================================================================
// CLOCK AND RESET SIGNALS
// ============================================================================

reg clk_100m;
reg clk_120m_dac;
reg ft601_clk_in;
reg reset_n;

// ADC clocks
reg adc_dco_p;
reg adc_dco_n;

// ADC data
reg [7:0] adc_data_pattern;
reg [7:0] adc_d_p;
reg [7:0] adc_d_n;

// FT601 interface
wire [31:0] ft601_data;
wire [3:0] ft601_be;
wire ft601_txe_n;
wire ft601_rxf_n;
reg ft601_txe;
reg ft601_rxf;
wire ft601_wr_n;
wire ft601_rd_n;
wire ft601_oe_n;
wire ft601_siwu_n;
reg [1:0] ft601_srb;
reg [1:0] ft601_swb;
wire ft601_clk_out;

// STM32 control signals
reg stm32_new_chirp;
reg stm32_new_elevation;
reg stm32_new_azimuth;
reg stm32_mixers_enable;

// ADAR1000 SPI signals
reg stm32_sclk_3v3;
reg stm32_mosi_3v3;
wire stm32_miso_3v3;
reg stm32_cs_adar1_3v3;
reg stm32_cs_adar2_3v3;
reg stm32_cs_adar3_3v3;
reg stm32_cs_adar4_3v3;

wire stm32_sclk_1v8;
wire stm32_mosi_1v8;
reg stm32_miso_1v8;
wire stm32_cs_adar1_1v8;
wire stm32_cs_adar2_1v8;
wire stm32_cs_adar3_1v8;
wire stm32_cs_adar4_1v8;

// DAC outputs
wire [7:0] dac_data;
wire dac_clk;
wire dac_sleep;

// RF control
wire fpga_rf_switch;
wire rx_mixer_en;
wire tx_mixer_en;

// ADAR1000 control
wire adar_tx_load_1, adar_rx_load_1;
wire adar_tx_load_2, adar_rx_load_2;
wire adar_tx_load_3, adar_rx_load_3;
wire adar_tx_load_4, adar_rx_load_4;
wire adar_tr_1, adar_tr_2, adar_tr_3, adar_tr_4;

// Status outputs
wire [5:0] current_elevation;
wire [5:0] current_azimuth;
wire [5:0] current_chirp;
wire new_chirp_frame;
wire [31:0] dbg_doppler_data;
wire dbg_doppler_valid;
wire [4:0] dbg_doppler_bin;
wire [5:0] dbg_range_bin;
wire [3:0] system_status;

// ============================================================================
// CLOCK GENERATION
// ============================================================================

// 100MHz system clock
initial begin
    clk_100m = 0;
    forever #(CLK_100M_PERIOD/2) clk_100m = ~clk_100m;
end

// 120MHz DAC clock
initial begin
    clk_120m_dac = 0;
    forever #(CLK_120M_PERIOD/2) clk_120m_dac = ~clk_120m_dac;
end

// FT601 clock (100MHz)
initial begin
    ft601_clk_in = 0;
    forever #(FT601_CLK_PERIOD/2) ft601_clk_in = ~ft601_clk_in;
end

// ADC DCO clock (400MHz)
initial begin
    adc_dco_p = 0;
    adc_dco_n = 1;
    forever begin
        #(ADC_DCO_PERIOD/2) begin
            adc_dco_p = ~adc_dco_p;
            adc_dco_n = ~adc_dco_n;
        end
    end
end

// ============================================================================
// RESET GENERATION
// ============================================================================

initial begin
    reset_n = 0;
    #100;
    reset_n = 1;
    #10;
end

// ============================================================================
// FT601 INTERFACE SIMULATION
// ============================================================================

// FT601 FIFO status
initial begin
    ft601_txe = 1'b0;      // TX FIFO not empty (ready to write)
    ft601_rxf = 1'b1;      // RX FIFO full (not ready to read)
    ft601_srb = 2'b00;
    ft601_swb = 2'b00;
    
    // Simulate occasional FIFO full conditions
    forever begin
        #1000;
        ft601_txe = $random % 2;
        ft601_rxf = $random % 2;
    end
end

// FT601 data bus monitoring
reg [31:0] ft601_captured_data;
reg [31:0] usb_packet_buffer [0:1023];
integer usb_packet_count = 0;
integer usb_byte_count = 0;

always @(negedge ft601_wr_n) begin
    if (!ft601_wr_n) begin
        ft601_captured_data = ft601_data;
        usb_packet_buffer[usb_packet_count] = ft601_captured_data;
        usb_byte_count = usb_byte_count + 4;
        
        if (usb_packet_count < 100) begin
            $display("[USB @%0t] WRITE: data=0x%08h, be=%b, count=%0d", 
                     $time, ft601_captured_data, ft601_be, usb_packet_count);
        end
        
        usb_packet_count = usb_packet_count + 1;
    end
end

// ============================================================================
// STM32 CONTROL SIGNAL GENERATION
// ============================================================================

integer chirp_num = 0;
integer elevation_num = 0;
integer azimuth_num = 0;

initial begin
    // Initialize
    stm32_new_chirp = 0;
    stm32_new_elevation = 0;
    stm32_new_azimuth = 0;
    stm32_mixers_enable = 1;
    
    stm32_sclk_3v3 = 0;
    stm32_mosi_3v3 = 0;
    stm32_cs_adar1_3v3 = 1;
    stm32_cs_adar2_3v3 = 1;
    stm32_cs_adar3_3v3 = 1;
    stm32_cs_adar4_3v3 = 1;
    stm32_miso_1v8 = 0;
    
    #200;
    
    // Generate chirp sequence
    for (chirp_num = 0; chirp_num < NUM_CHIRPS; chirp_num = chirp_num + 1) begin
        // New chirp toggle
        stm32_new_chirp = 1;
        #20;
        stm32_new_chirp = 0;
        
        // Every 8 chirps, change elevation
        if ((chirp_num % 8) == 0) begin
            stm32_new_elevation = 1;
            #20;
            stm32_new_elevation = 0;
            elevation_num = elevation_num + 1;
        end
        
        // Every 16 chirps, change azimuth
        if ((chirp_num % 16) == 0) begin
            stm32_new_azimuth = 1;
            #20;
            stm32_new_azimuth = 0;
            azimuth_num = azimuth_num + 1;
        end
        
        // Wait for chirp duration
        #3000;  // ~30us between chirps
    end
    
    // Disable mixers at the end
    #5000;
    stm32_mixers_enable = 0;
end

// ============================================================================
// ADC DATA GENERATION (Simulated Radar Echo)
// ============================================================================

integer sample_count = 0;
integer target_count = 0;
reg [31:0] echo_delay [0:9];
reg [7:0] echo_amplitude [0:9];
reg [7:0] echo_phase [0:9];
integer target_idx;

initial begin
    // Initialize targets (simulated objects)
    // Format: {delay_samples, amplitude, phase_index}
    echo_delay[0] = 500;   echo_amplitude[0] = 100; echo_phase[0] = 0;
    echo_delay[1] = 1200;  echo_amplitude[1] = 80;  echo_phase[1] = 45;
    echo_delay[2] = 2500;  echo_amplitude[2] = 60;  echo_phase[2] = 90;
    echo_delay[3] = 4000;  echo_amplitude[3] = 40;  echo_phase[3] = 135;
    echo_delay[4] = 6000;  echo_amplitude[4] = 20;  echo_phase[4] = 180;
    
    for (target_idx = 5; target_idx < 10; target_idx = target_idx + 1) begin
        echo_delay[target_idx] = 0;
        echo_amplitude[target_idx] = 0;
        echo_phase[target_idx] = 0;
    end
    
    adc_d_p = 8'h00;
    adc_d_n = ~8'h00;
    
    // Wait for reset and chirp start
    #500;
    
    // Generate ADC data synchronized with chirps
    forever begin
        @(posedge adc_dco_p);
        sample_count = sample_count + 1;
        
        // Generate echo signal when transmitter is active
        if (tx_mixer_en && fpga_rf_switch) begin
            compute_radar_echo(sample_count);
        end else begin
            adc_data_pattern = 8'h80;  // Mid-scale noise floor
        end
        
        // Add noise
        adc_data_pattern = adc_data_pattern + ($random % 16) - 8;
        
        // LVDS output
        adc_d_p = adc_data_pattern;
        adc_d_n = ~adc_data_pattern;
    end
end

// Sine LUT for echo modulation (pre-computed, equivalent to 128 + 127*sin(2*pi*i/256))
// Declared before task so iverilog can resolve the reference.
reg [7:0] sin_lut [0:255];
integer lut_i;
initial begin
    sin_lut[  0] = 128; sin_lut[  1] = 131; sin_lut[  2] = 134; sin_lut[  3] = 137;
    sin_lut[  4] = 140; sin_lut[  5] = 144; sin_lut[  6] = 147; sin_lut[  7] = 150;
    sin_lut[  8] = 153; sin_lut[  9] = 156; sin_lut[ 10] = 159; sin_lut[ 11] = 162;
    sin_lut[ 12] = 165; sin_lut[ 13] = 168; sin_lut[ 14] = 171; sin_lut[ 15] = 174;
    sin_lut[ 16] = 177; sin_lut[ 17] = 179; sin_lut[ 18] = 182; sin_lut[ 19] = 185;
    sin_lut[ 20] = 188; sin_lut[ 21] = 191; sin_lut[ 22] = 193; sin_lut[ 23] = 196;
    sin_lut[ 24] = 199; sin_lut[ 25] = 201; sin_lut[ 26] = 204; sin_lut[ 27] = 206;
    sin_lut[ 28] = 209; sin_lut[ 29] = 211; sin_lut[ 30] = 213; sin_lut[ 31] = 216;
    sin_lut[ 32] = 218; sin_lut[ 33] = 220; sin_lut[ 34] = 222; sin_lut[ 35] = 224;
    sin_lut[ 36] = 226; sin_lut[ 37] = 228; sin_lut[ 38] = 230; sin_lut[ 39] = 232;
    sin_lut[ 40] = 234; sin_lut[ 41] = 235; sin_lut[ 42] = 237; sin_lut[ 43] = 239;
    sin_lut[ 44] = 240; sin_lut[ 45] = 241; sin_lut[ 46] = 243; sin_lut[ 47] = 244;
    sin_lut[ 48] = 245; sin_lut[ 49] = 246; sin_lut[ 50] = 248; sin_lut[ 51] = 249;
    sin_lut[ 52] = 250; sin_lut[ 53] = 250; sin_lut[ 54] = 251; sin_lut[ 55] = 252;
    sin_lut[ 56] = 253; sin_lut[ 57] = 253; sin_lut[ 58] = 254; sin_lut[ 59] = 254;
    sin_lut[ 60] = 254; sin_lut[ 61] = 255; sin_lut[ 62] = 255; sin_lut[ 63] = 255;
    sin_lut[ 64] = 255; sin_lut[ 65] = 255; sin_lut[ 66] = 255; sin_lut[ 67] = 255;
    sin_lut[ 68] = 254; sin_lut[ 69] = 254; sin_lut[ 70] = 254; sin_lut[ 71] = 253;
    sin_lut[ 72] = 253; sin_lut[ 73] = 252; sin_lut[ 74] = 251; sin_lut[ 75] = 250;
    sin_lut[ 76] = 250; sin_lut[ 77] = 249; sin_lut[ 78] = 248; sin_lut[ 79] = 246;
    sin_lut[ 80] = 245; sin_lut[ 81] = 244; sin_lut[ 82] = 243; sin_lut[ 83] = 241;
    sin_lut[ 84] = 240; sin_lut[ 85] = 239; sin_lut[ 86] = 237; sin_lut[ 87] = 235;
    sin_lut[ 88] = 234; sin_lut[ 89] = 232; sin_lut[ 90] = 230; sin_lut[ 91] = 228;
    sin_lut[ 92] = 226; sin_lut[ 93] = 224; sin_lut[ 94] = 222; sin_lut[ 95] = 220;
    sin_lut[ 96] = 218; sin_lut[ 97] = 216; sin_lut[ 98] = 213; sin_lut[ 99] = 211;
    sin_lut[100] = 209; sin_lut[101] = 206; sin_lut[102] = 204; sin_lut[103] = 201;
    sin_lut[104] = 199; sin_lut[105] = 196; sin_lut[106] = 193; sin_lut[107] = 191;
    sin_lut[108] = 188; sin_lut[109] = 185; sin_lut[110] = 182; sin_lut[111] = 179;
    sin_lut[112] = 177; sin_lut[113] = 174; sin_lut[114] = 171; sin_lut[115] = 168;
    sin_lut[116] = 165; sin_lut[117] = 162; sin_lut[118] = 159; sin_lut[119] = 156;
    sin_lut[120] = 153; sin_lut[121] = 150; sin_lut[122] = 147; sin_lut[123] = 144;
    sin_lut[124] = 140; sin_lut[125] = 137; sin_lut[126] = 134; sin_lut[127] = 131;
    sin_lut[128] = 128; sin_lut[129] = 125; sin_lut[130] = 122; sin_lut[131] = 119;
    sin_lut[132] = 116; sin_lut[133] = 112; sin_lut[134] = 109; sin_lut[135] = 106;
    sin_lut[136] = 103; sin_lut[137] = 100; sin_lut[138] =  97; sin_lut[139] =  94;
    sin_lut[140] =  91; sin_lut[141] =  88; sin_lut[142] =  85; sin_lut[143] =  82;
    sin_lut[144] =  79; sin_lut[145] =  77; sin_lut[146] =  74; sin_lut[147] =  71;
    sin_lut[148] =  68; sin_lut[149] =  65; sin_lut[150] =  63; sin_lut[151] =  60;
    sin_lut[152] =  57; sin_lut[153] =  55; sin_lut[154] =  52; sin_lut[155] =  50;
    sin_lut[156] =  47; sin_lut[157] =  45; sin_lut[158] =  43; sin_lut[159] =  40;
    sin_lut[160] =  38; sin_lut[161] =  36; sin_lut[162] =  34; sin_lut[163] =  32;
    sin_lut[164] =  30; sin_lut[165] =  28; sin_lut[166] =  26; sin_lut[167] =  24;
    sin_lut[168] =  22; sin_lut[169] =  21; sin_lut[170] =  19; sin_lut[171] =  17;
    sin_lut[172] =  16; sin_lut[173] =  15; sin_lut[174] =  13; sin_lut[175] =  12;
    sin_lut[176] =  11; sin_lut[177] =  10; sin_lut[178] =   8; sin_lut[179] =   7;
    sin_lut[180] =   6; sin_lut[181] =   6; sin_lut[182] =   5; sin_lut[183] =   4;
    sin_lut[184] =   3; sin_lut[185] =   3; sin_lut[186] =   2; sin_lut[187] =   2;
    sin_lut[188] =   2; sin_lut[189] =   1; sin_lut[190] =   1; sin_lut[191] =   1;
    sin_lut[192] =   1; sin_lut[193] =   1; sin_lut[194] =   1; sin_lut[195] =   1;
    sin_lut[196] =   2; sin_lut[197] =   2; sin_lut[198] =   2; sin_lut[199] =   3;
    sin_lut[200] =   3; sin_lut[201] =   4; sin_lut[202] =   5; sin_lut[203] =   6;
    sin_lut[204] =   6; sin_lut[205] =   7; sin_lut[206] =   8; sin_lut[207] =  10;
    sin_lut[208] =  11; sin_lut[209] =  12; sin_lut[210] =  13; sin_lut[211] =  15;
    sin_lut[212] =  16; sin_lut[213] =  17; sin_lut[214] =  19; sin_lut[215] =  21;
    sin_lut[216] =  22; sin_lut[217] =  24; sin_lut[218] =  26; sin_lut[219] =  28;
    sin_lut[220] =  30; sin_lut[221] =  32; sin_lut[222] =  34; sin_lut[223] =  36;
    sin_lut[224] =  38; sin_lut[225] =  40; sin_lut[226] =  43; sin_lut[227] =  45;
    sin_lut[228] =  47; sin_lut[229] =  50; sin_lut[230] =  52; sin_lut[231] =  55;
    sin_lut[232] =  57; sin_lut[233] =  60; sin_lut[234] =  63; sin_lut[235] =  65;
    sin_lut[236] =  68; sin_lut[237] =  71; sin_lut[238] =  74; sin_lut[239] =  77;
    sin_lut[240] =  79; sin_lut[241] =  82; sin_lut[242] =  85; sin_lut[243] =  88;
    sin_lut[244] =  91; sin_lut[245] =  94; sin_lut[246] =  97; sin_lut[247] = 100;
    sin_lut[248] = 103; sin_lut[249] = 106; sin_lut[250] = 109; sin_lut[251] = 112;
    sin_lut[252] = 116; sin_lut[253] = 119; sin_lut[254] = 122; sin_lut[255] = 125;
end

// Task to generate radar echo based on multiple targets
// (Uses task instead of function so iverilog can access module-level memories)
task compute_radar_echo;
    input integer sample;
    integer t;
    integer echo_sum;
    integer chirp_phase;
    integer lut_idx;
begin
    echo_sum = 128;  // DC offset
    
    for (t = 0; t < 5; t = t + 1) begin
        if (echo_delay[t] > 0 && sample > echo_delay[t]) begin
            // Simple Doppler modulation
            chirp_phase = ((sample - echo_delay[t]) * 10) % 256;
            lut_idx = (chirp_phase + echo_phase[t]) % 256;
            echo_sum = echo_sum + $signed({1'b0, echo_amplitude[t]}) * 
                       $signed({1'b0, sin_lut[lut_idx]}) / 128;
        end
    end
    
    // Clamp to 8-bit range
    if (echo_sum > 255) echo_sum = 255;
    if (echo_sum < 0) echo_sum = 0;
    
    adc_data_pattern = echo_sum[7:0];
end
endtask

// ============================================================================
// SPI COMMUNICATION MONITORING
// ============================================================================

always @(posedge stm32_sclk_1v8) begin
    if (!stm32_cs_adar1_1v8) begin
        $display("[SPI @%0t] ADAR1: MOSI=%b, MISO=%b", 
                 $time, stm32_mosi_1v8, stm32_miso_1v8);
    end
    if (!stm32_cs_adar2_1v8) begin
        $display("[SPI @%0t] ADAR2: MOSI=%b, MISO=%b", 
                 $time, stm32_mosi_1v8, stm32_miso_1v8);
    end
end

// ============================================================================
// DUT INSTANTIATION
// ============================================================================

radar_system_top #(
`ifdef USB_MODE_1
    .USB_MODE(1)  // FT2232H interface (production 50T board)
`else
    .USB_MODE(0)  // FT601 interface (200T dev board)
`endif
) dut (
    // System Clocks
    .clk_100m(clk_100m),
    .clk_120m_dac(clk_120m_dac),
    .ft601_clk_in(ft601_clk_in),
    .reset_n(reset_n),
    
    // Transmitter Interfaces
    .dac_data(dac_data),
    .dac_clk(dac_clk),
    .dac_sleep(dac_sleep),
    .fpga_rf_switch(fpga_rf_switch),
    .rx_mixer_en(rx_mixer_en),
    .tx_mixer_en(tx_mixer_en),
    
    // ADAR1000 Control
    .adar_tx_load_1(adar_tx_load_1),
    .adar_rx_load_1(adar_rx_load_1),
    .adar_tx_load_2(adar_tx_load_2),
    .adar_rx_load_2(adar_rx_load_2),
    .adar_tx_load_3(adar_tx_load_3),
    .adar_rx_load_3(adar_rx_load_3),
    .adar_tx_load_4(adar_tx_load_4),
    .adar_rx_load_4(adar_rx_load_4),
    .adar_tr_1(adar_tr_1),
    .adar_tr_2(adar_tr_2),
    .adar_tr_3(adar_tr_3),
    .adar_tr_4(adar_tr_4),
    
    // Level Shifter SPI
    .stm32_sclk_3v3(stm32_sclk_3v3),
    .stm32_mosi_3v3(stm32_mosi_3v3),
    .stm32_miso_3v3(stm32_miso_3v3),
    .stm32_cs_adar1_3v3(stm32_cs_adar1_3v3),
    .stm32_cs_adar2_3v3(stm32_cs_adar2_3v3),
    .stm32_cs_adar3_3v3(stm32_cs_adar3_3v3),
    .stm32_cs_adar4_3v3(stm32_cs_adar4_3v3),
    
    .stm32_sclk_1v8(stm32_sclk_1v8),
    .stm32_mosi_1v8(stm32_mosi_1v8),
    .stm32_miso_1v8(stm32_miso_1v8),
    .stm32_cs_adar1_1v8(stm32_cs_adar1_1v8),
    .stm32_cs_adar2_1v8(stm32_cs_adar2_1v8),
    .stm32_cs_adar3_1v8(stm32_cs_adar3_1v8),
    .stm32_cs_adar4_1v8(stm32_cs_adar4_1v8),
    
    // Receiver Interfaces
    .adc_d_p(adc_d_p),
    .adc_d_n(adc_d_n),
    .adc_dco_p(adc_dco_p),
    .adc_dco_n(adc_dco_n),
    .adc_pwdn(adc_pwdn),
    
    // STM32 Control
    .stm32_new_chirp(stm32_new_chirp),
    .stm32_new_elevation(stm32_new_elevation),
    .stm32_new_azimuth(stm32_new_azimuth),
    .stm32_mixers_enable(stm32_mixers_enable),
    
    // FT601 Interface
    .ft601_data(ft601_data),
    .ft601_be(ft601_be),
    .ft601_txe_n(ft601_txe_n),
    .ft601_rxf_n(ft601_rxf_n),
    .ft601_txe(ft601_txe),
    .ft601_rxf(ft601_rxf),
    .ft601_wr_n(ft601_wr_n),
    .ft601_rd_n(ft601_rd_n),
    .ft601_oe_n(ft601_oe_n),
    .ft601_siwu_n(ft601_siwu_n),
    .ft601_srb(ft601_srb),
    .ft601_swb(ft601_swb),
    .ft601_clk_out(ft601_clk_out),
    
    // Status Outputs
    .current_elevation(current_elevation),
    .current_azimuth(current_azimuth),
    .current_chirp(current_chirp),
    .new_chirp_frame(new_chirp_frame),
    .dbg_doppler_data(dbg_doppler_data),
    .dbg_doppler_valid(dbg_doppler_valid),
    .dbg_doppler_bin(dbg_doppler_bin),
    .dbg_range_bin(dbg_range_bin),
    .system_status(system_status)
);

// ============================================================================
// MONITORING AND CHECKING
// ============================================================================

// Transmitter monitoring
always @(posedge clk_100m) begin
    if (new_chirp_frame) begin
        $display("[MON @%0t] New chirp frame: chirp=%0d, elev=%0d, az=%0d",
                 $time, current_chirp, current_elevation, current_azimuth);
    end
end

// DAC output monitoring
integer p;
integer dac_sample_count = 0;
always @(posedge dac_clk) begin
    if (dac_data != 8'h80) begin
        dac_sample_count = dac_sample_count + 1;
        if (dac_sample_count < 50) begin
            $display("[DAC @%0t] data=0x%02h", $time, dac_data);
        end
    end
end

// Doppler output monitoring
integer doppler_count = 0;
always @(posedge clk_100m) begin
    if (dbg_doppler_valid) begin
        doppler_count = doppler_count + 1;
        if (doppler_count < 100) begin
            $display("[DOPPLER @%0t] bin=%0d, range=%0d, data=0x%08h", 
                     $time, dbg_doppler_bin, dbg_range_bin, dbg_doppler_data);
        end
    end
end

// ============================================================================
// TEST COMPLETION
// ============================================================================

initial begin
    #SIM_TIME;
    
    $display("");
    $display("========================================");
    $display("SIMULATION COMPLETE");
    $display("========================================");
    $display("Total simulation time: %0t ns", $time);
    $display("Chirps generated: %0d", chirp_num);
    $display("USB packets sent: %0d", usb_packet_count);
    $display("USB bytes sent: %0d", usb_byte_count);
    $display("Doppler outputs: %0d", doppler_count);
    $display("DAC samples: %0d", dac_sample_count);
    $display("========================================");
    
    // Verify USB data format
    if (usb_packet_count > 0) begin
        $display("");
        $display("USB Packet Analysis:");
        $display("First 10 packets:");
        for (p = 0; p < 10 && p < usb_packet_count; p = p + 1) begin
            $display("  Packet[%0d]: 0x%08h", p, usb_packet_buffer[p]);
        end
    end
    
    $finish;
end

// ============================================================================
// ASSERTIONS AND CHECKS
// ============================================================================

// Check that chirp counter increments properly (procedural equivalent of SVA)
reg [5:0] prev_chirp;
always @(posedge clk_100m) begin
    if (reset_n) begin
        if (new_chirp_frame && (current_chirp == prev_chirp)) begin
            $display("[ASSERT @%0t] WARNING: Chirp counter not incrementing", $time);
        end
        prev_chirp <= current_chirp;
    end
end

// Check that system reset clears status (procedural equivalent of SVA)
always @(negedge reset_n) begin
    #10;  // Wait one clock cycle after reset assertion
    if (system_status != 4'b0000) begin
        $display("[ASSERT @%0t] ERROR: Reset failed to clear status (status=%b)", 
                 $time, system_status);
    end
end

// ============================================================================
// WAVEFORM DUMPING
// ============================================================================

initial begin
    $dumpfile("radar_system_tb.vcd");
    $dumpvars(0, radar_system_tb);
    
    // Optional: dump specific signals for debugging
    $dumpvars(1, dut.tx_inst);
    $dumpvars(1, dut.rx_inst);
    `ifdef USB_MODE_1
    $dumpvars(1, dut.gen_ft2232h.usb_inst);
    `else
    $dumpvars(1, dut.gen_ft601.usb_inst);
    `endif
end

endmodule
