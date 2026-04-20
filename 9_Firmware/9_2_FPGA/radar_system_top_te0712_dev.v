`timescale 1ns / 1ps

module radar_system_top_te0712_dev (
    input wire clk_100m,
    input wire reset_n,
    output wire [3:0] user_led,
    output wire [3:0] system_status
);

wire clk_100m_buf;
wire sys_reset_n;
reg [31:0] hb_counter;

BUFG bufg_100m (
    .I(clk_100m),
    .O(clk_100m_buf)
);

(* ASYNC_REG = "TRUE" *) reg [1:0] reset_sync;
always @(posedge clk_100m_buf or negedge reset_n) begin
    if (!reset_n) begin
        reset_sync <= 2'b00;
    end else begin
        reset_sync <= {reset_sync[0], 1'b1};
    end
end
assign sys_reset_n = reset_sync[1];

always @(posedge clk_100m_buf or negedge sys_reset_n) begin
    if (!sys_reset_n) begin
        hb_counter <= 32'd0;
    end else begin
        hb_counter <= hb_counter + 1'b1;
    end
end

assign user_led[0] = hb_counter[24];
assign user_led[1] = hb_counter[25];
assign user_led[2] = hb_counter[26];
assign user_led[3] = sys_reset_n;

assign system_status[0] = sys_reset_n;
assign system_status[1] = hb_counter[23];
assign system_status[2] = hb_counter[24];
assign system_status[3] = hb_counter[25];

endmodule
