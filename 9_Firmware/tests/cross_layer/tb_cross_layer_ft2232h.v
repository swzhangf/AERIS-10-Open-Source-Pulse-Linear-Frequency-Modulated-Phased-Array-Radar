`timescale 1ns / 1ps

/**
 * tb_cross_layer_ft2232h.v
 *
 * Cross-layer contract testbench for the FT2232H USB interface.
 * Exercises three packet types with known distinctive values and dumps
 * captured bytes to text files that the Python orchestrator can parse.
 *
 * Exercise A: Command round-trip (Host -> FPGA)
 *   - Send every opcode through the 4-byte read FSM
 *   - Dump cmd_opcode, cmd_addr, cmd_value to cmd_results.txt
 *
 * Exercise B: Data packet generation (FPGA -> Host)
 *   - Inject known range/doppler/cfar values
 *   - Capture all 11 output bytes
 *   - Dump to data_packet.txt
 *
 * Exercise C: Status packet generation (FPGA -> Host)
 *   - Set all status inputs to known non-zero values
 *   - Trigger status request
 *   - Capture all 26 output bytes
 *   - Dump to status_packet.txt
 */

module tb_cross_layer_ft2232h;

    // Clock periods
    localparam CLK_PERIOD    = 10.0;   // 100 MHz system clock
    localparam FT_CLK_PERIOD = 16.67;  // 60 MHz FT2232H clock

    // ---- Signals ----
    reg         clk;
    reg         reset_n;
    reg         ft_reset_n;

    // Radar data inputs
    reg  [31:0] range_profile;
    reg         range_valid;
    reg  [15:0] doppler_real;
    reg  [15:0] doppler_imag;
    reg         doppler_valid;
    reg         cfar_detection;
    reg         cfar_valid;

    // FT2232H physical interface
    wire [7:0]  ft_data;
    reg         ft_rxf_n;
    reg         ft_txe_n;
    wire        ft_rd_n;
    wire        ft_wr_n;
    wire        ft_oe_n;
    wire        ft_siwu;
    reg         ft_clk;

    // Host-side bus driver (for command injection)
    reg  [7:0]  host_data_drive;
    reg         host_data_drive_en;
    assign ft_data = host_data_drive_en ? host_data_drive : 8'hZZ;

    // Pulldown to avoid X during idle
    pulldown pd[7:0] (ft_data);

    // DUT command outputs
    wire [31:0] cmd_data;
    wire        cmd_valid;
    wire [7:0]  cmd_opcode;
    wire [7:0]  cmd_addr;
    wire [15:0] cmd_value;

    // Stream control
    reg  [2:0]  stream_control;

    // Status inputs
    reg         status_request;
    reg  [15:0] status_cfar_threshold;
    reg  [2:0]  status_stream_ctrl;
    reg  [1:0]  status_radar_mode;
    reg  [15:0] status_long_chirp;
    reg  [15:0] status_long_listen;
    reg  [15:0] status_guard;
    reg  [15:0] status_short_chirp;
    reg  [15:0] status_short_listen;
    reg  [5:0]  status_chirps_per_elev;
    reg  [1:0]  status_range_mode;
    reg  [4:0]  status_self_test_flags;
    reg  [7:0]  status_self_test_detail;
    reg         status_self_test_busy;
    reg  [3:0]  status_agc_current_gain;
    reg  [7:0]  status_agc_peak_magnitude;
    reg  [7:0]  status_agc_saturation_count;
    reg         status_agc_enable;

    // ---- Clock generators ----
    always #(CLK_PERIOD / 2)    clk    = ~clk;
    always #(FT_CLK_PERIOD / 2) ft_clk = ~ft_clk;

    // ---- DUT instantiation ----
    usb_data_interface_ft2232h uut (
        .clk                    (clk),
        .reset_n                (reset_n),
        .ft_reset_n             (ft_reset_n),
        .range_profile          (range_profile),
        .range_valid            (range_valid),
        .doppler_real           (doppler_real),
        .doppler_imag           (doppler_imag),
        .doppler_valid          (doppler_valid),
        .cfar_detection         (cfar_detection),
        .cfar_valid             (cfar_valid),
        .ft_data                (ft_data),
        .ft_rxf_n               (ft_rxf_n),
        .ft_txe_n               (ft_txe_n),
        .ft_rd_n                (ft_rd_n),
        .ft_wr_n                (ft_wr_n),
        .ft_oe_n                (ft_oe_n),
        .ft_siwu                (ft_siwu),
        .ft_clk                 (ft_clk),
        .cmd_data               (cmd_data),
        .cmd_valid              (cmd_valid),
        .cmd_opcode             (cmd_opcode),
        .cmd_addr               (cmd_addr),
        .cmd_value              (cmd_value),
        .stream_control         (stream_control),
        .status_request         (status_request),
        .status_cfar_threshold  (status_cfar_threshold),
        .status_stream_ctrl     (status_stream_ctrl),
        .status_radar_mode      (status_radar_mode),
        .status_long_chirp      (status_long_chirp),
        .status_long_listen     (status_long_listen),
        .status_guard           (status_guard),
        .status_short_chirp     (status_short_chirp),
        .status_short_listen    (status_short_listen),
        .status_chirps_per_elev (status_chirps_per_elev),
        .status_range_mode      (status_range_mode),
        .status_self_test_flags (status_self_test_flags),
        .status_self_test_detail(status_self_test_detail),
        .status_self_test_busy  (status_self_test_busy),
        .status_agc_current_gain    (status_agc_current_gain),
        .status_agc_peak_magnitude  (status_agc_peak_magnitude),
        .status_agc_saturation_count(status_agc_saturation_count),
        .status_agc_enable          (status_agc_enable)
    );

    // ---- Test bookkeeping ----
    integer pass_count;
    integer fail_count;
    integer test_num;
    integer cmd_file;
    integer data_file;
    integer status_file;

    // ---- Check task ----
    task check;
        input cond;
        input [511:0] label;
        begin
            test_num = test_num + 1;
            if (cond) begin
                $display("[PASS] Test %0d: %0s", test_num, label);
                pass_count = pass_count + 1;
            end else begin
                $display("[FAIL] Test %0d: %0s", test_num, label);
                fail_count = fail_count + 1;
            end
        end
    endtask

    // ---- Helper: apply reset ----
    task apply_reset;
        begin
            reset_n          = 0;
            ft_reset_n       = 0;
            range_profile    = 32'h0;
            range_valid      = 0;
            doppler_real     = 16'h0;
            doppler_imag     = 16'h0;
            doppler_valid    = 0;
            cfar_detection   = 0;
            cfar_valid       = 0;
            ft_rxf_n         = 1;    // No host data available
            ft_txe_n         = 0;    // TX FIFO ready
            host_data_drive  = 8'h0;
            host_data_drive_en = 0;
            stream_control        = 3'b111;
            status_request        = 0;
            status_cfar_threshold = 16'd0;
            status_stream_ctrl    = 3'b000;
            status_radar_mode     = 2'b00;
            status_long_chirp     = 16'd0;
            status_long_listen    = 16'd0;
            status_guard          = 16'd0;
            status_short_chirp    = 16'd0;
            status_short_listen   = 16'd0;
            status_chirps_per_elev = 6'd0;
            status_range_mode     = 2'b00;
            status_self_test_flags  = 5'b00000;
            status_self_test_detail = 8'd0;
            status_self_test_busy   = 1'b0;
            status_agc_current_gain     = 4'd0;
            status_agc_peak_magnitude   = 8'd0;
            status_agc_saturation_count = 8'd0;
            status_agc_enable           = 1'b0;
            repeat (6) @(posedge ft_clk);
            reset_n    = 1;
            ft_reset_n = 1;
            // Wait for stream_control CDC to propagate
            repeat (8) @(posedge ft_clk);
        end
    endtask

    // ---- Helper: send one 4-byte command via FT2232H read path ----
    //
    // FT2232H read FSM cycle-by-cycle:
    //   Cycle 0 (RD_IDLE):      sees !ft_rxf_n → ft_oe_n<=0, → RD_OE_ASSERT
    //   Cycle 1 (RD_OE_ASSERT): sees !ft_rxf_n → ft_rd_n<=0, → RD_READING
    //   Cycle 2 (RD_READING):   samples ft_data=byte0, cnt 0→1
    //   Cycle 3 (RD_READING):   samples ft_data=byte1, cnt 1→2
    //   Cycle 4 (RD_READING):   samples ft_data=byte2, cnt 2→3
    //   Cycle 5 (RD_READING):   samples ft_data=byte3, cnt=3→0, → RD_DEASSERT
    //   Cycle 6 (RD_DEASSERT):  ft_oe_n<=1, → RD_PROCESS
    //   Cycle 7 (RD_PROCESS):   cmd_valid<=1, decode, → RD_IDLE
    //
    // Data must be stable BEFORE the sampling posedge. We use #1 after
    // posedge to change data in the "delta after" region.
    task send_command_ft2232h;
        input [7:0] byte0;  // opcode
        input [7:0] byte1;  // addr
        input [7:0] byte2;  // value_hi
        input [7:0] byte3;  // value_lo
        begin
            // Pre-drive byte0 and signal data available
            @(posedge ft_clk); #1;
            host_data_drive    = byte0;
            host_data_drive_en = 1;
            ft_rxf_n           = 0;

            // Cycle 0: RD_IDLE sees !ft_rxf_n, goes to OE_ASSERT
            @(posedge ft_clk); #1;

            // Cycle 1: RD_OE_ASSERT, ft_rd_n goes low, goes to RD_READING
            @(posedge ft_clk); #1;

            // Cycle 2: RD_READING, byte0 is sampled, cnt 0→1
            // Now change to byte1 for next sample
            @(posedge ft_clk); #1;
            host_data_drive = byte1;

            // Cycle 3: RD_READING, byte1 is sampled, cnt 1→2
            @(posedge ft_clk); #1;
            host_data_drive = byte2;

            // Cycle 4: RD_READING, byte2 is sampled, cnt 2→3
            @(posedge ft_clk); #1;
            host_data_drive = byte3;

            // Cycle 5: RD_READING, byte3 is sampled, cnt=3, → RD_DEASSERT
            @(posedge ft_clk); #1;

            // Cycle 6: RD_DEASSERT, ft_oe_n←1, → RD_PROCESS
            @(posedge ft_clk); #1;

            // Cycle 7: RD_PROCESS, cmd decoded, cmd_valid←1, → RD_IDLE
            @(posedge ft_clk); #1;

            // cmd_valid was asserted at cycle 7's posedge. cmd_opcode/addr/value
            // are now valid (registered outputs hold until next RD_PROCESS).

            // Release bus
            host_data_drive_en = 0;
            host_data_drive    = 8'h0;
            ft_rxf_n           = 1;

            // Settle
            repeat (2) @(posedge ft_clk);
        end
    endtask

    // ---- Helper: capture N write bytes from the DUT ----
    // Monitors ft_wr_n and ft_data_out, captures bytes into array.
    // Used for data packets (11 bytes) and status packets (26 bytes).
    reg [7:0] captured_bytes [0:31];
    integer   capture_count;

    task capture_write_bytes;
        input integer expected_count;
        integer timeout;
        begin
            capture_count = 0;
            timeout = 0;

            while (capture_count < expected_count && timeout < 2000) begin
                @(posedge ft_clk); #1;
                timeout = timeout + 1;
                // DUT drives byte when ft_wr_n=0 and ft_data_oe=1
                // Sample AFTER posedge so registered outputs are settled
                if (!ft_wr_n && uut.ft_data_oe) begin
                    captured_bytes[capture_count] = uut.ft_data_out;
                    capture_count = capture_count + 1;
                end
            end
        end
    endtask

    // ---- Helper: pulse range_valid with CDC wait ----
    // Toggle CDC needs 3 sync stages + edge detect = 4+ ft_clk cycles.
    // Use 12 for safety margin.
    task assert_range_valid;
        input [31:0] data;
        begin
            @(posedge clk); #1;
            range_profile = data;
            range_valid   = 1;
            @(posedge clk); #1;
            range_valid   = 0;
            // Wait for toggle CDC propagation
            repeat (12) @(posedge ft_clk);
        end
    endtask

    // ---- Helper: pulse doppler_valid ----
    task pulse_doppler;
        input [15:0] dr;
        input [15:0] di;
        begin
            @(posedge clk); #1;
            doppler_real  = dr;
            doppler_imag  = di;
            doppler_valid = 1;
            @(posedge clk); #1;
            doppler_valid = 0;
            repeat (12) @(posedge ft_clk);
        end
    endtask

    // ---- Helper: pulse cfar_valid ----
    task pulse_cfar;
        input det;
        begin
            @(posedge clk); #1;
            cfar_detection = det;
            cfar_valid     = 1;
            @(posedge clk); #1;
            cfar_valid     = 0;
            repeat (12) @(posedge ft_clk);
        end
    endtask

    // ---- Helper: pulse status_request ----
    task pulse_status_request;
        begin
            @(posedge clk); #1;
            status_request = 1;
            @(posedge clk); #1;
            status_request = 0;
            // Wait for toggle CDC propagation
            repeat (12) @(posedge ft_clk);
        end
    endtask

    // ================================================================
    // Main stimulus
    // ================================================================
    integer i;

    initial begin
        $dumpfile("tb_cross_layer_ft2232h.vcd");
        $dumpvars(0, tb_cross_layer_ft2232h);

        clk    = 0;
        ft_clk = 0;
        pass_count = 0;
        fail_count = 0;
        test_num   = 0;

        // ============================================================
        // EXERCISE A: Command Round-Trip
        // Send commands with known opcode/addr/value, verify decoding.
        // Dump results to cmd_results.txt for Python validation.
        // ============================================================
        $display("\n=== EXERCISE A: Command Round-Trip ===");
        apply_reset;

        cmd_file = $fopen("cmd_results.txt", "w");
        $fwrite(cmd_file, "# opcode_sent addr_sent value_sent opcode_got addr_got value_got\n");

        // Test all real opcodes from radar_system_top.v
        // Format: opcode, addr=0x00, value

        // Basic control
        send_command_ft2232h(8'h01, 8'h00, 8'h00, 8'h02);  // RADAR_MODE=2
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h01, 8'h00, 16'h0002, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h01 && cmd_value === 16'h0002,
              "Cmd 0x01: RADAR_MODE=2");

        send_command_ft2232h(8'h02, 8'h00, 8'h00, 8'h01);  // TRIGGER_PULSE
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h02, 8'h00, 16'h0001, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h02 && cmd_value === 16'h0001,
              "Cmd 0x02: TRIGGER_PULSE");

        send_command_ft2232h(8'h03, 8'h00, 8'h27, 8'h10);  // DETECT_THRESHOLD=10000
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h03, 8'h00, 16'h2710, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h03 && cmd_value === 16'h2710,
              "Cmd 0x03: DETECT_THRESHOLD=10000");

        send_command_ft2232h(8'h04, 8'h00, 8'h00, 8'h07);  // STREAM_CONTROL=7
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h04, 8'h00, 16'h0007, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h04 && cmd_value === 16'h0007,
              "Cmd 0x04: STREAM_CONTROL=7");

        // Chirp timing
        send_command_ft2232h(8'h10, 8'h00, 8'h0B, 8'hB8);  // LONG_CHIRP=3000
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h10, 8'h00, 16'h0BB8, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h10 && cmd_value === 16'h0BB8,
              "Cmd 0x10: LONG_CHIRP=3000");

        send_command_ft2232h(8'h11, 8'h00, 8'h35, 8'h84);  // LONG_LISTEN=13700
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h11, 8'h00, 16'h3584, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h11 && cmd_value === 16'h3584,
              "Cmd 0x11: LONG_LISTEN=13700");

        send_command_ft2232h(8'h12, 8'h00, 8'h44, 8'h84);  // GUARD=17540
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h12, 8'h00, 16'h4484, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h12 && cmd_value === 16'h4484,
              "Cmd 0x12: GUARD=17540");

        send_command_ft2232h(8'h13, 8'h00, 8'h00, 8'h32);  // SHORT_CHIRP=50
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h13, 8'h00, 16'h0032, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h13 && cmd_value === 16'h0032,
              "Cmd 0x13: SHORT_CHIRP=50");

        send_command_ft2232h(8'h14, 8'h00, 8'h44, 8'h2A);  // SHORT_LISTEN=17450
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h14, 8'h00, 16'h442A, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h14 && cmd_value === 16'h442A,
              "Cmd 0x14: SHORT_LISTEN=17450");

        send_command_ft2232h(8'h15, 8'h00, 8'h00, 8'h20);  // CHIRPS_PER_ELEV=32
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h15, 8'h00, 16'h0020, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h15 && cmd_value === 16'h0020,
              "Cmd 0x15: CHIRPS_PER_ELEV=32");

        // Digital gain
        send_command_ft2232h(8'h16, 8'h00, 8'h00, 8'h05);  // GAIN_SHIFT=5
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h16, 8'h00, 16'h0005, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h16 && cmd_value === 16'h0005,
              "Cmd 0x16: GAIN_SHIFT=5");

        // Signal processing
        send_command_ft2232h(8'h20, 8'h00, 8'h00, 8'h01);  // RANGE_MODE=1
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h20, 8'h00, 16'h0001, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h20 && cmd_value === 16'h0001,
              "Cmd 0x20: RANGE_MODE=1");

        send_command_ft2232h(8'h21, 8'h00, 8'h00, 8'h03);  // CFAR_GUARD=3
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h21, 8'h00, 16'h0003, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h21 && cmd_value === 16'h0003,
              "Cmd 0x21: CFAR_GUARD=3");

        send_command_ft2232h(8'h22, 8'h00, 8'h00, 8'h0C);  // CFAR_TRAIN=12
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h22, 8'h00, 16'h000C, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h22 && cmd_value === 16'h000C,
              "Cmd 0x22: CFAR_TRAIN=12");

        send_command_ft2232h(8'h23, 8'h00, 8'h00, 8'h30);  // CFAR_ALPHA=0x30
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h23, 8'h00, 16'h0030, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h23 && cmd_value === 16'h0030,
              "Cmd 0x23: CFAR_ALPHA=0x30");

        send_command_ft2232h(8'h24, 8'h00, 8'h00, 8'h01);  // CFAR_MODE=1 (GO)
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h24, 8'h00, 16'h0001, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h24 && cmd_value === 16'h0001,
              "Cmd 0x24: CFAR_MODE=1");

        send_command_ft2232h(8'h25, 8'h00, 8'h00, 8'h01);  // CFAR_ENABLE=1
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h25, 8'h00, 16'h0001, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h25 && cmd_value === 16'h0001,
              "Cmd 0x25: CFAR_ENABLE=1");

        send_command_ft2232h(8'h26, 8'h00, 8'h00, 8'h01);  // MTI_ENABLE=1
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h26, 8'h00, 16'h0001, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h26 && cmd_value === 16'h0001,
              "Cmd 0x26: MTI_ENABLE=1");

        send_command_ft2232h(8'h27, 8'h00, 8'h00, 8'h03);  // DC_NOTCH_WIDTH=3
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h27, 8'h00, 16'h0003, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h27 && cmd_value === 16'h0003,
              "Cmd 0x27: DC_NOTCH_WIDTH=3");

        // AGC registers (0x28-0x2C)
        send_command_ft2232h(8'h28, 8'h00, 8'h00, 8'h01);  // AGC_ENABLE=1
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h28, 8'h00, 16'h0001, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h28 && cmd_value === 16'h0001,
              "Cmd 0x28: AGC_ENABLE=1");

        send_command_ft2232h(8'h29, 8'h00, 8'h00, 8'hC8);  // AGC_TARGET=200
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h29, 8'h00, 16'h00C8, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h29 && cmd_value === 16'h00C8,
              "Cmd 0x29: AGC_TARGET=200");

        send_command_ft2232h(8'h2A, 8'h00, 8'h00, 8'h02);  // AGC_ATTACK=2
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h2A, 8'h00, 16'h0002, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h2A && cmd_value === 16'h0002,
              "Cmd 0x2A: AGC_ATTACK=2");

        send_command_ft2232h(8'h2B, 8'h00, 8'h00, 8'h03);  // AGC_DECAY=3
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h2B, 8'h00, 16'h0003, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h2B && cmd_value === 16'h0003,
              "Cmd 0x2B: AGC_DECAY=3");

        send_command_ft2232h(8'h2C, 8'h00, 8'h00, 8'h06);  // AGC_HOLDOFF=6
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h2C, 8'h00, 16'h0006, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h2C && cmd_value === 16'h0006,
              "Cmd 0x2C: AGC_HOLDOFF=6");

        // Self-test / status
        send_command_ft2232h(8'h30, 8'h00, 8'h00, 8'h01);  // SELF_TEST_TRIGGER
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h30, 8'h00, 16'h0001, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h30 && cmd_value === 16'h0001,
              "Cmd 0x30: SELF_TEST_TRIGGER");

        send_command_ft2232h(8'h31, 8'h00, 8'h00, 8'h01);  // SELF_TEST_STATUS
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h31, 8'h00, 16'h0001, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h31 && cmd_value === 16'h0001,
              "Cmd 0x31: SELF_TEST_STATUS");

        send_command_ft2232h(8'hFF, 8'h00, 8'h00, 8'h00);  // STATUS_REQUEST
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'hFF, 8'h00, 16'h0000, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'hFF && cmd_value === 16'h0000,
              "Cmd 0xFF: STATUS_REQUEST");

        // Non-zero addr test
        send_command_ft2232h(8'h01, 8'hAB, 8'hCD, 8'hEF);  // addr=0xAB, value=0xCDEF
        $fwrite(cmd_file, "%02x %02x %04x %02x %02x %04x\n",
                8'h01, 8'hAB, 16'hCDEF, cmd_opcode, cmd_addr, cmd_value);
        check(cmd_opcode === 8'h01 && cmd_addr === 8'hAB && cmd_value === 16'hCDEF,
              "Cmd 0x01 with addr=0xAB, value=0xCDEF");

        $fclose(cmd_file);

        // ============================================================
        // EXERCISE B: Data Packet Generation
        // Inject known values, capture 11-byte output.
        // ============================================================
        $display("\n=== EXERCISE B: Data Packet Generation ===");
        apply_reset;
        ft_txe_n = 0;  // TX FIFO ready

        // Use distinctive values that make truncation/swap bugs obvious
        // range_profile = {Q[15:0], I[15:0]} = {0xCAFE, 0xBEEF}
        // doppler_real = 0x1234, doppler_imag = 0x5678
        // cfar_detection = 1

        // First inject doppler and cfar so pending flags are set
        pulse_doppler(16'h1234, 16'h5678);
        pulse_cfar(1'b1);

        // Now inject range_valid which triggers the write FSM.
        // CRITICAL: Must capture bytes IN PARALLEL with the trigger,
        // because the write FSM starts sending bytes ~3-4 ft_clk cycles
        // after the toggle CDC propagates. If we wait for CDC propagation
        // first, capture_write_bytes misses the early bytes.
        fork
            assert_range_valid(32'hCAFE_BEEF);
            capture_write_bytes(11);
        join

        check(capture_count === 11,
              "Data packet: captured 11 bytes");

        // Dump captured bytes to file
        data_file = $fopen("data_packet.txt", "w");
        $fwrite(data_file, "# byte_index hex_value\n");
        for (i = 0; i < capture_count; i = i + 1) begin
            $fwrite(data_file, "%0d %02x\n", i, captured_bytes[i]);
        end
        $fclose(data_file);

        // Verify locally too
        check(captured_bytes[0] === 8'hAA,
              "Data pkt: byte 0 = 0xAA (header)");
        check(captured_bytes[1] === 8'hCA,
              "Data pkt: byte 1 = 0xCA (range MSB = Q high)");
        check(captured_bytes[2] === 8'hFE,
              "Data pkt: byte 2 = 0xFE (range Q low)");
        check(captured_bytes[3] === 8'hBE,
              "Data pkt: byte 3 = 0xBE (range I high)");
        check(captured_bytes[4] === 8'hEF,
              "Data pkt: byte 4 = 0xEF (range I low)");
        check(captured_bytes[5] === 8'h12,
              "Data pkt: byte 5 = 0x12 (doppler_real MSB)");
        check(captured_bytes[6] === 8'h34,
              "Data pkt: byte 6 = 0x34 (doppler_real LSB)");
        check(captured_bytes[7] === 8'h56,
              "Data pkt: byte 7 = 0x56 (doppler_imag MSB)");
        check(captured_bytes[8] === 8'h78,
              "Data pkt: byte 8 = 0x78 (doppler_imag LSB)");
        // Byte 9 = {frame_start, 6'b0, cfar_detection}
        // After reset sample_counter==0, so frame_start=1 → 0x81
        check(captured_bytes[9] === 8'h81,
              "Data pkt: byte 9 = 0x81 (frame_start=1, cfar_detection=1)");
        check(captured_bytes[10] === 8'h55,
              "Data pkt: byte 10 = 0x55 (footer)");

        // ============================================================
        // EXERCISE C: Status Packet Generation
        // Set known status values, trigger readback, capture 26 bytes.
        // Uses distinctive non-zero values to detect truncation/swap.
        // ============================================================
        $display("\n=== EXERCISE C: Status Packet Generation ===");
        apply_reset;
        ft_txe_n = 0;

        // Set known distinctive status values
        status_cfar_threshold  = 16'hABCD;
        status_stream_ctrl     = 3'b101;
        status_radar_mode      = 2'b11;    // Use 0b11 to test both bits
        status_long_chirp      = 16'h1234;
        status_long_listen     = 16'h5678;
        status_guard           = 16'h9ABC;
        status_short_chirp     = 16'hDEF0;
        status_short_listen    = 16'hFACE;
        status_chirps_per_elev = 6'd42;
        status_range_mode      = 2'b10;
        status_self_test_flags  = 5'b10101;
        status_self_test_detail = 8'hA5;
        status_self_test_busy   = 1'b1;
        status_agc_current_gain     = 4'd7;
        status_agc_peak_magnitude   = 8'd200;
        status_agc_saturation_count = 8'd15;
        status_agc_enable           = 1'b1;

        // Pulse status_request and capture bytes IN PARALLEL
        // (same reason as Exercise B — write FSM starts before CDC wait ends)
        fork
            pulse_status_request;
            capture_write_bytes(26);
        join

        check(capture_count === 26,
              "Status packet: captured 26 bytes");

        // Dump captured bytes to file
        status_file = $fopen("status_packet.txt", "w");
        $fwrite(status_file, "# byte_index hex_value\n");
        for (i = 0; i < capture_count; i = i + 1) begin
            $fwrite(status_file, "%0d %02x\n", i, captured_bytes[i]);
        end

        // Also dump the raw status_words for debugging
        $fwrite(status_file, "# status_words (internal):\n");
        for (i = 0; i < 6; i = i + 1) begin
            $fwrite(status_file, "# word[%0d] = %08x\n", i, uut.status_words[i]);
        end
        $fclose(status_file);

        // Verify header/footer locally
        check(captured_bytes[0] === 8'hBB,
              "Status pkt: byte 0 = 0xBB (status header)");
        check(captured_bytes[25] === 8'h55,
              "Status pkt: byte 25 = 0x55 (footer)");

        // Verify status_words[1] = {long_chirp, long_listen} = {0x1234, 0x5678}
        check(captured_bytes[5] === 8'h12 && captured_bytes[6] === 8'h34 &&
              captured_bytes[7] === 8'h56 && captured_bytes[8] === 8'h78,
              "Status pkt: word1 = {long_chirp=0x1234, long_listen=0x5678}");

        // Verify status_words[2] = {guard, short_chirp} = {0x9ABC, 0xDEF0}
        check(captured_bytes[9] === 8'h9A && captured_bytes[10] === 8'hBC &&
              captured_bytes[11] === 8'hDE && captured_bytes[12] === 8'hF0,
              "Status pkt: word2 = {guard=0x9ABC, short_chirp=0xDEF0}");

        // ============================================================
        // Summary
        // ============================================================
        $display("");
        $display("========================================");
        $display("  CROSS-LAYER FT2232H TB RESULTS");
        $display("  PASSED: %0d / %0d", pass_count, test_num);
        $display("  FAILED: %0d / %0d", fail_count, test_num);
        if (fail_count == 0)
            $display("  ** ALL TESTS PASSED **");
        else
            $display("  ** SOME TESTS FAILED **");
        $display("========================================");

        #100;
        $finish;
    end

endmodule
