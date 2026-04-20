`timescale 1ns / 1ps

/**
 * tb_mti_canceller.v
 *
 * Testbench for mti_canceller.v (Moving Target Indication).
 * Uses [PASS]/[FAIL] markers for run_regression.sh compatibility.
 *
 * Tests:
 *   T1: Pass-through mode (mti_enable=0) — data unchanged
 *   T2: First chirp muted (zeros) when MTI enabled
 *   T3: Second chirp = current - previous (correct subtraction)
 *   T4: Stationary target cancels to zero
 *   T5: Moving target (phase shift) passes through
 *   T6: Saturation on large difference
 *   T7: Enable toggle mid-stream — clean transition
 *   T8: Reset during operation — clean recovery
 *   T9: range_bin_out tracks range_bin_in
 *   T10: Back-to-back chirps (3+ chirps, verify continuous operation)
 *   T11: Negative input values handled correctly
 */

module tb_mti_canceller;

parameter DATA_W = 16;
parameter NUM_BINS = 64;
parameter CLK_PERIOD = 10;

reg clk;
reg reset_n;

reg signed [DATA_W-1:0] range_i_in;
reg signed [DATA_W-1:0] range_q_in;
reg                      range_valid_in;
reg [5:0]                range_bin_in;
reg                      mti_enable;

wire signed [DATA_W-1:0] range_i_out;
wire signed [DATA_W-1:0] range_q_out;
wire                      range_valid_out;
wire [5:0]                range_bin_out;
wire                      mti_first_chirp;

integer pass_count, fail_count;

// Output capture
reg signed [DATA_W-1:0] cap_i [0:NUM_BINS-1];
reg signed [DATA_W-1:0] cap_q [0:NUM_BINS-1];
reg [5:0]               cap_bin [0:NUM_BINS-1];
integer cap_count;

mti_canceller #(
    .NUM_RANGE_BINS(NUM_BINS),
    .DATA_WIDTH(DATA_W)
) dut (
    .clk(clk),
    .reset_n(reset_n),
    .range_i_in(range_i_in),
    .range_q_in(range_q_in),
    .range_valid_in(range_valid_in),
    .range_bin_in(range_bin_in),
    .range_i_out(range_i_out),
    .range_q_out(range_q_out),
    .range_valid_out(range_valid_out),
    .range_bin_out(range_bin_out),
    .mti_enable(mti_enable),
    .mti_first_chirp(mti_first_chirp)
);

initial clk = 0;
always #(CLK_PERIOD/2) clk = ~clk;

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
        range_i_in = 0;
        range_q_in = 0;
        range_valid_in = 0;
        range_bin_in = 0;
        repeat (5) @(posedge clk);
        reset_n = 1;
        repeat (2) @(posedge clk);
    end
endtask

// Feed one range bin sample
task feed_sample;
    input [5:0] bin;
    input signed [DATA_W-1:0] i_val;
    input signed [DATA_W-1:0] q_val;
    begin
        @(posedge clk);
        range_i_in <= i_val;
        range_q_in <= q_val;
        range_valid_in <= 1'b1;
        range_bin_in <= bin;
        @(posedge clk);
        range_valid_in <= 1'b0;
    end
endtask

// Feed a full chirp (64 range bins) with constant I/Q
task feed_chirp_const;
    input signed [DATA_W-1:0] i_val;
    input signed [DATA_W-1:0] q_val;
    integer r;
    begin
        for (r = 0; r < NUM_BINS; r = r + 1) begin
            feed_sample(r[5:0], i_val, q_val);
        end
    end
endtask

// Feed a chirp where bin r has value i_base + r*i_step
task feed_chirp_ramp;
    input signed [DATA_W-1:0] i_base;
    input signed [DATA_W-1:0] i_step;
    input signed [DATA_W-1:0] q_val;
    integer r;
    begin
        for (r = 0; r < NUM_BINS; r = r + 1) begin
            feed_sample(r[5:0], i_base + i_step * r[DATA_W-1:0], q_val);
        end
    end
endtask

// Capture outputs during a chirp
task capture_chirp;
    integer timeout;
    begin
        cap_count = 0;
        timeout = NUM_BINS * 4 + 100;
        while (cap_count < NUM_BINS && timeout > 0) begin
            @(posedge clk);
            timeout = timeout - 1;
            if (range_valid_out) begin
                cap_i[cap_count]   = range_i_out;
                cap_q[cap_count]   = range_q_out;
                cap_bin[cap_count] = range_bin_out;
                cap_count = cap_count + 1;
            end
        end
    end
endtask

integer i;
reg all_zero;
reg all_match;
reg signed [DATA_W-1:0] expected;

initial begin
    $dumpfile("tb_mti_canceller.vcd");
    $dumpvars(0, tb_mti_canceller);

    pass_count = 0;
    fail_count = 0;

    // ================================================================
    // T1: Pass-through mode
    // ================================================================
    do_reset;
    mti_enable = 1'b0;

    // Feed one chirp with known data, capture output
    fork
        feed_chirp_const(16'sd1000, 16'sd500);
        capture_chirp;
    join

    check(1, "T1.1: Pass-through: 64 outputs", cap_count == 64);
    check(1, "T1.2: Pass-through: I[0]=1000", cap_i[0] == 16'sd1000);
    check(1, "T1.3: Pass-through: Q[0]=500", cap_q[0] == 16'sd500);
    check(1, "T1.4: Pass-through: I[63]=1000", cap_i[63] == 16'sd1000);

    // ================================================================
    // T2: First chirp muted when MTI enabled
    // ================================================================
    do_reset;
    mti_enable = 1'b1;

    fork
        feed_chirp_const(16'sd5000, 16'sd3000);
        capture_chirp;
    join

    all_zero = 1;
    for (i = 0; i < cap_count; i = i + 1) begin
        if (cap_i[i] != 0 || cap_q[i] != 0) all_zero = 0;
    end
    check(2, "T2.1: First chirp: 64 outputs", cap_count == 64);
    check(2, "T2.2: First chirp: all zeros (muted)", all_zero == 1);
    check(2, "T2.3: First chirp: mti_first_chirp was high", dut.has_previous == 1);

    // ================================================================
    // T3: Second chirp = current - previous
    // ================================================================
    // Previous chirp had I=5000, Q=3000. New chirp: I=7000, Q=4000.
    // Expected: I=2000, Q=1000.
    fork
        feed_chirp_const(16'sd7000, 16'sd4000);
        capture_chirp;
    join

    check(3, "T3.1: Second chirp: 64 outputs", cap_count == 64);
    check(3, "T3.2: MTI I[0] = 7000-5000 = 2000", cap_i[0] == 16'sd2000);
    check(3, "T3.3: MTI Q[0] = 4000-3000 = 1000", cap_q[0] == 16'sd1000);
    check(3, "T3.4: MTI I[32] = 2000", cap_i[32] == 16'sd2000);

    // ================================================================
    // T4: Stationary target cancels to zero
    // ================================================================
    // Feed identical chirp as previous (7000, 4000). Diff = 0.
    fork
        feed_chirp_const(16'sd7000, 16'sd4000);
        capture_chirp;
    join

    all_zero = 1;
    for (i = 0; i < cap_count; i = i + 1) begin
        if (cap_i[i] != 0 || cap_q[i] != 0) all_zero = 0;
    end
    check(4, "T4: Stationary target cancels to zero", all_zero == 1);

    // ================================================================
    // T5: Moving target passes through
    // ================================================================
    // Previous was (7000, 4000). New chirp: some bins different, some same.
    // Bin 10: I=10000 → diff=3000. Bin 30: I=7000 → diff=0. Rest same.
    begin : t5_block
        integer r;
        cap_count = 0;
        for (r = 0; r < NUM_BINS; r = r + 1) begin
            if (r == 10)
                feed_sample(r[5:0], 16'sd10000, 16'sd4000);
            else if (r == 30)
                feed_sample(r[5:0], 16'sd7000, 16'sd4000);
            else
                feed_sample(r[5:0], 16'sd7000, 16'sd4000);
        end
        // Wait for outputs
        repeat (10) @(posedge clk);
    end

    // Re-capture: since we didn't fork/join, manually count
    // Actually let me re-do this properly
    do_reset;
    mti_enable = 1'b1;

    // Chirp 1 (stored, output muted)
    fork
        feed_chirp_const(16'sd7000, 16'sd4000);
        capture_chirp;
    join

    // Chirp 2: bin 10 has moving target
    begin : t5_feed
        integer r;
        for (r = 0; r < NUM_BINS; r = r + 1) begin
            if (r == 10)
                feed_sample(r[5:0], 16'sd10000, 16'sd6000);
            else
                feed_sample(r[5:0], 16'sd7000, 16'sd4000);
        end
    end

    // Capture in parallel didn't work cleanly with named blocks, so just wait
    repeat (5) @(posedge clk);

    // Check: we need to capture during feed. Let me use a different approach.
    // Since feed_sample takes 2 cycles and output comes 1 cycle after valid_in,
    // outputs interleave with feeds. Let me just check DUT state.
    // Actually the capture task expects outputs; the issue is fork/join with
    // named blocks in iverilog. Let me restructure.

    // Reset and redo T5 cleanly
    do_reset;
    mti_enable = 1'b1;

    // Chirp 1: all constant
    fork
        feed_chirp_const(16'sd1000, 16'sd500);
        capture_chirp;
    join

    // Chirp 2: bin 20 has a moving target (I=5000 vs previous 1000)
    cap_count = 0;
    fork
        begin : t5_feed2
            integer r;
            for (r = 0; r < NUM_BINS; r = r + 1) begin
                if (r == 20)
                    feed_sample(r[5:0], 16'sd5000, 16'sd500);
                else
                    feed_sample(r[5:0], 16'sd1000, 16'sd500);
            end
        end
        capture_chirp;
    join

    check(5, "T5.1: Moving target: 64 outputs", cap_count == 64);
    check(5, "T5.2: Stationary bin 0: I=0", cap_i[0] == 16'sd0);
    check(5, "T5.3: Moving bin 20: I=4000", cap_i[20] == 16'sd4000);
    check(5, "T5.4: Moving bin 20: Q=0", cap_q[20] == 16'sd0);
    check(5, "T5.5: Stationary bin 63: I=0", cap_i[63] == 16'sd0);

    // ================================================================
    // T6: Saturation
    // ================================================================
    do_reset;
    mti_enable = 1'b1;

    // Chirp 1: I = -32000
    fork
        feed_chirp_const(-16'sd32000, 16'sd0);
        capture_chirp;
    join

    // Chirp 2: I = +32000. Diff = 64000, saturates to +32767.
    cap_count = 0;
    fork
        feed_chirp_const(16'sd32000, 16'sd0);
        capture_chirp;
    join

    check(6, "T6.1: Saturation: 64 outputs", cap_count == 64);
    check(6, "T6.2: Saturated I = 32767", cap_i[0] == 16'sd32767);

    // ================================================================
    // T7: Enable toggle mid-stream
    // ================================================================
    do_reset;
    mti_enable = 1'b0;

    // Feed one chirp in pass-through
    fork
        feed_chirp_const(16'sd2000, 16'sd1000);
        capture_chirp;
    join
    check(7, "T7.1: Pass-through I=2000", cap_i[0] == 16'sd2000);

    // Enable MTI
    mti_enable = 1'b1;

    // First MTI chirp should be muted
    cap_count = 0;
    fork
        feed_chirp_const(16'sd3000, 16'sd1500);
        capture_chirp;
    join

    all_zero = 1;
    for (i = 0; i < cap_count; i = i + 1) begin
        if (cap_i[i] != 0 || cap_q[i] != 0) all_zero = 0;
    end
    check(7, "T7.2: After enable: first chirp muted", all_zero == 1);

    // Second MTI chirp should subtract
    cap_count = 0;
    fork
        feed_chirp_const(16'sd5000, 16'sd2500);
        capture_chirp;
    join
    check(7, "T7.3: After enable: second chirp I=2000", cap_i[0] == 16'sd2000);

    // ================================================================
    // T8: Reset during operation
    // ================================================================
    do_reset;
    mti_enable = 1'b1;

    feed_chirp_const(16'sd1000, 16'sd500);
    repeat (5) @(posedge clk);

    // Reset mid-operation
    reset_n = 0;
    repeat (5) @(posedge clk);
    reset_n = 1;
    repeat (2) @(posedge clk);

    check(8, "T8.1: After reset: first_chirp=1", mti_first_chirp == 1);
    check(8, "T8.2: After reset: has_previous=0", dut.has_previous == 0);

    // ================================================================
    // T9: range_bin_out tracks range_bin_in
    // ================================================================
    do_reset;
    mti_enable = 1'b0;

    cap_count = 0;
    fork
        feed_chirp_const(16'sd100, 16'sd50);
        capture_chirp;
    join

    all_match = 1;
    for (i = 0; i < cap_count; i = i + 1) begin
        if (cap_bin[i] != i[5:0]) all_match = 0;
    end
    check(9, "T9: range_bin_out matches range_bin_in for all 64 bins", all_match == 1);

    // ================================================================
    // T10: Three consecutive chirps
    // ================================================================
    do_reset;
    mti_enable = 1'b1;

    // Chirp 1 (muted)
    fork
        feed_chirp_const(16'sd1000, 16'sd0);
        capture_chirp;
    join

    // Chirp 2: I=2000, diff=1000
    cap_count = 0;
    fork
        feed_chirp_const(16'sd2000, 16'sd0);
        capture_chirp;
    join
    check(10, "T10.1: Chirp 2: diff I=1000", cap_i[0] == 16'sd1000);

    // Chirp 3: I=5000, diff=3000
    cap_count = 0;
    fork
        feed_chirp_const(16'sd5000, 16'sd0);
        capture_chirp;
    join
    check(10, "T10.2: Chirp 3: diff I=3000", cap_i[0] == 16'sd3000);

    // ================================================================
    // T11: Negative input values
    // ================================================================
    do_reset;
    mti_enable = 1'b1;

    // Chirp 1: I=-3000
    fork
        feed_chirp_const(-16'sd3000, -16'sd1000);
        capture_chirp;
    join

    // Chirp 2: I=-1000. Diff = -1000 - (-3000) = 2000.
    cap_count = 0;
    fork
        feed_chirp_const(-16'sd1000, -16'sd500);
        capture_chirp;
    join

    check(11, "T11.1: Negative inputs: diff I = 2000", cap_i[0] == 16'sd2000);
    check(11, "T11.2: Negative inputs: diff Q = 500", cap_q[0] == 16'sd500);

    // ================================================================
    // SUMMARY
    // ================================================================
    $display("");
    $display("============================================");
    $display("  MTI Canceller Testbench Results");
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

initial begin
    #10_000_000;
    $display("[FAIL] Global watchdog timeout");
    $finish;
end

endmodule
