module dac_interface_enhanced (
    input wire clk_120m,
    input wire reset_n,
    input wire [7:0] chirp_data,
    input wire chirp_valid,
    output wire [7:0] dac_data,
    output wire dac_clk,
    output wire dac_sleep
);

// ============================================================================
// DAC data register (fabric FF — feeds ODDR D1/D2 inputs)
// ============================================================================
reg [7:0] dac_data_reg;

always @(posedge clk_120m or negedge reset_n) begin
    if (!reset_n) begin
        dac_data_reg <= 8'd128;  // Center value
    end else if (chirp_valid) begin
        dac_data_reg <= chirp_data;
    end else begin
        dac_data_reg <= 8'd128;  // Default to center when no chirp
    end
end

`ifndef SIMULATION
// ============================================================================
// ODDR for dac_clk forwarding (Xilinx 7-series)
// D1=1, D2=0 produces a clock replica aligned to clk_120m rising edge.
// The ODDR is placed in the IOB, giving near-zero skew between the
// forwarded clock and ODDR data outputs in the same bank.
// ============================================================================
ODDR #(
    .DDR_CLK_EDGE("OPPOSITE_EDGE"),
    .INIT(1'b0),
    .SRTYPE("SYNC")
) oddr_dac_clk (
    .Q(dac_clk),
    .C(clk_120m),
    .CE(1'b1),
    .D1(1'b1),
    .D2(1'b0),
    .R(1'b0),
    .S(1'b0)
);

// ============================================================================
// ODDR for dac_data[7:0] — packs output FFs into IOBs
// D1=D2=same value → SDR behavior through ODDR, but placed in IOB.
// This eliminates fabric routing delay to the output pad.
// ============================================================================
genvar i;
generate
    for (i = 0; i < 8; i = i + 1) begin : oddr_dac_data_gen
        ODDR #(
            .DDR_CLK_EDGE("OPPOSITE_EDGE"),
            .INIT(1'b0),
            .SRTYPE("SYNC")
        ) oddr_dac_data (
            .Q(dac_data[i]),
            .C(clk_120m),
            .CE(1'b1),
            .D1(dac_data_reg[i]),
            .D2(dac_data_reg[i]),
            .R(1'b0),
            .S(1'b0)
        );
    end
endgenerate

`else
// ============================================================================
// Simulation behavioral equivalent
// ============================================================================
assign dac_clk = clk_120m;
assign dac_data = dac_data_reg;
`endif

assign dac_sleep = 1'b0;

endmodule