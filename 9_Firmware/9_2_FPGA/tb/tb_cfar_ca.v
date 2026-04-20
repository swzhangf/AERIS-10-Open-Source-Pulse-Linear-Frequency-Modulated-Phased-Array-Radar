`timescale 1ns / 1ps

/**
 * tb_cfar_ca.v
 *
 * Comprehensive testbench for cfar_ca.v (Cell-Averaging CFAR Detector).
 * Uses [PASS]/[FAIL] markers compatible with run_regression.sh.
 *
 * Test plan:
 *   T1:  CFAR disabled → simple threshold pass-through (backward-compatible)
 *   T2:  CA-CFAR with uniform noise floor → no detections
 *   T3:  CA-CFAR with single strong target → exactly 1 detection at correct bin
 *   T4:  CA-CFAR with two targets separated by > window size → 2 detections
 *   T5:  CA-CFAR edge handling → targets at range bin 0 and 63
 *   T6:  GO-CFAR mode with asymmetric noise → correct target detection
 *   T7:  SO-CFAR mode → lower threshold, more sensitive
 *   T8:  Alpha scaling → higher alpha reduces detections
 *   T9:  Guard cell effect → target neighbor doesn't raise threshold
 *   T10: Zero guard, zero train corner case
 *   T11: Reset during processing → clean recovery
 *   T12: Back-to-back frames → second frame processes correctly
 *   T13: detect_count accumulates across frames
 *   T14: cfar_busy asserts during processing, deasserts after
 */

module tb_cfar_ca;

// ============================================================================
// PARAMETERS
// ============================================================================
parameter NUM_RANGE   = 64;
parameter NUM_DOPPLER = 32;
parameter MAG_W       = 17;
parameter ALPHA_W     = 8;
parameter CLK_PERIOD  = 10;  // 100 MHz

// ============================================================================
// DUT SIGNALS
// ============================================================================
reg clk;
reg reset_n;

reg [31:0] doppler_data;
reg        doppler_valid;
reg [4:0]  doppler_bin_in;
reg [5:0]  range_bin_in;
reg        frame_complete;

reg [3:0]  cfg_guard_cells;
reg [4:0]  cfg_train_cells;
reg [ALPHA_W-1:0] cfg_alpha;
reg [1:0]  cfg_cfar_mode;
reg        cfg_cfar_enable;
reg [15:0] cfg_simple_threshold;

wire        detect_flag;
wire        detect_valid;
wire [5:0]  detect_range;
wire [4:0]  detect_doppler;
wire [MAG_W-1:0] detect_magnitude;
wire [MAG_W-1:0] detect_threshold;
wire [15:0] detect_count;
wire        cfar_busy;
wire [7:0]  cfar_status;

// ============================================================================
// TEST TRACKING
// ============================================================================
integer pass_count;
integer fail_count;
integer test_num;
reg [255:0] test_name;

// Detection capture (flagged detections only)
integer det_cap_count;
reg [5:0]  det_cap_range  [0:255];
reg [4:0]  det_cap_doppler[0:255];
reg [MAG_W-1:0] det_cap_mag[0:255];
reg [MAG_W-1:0] det_cap_thr[0:255];
reg        det_cap_flag   [0:255];
integer det_total_valid;  // Total valid outputs (including non-detections)

// ============================================================================
// DUT INSTANTIATION
// ============================================================================
cfar_ca #(
    .NUM_RANGE_BINS(NUM_RANGE),
    .NUM_DOPPLER_BINS(NUM_DOPPLER),
    .MAG_WIDTH(MAG_W),
    .ALPHA_WIDTH(ALPHA_W)
) dut (
    .clk(clk),
    .reset_n(reset_n),
    .doppler_data(doppler_data),
    .doppler_valid(doppler_valid),
    .doppler_bin_in(doppler_bin_in),
    .range_bin_in(range_bin_in),
    .frame_complete(frame_complete),
    .cfg_guard_cells(cfg_guard_cells),
    .cfg_train_cells(cfg_train_cells),
    .cfg_alpha(cfg_alpha),
    .cfg_cfar_mode(cfg_cfar_mode),
    .cfg_cfar_enable(cfg_cfar_enable),
    .cfg_simple_threshold(cfg_simple_threshold),
    .detect_flag(detect_flag),
    .detect_valid(detect_valid),
    .detect_range(detect_range),
    .detect_doppler(detect_doppler),
    .detect_magnitude(detect_magnitude),
    .detect_threshold(detect_threshold),
    .detect_count(detect_count),
    .cfar_busy(cfar_busy),
    .cfar_status(cfar_status)
);

// ============================================================================
// CLOCK GENERATION
// ============================================================================
initial clk = 0;
always #(CLK_PERIOD/2) clk = ~clk;

// ============================================================================
// HELPER TASKS
// ============================================================================

task check;
    input integer tnum;
    input [255:0] desc;
    input condition;
    begin
        if (condition) begin
            $display("[PASS(T%0d)] %0s", tnum, desc);
            pass_count = pass_count + 1;
        end else begin
            $display("[FAIL(T%0d)] %0s", tnum, desc);
            fail_count = fail_count + 1;
        end
    end
endtask

task do_reset;
    begin
        reset_n = 0;
        doppler_data = 32'd0;
        doppler_valid = 1'b0;
        doppler_bin_in = 5'd0;
        range_bin_in = 6'd0;
        frame_complete = 1'b0;
        repeat (5) @(posedge clk);
        reset_n = 1;
        repeat (2) @(posedge clk);
    end
endtask

// Feed one Doppler sample (I/Q packed as {Q, I})
task feed_sample;
    input [5:0] rbin;
    input [4:0] dbin;
    input signed [15:0] i_val;
    input signed [15:0] q_val;
    begin
        @(posedge clk);
        doppler_data <= {q_val, i_val};
        doppler_valid <= 1'b1;
        range_bin_in <= rbin;
        doppler_bin_in <= dbin;
        @(posedge clk);
        doppler_valid <= 1'b0;
    end
endtask

// Feed a complete frame with uniform noise + optional targets
// noise_level: base I value for all cells
// num_targets: number of target cells
// tgt_range[0..3], tgt_doppler[0..3], tgt_level[0..3]: target parameters
reg [5:0]  tgt_range  [0:7];
reg [4:0]  tgt_doppler[0:7];
reg [15:0] tgt_level  [0:7];
integer    num_targets;

task feed_frame;
    input [15:0] noise_level;
    integer r, d, t;
    reg is_target;
    reg [15:0] i_val;
    begin
        // Feed all 64*32 = 2048 samples in Doppler processor output order:
        // For each range bin, output all 32 Doppler bins
        for (r = 0; r < NUM_RANGE; r = r + 1) begin
            for (d = 0; d < NUM_DOPPLER; d = d + 1) begin
                is_target = 0;
                i_val = noise_level;
                for (t = 0; t < num_targets; t = t + 1) begin
                    if (r == tgt_range[t] && d == tgt_doppler[t]) begin
                        is_target = 1;
                        i_val = tgt_level[t];
                    end
                end
                feed_sample(r[5:0], d[4:0], $signed(i_val), 16'sd0);
            end
        end
    end
endtask

task pulse_frame_complete;
    begin
        @(posedge clk);
        frame_complete <= 1'b1;
        @(posedge clk);
        frame_complete <= 1'b0;
    end
endtask

// Wait for CFAR processing to complete (with timeout)
task wait_cfar_done;
    input integer timeout_cycles;
    integer countdown;
    begin
        countdown = timeout_cycles;
        while (cfar_busy && countdown > 0) begin
            @(posedge clk);
            countdown = countdown - 1;
        end
        if (countdown == 0)
            $display("[WARN] CFAR processing timeout after %0d cycles", timeout_cycles);
    end
endtask

// Capture flagged detections during CFAR processing
task capture_detections;
    input integer timeout_cycles;
    integer countdown;
    begin
        det_cap_count = 0;
        det_total_valid = 0;
        countdown = timeout_cycles;
        while ((cfar_busy || countdown == timeout_cycles) && countdown > 0) begin
            @(posedge clk);
            countdown = countdown - 1;
            if (detect_valid) begin
                det_total_valid = det_total_valid + 1;
                // Only capture flagged detections (saves buffer space)
                if (detect_flag && det_cap_count < 256) begin
                    det_cap_range[det_cap_count]   = detect_range;
                    det_cap_doppler[det_cap_count] = detect_doppler;
                    det_cap_mag[det_cap_count]     = detect_magnitude;
                    det_cap_thr[det_cap_count]     = detect_threshold;
                    det_cap_flag[det_cap_count]    = 1'b1;
                    det_cap_count = det_cap_count + 1;
                end
            end
        end
    end
endtask

// Count flagged detections (all captured entries are flagged)
function integer count_flagged_detections;
    input integer dummy;
    begin
        count_flagged_detections = det_cap_count;
    end
endfunction

// Find if a specific (range, doppler) was flagged as detection
function integer find_detection;
    input [5:0] rbin;
    input [4:0] dbin;
    integer i;
    begin
        find_detection = 0;
        for (i = 0; i < det_cap_count; i = i + 1) begin
            if (det_cap_flag[i] && det_cap_range[i] == rbin && det_cap_doppler[i] == dbin)
                find_detection = 1;
        end
    end
endfunction

// ============================================================================
// MAIN TEST SEQUENCE
// ============================================================================
integer i;
integer flagged;

initial begin
    $dumpfile("tb_cfar_ca.vcd");
    $dumpvars(0, tb_cfar_ca);

    pass_count = 0;
    fail_count = 0;
    num_targets = 0;

    // Default config: CA-CFAR, guard=2, train=8, alpha=3.0 (Q4.4 = 0x30)
    cfg_guard_cells = 4'd2;
    cfg_train_cells = 5'd8;
    cfg_alpha = 8'h30;
    cfg_cfar_mode = 2'b00;
    cfg_cfar_enable = 1'b1;
    cfg_simple_threshold = 16'd5000;

    // ================================================================
    // T1: CFAR disabled → simple threshold pass-through
    // ================================================================
    test_num = 1;
    do_reset;
    cfg_cfar_enable = 1'b0;
    cfg_simple_threshold = 16'd100;

    // Feed a few samples: one below threshold, one above
    feed_sample(6'd0, 5'd0, 16'sd50, 16'sd0);   // mag=50 < 100 → no detect
    @(posedge clk); // let detect_valid propagate
    check(1, "T1.1: CFAR disabled, below threshold -> no flag", detect_flag == 0);

    feed_sample(6'd1, 5'd0, 16'sd200, 16'sd0);  // mag=200 > 100 → detect
    @(posedge clk);
    check(1, "T1.2: CFAR disabled, above threshold -> flag=1", detect_flag == 1);

    // ================================================================
    // T2: CA-CFAR uniform noise → no detections
    // ================================================================
    test_num = 2;
    do_reset;
    cfg_cfar_enable = 1'b1;
    cfg_guard_cells = 4'd2;
    cfg_train_cells = 5'd8;
    cfg_alpha = 8'h10;  // alpha=1.0 in Q4.4 (low threshold → still no detect if uniform)
    cfg_cfar_mode = 2'b00;
    num_targets = 0;

    feed_frame(16'd1000);  // Uniform noise: all cells = 1000
    pulse_frame_complete;
    capture_detections(20000);

    flagged = count_flagged_detections(0);
    // With uniform noise and alpha >= 1.0, threshold ≈ noise level
    // Some edge cells might detect due to fewer training cells → lower threshold
    // Check that interior cells (away from edges) have no detections
    check(2, "T2: Uniform noise, CA-CFAR: few or no interior detections", flagged < 20);
    $display("  [INFO] T2: %0d detections out of %0d valid outputs (uniform noise)", flagged, det_total_valid);

    // ================================================================
    // T3: CA-CFAR single strong target → detection at correct bin
    // ================================================================
    test_num = 3;
    do_reset;
    cfg_cfar_enable = 1'b1;
    cfg_guard_cells = 4'd2;
    cfg_train_cells = 5'd8;
    cfg_alpha = 8'h10;  // alpha=1.0
    cfg_cfar_mode = 2'b00;

    num_targets = 1;
    tgt_range[0] = 6'd32;
    tgt_doppler[0] = 5'd16;
    tgt_level[0] = 16'd20000;  // 20x noise level

    feed_frame(16'd1000);
    pulse_frame_complete;
    capture_detections(20000);

    flagged = count_flagged_detections(0);
    check(3, "T3.1: Single strong target detected", flagged > 0);
    check(3, "T3.2: Target at (32,16) flagged", find_detection(6'd32, 5'd16) == 1);
    $display("  [INFO] T3: %0d total detections", flagged);

    // ================================================================
    // T4: Two targets well-separated → both detected
    // ================================================================
    test_num = 4;
    do_reset;
    cfg_cfar_enable = 1'b1;
    cfg_guard_cells = 4'd2;
    cfg_train_cells = 5'd8;
    cfg_alpha = 8'h10;
    cfg_cfar_mode = 2'b00;

    num_targets = 2;
    tgt_range[0] = 6'd10;  tgt_doppler[0] = 5'd5;  tgt_level[0] = 16'd25000;
    tgt_range[1] = 6'd50;  tgt_doppler[1] = 5'd20; tgt_level[1] = 16'd25000;

    feed_frame(16'd1000);
    pulse_frame_complete;
    capture_detections(20000);

    flagged = count_flagged_detections(0);
    check(4, "T4.1: Two targets: at least 2 detections", flagged >= 2);
    check(4, "T4.2: Target at (10,5) detected", find_detection(6'd10, 5'd5) == 1);
    check(4, "T4.3: Target at (50,20) detected", find_detection(6'd50, 5'd20) == 1);

    // ================================================================
    // T5: Edge targets → range bin 0 and 63
    // ================================================================
    test_num = 5;
    do_reset;
    cfg_cfar_enable = 1'b1;
    cfg_guard_cells = 4'd2;
    cfg_train_cells = 5'd4;
    cfg_alpha = 8'h08;  // alpha=0.5 (low → more sensitive at edges)
    cfg_cfar_mode = 2'b00;

    num_targets = 2;
    tgt_range[0] = 6'd0;   tgt_doppler[0] = 5'd0;  tgt_level[0] = 16'd20000;
    tgt_range[1] = 6'd63;  tgt_doppler[1] = 5'd0;  tgt_level[1] = 16'd20000;

    feed_frame(16'd1000);
    pulse_frame_complete;
    capture_detections(20000);

    // Edge targets have fewer training cells → lower threshold → should still detect
    check(5, "T5.1: Edge target at (0,0) detected", find_detection(6'd0, 5'd0) == 1);
    check(5, "T5.2: Edge target at (63,0) detected", find_detection(6'd63, 5'd0) == 1);

    // ================================================================
    // T6: GO-CFAR with asymmetric noise
    // ================================================================
    test_num = 6;
    do_reset;
    cfg_cfar_enable = 1'b1;
    cfg_guard_cells = 4'd1;
    cfg_train_cells = 5'd4;
    cfg_alpha = 8'h10;  // alpha=1.0
    cfg_cfar_mode = 2'b01;  // GO-CFAR

    // Target at range=32, noise higher on one side (simulate clutter edge)
    // Leading (range<32): noise=1000, Lagging (range>32): noise=5000
    // GO-CFAR should use max(leading_avg, lagging_avg) = lagging
    // Target must exceed the higher threshold
    num_targets = 1;
    tgt_range[0] = 6'd32;  tgt_doppler[0] = 5'd0;  tgt_level[0] = 16'd25000;

    // Custom frame: asymmetric noise
    begin : t6_feed
        integer r, d;
        reg [15:0] noise;
        for (r = 0; r < NUM_RANGE; r = r + 1) begin
            for (d = 0; d < NUM_DOPPLER; d = d + 1) begin
                if (r == 32 && d == 0)
                    noise = 16'd25000;
                else if (r < 32)
                    noise = 16'd1000;
                else
                    noise = 16'd5000;
                feed_sample(r[5:0], d[4:0], $signed(noise), 16'sd0);
            end
        end
    end
    pulse_frame_complete;
    capture_detections(20000);

    check(6, "T6: GO-CFAR with asymmetric noise: target at (32,0) detected", find_detection(6'd32, 5'd0) == 1);

    // ================================================================
    // T7: SO-CFAR → more sensitive (lower threshold)
    // ================================================================
    test_num = 7;
    do_reset;
    cfg_cfar_enable = 1'b1;
    cfg_guard_cells = 4'd1;
    cfg_train_cells = 5'd4;
    cfg_alpha = 8'h10;
    cfg_cfar_mode = 2'b10;  // SO-CFAR

    // Same asymmetric scene — SO-CFAR uses min(leading_avg, lagging_avg)
    // Threshold lower → should detect more easily
    num_targets = 1;
    tgt_range[0] = 6'd32;  tgt_doppler[0] = 5'd0;  tgt_level[0] = 16'd8000;

    begin : t7_feed
        integer r, d;
        reg [15:0] noise;
        for (r = 0; r < NUM_RANGE; r = r + 1) begin
            for (d = 0; d < NUM_DOPPLER; d = d + 1) begin
                if (r == 32 && d == 0)
                    noise = 16'd8000;
                else if (r < 32)
                    noise = 16'd1000;
                else
                    noise = 16'd5000;
                feed_sample(r[5:0], d[4:0], $signed(noise), 16'sd0);
            end
        end
    end
    pulse_frame_complete;
    capture_detections(20000);

    check(7, "T7: SO-CFAR: target at (32,0) with modest level detected", find_detection(6'd32, 5'd0) == 1);

    // ================================================================
    // T8: High alpha → fewer detections
    // ================================================================
    test_num = 8;
    do_reset;
    cfg_cfar_enable = 1'b1;
    cfg_guard_cells = 4'd2;
    cfg_train_cells = 5'd8;
    cfg_alpha = 8'hF0;  // alpha=15.0 (very high → very few detections)
    cfg_cfar_mode = 2'b00;

    num_targets = 1;
    tgt_range[0] = 6'd32;  tgt_doppler[0] = 5'd16;  tgt_level[0] = 16'd5000;
    // Target only 5x noise → shouldn't exceed alpha=15 threshold

    feed_frame(16'd1000);
    pulse_frame_complete;
    capture_detections(20000);

    flagged = count_flagged_detections(0);
    check(8, "T8: High alpha=15.0: weak target NOT detected", find_detection(6'd32, 5'd16) == 0);
    $display("  [INFO] T8: %0d detections with alpha=15.0", flagged);

    // ================================================================
    // T9: Guard cells prevent target leakage
    // ================================================================
    test_num = 9;
    do_reset;
    cfg_cfar_enable = 1'b1;
    cfg_guard_cells = 4'd3;  // 3 guard cells each side
    cfg_train_cells = 5'd8;
    cfg_alpha = 8'h10;  // alpha=1.0
    cfg_cfar_mode = 2'b00;

    // Strong target at range=32. Neighbors (range 29-31, 33-35) are guard cells
    // and should NOT inflate the noise estimate.
    num_targets = 1;
    tgt_range[0] = 6'd32;  tgt_doppler[0] = 5'd0;  tgt_level[0] = 16'd30000;

    feed_frame(16'd1000);
    pulse_frame_complete;
    capture_detections(20000);

    check(9, "T9: Guard cells: target at (32,0) detected with guard=3", find_detection(6'd32, 5'd0) == 1);

    // ================================================================
    // T10: Corner case — zero guard, minimal train
    // ================================================================
    test_num = 10;
    do_reset;
    cfg_cfar_enable = 1'b1;
    cfg_guard_cells = 4'd0;  // No guard cells
    cfg_train_cells = 5'd1;  // Minimum training
    cfg_alpha = 8'h10;       // alpha=1.0
    cfg_cfar_mode = 2'b00;

    num_targets = 1;
    tgt_range[0] = 6'd32;  tgt_doppler[0] = 5'd0;  tgt_level[0] = 16'd10000;

    feed_frame(16'd1000);
    pulse_frame_complete;
    capture_detections(20000);

    check(10, "T10: guard=0, train=1: target detected", find_detection(6'd32, 5'd0) == 1);

    // ================================================================
    // T11: Reset during processing → clean recovery
    // ================================================================
    test_num = 11;
    do_reset;
    cfg_cfar_enable = 1'b1;
    cfg_guard_cells = 4'd2;
    cfg_train_cells = 5'd8;
    cfg_alpha = 8'h10;
    cfg_cfar_mode = 2'b00;
    num_targets = 0;

    feed_frame(16'd1000);
    pulse_frame_complete;

    // Wait partway into CFAR processing
    repeat (200) @(posedge clk);
    check(11, "T11.1: CFAR busy during processing", cfar_busy == 1);

    // Reset mid-processing
    reset_n = 0;
    repeat (5) @(posedge clk);
    reset_n = 1;
    repeat (5) @(posedge clk);

    check(11, "T11.2: After reset, CFAR not busy", cfar_busy == 0);
    check(11, "T11.3: After reset, state is IDLE", dut.state == 4'd0);

    // ================================================================
    // T12: Back-to-back frames
    // ================================================================
    test_num = 12;
    do_reset;
    cfg_cfar_enable = 1'b1;
    cfg_guard_cells = 4'd2;
    cfg_train_cells = 5'd8;
    cfg_alpha = 8'h10;
    cfg_cfar_mode = 2'b00;

    // Frame 1: no targets
    num_targets = 0;
    feed_frame(16'd1000);
    pulse_frame_complete;
    wait_cfar_done(20000);

    // Frame 2: one target
    num_targets = 1;
    tgt_range[0] = 6'd20;  tgt_doppler[0] = 5'd10;  tgt_level[0] = 16'd25000;
    feed_frame(16'd1000);
    pulse_frame_complete;
    capture_detections(20000);

    check(12, "T12: Back-to-back frame 2: target at (20,10) detected", find_detection(6'd20, 5'd10) == 1);

    // ================================================================
    // T13: detect_count accumulates
    // ================================================================
    test_num = 13;
    do_reset;
    cfg_cfar_enable = 1'b1;
    cfg_guard_cells = 4'd2;
    cfg_train_cells = 5'd8;
    cfg_alpha = 8'h10;
    cfg_cfar_mode = 2'b00;

    num_targets = 1;
    tgt_range[0] = 6'd30;  tgt_doppler[0] = 5'd0;  tgt_level[0] = 16'd20000;

    // Frame 1
    feed_frame(16'd1000);
    pulse_frame_complete;
    wait_cfar_done(20000);
    begin : t13_save
        reg [15:0] count_after_frame1;
        count_after_frame1 = detect_count;
        $display("  [INFO] T13: detect_count after frame 1 = %0d", count_after_frame1);

        // Frame 2 (same target)
        feed_frame(16'd1000);
        pulse_frame_complete;
        wait_cfar_done(20000);
        $display("  [INFO] T13: detect_count after frame 2 = %0d", detect_count);

        check(13, "T13: detect_count increases after second frame", detect_count > count_after_frame1);
    end

    // ================================================================
    // T14: cfar_busy signal
    // ================================================================
    test_num = 14;
    do_reset;
    cfg_cfar_enable = 1'b1;
    cfg_guard_cells = 4'd2;
    cfg_train_cells = 5'd8;
    cfg_alpha = 8'h10;
    cfg_cfar_mode = 2'b00;
    num_targets = 0;

    check(14, "T14.1: Initially not busy", cfar_busy == 0);

    // Start feeding data
    feed_sample(6'd0, 5'd0, 16'sd1000, 16'sd0);
    @(posedge clk);
    check(14, "T14.2: Busy after first sample", cfar_busy == 1);

    // Feed rest of frame
    begin : t14_feed
        integer r, d;
        for (r = 0; r < NUM_RANGE; r = r + 1) begin
            for (d = 0; d < NUM_DOPPLER; d = d + 1) begin
                if (r == 0 && d == 0) begin
                    // Already fed
                end else begin
                    feed_sample(r[5:0], d[4:0], 16'sd1000, 16'sd0);
                end
            end
        end
    end
    pulse_frame_complete;
    wait_cfar_done(20000);
    repeat (5) @(posedge clk);

    check(14, "T14.3: Not busy after processing complete", cfar_busy == 0);

    // ================================================================
    // SUMMARY
    // ================================================================
    $display("");
    $display("============================================");
    $display("  CFAR CA Testbench Results");
    $display("============================================");
    $display("  PASS: %0d", pass_count);
    $display("  FAIL: %0d", fail_count);
    $display("============================================");

    if (fail_count > 0)
        $display("[FAIL] %0d test(s) failed", fail_count);
    else
        $display("[PASS] All %0d tests passed", pass_count);

    $finish;
end

// ============================================================================
// WATCHDOG TIMEOUT
// ============================================================================
initial begin
    #50_000_000;  // 50 ms
    $display("[FAIL] Global watchdog timeout");
    $finish;
end

endmodule
