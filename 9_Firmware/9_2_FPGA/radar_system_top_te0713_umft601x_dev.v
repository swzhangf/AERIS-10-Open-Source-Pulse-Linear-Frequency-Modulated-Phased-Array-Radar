`timescale 1ns / 1ps

module radar_system_top_te0713_umft601x_dev (
    input  wire        ft601_clk_in,
    inout  wire [31:0] ft601_data,
    output wire [3:0]  ft601_be,
    input  wire        ft601_txe,
    input  wire        ft601_rxf,
    output wire        ft601_wr_n,
    output wire        ft601_rd_n,
    output wire        ft601_oe_n,
    output wire        ft601_siwu_n,
    output wire        ft601_chip_reset_n,
    output wire        ft601_wakeup_n,
    output wire        ft601_gpio0,
    output wire        ft601_gpio1
);

reg [15:0] por_counter = 16'd0;
reg [31:0] hb_counter = 32'd0;
reg [15:0] packet_div = 16'd0;
reg [2:0] stream_control_reg = 3'b001;
reg        status_request_reg = 1'b0;
reg [31:0] range_profile_reg = 32'd0;
reg        range_valid_reg = 1'b0;
reg [15:0] doppler_real_reg = 16'd0;
reg [15:0] doppler_imag_reg = 16'd0;
reg        doppler_valid_reg = 1'b0;
reg        cfar_detection_reg = 1'b0;
reg        cfar_valid_reg = 1'b0;

wire        sys_reset_n;
wire [31:0] cmd_data;
wire        cmd_valid;
wire [7:0]  cmd_opcode;
wire [7:0]  cmd_addr;
wire [15:0] cmd_value;
wire        ft601_clk_out_unused;
wire        ft601_txe_n_unused;
wire        ft601_rxf_n_unused;

assign sys_reset_n = por_counter[15];
assign ft601_chip_reset_n = sys_reset_n;
assign ft601_wakeup_n = 1'b1;
assign ft601_gpio0 = hb_counter[24];
assign ft601_gpio1 = sys_reset_n;

always @(posedge ft601_clk_in) begin
    if (!sys_reset_n) begin
        por_counter <= por_counter + 1'b1;
        hb_counter <= 32'd0;
        packet_div <= 16'd0;
        stream_control_reg <= 3'b001;
        status_request_reg <= 1'b0;
        range_profile_reg <= 32'd0;
        range_valid_reg <= 1'b0;
        doppler_real_reg <= 16'd0;
        doppler_imag_reg <= 16'd0;
        doppler_valid_reg <= 1'b0;
        cfar_detection_reg <= 1'b0;
        cfar_valid_reg <= 1'b0;
    end else begin
        hb_counter <= hb_counter + 1'b1;
        packet_div <= packet_div + 1'b1;

        status_request_reg <= 1'b0;
        range_valid_reg <= 1'b0;
        doppler_valid_reg <= 1'b0;
        cfar_valid_reg <= 1'b0;

        if (cmd_valid) begin
            case (cmd_opcode)
                8'h04: stream_control_reg <= cmd_value[2:0];
                8'hFF: status_request_reg <= 1'b1;
                default: ;
            endcase
        end

        if (packet_div == 16'hFFFF && stream_control_reg[0]) begin
            range_profile_reg <= {hb_counter[31:16], hb_counter[15:0] ^ 16'hA5A5};
            range_valid_reg <= 1'b1;

            if (stream_control_reg[1]) begin
                doppler_real_reg <= hb_counter[31:16];
                doppler_imag_reg <= hb_counter[15:0];
                doppler_valid_reg <= 1'b1;
            end

            if (stream_control_reg[2]) begin
                cfar_detection_reg <= hb_counter[10];
                cfar_valid_reg <= 1'b1;
            end
        end
    end
end

usb_data_interface usb_inst (
    .clk(ft601_clk_in),
    .reset_n(sys_reset_n),
    .ft601_reset_n(sys_reset_n),
    .range_profile(range_profile_reg),
    .range_valid(range_valid_reg),
    .doppler_real(doppler_real_reg),
    .doppler_imag(doppler_imag_reg),
    .doppler_valid(doppler_valid_reg),
    .cfar_detection(cfar_detection_reg),
    .cfar_valid(cfar_valid_reg),
    .ft601_data(ft601_data),
    .ft601_be(ft601_be),
    .ft601_txe_n(ft601_txe_n_unused),
    .ft601_rxf_n(ft601_rxf_n_unused),
    .ft601_txe(ft601_txe),
    .ft601_rxf(ft601_rxf),
    .ft601_wr_n(ft601_wr_n),
    .ft601_rd_n(ft601_rd_n),
    .ft601_oe_n(ft601_oe_n),
    .ft601_siwu_n(ft601_siwu_n),
    .ft601_srb(2'b00),
    .ft601_swb(2'b00),
    .ft601_clk_out(ft601_clk_out_unused),
    .ft601_clk_in(ft601_clk_in),
    .cmd_data(cmd_data),
    .cmd_valid(cmd_valid),
    .cmd_opcode(cmd_opcode),
    .cmd_addr(cmd_addr),
    .cmd_value(cmd_value),
    .stream_control(stream_control_reg),
    .status_request(status_request_reg),
    .status_cfar_threshold(16'h1234),
    .status_stream_ctrl(stream_control_reg),
    .status_radar_mode(2'b00),
    .status_long_chirp(16'd3000),
    .status_long_listen(16'd13700),
    .status_guard(16'd17540),
    .status_short_chirp(16'd50),
    .status_short_listen(16'd17450),
    .status_chirps_per_elev(6'd32),
    .status_range_mode(2'b01),
    .status_self_test_flags(5'b11111),
    .status_self_test_detail(8'hA5),
    .status_self_test_busy(1'b0),
    // AGC status: tie off with benign defaults (no AGC on dev board)
    .status_agc_current_gain(4'd0),
    .status_agc_peak_magnitude(8'd0),
    .status_agc_saturation_count(8'd0),
    .status_agc_enable(1'b0)
);

endmodule
