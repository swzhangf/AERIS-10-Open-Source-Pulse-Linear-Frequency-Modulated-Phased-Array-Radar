`timescale 1ns / 1ps
//
// AERIS-10 TE0713+TE0701 Dev Heartbeat
//
// Minimal design to verify FPGA configuration and clock.
// Uses TE0713 FIFO0CLK (50 MHz, Bank 14, LVCMOS15) at pin U20.
// LEDs and status outputs on Bank 16 FMC LA pins (LVCMOS33).
//
// At 50 MHz:
//   user_led[0] toggles at ~1.49 Hz  (bit 24)
//   user_led[1] toggles at ~0.75 Hz  (bit 25)
//   user_led[2] toggles at ~0.37 Hz  (bit 26)
//   user_led[3] toggles at ~0.19 Hz  (bit 27)
//

module radar_system_top_te0713_dev (
    input wire clk_100m,        // TE0713 FIFO0CLK (actually 50 MHz)
    output wire [3:0] user_led,
    output wire [3:0] system_status
);

wire clk_buf;
reg [31:0] hb_counter = 32'd0;

BUFG bufg_clk (
    .I(clk_100m),
    .O(clk_buf)
);

always @(posedge clk_buf) begin
    hb_counter <= hb_counter + 1'b1;
end

assign user_led[0] = hb_counter[24];
assign user_led[1] = hb_counter[25];
assign user_led[2] = hb_counter[26];
assign user_led[3] = hb_counter[27];

assign system_status[0] = hb_counter[23];
assign system_status[1] = hb_counter[24];
assign system_status[2] = hb_counter[25];
assign system_status[3] = hb_counter[26];

endmodule
