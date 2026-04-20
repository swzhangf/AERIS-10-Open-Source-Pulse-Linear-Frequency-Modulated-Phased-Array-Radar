`timescale 1ns / 1ps

module tb_range_bin_decimator;

    // ── Parameters ─────────────────────────────────────────────
    localparam CLK_PERIOD       = 10.0;  // 100 MHz
    localparam INPUT_BINS       = 1024;
    localparam OUTPUT_BINS      = 64;
    localparam DECIMATION_FACTOR = 16;

    // ── Signals ────────────────────────────────────────────────
    reg         clk;
    reg         reset_n;
    reg  signed [15:0] range_i_in;
    reg  signed [15:0] range_q_in;
    reg         range_valid_in;
    wire signed [15:0] range_i_out;
    wire signed [15:0] range_q_out;
    wire        range_valid_out;
    wire [5:0]  range_bin_index;
    reg  [1:0]  decimation_mode;
    reg  [9:0]  start_bin;
    wire        watchdog_timeout;

    // ── Test bookkeeping ───────────────────────────────────────
    integer pass_count;
    integer fail_count;
    integer test_num;
    integer csv_file;
    integer i, k;

    // ── Concurrent output capture ──────────────────────────────
    // These are written by an always block that runs concurrently
    reg signed [15:0] cap_i [0:OUTPUT_BINS-1];
    reg signed [15:0] cap_q [0:OUTPUT_BINS-1];
    reg [5:0]         cap_idx [0:OUTPUT_BINS-1];
    integer           cap_count;
    reg               cap_enable;  // testbench sets this to enable capture

    // ── Clock ──────────────────────────────────────────────────
    always #(CLK_PERIOD/2) clk = ~clk;

    // ── DUT ────────────────────────────────────────────────────
    range_bin_decimator #(
        .INPUT_BINS       (INPUT_BINS),
        .OUTPUT_BINS      (OUTPUT_BINS),
        .DECIMATION_FACTOR(DECIMATION_FACTOR)
    ) uut (
        .clk            (clk),
        .reset_n        (reset_n),
        .range_i_in     (range_i_in),
        .range_q_in     (range_q_in),
        .range_valid_in (range_valid_in),
        .range_i_out    (range_i_out),
        .range_q_out    (range_q_out),
        .range_valid_out(range_valid_out),
        .range_bin_index(range_bin_index),
        .decimation_mode(decimation_mode),
        .start_bin      (start_bin),
        .watchdog_timeout(watchdog_timeout)
    );

    // ── Watchdog timeout pulse counter ───────────────────────────
    integer wd_pulse_count;
    always @(posedge clk) begin
        #1;
        if (watchdog_timeout)
            wd_pulse_count = wd_pulse_count + 1;
    end

    // ── Concurrent output capture block ────────────────────────
    // Runs alongside the initial block, captures every valid output
    always @(posedge clk) begin
        #1;
        if (cap_enable && range_valid_out) begin
            if (cap_count < OUTPUT_BINS) begin
                cap_i[cap_count]   = range_i_out;
                cap_q[cap_count]   = range_q_out;
                cap_idx[cap_count] = range_bin_index;
            end
            cap_count = cap_count + 1;
        end
    end

    // ── Check task ─────────────────────────────────────────────
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

    // ── Helper: apply reset and clear capture ──────────────────
    task apply_reset;
        begin
            reset_n        = 0;
            range_valid_in = 0;
            range_i_in     = 16'd0;
            range_q_in     = 16'd0;
            decimation_mode = 2'b00;
            start_bin      = 10'd0;
            cap_enable     = 0;
            cap_count      = 0;
            repeat (4) @(posedge clk);
            reset_n = 1;
            @(posedge clk); #1;
        end
    endtask

    // ── Helper: start capture ──────────────────────────────────
    task start_capture;
        begin
            cap_count  = 0;
            cap_enable = 1;
        end
    endtask

    // ── Helper: stop capture and wait for trailing outputs ─────
    task stop_capture;
        begin
            // Wait a few cycles for any trailing output
            repeat (10) @(posedge clk);
            cap_enable = 0;
            #1;
        end
    endtask

    // ── Helper: feed ramp data (I=bin_index, Q=0) ──────────────
    task feed_ramp;
        integer idx;
        begin
            for (idx = 0; idx < INPUT_BINS; idx = idx + 1) begin
                range_i_in     = idx[15:0];
                range_q_in     = 16'd0;
                range_valid_in = 1'b1;
                @(posedge clk); #1;
            end
            range_valid_in = 1'b0;
        end
    endtask

    // ── Helper: feed constant data ─────────────────────────────
    task feed_constant;
        input signed [15:0] val_i;
        input signed [15:0] val_q;
        integer idx;
        begin
            for (idx = 0; idx < INPUT_BINS; idx = idx + 1) begin
                range_i_in     = val_i;
                range_q_in     = val_q;
                range_valid_in = 1'b1;
                @(posedge clk); #1;
            end
            range_valid_in = 1'b0;
        end
    endtask

    // ── Helper: feed peaked data ───────────────────────────────
    task feed_peaked;
        integer idx, grp, pos_in_grp, spike_pos;
        begin
            for (idx = 0; idx < INPUT_BINS; idx = idx + 1) begin
                grp        = idx / DECIMATION_FACTOR;
                pos_in_grp = idx % DECIMATION_FACTOR;
                spike_pos  = grp % DECIMATION_FACTOR;

                if (pos_in_grp == spike_pos)
                    range_i_in = (grp + 1) * 100;
                else
                    range_i_in = 16'sd1;

                range_q_in     = 16'd0;
                range_valid_in = 1'b1;
                @(posedge clk); #1;
            end
            range_valid_in = 1'b0;
        end
    endtask

    // ── Stimulus ───────────────────────────────────────────────
    initial begin
        $dumpfile("tb_range_bin_decimator.vcd");
        $dumpvars(0, tb_range_bin_decimator);

        clk        = 0;
        pass_count = 0;
        fail_count = 0;
        test_num   = 0;
        cap_enable = 0;
        cap_count  = 0;
        wd_pulse_count = 0;

        // Init cap arrays
        for (i = 0; i < OUTPUT_BINS; i = i + 1) begin
            cap_i[i]   = 16'd0;
            cap_q[i]   = 16'd0;
            cap_idx[i] = 6'd0;
        end

        // ════════════════════════════════════════════════════════
        // TEST GROUP 1: Reset behaviour
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 1: Reset Behaviour ---");
        apply_reset;

        reset_n = 0;
        repeat (4) @(posedge clk); #1;
        check(range_valid_out === 1'b0, "range_valid_out=0 during reset");
        check(range_i_out === 16'd0,   "range_i_out=0 during reset");
        check(range_q_out === 16'd0,   "range_q_out=0 during reset");
        check(range_bin_index === 6'd0, "range_bin_index=0 during reset");
        reset_n = 1;
        @(posedge clk); #1;

        // ════════════════════════════════════════════════════════
        // TEST GROUP 2: Simple decimation mode (mode 00) — ramp
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 2: Simple Decimation (mode 00) — Ramp ---");
        apply_reset;
        decimation_mode = 2'b00;

        start_capture;
        feed_ramp;
        stop_capture;

        $display("  Output count: %0d (expected %0d)", cap_count, OUTPUT_BINS);
        check(cap_count == OUTPUT_BINS, "Outputs exactly 64 bins");

        // In mode 00, takes sample at index DECIMATION_FACTOR/2 = 8 within group
        // Group 0: samples 0-15, center at index 8 → value = 8
        // Group 1: samples 16-31, center at index 24 → value = 24
        if (cap_count >= 2) begin
            $display("  Bin 0: I=%0d (expect 8)", cap_i[0]);
            $display("  Bin 1: I=%0d (expect 24)", cap_i[1]);
        end
        check(cap_count >= 1 && cap_i[0] == 16'sd8,   "Bin 0: center sample I=8");
        check(cap_count >= 2 && cap_i[1] == 16'sd24,  "Bin 1: center sample I=24");
        check(cap_count >= 64 && cap_i[63] == 16'sd1016, "Bin 63: center sample I=1016");

        // Check bin indices are sequential
        check(cap_count >= 1 && cap_idx[0]  == 6'd0,  "First bin index = 0");
        check(cap_count >= 64 && cap_idx[63] == 6'd63, "Last bin index = 63");

        // Write CSV
        csv_file = $fopen("rbd_mode00_ramp.csv", "w");
        $fwrite(csv_file, "output_bin,index,i_value,q_value\n");
        for (i = 0; i < cap_count && i < OUTPUT_BINS; i = i + 1)
            $fwrite(csv_file, "%0d,%0d,%0d,%0d\n", i, cap_idx[i], cap_i[i], cap_q[i]);
        $fclose(csv_file);

        // ════════════════════════════════════════════════════════
        // TEST GROUP 3: Peak detection mode (mode 01) — peaked data
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 3: Peak Detection (mode 01) ---");
        apply_reset;
        decimation_mode = 2'b01;

        start_capture;
        feed_peaked;
        stop_capture;

        $display("  Output count: %0d", cap_count);
        check(cap_count == OUTPUT_BINS, "Outputs exactly 64 bins");

        if (cap_count >= 10) begin
            $display("  Bin 0: I=%0d (expect 100)", cap_i[0]);
            $display("  Bin 1: I=%0d (expect 200)", cap_i[1]);
            $display("  Bin 9: I=%0d (expect 1000)", cap_i[9]);
        end
        check(cap_count >= 1 && cap_i[0] == 16'sd100,  "Bin 0: peak = 100");
        check(cap_count >= 2 && cap_i[1] == 16'sd200,  "Bin 1: peak = 200");
        check(cap_count >= 10 && cap_i[9] == 16'sd1000, "Bin 9: peak = 1000");

        csv_file = $fopen("rbd_mode01_peak.csv", "w");
        $fwrite(csv_file, "output_bin,index,i_value,q_value\n");
        for (i = 0; i < cap_count && i < OUTPUT_BINS; i = i + 1)
            $fwrite(csv_file, "%0d,%0d,%0d,%0d\n", i, cap_idx[i], cap_i[i], cap_q[i]);
        $fclose(csv_file);

        // ════════════════════════════════════════════════════════
        // TEST GROUP 4: Averaging mode (mode 10) — constant data
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 4: Averaging (mode 10) — Constant ---");
        apply_reset;
        decimation_mode = 2'b10;

        start_capture;
        feed_constant(16'sd160, 16'sd80);
        stop_capture;

        $display("  Output count: %0d", cap_count);
        check(cap_count == OUTPUT_BINS, "Outputs exactly 64 bins");

        if (cap_count >= 1)
            $display("  Bin 0: I=%0d Q=%0d (expect 160, 80)", cap_i[0], cap_q[0]);
        check(cap_count >= 1 && cap_i[0] == 16'sd160, "Avg mode: constant I preserved (160)");
        check(cap_count >= 1 && cap_q[0] == 16'sd80,  "Avg mode: constant Q preserved (80)");
        check(cap_count >= 64 && cap_i[63] == 16'sd160, "Avg mode: last bin I preserved");

        csv_file = $fopen("rbd_mode10_avg.csv", "w");
        $fwrite(csv_file, "output_bin,index,i_value,q_value\n");
        for (i = 0; i < cap_count && i < OUTPUT_BINS; i = i + 1)
            $fwrite(csv_file, "%0d,%0d,%0d,%0d\n", i, cap_idx[i], cap_i[i], cap_q[i]);
        $fclose(csv_file);

        // ════════════════════════════════════════════════════════
        // TEST GROUP 5: Averaging mode — ramp (verify averaging)
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 5: Averaging (mode 10) — Ramp ---");
        apply_reset;
        decimation_mode = 2'b10;

        start_capture;
        feed_ramp;
        stop_capture;

        check(cap_count == OUTPUT_BINS, "Outputs exactly 64 bins");

        // Group 0: values 0..15, sum=120, >>4 = 7
        // Group 1: values 16..31, sum=376, >>4 = 23
        if (cap_count >= 2) begin
            $display("  Bin 0: I=%0d (expect 7)", cap_i[0]);
            $display("  Bin 1: I=%0d (expect 23)", cap_i[1]);
        end
        check(cap_count >= 1 && cap_i[0] == 16'sd7,  "Avg ramp group 0 = 7");
        check(cap_count >= 2 && cap_i[1] == 16'sd23, "Avg ramp group 1 = 23");

        csv_file = $fopen("rbd_mode10_ramp.csv", "w");
        $fwrite(csv_file, "output_bin,index,i_value,q_value\n");
        for (i = 0; i < cap_count && i < OUTPUT_BINS; i = i + 1)
            $fwrite(csv_file, "%0d,%0d,%0d,%0d\n", i, cap_idx[i], cap_i[i], cap_q[i]);
        $fclose(csv_file);

        // ════════════════════════════════════════════════════════
        // TEST GROUP 6: No valid input → no output
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 6: No Valid Input → No Output ---");
        apply_reset;
        decimation_mode = 2'b01;

        start_capture;
        repeat (200) @(posedge clk);
        cap_enable = 0; #1;
        check(cap_count == 0, "No output when no valid input");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 7: Back-to-back frames
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 7: Back-to-back Frames ---");
        apply_reset;
        decimation_mode = 2'b00;

        // Frame 1
        start_capture;
        feed_ramp;
        stop_capture;
        $display("  Frame 1: %0d outputs", cap_count);
        check(cap_count == OUTPUT_BINS, "Frame 1: 64 outputs");

        // Small gap then frame 2
        repeat (5) @(posedge clk);
        start_capture;
        feed_ramp;
        stop_capture;
        $display("  Frame 2: %0d outputs", cap_count);
        check(cap_count == OUTPUT_BINS, "Frame 2: 64 outputs");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 8: Peak detection with negative values
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 8: Peak Detection with Negatives ---");
        apply_reset;
        decimation_mode = 2'b01;

        start_capture;
        // Feed first group: 15 at -100, one at -500
        for (i = 0; i < INPUT_BINS; i = i + 1) begin
            if (i < DECIMATION_FACTOR) begin
                if (i == 3) begin
                    range_i_in = -16'sd500;
                    range_q_in = 16'sd0;
                end else begin
                    range_i_in = -16'sd100;
                    range_q_in = 16'sd0;
                end
            end else begin
                range_i_in = 16'sd1;
                range_q_in = 16'sd0;
            end
            range_valid_in = 1'b1;
            @(posedge clk); #1;
        end
        range_valid_in = 1'b0;
        stop_capture;

        if (cap_count >= 1)
            $display("  Bin 0: I=%0d (expect -500)", cap_i[0]);
        check(cap_count >= 1 && cap_i[0] == -16'sd500,
              "Peak picks largest magnitude (negative value)");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 9: Saturation Boundary Tests
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 9: Saturation Boundary Tests ---");

        // ── Test 9a: All max positive in mode 01 (peak detection) ──
        $display("  Test 9a: All max positive, mode 01 (peak detection)");
        apply_reset;
        decimation_mode = 2'b01;
        start_capture;
        feed_constant(16'sh7FFF, 16'sh7FFF);
        stop_capture;
        $display("    Output count: %0d", cap_count);
        check(cap_count == OUTPUT_BINS, "9a: Outputs exactly 64 bins");
        if (cap_count >= 1)
            $display("    Bin 0: I=%0d Q=%0d (expect 32767, 32767)", cap_i[0], cap_q[0]);
        check(cap_count >= 1 && cap_i[0] == 16'sh7FFF, "9a: Bin 0 peak I = 0x7FFF");
        check(cap_count >= 64 && cap_i[63] == 16'sh7FFF, "9a: Bin 63 peak I = 0x7FFF");

        // ── Test 9b: All max negative in mode 01 (peak detection) ──
        $display("  Test 9b: All max negative, mode 01 (peak detection)");
        apply_reset;
        decimation_mode = 2'b01;
        start_capture;
        feed_constant(16'sh8000, 16'sh8000);
        stop_capture;
        $display("    Output count: %0d", cap_count);
        check(cap_count == OUTPUT_BINS, "9b: Outputs exactly 64 bins");
        if (cap_count >= 1)
            $display("    Bin 0: I=%0d Q=%0d", cap_i[0], cap_q[0]);

        // ── Test 9c: All max positive in mode 10 (averaging) ──
        $display("  Test 9c: All max positive, mode 10 (averaging)");
        apply_reset;
        decimation_mode = 2'b10;
        start_capture;
        feed_constant(16'sh7FFF, 16'sh7FFF);
        stop_capture;
        $display("    Output count: %0d", cap_count);
        check(cap_count == OUTPUT_BINS, "9c: Outputs exactly 64 bins");
        if (cap_count >= 1)
            $display("    Bin 0: I=%0d (expect 32767)", cap_i[0]);
        // sum_i = 16 * 0x7FFF = 0x7FFF0, >>4 = 0x7FFF
        check(cap_count >= 1 && cap_i[0] == 16'sh7FFF, "9c: Avg of 0x7FFF = 0x7FFF");

        // ── Test 9d: Alternating max pos/neg in mode 10 (averaging) ──
        $display("  Test 9d: Alternating max pos/neg, mode 10 (averaging)");
        apply_reset;
        decimation_mode = 2'b10;
        start_capture;
        // Feed alternating 0x7FFF / 0x8000 per sample
        for (i = 0; i < INPUT_BINS; i = i + 1) begin
            if (i % 2 == 0) begin
                range_i_in = 16'sh7FFF;
                range_q_in = 16'sh7FFF;
            end else begin
                range_i_in = 16'sh8000;
                range_q_in = 16'sh8000;
            end
            range_valid_in = 1'b1;
            @(posedge clk); #1;
        end
        range_valid_in = 1'b0;
        stop_capture;
        $display("    Output count: %0d", cap_count);
        check(cap_count == OUTPUT_BINS, "9d: Outputs exactly 64 bins");
        // 8*32767 + 8*(-32768) = -8, sum[19:4] = -1
        if (cap_count >= 1)
            $display("    Bin 0: I=%0d (expect -1)", cap_i[0]);
        check(cap_count >= 1 && cap_i[0] == -16'sd1, "9d: Avg of alternating = -1");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 10: Valid-Gap / Stall Test
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 10: Valid-Gap / Stall Test ---");
        apply_reset;
        decimation_mode = 2'b00;

        start_capture;
        // Feed 1024 samples with gaps: every 50 samples, deassert for 20 cycles
        begin : gap_feed_block
            integer sample_idx;
            integer samples_since_gap;
            sample_idx       = 0;
            samples_since_gap = 0;
            while (sample_idx < INPUT_BINS) begin
                range_i_in     = sample_idx[15:0];
                range_q_in     = 16'd0;
                range_valid_in = 1'b1;
                @(posedge clk); #1;
                sample_idx       = sample_idx + 1;
                samples_since_gap = samples_since_gap + 1;
                if (samples_since_gap == 50 && sample_idx < INPUT_BINS) begin
                    // Insert gap: deassert valid for 20 cycles
                    range_valid_in = 1'b0;
                    repeat (20) @(posedge clk);
                    #1;
                    samples_since_gap = 0;
                end
            end
            range_valid_in = 1'b0;
        end
        stop_capture;

        $display("  Output count: %0d (expected %0d)", cap_count, OUTPUT_BINS);
        check(cap_count == OUTPUT_BINS, "10: Outputs exactly 64 bins with gaps");
        // Mode 00 takes center sample (index 8 within group)
        // Group 0: logical samples 0..15, center at 8 → value 8
        // Group 1: logical samples 16..31, center at 24 → value 24
        if (cap_count >= 2) begin
            $display("  Bin 0: I=%0d (expect 8)", cap_i[0]);
            $display("  Bin 1: I=%0d (expect 24)", cap_i[1]);
        end
        check(cap_count >= 1 && cap_i[0] == 16'sd8, "10: Gap test Bin 0 I=8");
        check(cap_count >= 2 && cap_i[1] == 16'sd24, "10: Gap test Bin 1 I=24");
        check(cap_count >= 64 && cap_i[63] == 16'sd1016, "10: Gap test Bin 63 I=1016");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 11: Reset Mid-Operation
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 11: Reset Mid-Operation ---");
        apply_reset;
        decimation_mode = 2'b01;

        start_capture;
        // Feed ~512 samples (halfway through)
        for (i = 0; i < 512; i = i + 1) begin
            range_i_in     = i[15:0];
            range_q_in     = 16'd0;
            range_valid_in = 1'b1;
            @(posedge clk); #1;
        end
        range_valid_in = 1'b0;
        @(posedge clk); #1;

        // Assert reset for 4 cycles
        reset_n = 1'b0;
        repeat (4) @(posedge clk);
        #1;
        // Verify outputs are cleared during reset
        check(range_valid_out === 1'b0, "11: range_valid_out=0 during mid-reset");

        // Release reset
        reset_n = 1'b1;
        @(posedge clk); #1;

        // Reset capture for the new frame
        cap_count  = 0;
        cap_enable = 1;

        // Feed a complete new frame
        feed_constant(16'sd42, 16'sd21);
        stop_capture;

        $display("  Output count after reset+refeed: %0d", cap_count);
        check(cap_count == OUTPUT_BINS, "11: 64 outputs after mid-reset + new frame");
        // Mode 01 peak detection with constant 42 → all peaks = 42
        if (cap_count >= 1)
            $display("  Bin 0: I=%0d (expect 42)", cap_i[0]);
        check(cap_count >= 1 && cap_i[0] == 16'sd42, "11: Post-reset Bin 0 I=42");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 12: Reserved Mode (2'b11)
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 12: Reserved Mode (2'b11) ---");
        apply_reset;
        decimation_mode = 2'b11;

        start_capture;
        feed_constant(16'sd999, 16'sd555);
        stop_capture;

        $display("  Output count: %0d", cap_count);
        check(cap_count == OUTPUT_BINS, "12: Reserved mode outputs 64 bins");
        if (cap_count >= 1)
            $display("  Bin 0: I=%0d Q=%0d (expect 0, 0)", cap_i[0], cap_q[0]);
        check(cap_count >= 1 && cap_i[0] == 16'sd0, "12: Reserved mode I=0");
        check(cap_count >= 1 && cap_q[0] == 16'sd0, "12: Reserved mode Q=0");
        // Check last bin too
        check(cap_count >= 64 && cap_i[63] == 16'sd0, "12: Reserved mode Bin 63 I=0");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 13: Overflow Test for Accumulator (mode 10)
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 13: Overflow Test for Accumulator ---");
        apply_reset;
        decimation_mode = 2'b10;

        start_capture;
        // Feed alternating groups of 16×0x7FFF and 16×0x8000
        for (i = 0; i < INPUT_BINS; i = i + 1) begin
            k = i / DECIMATION_FACTOR;  // group index
            if (k % 2 == 0) begin
                range_i_in = 16'sh7FFF;
                range_q_in = 16'sh7FFF;
            end else begin
                range_i_in = 16'sh8000;
                range_q_in = 16'sh8000;
            end
            range_valid_in = 1'b1;
            @(posedge clk); #1;
        end
        range_valid_in = 1'b0;
        stop_capture;

        $display("  Output count: %0d", cap_count);
        check(cap_count == OUTPUT_BINS, "13: Accumulator stress outputs 64 bins");
        // Even groups (16×7FFF): sum=0x7FFF0, >>4=0x7FFF=32767
        // Odd groups  (16×8000): sum=0x80000 in 21 bits, but 20-bit reg wraps
        // 16 * (-32768) = -524288 = 20'h80000 which is exactly representable
        // sum_i[19:4] = 16'h8000 = -32768
        if (cap_count >= 2) begin
            $display("  Bin 0 (even grp): I=%0d (expect 32767)", cap_i[0]);
            $display("  Bin 1 (odd  grp): I=%0d (expect -32768)", cap_i[1]);
        end
        check(cap_count >= 1 && cap_i[0] == 16'sh7FFF,
              "13: Even group avg = 0x7FFF");
        check(cap_count >= 2 && cap_i[1] == 16'sh8000,
              "13: Odd group avg = 0x8000 (boundary value)");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 14: start_bin functionality
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 14: start_bin Functionality ---");

        // 14a: start_bin=16, mode 00 (simple decimation), ramp input
        // With start_bin=16, the first 16 samples are skipped.
        // Processing starts at input sample 16.
        // Group 0: input samples 16..31, center at index 8 within group → sample 24 → I=24
        // Group 1: input samples 32..47, center at index 8 → sample 40 → I=40
        apply_reset;
        decimation_mode = 2'b00;
        start_bin = 10'd16;

        start_capture;
        // Feed 1024 + 16 = 1040 samples of ramp data
        // But wait - the DUT expects exactly 1024 input bins worth of processing
        // after skipping. We need to feed start_bin + OUTPUT_BINS*DECIMATION_FACTOR
        // = 16 + 64*16 = 16 + 1024 = 1040 valid samples.
        for (i = 0; i < 1040; i = i + 1) begin
            range_i_in     = i[15:0];
            range_q_in     = 16'd0;
            range_valid_in = 1'b1;
            @(posedge clk); #1;
        end
        range_valid_in = 1'b0;
        stop_capture;

        $display("  14a: start_bin=16, mode 00 ramp");
        $display("  Output count: %0d (expected %0d)", cap_count, OUTPUT_BINS);
        if (cap_count >= 2) begin
            $display("  Bin 0: I=%0d (expect 24)", cap_i[0]);
            $display("  Bin 1: I=%0d (expect 40)", cap_i[1]);
        end
        check(cap_count == OUTPUT_BINS, "14a: start_bin=16 outputs 64 bins");
        check(cap_count >= 1 && cap_i[0] == 16'sd24,
              "14a: Bin 0 center = input 24 (skip 16 + center at 8)");
        check(cap_count >= 2 && cap_i[1] == 16'sd40,
              "14a: Bin 1 center = input 40");

        // 14b: start_bin=32, mode 01 (peak detection)
        // Skip first 32 samples, then peak-detect groups of 16
        // Feed peaked data where group G (starting from bin 32) has spike at
        // varying positions with value (G+1)*100
        apply_reset;
        decimation_mode = 2'b01;
        start_bin = 10'd32;

        start_capture;
        for (i = 0; i < 1056; i = i + 1) begin
            if (i < 32) begin
                // Skipped region — feed garbage
                range_i_in = 16'sh7FFF;  // Max value — should be ignored
                range_q_in = 16'sh7FFF;
            end else begin : peak_gen
                integer rel_idx, grp, pos_in_grp;
                rel_idx = i - 32;
                grp = rel_idx / DECIMATION_FACTOR;
                pos_in_grp = rel_idx % DECIMATION_FACTOR;
                if (grp < OUTPUT_BINS) begin
                    if (pos_in_grp == 0)
                        range_i_in = (grp + 1) * 100;
                    else
                        range_i_in = 16'sd1;
                end else begin
                    range_i_in = 16'sd1;
                end
                range_q_in = 16'd0;
            end
            range_valid_in = 1'b1;
            @(posedge clk); #1;
        end
        range_valid_in = 1'b0;
        stop_capture;

        $display("  14b: start_bin=32, mode 01 peak detect");
        $display("  Output count: %0d", cap_count);
        if (cap_count >= 2) begin
            $display("  Bin 0: I=%0d (expect 100)", cap_i[0]);
            $display("  Bin 1: I=%0d (expect 200)", cap_i[1]);
        end
        check(cap_count == OUTPUT_BINS, "14b: start_bin=32 outputs 64 bins");
        // The skipped max-value samples should NOT appear in output
        check(cap_count >= 1 && cap_i[0] == 16'sd100,
              "14b: Bin 0 peak = 100 (skipped garbage)");
        check(cap_count >= 2 && cap_i[1] == 16'sd200,
              "14b: Bin 1 peak = 200");

        // 14c: start_bin=0 (verify default still works after using start_bin)
        apply_reset;
        decimation_mode = 2'b00;
        start_bin = 10'd0;

        start_capture;
        feed_ramp;
        stop_capture;

        check(cap_count == OUTPUT_BINS, "14c: start_bin=0 still works");
        check(cap_count >= 1 && cap_i[0] == 16'sd8,
              "14c: Bin 0 = 8 (original behavior preserved)");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 15: Watchdog Timeout (Fix 5)
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 15: Watchdog Timeout (Fix 5) ---");

        // 15a: Stall in ST_PROCESS — feed 8 samples (half a group) then stop.
        //      After 256 clocks of no valid, watchdog should fire and return to IDLE.
        //      After that, a fresh full frame should still produce 64 outputs.
        $display("  15a: Stall mid-group in ST_PROCESS");
        apply_reset;
        wd_pulse_count = 0;
        decimation_mode = 2'b01;  // Peak mode

        // Feed only 8 samples (partial group)
        for (i = 0; i < 8; i = i + 1) begin
            range_i_in     = (i + 1) * 100;
            range_q_in     = 16'd0;
            range_valid_in = 1'b1;
            @(posedge clk); #1;
        end
        range_valid_in = 1'b0;

        // Wait for watchdog to fire (256 + margin)
        repeat (280) @(posedge clk); #1;
        check(wd_pulse_count == 1, "15a: watchdog_timeout pulsed once");

        // Verify DUT returned to idle — feed a complete frame and check output
        // Mode 01 (peak) with ramp: group 0 has values 0..15, peak = 15
        start_capture;
        feed_ramp;
        stop_capture;

        $display("  15a: Output count after recovery: %0d", cap_count);
        check(cap_count == OUTPUT_BINS, "15a: 64 outputs after watchdog recovery");
        check(cap_count >= 1 && cap_i[0] == 16'sd15, "15a: Bin 0 = 15 (peak of 0..15) after recovery");

        // 15b: Stall in ST_SKIP — set start_bin=100, feed 50 samples then stop.
        //      DUT should be in ST_SKIP, watchdog fires after 256 idle clocks.
        $display("  15b: Stall in ST_SKIP");
        apply_reset;
        wd_pulse_count = 0;
        decimation_mode = 2'b00;
        start_bin = 10'd100;

        // Feed only 50 samples (not enough to finish skipping)
        for (i = 0; i < 50; i = i + 1) begin
            range_i_in     = i[15:0];
            range_q_in     = 16'd0;
            range_valid_in = 1'b1;
            @(posedge clk); #1;
        end
        range_valid_in = 1'b0;

        // Wait for watchdog
        repeat (280) @(posedge clk); #1;
        check(wd_pulse_count == 1, "15b: watchdog_timeout pulsed once in ST_SKIP");

        // Recovery: feed full frame with start_bin=0
        start_bin = 10'd0;
        start_capture;
        feed_ramp;
        stop_capture;
        check(cap_count == OUTPUT_BINS, "15b: 64 outputs after ST_SKIP watchdog recovery");

        // 15c: Normal operation should NOT trigger watchdog.
        //      Short gaps (20 clocks) are well under the 256 limit.
        $display("  15c: Normal gaps do NOT trigger watchdog");
        apply_reset;
        wd_pulse_count = 0;
        decimation_mode = 2'b01;
        start_bin = 10'd0;

        start_capture;
        // Reuse the gap-feed pattern from Test Group 10: gaps of 20 cycles every 50 samples
        begin : wd_gap_feed
            integer sample_idx, samples_since_gap;
            sample_idx = 0;
            samples_since_gap = 0;
            while (sample_idx < INPUT_BINS) begin
                range_i_in     = sample_idx[15:0];
                range_q_in     = 16'd0;
                range_valid_in = 1'b1;
                @(posedge clk); #1;
                sample_idx = sample_idx + 1;
                samples_since_gap = samples_since_gap + 1;
                if (samples_since_gap == 50 && sample_idx < INPUT_BINS) begin
                    range_valid_in = 1'b0;
                    repeat (20) @(posedge clk);
                    #1;
                    samples_since_gap = 0;
                end
            end
            range_valid_in = 1'b0;
        end
        stop_capture;

        check(wd_pulse_count == 0, "15c: No watchdog timeout with 20-cycle gaps");
        check(cap_count == OUTPUT_BINS, "15c: Still outputs 64 bins with gaps");

        // 15d: Watchdog does NOT fire in ST_IDLE (no false trigger when idle).
        $display("  15d: No false watchdog in ST_IDLE");
        apply_reset;
        wd_pulse_count = 0;
        // Just wait 512 clocks doing nothing — should NOT trigger watchdog
        repeat (512) @(posedge clk); #1;
        check(wd_pulse_count == 0, "15d: No watchdog timeout while idle");

        // ════════════════════════════════════════════════════════
        // Summary
        // ════════════════════════════════════════════════════════
        $display("");
        $display("========================================");
        $display("  RANGE BIN DECIMATOR RESULTS");
        $display("  PASSED: %0d / %0d", pass_count, test_num);
        $display("  FAILED: %0d / %0d", fail_count, test_num);
        if (fail_count == 0)
            $display("  ** ALL TESTS PASSED **");
        else
            $display("  ** SOME TESTS FAILED **");
        $display("========================================");
        $display("");

        #100;
        $finish;
    end

endmodule
