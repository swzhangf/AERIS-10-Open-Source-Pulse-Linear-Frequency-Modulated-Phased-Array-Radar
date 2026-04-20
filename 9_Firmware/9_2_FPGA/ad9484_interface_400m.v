module ad9484_interface_400m (
    // ADC Physical Interface (LVDS)
    input wire [7:0] adc_d_p,        // ADC Data P
    input wire [7:0] adc_d_n,        // ADC Data N
    input wire adc_dco_p,            // Data Clock Output P (400MHz)
    input wire adc_dco_n,            // Data Clock Output N (400MHz)
    
    // System Interface
    input wire sys_clk,              // 100MHz system clock (for control only)
    input wire reset_n,
    
    // Output at 400MHz domain
    output wire [7:0] adc_data_400m, // ADC data at 400MHz
    output wire adc_data_valid_400m, // Valid at 400MHz
    output wire adc_dco_bufg         // Buffered 400MHz DCO clock for downstream use
);

// LVDS to single-ended conversion
wire [7:0] adc_data;
wire adc_dco;

// IBUFDS for each data bit
// NOTE: IOSTANDARD and DIFF_TERM are set via XDC constraints, not RTL
// parameters, to support multiple FPGA targets with different bank voltages:
//   - XC7A200T (FBG484): Bank 14 VCCO = 2.5V → LVDS_25
//   - XC7A50T  (FTG256): Bank 14 VCCO = 3.3V → LVDS_33
genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin : data_buffers
        IBUFDS #(
            .DIFF_TERM("FALSE"),    // Overridden by XDC DIFF_TERM property
            .IOSTANDARD("DEFAULT")  // Overridden by XDC IOSTANDARD property
        ) ibufds_data (
            .O(adc_data[i]),
            .I(adc_d_p[i]),
            .IB(adc_d_n[i])
        );
    end
endgenerate

// IBUFDS for DCO
IBUFDS #(
    .DIFF_TERM("FALSE"),    // Overridden by XDC DIFF_TERM property
    .IOSTANDARD("DEFAULT")  // Overridden by XDC IOSTANDARD property
) ibufds_dco (
    .O(adc_dco),
    .I(adc_dco_p),
    .IB(adc_dco_n)
);

// ============================================================================
// Clock buffering strategy for source-synchronous ADC interface:
//
// BUFIO: Near-zero insertion delay, can only drive IOB primitives (IDDR).
//        Used for IDDR clocking to match the data path delay through IBUFDS.
//        This eliminates the hold violation caused by BUFG insertion delay.
//
// BUFG:  Global clock buffer for fabric logic (downstream processing).
//        Has ~4 ns insertion delay but that's fine for fabric-to-fabric paths.
// ============================================================================
wire adc_dco_bufio;   // Near-zero delay — drives IDDR only
wire adc_dco_buffered; // BUFG output — drives fabric logic

BUFIO bufio_dco (
    .I(adc_dco),
    .O(adc_dco_bufio)
);

// MMCME2 jitter-cleaning wrapper replaces the direct BUFG.
// The PLL feedback loop attenuates input jitter from ~50 ps to ~20-30 ps,
// reducing clock uncertainty and improving WNS on the 400 MHz CIC path.
wire mmcm_locked;

adc_clk_mmcm mmcm_inst (
    .clk_in       (adc_dco),          // 400 MHz from IBUFDS output
    .reset_n      (reset_n),
    .clk_400m_out (adc_dco_buffered), // Jitter-cleaned 400 MHz on BUFG
    .mmcm_locked  (mmcm_locked)
);
assign adc_dco_bufg = adc_dco_buffered;

// IDDR for capturing DDR data
wire [7:0] adc_data_rise;  // Data on rising edge (BUFIO domain)
wire [7:0] adc_data_fall;  // Data on falling edge (BUFIO domain)

genvar j;
generate
    for (j = 0; j < 8; j = j + 1) begin : iddr_gen
        IDDR #(
            .DDR_CLK_EDGE("SAME_EDGE_PIPELINED"),
            .INIT_Q1(1'b0),
            .INIT_Q2(1'b0),
            .SRTYPE("SYNC")
        ) iddr_inst (
            .Q1(adc_data_rise[j]),   // Rising edge data
            .Q2(adc_data_fall[j]),   // Falling edge data
            .C(adc_dco_bufio),       // BUFIO clock (near-zero insertion delay)
            .CE(1'b1),
            .D(adc_data[j]),
            .R(1'b0),
            .S(1'b0)
        );
    end
endgenerate

// ============================================================================
// Re-register IDDR outputs into BUFG domain
// IDDR with SAME_EDGE_PIPELINED produces outputs stable for a full clock cycle.
// BUFIO and BUFG are derived from the same source (adc_dco), so they are
// frequency-matched. This single register stage transfers from IOB (BUFIO)
// to fabric (BUFG) with guaranteed timing.
// ============================================================================
reg [7:0] adc_data_rise_bufg;
reg [7:0] adc_data_fall_bufg;

always @(posedge adc_dco_buffered) begin
    adc_data_rise_bufg <= adc_data_rise;
    adc_data_fall_bufg <= adc_data_fall;
end

// Combine rising and falling edge data to get 400MSPS stream
reg [7:0] adc_data_400m_reg;
reg adc_data_valid_400m_reg;
reg dco_phase;

// ── Reset synchronizer ────────────────────────────────────────
// reset_n comes from the 100 MHz sys_clk domain.  Assertion (going low)
// is asynchronous and safe — the FFs enter reset instantly.  De-assertion
// (going high) must be synchronised to adc_dco_buffered to avoid
// metastability.  This is the classic "async assert, sync de-assert" pattern.
//
// mmcm_locked gates de-assertion: the 400 MHz domain stays in reset until
// the MMCM PLL has locked and the jitter-cleaned clock is stable.
(* ASYNC_REG = "TRUE" *) reg [1:0] reset_sync_400m;
wire reset_n_400m;
wire reset_n_gated = reset_n & mmcm_locked;

always @(posedge adc_dco_buffered or negedge reset_n_gated) begin
    if (!reset_n_gated)
        reset_sync_400m <= 2'b00;           // async assert (or MMCM not locked)
    else
        reset_sync_400m <= {reset_sync_400m[0], 1'b1};  // sync de-assert
end
assign reset_n_400m = reset_sync_400m[1];

always @(posedge adc_dco_buffered or negedge reset_n_400m) begin
    if (!reset_n_400m) begin
        adc_data_400m_reg <= 8'b0;
        adc_data_valid_400m_reg <= 1'b0;
        dco_phase <= 1'b0;
    end else begin
        dco_phase <= ~dco_phase;
        
        if (dco_phase) begin
            // Output falling edge data (completes the 400MSPS stream)
            adc_data_400m_reg <= adc_data_fall_bufg;
        end else begin
            // Output rising edge data
            adc_data_400m_reg <= adc_data_rise_bufg;
        end
        
        adc_data_valid_400m_reg <= 1'b1; // Always valid when ADC is running
    end
end

assign adc_data_400m = adc_data_400m_reg;
assign adc_data_valid_400m = adc_data_valid_400m_reg;

endmodule