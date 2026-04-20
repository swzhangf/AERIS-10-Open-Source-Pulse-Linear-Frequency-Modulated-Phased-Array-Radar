`timescale 1ns / 1ps
// ============================================================================
// ad9484_interface_400m_stub.v -- Behavioral stub for iverilog simulation
//
// Replaces the real ad9484_interface_400m which uses Xilinx primitives
// (IBUFDS, BUFG, IDDR) that cannot compile in iverilog.
//
// Convention for testbench use:
//   - Drive adc_d_p[7:0] with single-ended 8-bit ADC data
//   - Drive adc_dco_p with the 400MHz clock (testbench-generated)
//   - adc_d_n and adc_dco_n are ignored
//   - adc_dco_bufg = adc_dco_p  (pass-through, no BUFG)
//   - 1-cycle pipeline latency on data, same as real IDDR+register path
// ============================================================================

module ad9484_interface_400m (
    // ADC Physical Interface (LVDS)
    input wire [7:0] adc_d_p,
    input wire [7:0] adc_d_n,
    input wire adc_dco_p,
    input wire adc_dco_n,

    // System Interface
    input wire sys_clk,
    input wire reset_n,

    // Output at 400MHz domain
    output wire [7:0] adc_data_400m,
    output wire adc_data_valid_400m,
    output wire adc_dco_bufg
);

// Pass-through clock (no BUFG needed in simulation)
assign adc_dco_bufg = adc_dco_p;

// 1-cycle pipeline register (matches real IDDR + output register latency)
reg [7:0] adc_data_400m_reg;
reg adc_data_valid_400m_reg;

always @(posedge adc_dco_p or negedge reset_n) begin
    if (!reset_n) begin
        adc_data_400m_reg <= 8'b0;
        adc_data_valid_400m_reg <= 1'b0;
    end else begin
        adc_data_400m_reg <= adc_d_p;
        adc_data_valid_400m_reg <= 1'b1;
    end
end

assign adc_data_400m = adc_data_400m_reg;
assign adc_data_valid_400m = adc_data_valid_400m_reg;

endmodule
