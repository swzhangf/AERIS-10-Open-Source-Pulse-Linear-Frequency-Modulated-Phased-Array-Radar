`timescale 1ns / 1ps

/**
 * tb_doppler_realdata.v
 *
 * Co-simulation testbench: feeds real ADI CN0566 radar data (post-range-FFT)
 * through the Doppler processor RTL and compares output bit-for-bit against
 * the Python golden reference (golden_reference.py).
 *
 * Stimulus:  cosim/real_data/hex/doppler_input_realdata.hex
 *            (2048 x 32-bit packed {Q[31:16], I[15:0]}, chirp-major order)
 * Expected:  cosim/real_data/hex/doppler_ref_i.hex, doppler_ref_q.hex
 *            (2048 x 16-bit signed, range-major order: rbin0 x 32 doppler, ...)
 *
 * Pass criteria: ALL 2048 output bins match golden reference exactly.
 *
 * Compile:
 *   iverilog -Wall -DSIMULATION -g2012 \
 *     -o tb/tb_doppler_realdata.vvp \
 *     tb/tb_doppler_realdata.v doppler_processor.v xfft_16.v fft_engine.v
 *
 * Run from: 9_Firmware/9_2_FPGA/
 *   vvp tb/tb_doppler_realdata.vvp
 */

module tb_doppler_realdata;

// ============================================================================
// PARAMETERS
// ============================================================================
localparam CLK_PERIOD    = 10.0;           // 100 MHz
localparam DOPPLER_FFT   = 32;             // Total packed Doppler bins (2 sub-frames x 16-pt FFT)
localparam RANGE_BINS    = 64;
localparam CHIRPS        = 32;
localparam TOTAL_INPUTS  = CHIRPS * RANGE_BINS;  // 2048
localparam TOTAL_OUTPUTS = RANGE_BINS * DOPPLER_FFT;  // 2048
localparam MAX_CYCLES    = 500_000;        // Timeout: 5 ms at 100 MHz

// Error tolerance: 0 means exact match required.
localparam integer MAX_ERROR = 0;

// ============================================================================
// CLOCK AND RESET
// ============================================================================
reg clk;
reg reset_n;

initial clk = 0;
always #(CLK_PERIOD / 2) clk = ~clk;

// ============================================================================
// DUT SIGNALS
// ============================================================================
reg  [31:0] range_data;
reg         data_valid;
reg         new_chirp_frame;
wire [31:0] doppler_output;
wire        doppler_valid;
wire [4:0]  doppler_bin;
wire [5:0]  range_bin;
wire        processing_active;
wire        frame_complete;
wire [3:0]  dut_status;

// ============================================================================
// DUT INSTANTIATION
// ============================================================================
doppler_processor_optimized dut (
    .clk(clk),
    .reset_n(reset_n),
    .range_data(range_data),
    .data_valid(data_valid),
    .new_chirp_frame(new_chirp_frame),
    .doppler_output(doppler_output),
    .doppler_valid(doppler_valid),
    .doppler_bin(doppler_bin),
    .range_bin(range_bin),
    .sub_frame(),                   // Not used in this testbench
    .processing_active(processing_active),
    .frame_complete(frame_complete),
    .status(dut_status)
);

// Internal DUT state (for debug)
wire [2:0] dut_state_w = dut.state;

// ============================================================================
// INPUT DATA MEMORY (loaded from hex file)
// ============================================================================
reg [31:0] input_mem [0:TOTAL_INPUTS-1];

initial begin
    $readmemh("tb/cosim/real_data/hex/doppler_input_realdata.hex", input_mem);
end

// ============================================================================
// REFERENCE DATA (loaded from hex files)
// ============================================================================
reg signed [15:0] ref_i [0:TOTAL_OUTPUTS-1];
reg signed [15:0] ref_q [0:TOTAL_OUTPUTS-1];

initial begin
    $readmemh("tb/cosim/real_data/hex/doppler_ref_i.hex", ref_i);
    $readmemh("tb/cosim/real_data/hex/doppler_ref_q.hex", ref_q);
end

// ============================================================================
// OUTPUT CAPTURE
// ============================================================================
reg signed [15:0] cap_out_i [0:TOTAL_OUTPUTS-1];
reg signed [15:0] cap_out_q [0:TOTAL_OUTPUTS-1];
reg [5:0]  cap_rbin  [0:TOTAL_OUTPUTS-1];
reg [4:0]  cap_dbin  [0:TOTAL_OUTPUTS-1];
integer out_count;

// ============================================================================
// PASS / FAIL TRACKING
// ============================================================================
integer pass_count, fail_count, test_count;

task check;
    input cond;
    input [511:0] label;
    begin
        test_count = test_count + 1;
        if (cond) begin
            pass_count = pass_count + 1;
        end else begin
            $display("  [FAIL] %0s", label);
            fail_count = fail_count + 1;
        end
    end
endtask

// ============================================================================
// MAIN TEST SEQUENCE
// ============================================================================
integer i, cycle_count;
integer n_exact, n_within_tol;
integer max_err_i, max_err_q;
integer abs_diff_i, abs_diff_q;
reg signed [31:0] diff_i, diff_q;
integer mismatches_printed;

initial begin
    // ---- Init ----
    pass_count = 0;
    fail_count = 0;
    test_count = 0;
    out_count  = 0;
    range_data = 0;
    data_valid = 0;
    new_chirp_frame = 0;
    reset_n = 0;

    // ---- Reset ----
    #(CLK_PERIOD * 10);
    reset_n = 1;
    #(CLK_PERIOD * 5);

    $display("============================================================");
    $display("  Doppler Processor Real-Data Co-Simulation");
    $display("  ADI CN0566 Phaser 10.525 GHz X-band FMCW");
    $display("  Input: 32 chirps x 64 range bins (post-range-FFT)");
    $display("  Expected: 64 range bins x 32 Doppler bins");
    $display("============================================================");

    // ---- Debug: check hex file loaded ----
    $display("  input_mem[0]    = %08h", input_mem[0]);
    $display("  input_mem[1]    = %08h", input_mem[1]);
    $display("  input_mem[2047] = %08h", input_mem[2047]);
    $display("  ref_i[0] = %04h, ref_q[0] = %04h", ref_i[0], ref_q[0]);

    // ---- Check 1: DUT starts in IDLE ----
    check(dut_state_w == 3'b000,
          "DUT starts in S_IDLE after reset");

    // ---- Pulse new_chirp_frame to start a new frame ----
    @(posedge clk);
    new_chirp_frame <= 1;
    @(posedge clk);
    @(posedge clk);
    new_chirp_frame <= 0;
    @(posedge clk);

    // ---- Feed input data (2048 samples, chirp-major) ----
    $display("\n--- Feeding %0d input samples ---", TOTAL_INPUTS);

    for (i = 0; i < TOTAL_INPUTS; i = i + 1) begin
        @(posedge clk);
        range_data <= input_mem[i];
        data_valid <= 1;
        if (i < 3 || i == TOTAL_INPUTS - 1) begin
            $display("  [feed] i=%0d data=%08h state=%0d",
                     i, input_mem[i], dut_state_w);
        end
    end
    @(posedge clk);
    data_valid <= 0;
    range_data <= 0;

    $display("  After feeding: state=%0d", dut_state_w);

    // ---- Check 2: DUT should be processing ----
    #(CLK_PERIOD * 5);
    check(dut_state_w != 3'b000 && dut_state_w != 3'b001,
          "DUT entered processing state after 2048 input samples");

    // ---- Collect outputs ----
    $display("\n--- Waiting for %0d output samples ---", TOTAL_OUTPUTS);

    cycle_count = 0;
    while (out_count < TOTAL_OUTPUTS && cycle_count < MAX_CYCLES) begin
        @(posedge clk);
        cycle_count = cycle_count + 1;

        if (doppler_valid) begin
            cap_out_i[out_count] = doppler_output[15:0];
            cap_out_q[out_count] = doppler_output[31:16];
            cap_rbin[out_count]  = range_bin;
            cap_dbin[out_count]  = doppler_bin;
            out_count = out_count + 1;
        end
    end

    $display("  Collected %0d output samples in %0d cycles", out_count,
             cycle_count);

    // ---- Check 3: Correct output count ----
    check(out_count == TOTAL_OUTPUTS,
          "Output sample count == 2048");

    // ---- Check 4: Did not timeout ----
    check(cycle_count < MAX_CYCLES,
          "Processing completed within timeout");

    // ---- Check 5: DUT returns to IDLE ----
    #(CLK_PERIOD * 20);
    check(dut_state_w == 3'b000,
          "DUT returned to S_IDLE after processing");

    // ---- Check 6: Output ordering ----
    if (out_count > 0) begin
        check(cap_rbin[0] == 0 && cap_dbin[0] == 0,
              "First output: range_bin=0, doppler_bin=0");
    end
    if (out_count == TOTAL_OUTPUTS) begin
        check(cap_rbin[TOTAL_OUTPUTS-1] == RANGE_BINS - 1,
              "Last output: range_bin=63");
        check(cap_dbin[TOTAL_OUTPUTS-1] == DOPPLER_FFT - 1,
              "Last output: doppler_bin=31");
    end

    // ==================================================================
    // BIT-FOR-BIT COMPARISON against golden reference
    // ==================================================================
    $display("");
    $display("--- Comparing RTL output vs Python golden reference ---");

    max_err_i = 0;
    max_err_q = 0;
    n_exact   = 0;
    n_within_tol = 0;
    mismatches_printed = 0;

    for (i = 0; i < out_count; i = i + 1) begin
        diff_i = cap_out_i[i] - ref_i[i];
        diff_q = cap_out_q[i] - ref_q[i];

        // Absolute value
        abs_diff_i = (diff_i < 0) ? -diff_i : diff_i;
        abs_diff_q = (diff_q < 0) ? -diff_q : diff_q;

        if (abs_diff_i > max_err_i) max_err_i = abs_diff_i;
        if (abs_diff_q > max_err_q) max_err_q = abs_diff_q;

        if (diff_i == 0 && diff_q == 0)
            n_exact = n_exact + 1;

        if (abs_diff_i <= MAX_ERROR && abs_diff_q <= MAX_ERROR)
            n_within_tol = n_within_tol + 1;

        // Print first 20 mismatches for debug
        if ((abs_diff_i > MAX_ERROR || abs_diff_q > MAX_ERROR) &&
            mismatches_printed < 20) begin
            $display("    [%4d] rbin=%2d dbin=%2d RTL=(%6d,%6d) REF=(%6d,%6d) ERR=(%4d,%4d)",
                     i, cap_rbin[i], cap_dbin[i],
                     $signed(cap_out_i[i]), $signed(cap_out_q[i]),
                     $signed(ref_i[i]), $signed(ref_q[i]),
                     diff_i, diff_q);
            mismatches_printed = mismatches_printed + 1;
        end
    end

    // Per-sample pass/fail
    for (i = 0; i < out_count; i = i + 1) begin
        diff_i = cap_out_i[i] - ref_i[i];
        diff_q = cap_out_q[i] - ref_q[i];
        abs_diff_i = (diff_i < 0) ? -diff_i : diff_i;
        abs_diff_q = (diff_q < 0) ? -diff_q : diff_q;
        check(abs_diff_i <= MAX_ERROR && abs_diff_q <= MAX_ERROR,
              "Doppler output bin match");
    end

    // ==================================================================
    // SUMMARY
    // ==================================================================
    $display("");
    $display("============================================================");
    $display("  SUMMARY: Doppler Processor Real-Data Co-Simulation");
    $display("============================================================");
    $display("  Total output bins:  %0d", out_count);
    $display("  Exact match:        %0d / %0d", n_exact, out_count);
    $display("  Within tolerance:   %0d / %0d (tol=%0d)", n_within_tol, out_count, MAX_ERROR);
    $display("  Max error (I):      %0d", max_err_i);
    $display("  Max error (Q):      %0d", max_err_q);
    $display("  Structural checks:  %0d", 7);  // checks 1-7 above
    $display("  Data match checks:  %0d", out_count);
    $display("  Pass: %0d  Fail: %0d", pass_count, fail_count);
    $display("============================================================");

    if (fail_count == 0)
        $display("RESULT: ALL TESTS PASSED (%0d/%0d)", pass_count, test_count);
    else
        $display("RESULT: %0d TESTS FAILED", fail_count);

    $display("============================================================");

    #(CLK_PERIOD * 10);
    $finish;
end

// ============================================================================
// WATCHDOG
// ============================================================================
initial begin
    #(CLK_PERIOD * MAX_CYCLES * 2);
    $display("[TIMEOUT] Simulation exceeded %0d cycles — aborting", MAX_CYCLES * 2);
    $display("SOME TESTS FAILED");
    $finish;
end

endmodule
