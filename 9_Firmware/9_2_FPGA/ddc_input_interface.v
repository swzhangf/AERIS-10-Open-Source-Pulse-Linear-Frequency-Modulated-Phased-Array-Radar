`timescale 1ns / 1ps
// ddc_input_interface.v
module ddc_input_interface (
    input wire clk,           // 100MHz
    input wire reset_n,
    
    // DDC Input (18-bit)
    input wire signed [17:0] ddc_i,
    input wire signed [17:0] ddc_q,
    input wire valid_i,
    input wire valid_q,
    
    // Scaled output (16-bit)
    output reg signed [15:0] adc_i,
    output reg signed [15:0] adc_q,
    output reg adc_valid,
    
    // Status
    output wire data_sync_error
);

// Synchronize valid signals
reg valid_i_reg, valid_q_reg;
reg valid_sync;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        valid_i_reg <= 1'b0;
        valid_q_reg <= 1'b0;
        valid_sync <= 1'b0;
        adc_valid <= 1'b0;
    end else begin
        valid_i_reg <= valid_i;
        valid_q_reg <= valid_q;
        
        // Require both I and Q valid simultaneously
        valid_sync <= valid_i_reg && valid_q_reg;
        adc_valid <= valid_sync;
    end
end

// Scale 18-bit to 16-bit with convergent rounding + saturation
// ddc_i[17:2] extracts the upper 16 bits; ddc_i[1] is the rounding bit.
// Without saturation, 0x7FFF + 1 = 0x8000 (sign flip at positive full scale).
// Fix: saturate to 0x7FFF when rounding would overflow a positive value.
// Negative values cannot overflow: the most negative 18-bit value (-131072)
// truncates to -8192 (0x8000 as 16-bit) and rounding only moves toward zero.
wire [15:0] trunc_i = ddc_i[17:2];
wire [15:0] trunc_q = ddc_q[17:2];
wire        round_i = ddc_i[1];
wire        round_q = ddc_q[1];

// Overflow occurs only when truncated value is max positive AND round bit set
wire        sat_i = (trunc_i == 16'h7FFF) & round_i;
wire        sat_q = (trunc_q == 16'h7FFF) & round_q;

always @(posedge clk) begin
    if (valid_sync) begin
        adc_i <= sat_i ? 16'sh7FFF : (trunc_i + {15'b0, round_i});
        adc_q <= sat_q ? 16'sh7FFF : (trunc_q + {15'b0, round_q});
    end
end

// Error detection
assign data_sync_error = (valid_i_reg ^ valid_q_reg);

endmodule