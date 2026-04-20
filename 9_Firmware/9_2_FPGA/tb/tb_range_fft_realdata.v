`timescale 1ns / 1ps

/**
 * tb_range_fft_realdata.v
 *
 * Co-simulation testbench: feeds real ADI CN0566 radar IQ data through
 * the 1024-point fft_engine and compares output bit-for-bit against
 * the Python golden reference (golden_reference.py).
 *
 * Stimulus:  cosim/real_data/hex/chirp0_i.hex, chirp0_q.hex
 * Expected:  cosim/real_data/hex/range_fft_chirp0_i.hex, range_fft_chirp0_q.hex
 *
 * The golden reference uses identical fixed-point arithmetic (32-bit internal,
 * 16-bit twiddle, same quarter-wave ROM, same bit-reversal and butterfly
 * schedule), so outputs should match exactly (0 error tolerance).
 *
 * Pass criteria: ALL 1024 output bins match golden reference exactly.
 */

module tb_range_fft_realdata;

// ============================================================================
// PARAMETERS
// ============================================================================
localparam N         = 1024;
localparam LOG2N     = 10;
localparam DATA_W    = 16;
localparam INT_W     = 32;
localparam TW_W      = 16;
localparam CLK_PERIOD = 10;  // 100 MHz for simulation

// Error tolerance: 0 means exact match required.
// If the Python golden reference is truly bit-accurate, this should be 0.
// Set to 1 if there are minor rounding differences to debug later.
localparam integer MAX_ERROR = 0;

// ============================================================================
// SIGNALS
// ============================================================================
reg clk, reset_n;
reg start, inverse;
reg signed [DATA_W-1:0] din_re, din_im;
reg din_valid;
wire signed [DATA_W-1:0] dout_re, dout_im;
wire dout_valid, busy, done_sig;

// ============================================================================
// STIMULUS AND REFERENCE MEMORIES
// ============================================================================
reg signed [DATA_W-1:0] stim_re  [0:N-1];
reg signed [DATA_W-1:0] stim_im  [0:N-1];
reg signed [DATA_W-1:0] ref_re   [0:N-1];
reg signed [DATA_W-1:0] ref_im   [0:N-1];
reg signed [DATA_W-1:0] cap_re   [0:N-1];
reg signed [DATA_W-1:0] cap_im   [0:N-1];

// ============================================================================
// DUT — 1024-point FFT engine
// ============================================================================
fft_engine #(
    .N(N),
    .LOG2N(LOG2N),
    .DATA_W(DATA_W),
    .INTERNAL_W(INT_W),
    .TWIDDLE_W(TW_W),
    .TWIDDLE_FILE("fft_twiddle_1024.mem")
) dut (
    .clk(clk),
    .reset_n(reset_n),
    .start(start),
    .inverse(inverse),
    .din_re(din_re),
    .din_im(din_im),
    .din_valid(din_valid),
    .dout_re(dout_re),
    .dout_im(dout_im),
    .dout_valid(dout_valid),
    .busy(busy),
    .done(done_sig)
);

// ============================================================================
// CLOCK
// ============================================================================
initial clk = 0;
always #(CLK_PERIOD/2) clk = ~clk;

// ============================================================================
// PASS / FAIL TRACKING
// ============================================================================
integer pass_count, fail_count;

task check;
    input cond;
    input [512*8-1:0] label;
    begin
        if (cond) begin
            pass_count = pass_count + 1;
        end else begin
            $display("  [FAIL] %0s", label);
            fail_count = fail_count + 1;
        end
    end
endtask

// ============================================================================
// VCD (optional — uncomment for waveform debug)
// ============================================================================
// initial begin
//     $dumpfile("tb_range_fft_realdata.vcd");
//     $dumpvars(0, tb_range_fft_realdata);
// end

// ============================================================================
// MAIN TEST
// ============================================================================
integer i, out_idx;
integer err_re, err_im, max_err_re, max_err_im;
integer n_exact, n_within_tol;
reg signed [31:0] diff_re, diff_im;
integer abs_diff_re, abs_diff_im;

initial begin
    pass_count = 0;
    fail_count = 0;

    $display("============================================================");
    $display("  Range FFT Real-Data Co-Simulation (1024-pt)");
    $display("  ADI CN0566 Phaser 10.525 GHz X-band FMCW");
    $display("============================================================");

    // ------------------------------------------------------------------
    // Load hex files
    // ------------------------------------------------------------------
    $readmemh("tb/cosim/real_data/hex/chirp0_i.hex", stim_re);
    $readmemh("tb/cosim/real_data/hex/chirp0_q.hex", stim_im);
    $readmemh("tb/cosim/real_data/hex/range_fft_chirp0_i.hex", ref_re);
    $readmemh("tb/cosim/real_data/hex/range_fft_chirp0_q.hex", ref_im);

    $display("  Loaded stimulus: chirp0_i/q.hex (1024 samples)");
    $display("  Loaded reference: range_fft_chirp0_i/q.hex (1024 bins)");
    $display("  First stim sample: re=%0d, im=%0d", stim_re[0], stim_im[0]);
    $display("  Last  stim sample: re=%0d, im=%0d", stim_re[N-1], stim_im[N-1]);
    $display("");

    // ------------------------------------------------------------------
    // Reset
    // ------------------------------------------------------------------
    reset_n  = 0;
    start    = 0;
    inverse  = 0;
    din_re   = 0;
    din_im   = 0;
    din_valid = 0;
    repeat (5) @(posedge clk); #1;
    reset_n = 1;
    repeat (2) @(posedge clk); #1;

    // ------------------------------------------------------------------
    // Start forward FFT
    // ------------------------------------------------------------------
    $display("--- Running 1024-point forward FFT ---");
    inverse = 0;
    @(posedge clk); #1;
    start = 1;
    @(posedge clk); #1;
    start = 0;

    // Feed N samples
    for (i = 0; i < N; i = i + 1) begin
        din_re    = stim_re[i];
        din_im    = stim_im[i];
        din_valid = 1;
        @(posedge clk); #1;
    end
    din_valid = 0;
    din_re    = 0;
    din_im    = 0;

    // Capture N output samples
    out_idx = 0;
    while (out_idx < N) begin
        @(posedge clk); #1;
        if (dout_valid) begin
            cap_re[out_idx] = dout_re;
            cap_im[out_idx] = dout_im;
            out_idx = out_idx + 1;
        end
    end

    $display("  FFT output captured: %0d bins", out_idx);

    // ------------------------------------------------------------------
    // Compare output vs golden reference
    // ------------------------------------------------------------------
    $display("");
    $display("--- Comparing RTL output vs Python golden reference ---");

    max_err_re = 0;
    max_err_im = 0;
    n_exact    = 0;
    n_within_tol = 0;

    for (i = 0; i < N; i = i + 1) begin
        diff_re = cap_re[i] - ref_re[i];
        diff_im = cap_im[i] - ref_im[i];

        // Absolute value
        abs_diff_re = (diff_re < 0) ? -diff_re : diff_re;
        abs_diff_im = (diff_im < 0) ? -diff_im : diff_im;

        if (abs_diff_re > max_err_re) max_err_re = abs_diff_re;
        if (abs_diff_im > max_err_im) max_err_im = abs_diff_im;

        if (diff_re == 0 && diff_im == 0)
            n_exact = n_exact + 1;

        if (abs_diff_re <= MAX_ERROR && abs_diff_im <= MAX_ERROR)
            n_within_tol = n_within_tol + 1;

        // Print first 10 mismatches and some spot checks
        if ((abs_diff_re > MAX_ERROR || abs_diff_im > MAX_ERROR) &&
            (fail_count < 10)) begin
            $display("    Bin %4d: RTL=(%6d,%6d) REF=(%6d,%6d) ERR=(%4d,%4d)",
                     i, cap_re[i], cap_im[i], ref_re[i], ref_im[i],
                     diff_re, diff_im);
        end

        check(abs_diff_re <= MAX_ERROR && abs_diff_im <= MAX_ERROR,
              "range FFT bin match");
    end

    // ------------------------------------------------------------------
    // Summary
    // ------------------------------------------------------------------
    $display("");
    $display("============================================================");
    $display("  SUMMARY: Range FFT Real-Data Co-Simulation");
    $display("============================================================");
    $display("  Total bins:       %0d", N);
    $display("  Exact match:      %0d / %0d", n_exact, N);
    $display("  Within tolerance:  %0d / %0d (tol=%0d)", n_within_tol, N, MAX_ERROR);
    $display("  Max error (re):   %0d", max_err_re);
    $display("  Max error (im):   %0d", max_err_im);
    $display("  Pass: %0d  Fail: %0d", pass_count, fail_count);
    $display("============================================================");

    if (fail_count == 0)
        $display("RESULT: ALL TESTS PASSED");
    else
        $display("RESULT: %0d TESTS FAILED", fail_count);

    $finish;
end

// Timeout watchdog (1024-point FFT should finish well within 1M cycles)
initial begin
    #(CLK_PERIOD * 2000000);
    $display("[TIMEOUT] Simulation exceeded 2M cycles — aborting");
    $finish;
end

endmodule
