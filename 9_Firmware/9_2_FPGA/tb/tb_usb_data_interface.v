`timescale 1ns / 1ps

module tb_usb_data_interface;

    // ── Parameters ─────────────────────────────────────────────
    localparam CLK_PERIOD     = 10.0;  // 100 MHz main clock
    localparam FT_CLK_PERIOD  = 10.0;  // 100 MHz FT601 clock (asynchronous)

    // State definitions (mirror the DUT — 4-state packed-word FSM)
    localparam [3:0] S_IDLE           = 4'd0,
                     S_SEND_DATA_WORD = 4'd1,
                     S_SEND_STATUS    = 4'd2,
                     S_WAIT_ACK       = 4'd3;

    // ── Signals ────────────────────────────────────────────────
    reg         clk;
    reg         reset_n;

    // Radar data inputs
    reg  [31:0] range_profile;
    reg         range_valid;
    reg  [15:0] doppler_real;
    reg  [15:0] doppler_imag;
    reg         doppler_valid;
    reg         cfar_detection;
    reg         cfar_valid;

    // FT601 interface
    wire [31:0] ft601_data;
    wire [3:0]  ft601_be;
    wire        ft601_txe_n;
    wire        ft601_rxf_n;
    reg         ft601_txe;
    reg         ft601_rxf;
    wire        ft601_wr_n;
    wire        ft601_rd_n;
    wire        ft601_oe_n;
    wire        ft601_siwu_n;
    reg  [1:0]  ft601_srb;
    reg  [1:0]  ft601_swb;
    wire        ft601_clk_out;
    reg         ft601_clk_in;

    // Pulldown: when nobody drives, data reads as 0 (not X)
    pulldown pd[31:0] (ft601_data);

    // Host-to-FPGA data bus driver (for read path testing)
    reg [31:0] host_data_drive;
    reg        host_data_drive_en;
    assign ft601_data = host_data_drive_en ? host_data_drive : 32'hzzzz_zzzz;

    // DUT command outputs (Gap 4: USB Read Path)
    wire [31:0] cmd_data;
    wire        cmd_valid;
    wire [7:0]  cmd_opcode;
    wire [7:0]  cmd_addr;
    wire [15:0] cmd_value;

    // Gap 2: Stream control + status readback inputs
    reg  [2:0]  stream_control;
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

    // Self-test status readback inputs
    reg  [4:0]  status_self_test_flags;
    reg  [7:0]  status_self_test_detail;
    reg         status_self_test_busy;

    // AGC status readback inputs
    reg  [3:0]  status_agc_current_gain;
    reg  [7:0]  status_agc_peak_magnitude;
    reg  [7:0]  status_agc_saturation_count;
    reg         status_agc_enable;

    // ── Clock generators (asynchronous) ────────────────────────
    always #(CLK_PERIOD / 2) clk = ~clk;
    always #(FT_CLK_PERIOD / 2) ft601_clk_in = ~ft601_clk_in;

    // ── DUT ────────────────────────────────────────────────────
    usb_data_interface uut (
        .clk              (clk),
        .reset_n          (reset_n),
        .ft601_reset_n    (reset_n),     // In TB, share same reset for both domains
        .range_profile    (range_profile),
        .range_valid      (range_valid),
        .doppler_real     (doppler_real),
        .doppler_imag     (doppler_imag),
        .doppler_valid    (doppler_valid),
        .cfar_detection   (cfar_detection),
        .cfar_valid       (cfar_valid),
        .ft601_data       (ft601_data),
        .ft601_be         (ft601_be),
        .ft601_txe_n      (ft601_txe_n),
        .ft601_rxf_n      (ft601_rxf_n),
        .ft601_txe        (ft601_txe),
        .ft601_rxf        (ft601_rxf),
        .ft601_wr_n       (ft601_wr_n),
        .ft601_rd_n       (ft601_rd_n),
        .ft601_oe_n       (ft601_oe_n),
        .ft601_siwu_n     (ft601_siwu_n),
        .ft601_srb        (ft601_srb),
        .ft601_swb        (ft601_swb),
        .ft601_clk_out    (ft601_clk_out),
        .ft601_clk_in     (ft601_clk_in),
        
        // Host command outputs (Gap 4: USB Read Path)
        .cmd_data         (cmd_data),
        .cmd_valid        (cmd_valid),
        .cmd_opcode       (cmd_opcode),
        .cmd_addr         (cmd_addr),
        .cmd_value        (cmd_value),

        // Gap 2: Stream control + status readback
        .stream_control        (stream_control),
        .status_request        (status_request),
        .status_cfar_threshold (status_cfar_threshold),
        .status_stream_ctrl    (status_stream_ctrl),
        .status_radar_mode     (status_radar_mode),
        .status_long_chirp     (status_long_chirp),
        .status_long_listen    (status_long_listen),
        .status_guard          (status_guard),
        .status_short_chirp    (status_short_chirp),
        .status_short_listen   (status_short_listen),
        .status_chirps_per_elev(status_chirps_per_elev),
        .status_range_mode     (status_range_mode),

        // Self-test status readback
        .status_self_test_flags (status_self_test_flags),
        .status_self_test_detail(status_self_test_detail),
        .status_self_test_busy  (status_self_test_busy),

        // AGC status readback
        .status_agc_current_gain    (status_agc_current_gain),
        .status_agc_peak_magnitude  (status_agc_peak_magnitude),
        .status_agc_saturation_count(status_agc_saturation_count),
        .status_agc_enable          (status_agc_enable)
    );

    // ── Test bookkeeping ───────────────────────────────────────
    integer pass_count;
    integer fail_count;
    integer test_num;
    integer csv_file;

    // ── Check task (512-bit label) ─────────────────────────────
    task check;
        input cond;
        input [511:0] label;
        begin
            test_num = test_num + 1;
            if (cond) begin
                $display("[PASS] Test %0d: %0s", test_num, label);
                pass_count = pass_count + 1;
                $fwrite(csv_file, "%0d,PASS,%0s\n", test_num, label);
            end else begin
                $display("[FAIL] Test %0d: %0s", test_num, label);
                fail_count = fail_count + 1;
                $fwrite(csv_file, "%0d,FAIL,%0s\n", test_num, label);
            end
        end
    endtask

    // ── Helper: apply reset ────────────────────────────────────
    task apply_reset;
        begin
            reset_n          = 0;
            range_profile    = 32'h0;
            range_valid      = 0;
            doppler_real     = 16'h0;
            doppler_imag     = 16'h0;
            doppler_valid    = 0;
            cfar_detection   = 0;
            cfar_valid       = 0;
            ft601_txe        = 0;   // TX FIFO ready (active low)
            ft601_rxf        = 1;
            ft601_srb        = 2'b00;
            ft601_swb        = 2'b00;
            host_data_drive  = 32'h0;
            host_data_drive_en = 0;
            // Gap 2: Stream control defaults (all streams enabled)
            stream_control        = 3'b111;
            status_request        = 0;
            status_cfar_threshold = 16'd10000;
            status_stream_ctrl    = 3'b111;
            status_radar_mode     = 2'b00;
            status_long_chirp     = 16'd3000;
            status_long_listen    = 16'd13700;
            status_guard          = 16'd17540;
            status_short_chirp    = 16'd50;
            status_short_listen   = 16'd17450;
            status_chirps_per_elev = 6'd32;
            status_range_mode     = 2'b00;
            status_self_test_flags  = 5'b00000;
            status_self_test_detail = 8'd0;
            status_self_test_busy   = 1'b0;
            status_agc_current_gain     = 4'd0;
            status_agc_peak_magnitude   = 8'd0;
            status_agc_saturation_count = 8'd0;
            status_agc_enable           = 1'b0;
            repeat (6) @(posedge ft601_clk_in);
            reset_n = 1;
            // Wait enough cycles for stream_control CDC to propagate
            // (DUT resets stream_ctrl_sync to 3'b001; TB sets stream_control=3'b111
            // which needs 2-stage sync + 1 cycle = 4+ ft601_clk cycles)
            repeat (6) @(posedge ft601_clk_in);
        end
    endtask

    // ── Helper: wait for DUT to reach a specific write FSM state ──
    task wait_for_state;
        input [3:0] target;
        input integer max_cyc;
        integer cnt;
        begin
            cnt = 0;
            while (uut.current_state !== target && cnt < max_cyc) begin
                @(posedge ft601_clk_in);
                cnt = cnt + 1;
            end
        end
    endtask

    // ── Helper: assert range_valid in clk domain, wait for CDC ──
    task assert_range_valid;
        input [31:0] data;
        begin
            @(posedge clk);
            range_profile = data;
            range_valid   = 1;
            repeat (3) @(posedge ft601_clk_in);
            @(posedge clk);
            range_valid = 0;
            repeat (3) @(posedge ft601_clk_in);
        end
    endtask

    // Pulse doppler_valid once (produces ONE rising-edge in ft601 domain)
    task pulse_doppler_once;
        input [15:0] dr;
        input [15:0] di;
        begin
            @(posedge clk);
            doppler_real  = dr;
            doppler_imag  = di;
            doppler_valid = 1;
            repeat (3) @(posedge ft601_clk_in);
            @(posedge clk);
            doppler_valid = 0;
            repeat (3) @(posedge ft601_clk_in);
        end
    endtask

    // Pulse cfar_valid once
    task pulse_cfar_once;
        input det;
        begin
            @(posedge clk);
            cfar_detection = det;
            cfar_valid     = 1;
            repeat (3) @(posedge ft601_clk_in);
            @(posedge clk);
            cfar_valid = 0;
            repeat (3) @(posedge ft601_clk_in);
        end
    endtask

    // Set data_pending flags directly via hierarchical access.
    // This is the standard TB technique for internal state setup —
    // bypasses the CDC path for immediate, reliable flag setting.
    // Call BEFORE assert_range_valid in tests that need doppler/cfar data.
    task preload_pending_data;
        begin
            @(posedge ft601_clk_in);
            uut.doppler_data_pending = 1'b1;
            uut.cfar_data_pending    = 1'b1;
            @(posedge ft601_clk_in);
        end
    endtask

    // Set only doppler pending (no cfar)
    task preload_doppler_pending;
        begin
            @(posedge ft601_clk_in);
            uut.doppler_data_pending = 1'b1;
            @(posedge ft601_clk_in);
        end
    endtask

    // Set only cfar pending (no doppler)
    task preload_cfar_pending;
        begin
            @(posedge ft601_clk_in);
            uut.cfar_data_pending = 1'b1;
            @(posedge ft601_clk_in);
        end
    endtask

    // ── Helper: wait for read FSM to reach a specific state ───
    task wait_for_read_state;
        input [2:0] target;
        input integer max_cyc;
        integer cnt;
        begin
            cnt = 0;
            while (uut.read_state !== target && cnt < max_cyc) begin
                @(posedge ft601_clk_in);
                cnt = cnt + 1;
            end
        end
    endtask

    // ── Helper: send a single host command word via the read path ──
    // Simulates the FT601 host presenting a 32-bit command word.
    // Protocol: Assert RXF=0 (data available), wait for OE_N=0,
    // drive data bus, wait for RD_N=0, then release.
    task send_host_command;
        input [31:0] cmd_word;
        begin
            // Signal host has data
            ft601_rxf = 0;
            // Wait for FPGA to assert OE_N (bus turnaround)
            wait_for_read_state(3'd1, 20); // RD_OE_ASSERT = 3'd1
            @(posedge ft601_clk_in); #1;
            // Drive data bus (FT601 drives in real hardware)
            host_data_drive = cmd_word;
            host_data_drive_en = 1;
            // Wait for FPGA to assert RD_N=0 (RD_READING state)
            wait_for_read_state(3'd2, 20); // RD_READING = 3'd2
            @(posedge ft601_clk_in); #1;
            // Data has been sampled. FPGA deasserts RD then OE.
            // Wait for RD_PROCESS or back to RD_IDLE
            wait_for_read_state(3'd4, 20); // RD_PROCESS = 3'd4
            @(posedge ft601_clk_in); #1;
            // Release bus and deassert RXF
            host_data_drive_en = 0;
            host_data_drive = 32'h0;
            ft601_rxf = 1;
            // Wait for read FSM to return to idle
            wait_for_read_state(3'd0, 20); // RD_IDLE = 3'd0
            @(posedge ft601_clk_in); #1;
        end
    endtask

    // Drive a complete data packet through the new 3-word packed FSM.
    // Pre-loads pending flags, triggers range_valid, and waits for IDLE.
    // With the new FSM, all data is pre-packed in IDLE then sent as 3 words.
    task drive_full_packet;
        input [31:0] rng;
        input [15:0] dr;
        input [15:0] di;
        input        det;
        begin
            // Set doppler/cfar captured values via CDC inputs
            @(posedge clk);
            doppler_real   = dr;
            doppler_imag   = di;
            cfar_detection = det;
            @(posedge clk);
            // Pre-load pending flags so FSM includes doppler/cfar in packet
            preload_pending_data;
            // Trigger the packet
            assert_range_valid(rng);
            // Wait for complete packet cycle: IDLE → SEND_DATA_WORD(×3) → WAIT_ACK → IDLE
            wait_for_state(S_IDLE, 100);
        end
    endtask

    // ── Stimulus ───────────────────────────────────────────────
    initial begin
        $dumpfile("tb_usb_data_interface.vcd");
        $dumpvars(0, tb_usb_data_interface);

        clk          = 0;
        ft601_clk_in = 0;
        pass_count   = 0;
        fail_count   = 0;
        test_num     = 0;
        host_data_drive    = 32'h0;
        host_data_drive_en = 0;

        csv_file = $fopen("tb_usb_data_interface.csv", "w");
        $fwrite(csv_file, "test_num,pass_fail,label\n");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 1: Reset behaviour
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 1: Reset Behaviour ---");
        apply_reset;
        reset_n = 0;
        repeat (4) @(posedge ft601_clk_in); #1;

        check(uut.current_state === S_IDLE,
              "State is IDLE after reset");
        check(ft601_wr_n === 1'b1,
              "ft601_wr_n=1 after reset");
        check(uut.ft601_data_oe === 1'b0,
              "ft601_data_oe=0 after reset");
        check(ft601_rd_n === 1'b1,
              "ft601_rd_n=1 after reset");
        check(ft601_oe_n === 1'b1,
              "ft601_oe_n=1 after reset");
        check(ft601_siwu_n === 1'b1,
              "ft601_siwu_n=1 after reset");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 2: Data packet word packing
        //
        // New FSM packs 11-byte data into 3 × 32-bit words:
        //   Word 0: {HEADER, range[31:24], range[23:16], range[15:8]}
        //   Word 1: {range[7:0], dop_re_hi, dop_re_lo, dop_im_hi}
        //   Word 2: {dop_im_lo, detection, FOOTER, 0x00}  BE=1110
        //
        // The DUT uses range_data_ready (1-cycle delayed range_valid_ft)
        // to trigger packing.  Doppler/CFAR _cap registers must be
        // pre-loaded via hierarchical access because no valid pulse is
        // given in this test (we only want to verify packing, not CDC).
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 2: Data Packet Word Packing ---");
        apply_reset;
        ft601_txe = 1;  // Stall so we can inspect packed words

        // Set known doppler/cfar values on clk-domain inputs
        @(posedge clk);
        doppler_real   = 16'hABCD;
        doppler_imag   = 16'hEF01;
        cfar_detection = 1'b1;
        @(posedge clk);

        // Pre-load pending flags AND captured-data registers directly.
        // No doppler/cfar valid pulses are given, so the CDC capture path
        // never fires — we must set the _cap registers via hierarchical
        // access for the word-packing checks to be meaningful.
        preload_pending_data;
        @(posedge ft601_clk_in);
        uut.doppler_real_cap   = 16'hABCD;
        uut.doppler_imag_cap   = 16'hEF01;
        uut.cfar_detection_cap = 1'b1;
        @(posedge ft601_clk_in);

        assert_range_valid(32'hDEAD_BEEF);

        // FSM should be in SEND_DATA_WORD, stalled on ft601_txe=1
        wait_for_state(S_SEND_DATA_WORD, 50);
        repeat (2) @(posedge ft601_clk_in); #1;

        check(uut.current_state === S_SEND_DATA_WORD,
              "Stalled in SEND_DATA_WORD (backpressure)");

        // Verify pre-packed words
        // range_profile = 0xDEAD_BEEF → range[31:24]=0xDE, [23:16]=0xAD, [15:8]=0xBE, [7:0]=0xEF
        // Word 0: {0xAA, 0xDE, 0xAD, 0xBE}
        check(uut.data_pkt_word0 === {8'hAA, 8'hDE, 8'hAD, 8'hBE},
              "Word 0: {HEADER=AA, range[31:8]}");
        // Word 1: {0xEF, 0xAB, 0xCD, 0xEF}
        check(uut.data_pkt_word1 === {8'hEF, 8'hAB, 8'hCD, 8'hEF},
              "Word 1: {range[7:0], dop_re, dop_im_hi}");
        // Word 2: {0x01, detection_byte, 0x55, 0x00}
        // detection_byte bit 7 = frame_start (sample_counter==0 → 1), bit 0 = cfar=1
        // so detection_byte = 8'b1000_0001 = 8'h81
        check(uut.data_pkt_word2 === {8'h01, 8'h81, 8'h55, 8'h00},
              "Word 2: {dop_im_lo, det=81, FOOTER=55, pad=00}");
        check(uut.data_pkt_be2 === 4'b1110,
              "Word 2 BE=1110 (3 valid bytes + 1 pad)");

        // Release backpressure and verify word 0 appears on bus.
        // On the first posedge with !ft601_txe the FSM drives word 0 and
        // advances data_word_idx 0→1 via NBA.  After #1 the NBA has
        // resolved, so we see idx=1 and ft601_data_out=word0.
        ft601_txe = 0;
        @(posedge ft601_clk_in); #1;

        check(uut.ft601_data_out === {8'hAA, 8'hDE, 8'hAD, 8'hBE},
              "Word 0 driven on data bus after backpressure release");
        check(ft601_wr_n === 1'b0,
              "Write strobe active during SEND_DATA_WORD");
        check(ft601_be === 4'b1111,
              "Byte enable=1111 for word 0");
        check(uut.ft601_data_oe === 1'b1,
              "Data bus output enabled during SEND_DATA_WORD");

        // Next posedge: FSM drives word 1, advances idx 1→2.
        // After NBA: idx=2, ft601_data_out=word1.
        @(posedge ft601_clk_in); #1;
        check(uut.data_word_idx === 2'd2,
              "data_word_idx advanced past word 1 (now 2)");
        check(uut.ft601_data_out === {8'hEF, 8'hAB, 8'hCD, 8'hEF},
              "Word 1 driven on data bus");
        check(ft601_be === 4'b1111,
              "Byte enable=1111 for word 1");

        // Next posedge: FSM drives word 2, idx resets 2→0,
        // and current_state transitions to WAIT_ACK.
        @(posedge ft601_clk_in); #1;
        check(uut.current_state === S_WAIT_ACK,
              "Transitioned to WAIT_ACK after 3 data words");
        check(uut.ft601_data_out === {8'h01, 8'h81, 8'h55, 8'h00},
              "Word 2 driven on data bus");
        check(ft601_be === 4'b1110,
              "Byte enable=1110 for word 2 (last byte is pad)");

        // Then back to IDLE
        @(posedge ft601_clk_in); #1;
        check(uut.current_state === S_IDLE,
              "Returned to IDLE after WAIT_ACK");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 3: Header and footer verification
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 3: Header and Footer Verification ---");
        apply_reset;
        ft601_txe = 1;  // Stall to inspect

        @(posedge clk);
        doppler_real   = 16'h0000;
        doppler_imag   = 16'h0000;
        cfar_detection = 1'b0;
        @(posedge clk);
        preload_pending_data;
        assert_range_valid(32'hCAFE_BABE);

        wait_for_state(S_SEND_DATA_WORD, 50);
        repeat (2) @(posedge ft601_clk_in); #1;

        // Header is in byte 3 (MSB) of word 0
        check(uut.data_pkt_word0[31:24] === 8'hAA,
              "Header byte 0xAA in word 0 MSB");
        // Footer is in byte 1 (bits [15:8]) of word 2
        check(uut.data_pkt_word2[15:8] === 8'h55,
              "Footer byte 0x55 in word 2");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 4: Doppler data capture verification
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 4: Doppler Data Capture ---");
        apply_reset;
        ft601_txe = 0;

        // Provide doppler data via valid pulse (updates captured values)
        @(posedge clk);
        doppler_real  = 16'hAAAA;
        doppler_imag  = 16'h5555;
        doppler_valid = 1;
        repeat (3) @(posedge ft601_clk_in);
        @(posedge clk);
        doppler_valid = 0;
        repeat (4) @(posedge ft601_clk_in); #1;

        check(uut.doppler_real_cap === 16'hAAAA,
              "doppler_real captured correctly");
        check(uut.doppler_imag_cap === 16'h5555,
              "doppler_imag captured correctly");

        // Drive a packet with pending doppler + cfar (both needed for gating
        // since all streams are enabled after reset/apply_reset).
        preload_pending_data;
        assert_range_valid(32'h0000_0001);
        wait_for_state(S_IDLE, 100);
        #1;
        check(uut.current_state === S_IDLE,
              "Packet completed with doppler data");
        check(uut.doppler_data_pending === 1'b0,
              "doppler_data_pending cleared after packet");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 5: CFAR detection data
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 5: CFAR Detection Data ---");
        apply_reset;
        ft601_txe = 0;
        preload_pending_data;
        assert_range_valid(32'h0000_0002);
        wait_for_state(S_IDLE, 200);
        #1;
        check(uut.cfar_data_pending === 1'b0,
              "cfar_data_pending cleared after packet");
        check(uut.current_state === S_IDLE &&
              uut.doppler_data_pending === 1'b0 &&
              uut.cfar_data_pending === 1'b0,
              "CFAR detection sent, all pending flags cleared");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 6: Footer retained after packet
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 6: Footer Retention ---");
        apply_reset;
        ft601_txe = 0;

        @(posedge clk);
        cfar_detection = 1'b1;
        @(posedge clk);
        preload_pending_data;
        assert_range_valid(32'hFACE_FEED);
        wait_for_state(S_IDLE, 100);
        #1;
        check(uut.current_state === S_IDLE,
              "Full packet incl. footer completed, back in IDLE");

        // The last word driven was word 2 which contains footer 0x55.
        // WAIT_ACK and IDLE don't overwrite ft601_data_out, so it retains
        // the last driven value.
        check(uut.ft601_data_out[15:8] === 8'h55,
              "ft601_data_out retains footer 0x55 in word 2 position");

        // Verify WAIT_ACK → IDLE transition
        apply_reset;
        ft601_txe = 0;
        preload_pending_data;
        assert_range_valid(32'h1234_5678);
        wait_for_state(S_IDLE, 100);
        #1;
        check(uut.current_state === S_IDLE,
              "Returned to IDLE after WAIT_ACK");
        check(ft601_wr_n === 1'b1,
              "ft601_wr_n deasserted in IDLE");
        check(uut.ft601_data_oe === 1'b0,
              "Data bus released in IDLE");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 7: Full packet sequence (end-to-end)
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 7: Full Packet Sequence ---");
        apply_reset;
        ft601_txe = 0;

        drive_full_packet(32'hCAFE_BABE, 16'h1234, 16'h5678, 1'b1);

        check(uut.current_state === S_IDLE,
              "Full packet completed, back in IDLE");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 8: FIFO backpressure
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 8: FIFO Backpressure ---");
        apply_reset;
        ft601_txe = 1;  // FIFO full — stall

        preload_pending_data;
        assert_range_valid(32'hBBBB_CCCC);

        wait_for_state(S_SEND_DATA_WORD, 50);
        repeat (10) @(posedge ft601_clk_in); #1;

        check(uut.current_state === S_SEND_DATA_WORD,
              "Stalled in SEND_DATA_WORD when ft601_txe=1 (FIFO full)");
        check(ft601_wr_n === 1'b1,
              "ft601_wr_n not asserted during backpressure stall");

        ft601_txe = 0;
        repeat (6) @(posedge ft601_clk_in); #1;

        check(uut.current_state === S_IDLE || uut.current_state === S_WAIT_ACK,
              "Resumed and completed after backpressure released");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 9: Clock divider
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 9: Clock Forwarding ---");
        apply_reset;
        // Let the system run for a few clocks to stabilize after reset
        repeat (2) @(posedge ft601_clk_in);

        // After ODDR change, ft601_clk_out is a forwarded copy of
        // ft601_clk_in (in simulation: direct assign passthrough).
        // Verify that ft601_clk_out tracks ft601_clk_in over 20 edges.
        begin : clk_fwd_block
            integer match_count;
            match_count = 0;

            repeat (20) begin
                @(posedge ft601_clk_in); #1;
                if (ft601_clk_out === 1'b1)
                    match_count = match_count + 1;
            end

            check(match_count === 20,
                  "ft601_clk_out follows ft601_clk_in (forwarded clock)");
        end

        // ════════════════════════════════════════════════════════
        // TEST GROUP 10: Bus release in IDLE and WAIT_ACK
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 10: Bus Release ---");
        apply_reset;
        #1;

        check(uut.ft601_data_oe === 1'b0,
              "ft601_data_oe=0 in IDLE (bus released)");
        check(ft601_data === 32'h0000_0000,
              "ft601_data reads 0 in IDLE (pulldown active)");

        // Drive a full packet and check WAIT_ACK
        ft601_txe = 0;
        preload_pending_data;
        assert_range_valid(32'h1111_2222);
        wait_for_state(S_WAIT_ACK, 50);
        #1;

        check(uut.ft601_data_oe === 1'b0,
              "ft601_data_oe=0 in WAIT_ACK (bus released)");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 11: Multiple consecutive packets
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 11: Multiple Consecutive Packets ---");
        apply_reset;
        ft601_txe = 0;

        drive_full_packet(32'hAAAA_BBBB, 16'h1111, 16'h2222, 1'b1);
        check(uut.current_state === S_IDLE,
              "Packet 1 complete, back in IDLE");

        repeat (4) @(posedge ft601_clk_in);

        drive_full_packet(32'hCCCC_DDDD, 16'h5555, 16'h6666, 1'b0);
        check(uut.current_state === S_IDLE,
              "Packet 2 complete, back in IDLE");

        check(uut.range_profile_cap === 32'hCCCC_DDDD,
              "Packet 2 range data captured correctly");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 12: Read Path - Single Command (Gap 4)
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 12: Read Path - Single Command ---");
        apply_reset;
        // Write FSM is IDLE, so read FSM can activate

        // Send "Set radar mode" command: opcode=0x01, addr=0x00, value=0x0002
        send_host_command({8'h01, 8'h00, 16'h0002});

        check(cmd_opcode === 8'h01,
              "Read path: cmd_opcode=0x01 (set mode)");
        check(cmd_addr === 8'h00,
              "Read path: cmd_addr=0x00");
        check(cmd_value === 16'h0002,
              "Read path: cmd_value=0x0002 (single-chirp mode)");
        check(cmd_data === {8'h01, 8'h00, 16'h0002},
              "Read path: cmd_data matches full command word");

        // Verify read FSM returned to idle
        check(uut.read_state === 3'd0,
              "Read FSM returned to RD_IDLE after command");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 13: Read Path - Multiple Commands (Gap 4)
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 13: Read Path - Multiple Commands ---");
        apply_reset;

        // Command 1: Set radar mode to auto-scan (0x01)
        send_host_command({8'h01, 8'h00, 16'h0001});
        check(cmd_opcode === 8'h01,
              "Multi-cmd 1: opcode=0x01 (set mode)");
        check(cmd_value === 16'h0001,
              "Multi-cmd 1: value=0x0001 (auto-scan)");

        // Command 2: Single chirp trigger (0x02)
        send_host_command({8'h02, 8'h00, 16'h0000});
        check(cmd_opcode === 8'h02,
              "Multi-cmd 2: opcode=0x02 (trigger)");

        // Command 3: Set CFAR threshold (0x03)
        send_host_command({8'h03, 8'h00, 16'h1234});
        check(cmd_opcode === 8'h03,
              "Multi-cmd 3: opcode=0x03 (CFAR threshold)");
        check(cmd_value === 16'h1234,
              "Multi-cmd 3: value=0x1234");

        // Command 4: Set stream control (0x04)
        send_host_command({8'h04, 8'h00, 16'h0005});
        check(cmd_opcode === 8'h04,
              "Multi-cmd 4: opcode=0x04 (stream control)");
        check(cmd_value === 16'h0005,
              "Multi-cmd 4: value=0x0005 (range+cfar)");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 14: Read/Write Interleave (Gap 4)
        // Verifies no bus contention: read FSM only operates when
        // write FSM is IDLE.
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 14: Read/Write Interleave ---");
        apply_reset;
        ft601_txe = 0;

        // Start a write packet
        preload_pending_data;
        assert_range_valid(32'hFACE_FEED);
        wait_for_state(S_SEND_DATA_WORD, 50);
        @(posedge ft601_clk_in); #1;

        // While write FSM is active, assert RXF=0 (host has data)
        // Read FSM should NOT activate (read_state stays RD_IDLE)
        ft601_rxf = 0;
        repeat (5) @(posedge ft601_clk_in); #1;

        check(uut.read_state === 3'd0,
              "Read FSM stays in RD_IDLE while write FSM active");

        // Deassert RXF, complete the write packet
        ft601_rxf = 1;
        wait_for_state(S_IDLE, 100);
        @(posedge ft601_clk_in); #1;

        check(uut.current_state === S_IDLE,
              "Write packet completed, FSM in IDLE");

        // Now send a read command — should work fine after write completes
        send_host_command({8'h01, 8'h00, 16'h0002});
        check(cmd_opcode === 8'h01,
              "Read after write: cmd_opcode=0x01");
        check(cmd_value === 16'h0002,
              "Read after write: cmd_value=0x0002");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 15: Stream Control Gating (Gap 2)
        // Verify that disabling individual streams causes the write
        // FSM to zero those fields in the packed words.
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 15: Stream Control Gating (Gap 2) ---");

        // 15a: Disable doppler stream (stream_control = 3'b101 = range + cfar only)
        apply_reset;
        ft601_txe = 1;  // Stall to inspect packed words
        stream_control = 3'b101;  // range + cfar, no doppler
        // Wait for CDC propagation (2-stage sync)
        repeat (6) @(posedge ft601_clk_in);

        @(posedge clk);
        doppler_real   = 16'hAAAA;
        doppler_imag   = 16'hBBBB;
        cfar_detection = 1'b1;
        @(posedge clk);

        preload_cfar_pending;
        assert_range_valid(32'hAA11_BB22);

        wait_for_state(S_SEND_DATA_WORD, 200);
        repeat (2) @(posedge ft601_clk_in); #1;

        // With doppler disabled, doppler fields in words 1 and 2 should be zero
        // Word 1: {range[7:0], 0x00, 0x00, 0x00} (doppler zeroed)
        check(uut.data_pkt_word1[23:0] === 24'h000000,
              "Stream gate: doppler bytes zeroed in word 1 when disabled");

        // Word 2 byte 3 (dop_im_lo) should also be zero
        check(uut.data_pkt_word2[31:24] === 8'h00,
              "Stream gate: dop_im_lo zeroed in word 2 when disabled");

        // Let it complete
        ft601_txe = 0;
        wait_for_state(S_IDLE, 100);
        #1;
        check(uut.current_state === S_IDLE,
              "Stream gate: packet completed without doppler");

        // 15b: Disable all streams (stream_control = 3'b000)
        // With no streams enabled, a range_valid pulse should NOT trigger the write FSM.
        apply_reset;
        ft601_txe = 0;
        stream_control = 3'b000;
        repeat (6) @(posedge ft601_clk_in);

        // Assert range_valid — FSM should stay in IDLE
        @(posedge clk);
        range_profile = 32'hDEAD_DEAD;
        range_valid   = 1;
        repeat (3) @(posedge ft601_clk_in);
        @(posedge clk);
        range_valid = 0;
        // Wait a few more cycles for any CDC propagation
        repeat (10) @(posedge ft601_clk_in); #1;

        check(uut.current_state === S_IDLE,
              "Stream gate: FSM stays IDLE when all streams disabled");

        // 15c: Restore all streams
        stream_control = 3'b111;
        repeat (6) @(posedge ft601_clk_in);

        // ════════════════════════════════════════════════════════
        // TEST GROUP 16: Status Readback (Gap 2)
        // Verify that pulsing status_request triggers an 8-word
        // status response via the SEND_STATUS state.
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 16: Status Readback (Gap 2) ---");
        apply_reset;
        ft601_txe = 0;

        // Set known status input values
        status_cfar_threshold  = 16'hABCD;
        status_stream_ctrl     = 3'b101;
        status_radar_mode      = 2'b01;
        status_long_chirp      = 16'd3000;
        status_long_listen     = 16'd13700;
        status_guard           = 16'd17540;
        status_short_chirp     = 16'd50;
        status_short_listen    = 16'd17450;
        status_chirps_per_elev = 6'd32;
        status_range_mode      = 2'b10;  // Long-range for status test
        // Self-test status: all 5 tests passed, detail=0xA5, not busy
        status_self_test_flags  = 5'b11111;
        status_self_test_detail = 8'hA5;
        status_self_test_busy   = 1'b0;
        // AGC status: gain=5, peak=180, sat_count=12, enabled
        status_agc_current_gain     = 4'd5;
        status_agc_peak_magnitude   = 8'd180;
        status_agc_saturation_count = 8'd12;
        status_agc_enable           = 1'b1;

        // Pulse status_request (1 cycle in clk domain — toggles status_req_toggle_100m)
        @(posedge clk);
        status_request = 1;
        @(posedge clk);
        status_request = 0;

        // Wait for toggle CDC propagation to ft601_clk domain
        // (2-stage sync + edge detect = ~3-4 ft601_clk cycles)
        repeat (8) @(posedge ft601_clk_in); #1;

        // The write FSM should enter SEND_STATUS
        // Give it time to start (IDLE sees status_req_ft601)
        wait_for_state(S_SEND_STATUS, 20);
        #1;
        check(uut.current_state === S_SEND_STATUS,
              "Status readback: FSM entered SEND_STATUS");

        // The SEND_STATUS state sends 8 words (idx 0-7):
        // idx 0: 0xBB header, idx 1-6: status_words[0-5], idx 7: 0x55 footer
        // After idx 7 it transitions to WAIT_ACK -> IDLE.
        // Since ft601_txe=0, all 8 words should stream without stall.
        wait_for_state(S_IDLE, 100);
        #1;
        check(uut.current_state === S_IDLE,
              "Status readback: returned to IDLE after 8-word response");

        // Verify the status snapshot was captured correctly.
        check(uut.status_words[1] === {16'd3000, 16'd13700},
              "Status readback: word 1 = {long_chirp, long_listen}");
        check(uut.status_words[2] === {16'd17540, 16'd50},
              "Status readback: word 2 = {guard, short_chirp}");
        check(uut.status_words[3] === {16'd17450, 10'd0, 6'd32},
              "Status readback: word 3 = {short_listen, 0, chirps_per_elev}");
        check(uut.status_words[4] === {4'd5, 8'd180, 8'd12, 1'b1, 9'd0, 2'b10},
              "Status readback: word 4 = {agc_gain=5, peak=180, sat=12, en=1, range_mode=2}");
        // status_words[5] = {7'd0, busy, 8'd0, detail[7:0], 3'd0, flags[4:0]}
        // = {7'd0, 1'b0, 8'd0, 8'hA5, 3'd0, 5'b11111}
        check(uut.status_words[5] === {7'd0, 1'b0, 8'd0, 8'hA5, 3'd0, 5'b11111},
              "Status readback: word 5 = self-test {busy=0, detail=A5, flags=1F}");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 17: New Chirp Timing Opcodes (Gap 2)
        // Verify opcodes 0x10-0x15 are properly decoded by the
        // read path.
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 17: Chirp Timing Opcodes (Gap 2) ---");
        apply_reset;

        // 0x10: Long chirp cycles
        send_host_command({8'h10, 8'h00, 16'd2500});
        check(cmd_opcode === 8'h10,
              "Chirp opcode: 0x10 (long chirp cycles)");
        check(cmd_value === 16'd2500,
              "Chirp opcode: value=2500");

        // 0x11: Long listen cycles
        send_host_command({8'h11, 8'h00, 16'd12000});
        check(cmd_opcode === 8'h11,
              "Chirp opcode: 0x11 (long listen cycles)");
        check(cmd_value === 16'd12000,
              "Chirp opcode: value=12000");

        // 0x12: Guard cycles
        send_host_command({8'h12, 8'h00, 16'd15000});
        check(cmd_opcode === 8'h12,
              "Chirp opcode: 0x12 (guard cycles)");
        check(cmd_value === 16'd15000,
              "Chirp opcode: value=15000");

        // 0x13: Short chirp cycles
        send_host_command({8'h13, 8'h00, 16'd40});
        check(cmd_opcode === 8'h13,
              "Chirp opcode: 0x13 (short chirp cycles)");
        check(cmd_value === 16'd40,
              "Chirp opcode: value=40");

        // 0x14: Short listen cycles
        send_host_command({8'h14, 8'h00, 16'd16000});
        check(cmd_opcode === 8'h14,
              "Chirp opcode: 0x14 (short listen cycles)");
        check(cmd_value === 16'd16000,
              "Chirp opcode: value=16000");

        // 0x15: Chirps per elevation
        send_host_command({8'h15, 8'h00, 16'd16});
        check(cmd_opcode === 8'h15,
              "Chirp opcode: 0x15 (chirps per elevation)");
        check(cmd_value === 16'd16,
              "Chirp opcode: value=16");

        // 0xFF: Status request (opcode decode check — actual readback tested above)
        send_host_command({8'hFF, 8'h00, 16'h0000});
        check(cmd_opcode === 8'hFF,
              "Chirp opcode: 0xFF (status request)");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 18: Self-Test Readback Variants
        // Verify self-test busy flag, partial failures, and
        // alternate status word 5 values.
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 18: Self-Test Readback Variants ---");
        apply_reset;
        ft601_txe = 0;

        // Scenario A: Self-test busy, partial failure, different detail
        status_self_test_flags  = 5'b10110;  // T0 fail, T3 fail
        status_self_test_detail = 8'h42;
        status_self_test_busy   = 1'b1;

        // Trigger status readback
        @(posedge clk);
        status_request = 1;
        @(posedge clk);
        status_request = 0;

        repeat (8) @(posedge ft601_clk_in); #1;
        wait_for_state(S_SEND_STATUS, 20);
        #1;
        check(uut.current_state === S_SEND_STATUS,
              "Self-test readback A: FSM entered SEND_STATUS");

        wait_for_state(S_IDLE, 100);
        #1;
        check(uut.current_state === S_IDLE,
              "Self-test readback A: returned to IDLE");

        // Verify word 5: {7'd0, busy=1, 8'd0, detail=0x42, 3'd0, flags=5'b10110}
        check(uut.status_words[5] === {7'd0, 1'b1, 8'd0, 8'h42, 3'd0, 5'b10110},
              "Self-test readback A: word 5 = {busy=1, detail=42, flags=16}");

        // ════════════════════════════════════════════════════════
        // Summary
        // ════════════════════════════════════════════════════════
        $display("");
        $display("========================================");
        $display("  USB DATA INTERFACE TESTBENCH RESULTS");
        $display("  PASSED: %0d / %0d", pass_count, test_num);
        $display("  FAILED: %0d / %0d", fail_count, test_num);
        if (fail_count == 0)
            $display("  ** ALL TESTS PASSED **");
        else
            $display("  ** SOME TESTS FAILED **");
        $display("========================================");
        $display("");

        $fclose(csv_file);
        #100;
        $finish;
    end

endmodule
