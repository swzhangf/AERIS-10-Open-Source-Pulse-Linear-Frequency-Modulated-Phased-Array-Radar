`timescale 1ns / 1ps

/**
 * tb_fullchain_realdata.v
 *
 * Full-chain co-simulation testbench: feeds real ADI CN0566 radar data
 * (post-range-FFT, 32 chirps x 1024 bins) through:
 *
 *   range_bin_decimator (peak detection, 1024→64)
 *     → doppler_processor_optimized (Hamming + dual 16-pt FFT)
 *
 * and compares the Doppler output bit-for-bit against the Python golden
 * reference that models the same chain (golden_reference.py).
 *
 * Stimulus:
 *   tb/cosim/real_data/hex/fullchain_range_input.hex
 *     32768 x 32-bit packed {Q[31:16], I[15:0]} — 32 chirps x 1024 bins
 *
 * Expected:
 *   tb/cosim/real_data/hex/fullchain_doppler_ref_i.hex
 *   tb/cosim/real_data/hex/fullchain_doppler_ref_q.hex
 *     2048 x 16-bit signed — 64 range bins x 32 Doppler bins
 *
 * Pass criteria: ALL 2048 Doppler output bins match exactly.
 *
 * Compile:
 *   iverilog -Wall -DSIMULATION -g2012 \
 *     -o tb/tb_fullchain_realdata.vvp \
 *     tb/tb_fullchain_realdata.v \
 *     range_bin_decimator.v doppler_processor.v xfft_16.v fft_engine.v
 *
 * Run from: 9_Firmware/9_2_FPGA/
 *   vvp tb/tb_fullchain_realdata.vvp
 */

module tb_fullchain_realdata;

// ============================================================================
// PARAMETERS
// ============================================================================
localparam CLK_PERIOD    = 10.0;          // 100 MHz
localparam DOPPLER_FFT   = 32;
localparam RANGE_BINS    = 64;
localparam CHIRPS        = 32;
localparam INPUT_BINS    = 1024;
localparam DECIM_FACTOR  = 16;

localparam TOTAL_INPUT_SAMPLES  = CHIRPS * INPUT_BINS;     // 32768
localparam TOTAL_OUTPUT_SAMPLES = RANGE_BINS * DOPPLER_FFT; // 2048
localparam SAMPLES_PER_CHIRP    = INPUT_BINS;              // 1024
localparam DECIM_PER_CHIRP      = RANGE_BINS;              // 64

// Generous timeout: decimator + Doppler processing + margin
localparam MAX_CYCLES = 2_000_000;

// Error tolerance: 0 = exact match required
localparam integer MAX_ERROR = 0;

// ============================================================================
// CLOCK AND RESET
// ============================================================================
reg clk;
reg reset_n;

initial clk = 0;
always #(CLK_PERIOD / 2) clk = ~clk;

// ============================================================================
// DECIMATOR SIGNALS
// ============================================================================
reg  signed [15:0] decim_i_in;
reg  signed [15:0] decim_q_in;
reg                decim_valid_in;

wire signed [15:0] decim_i_out;
wire signed [15:0] decim_q_out;
wire               decim_valid_out;
wire [5:0]         decim_bin_index;

// ============================================================================
// DOPPLER SIGNALS
// ============================================================================
// Wire decimator output directly into Doppler input (matching RTL)
wire [31:0] range_data_32bit;
wire        range_data_valid;

assign range_data_32bit = {decim_q_out, decim_i_out};
assign range_data_valid = decim_valid_out;

reg         new_chirp_frame;

wire [31:0] doppler_output;
wire        doppler_valid;
wire [4:0]  doppler_bin;
wire [5:0]  range_bin;
wire        processing_active;
wire        frame_complete;
wire [3:0]  dut_status;

// ============================================================================
// DUT INSTANTIATION: Range Bin Decimator
// ============================================================================
range_bin_decimator #(
    .INPUT_BINS(INPUT_BINS),
    .OUTPUT_BINS(RANGE_BINS),
    .DECIMATION_FACTOR(DECIM_FACTOR)
) range_decim (
    .clk(clk),
    .reset_n(reset_n),
    .range_i_in(decim_i_in),
    .range_q_in(decim_q_in),
    .range_valid_in(decim_valid_in),
    .range_i_out(decim_i_out),
    .range_q_out(decim_q_out),
    .range_valid_out(decim_valid_out),
    .range_bin_index(decim_bin_index),
    .decimation_mode(2'b01),       // Peak detection mode
    .start_bin(10'd0),
    .watchdog_timeout()
);

// ============================================================================
// DUT INSTANTIATION: Doppler Processor
// ============================================================================
doppler_processor_optimized doppler_proc (
    .clk(clk),
    .reset_n(reset_n),
    .range_data(range_data_32bit),
    .data_valid(range_data_valid),
    .new_chirp_frame(new_chirp_frame),
    .doppler_output(doppler_output),
    .doppler_valid(doppler_valid),
    .doppler_bin(doppler_bin),
    .range_bin(range_bin),
    .processing_active(processing_active),
    .frame_complete(frame_complete),
    .status(dut_status)
);

// Internal DUT state (for debug)
wire [2:0] decim_state = range_decim.state;
wire [2:0] doppler_state = doppler_proc.state;

// ============================================================================
// INPUT DATA MEMORY (loaded from hex file)
// ============================================================================
// 32768 x 32-bit packed {Q[31:16], I[15:0]}
reg [31:0] input_mem [0:TOTAL_INPUT_SAMPLES-1];

initial begin
    $readmemh("tb/cosim/real_data/hex/fullchain_range_input.hex", input_mem);
end

// ============================================================================
// REFERENCE DATA (loaded from hex files)
// ============================================================================
reg signed [15:0] ref_i [0:TOTAL_OUTPUT_SAMPLES-1];
reg signed [15:0] ref_q [0:TOTAL_OUTPUT_SAMPLES-1];

initial begin
    $readmemh("tb/cosim/real_data/hex/fullchain_doppler_ref_i.hex", ref_i);
    $readmemh("tb/cosim/real_data/hex/fullchain_doppler_ref_q.hex", ref_q);
end

// ============================================================================
// DECIMATOR OUTPUT CAPTURE (for debug)
// ============================================================================
integer decim_out_count;
reg signed [15:0] decim_cap_i [0:CHIRPS*RANGE_BINS-1];
reg signed [15:0] decim_cap_q [0:CHIRPS*RANGE_BINS-1];

// ============================================================================
// DOPPLER OUTPUT CAPTURE
// ============================================================================
reg signed [15:0] cap_out_i [0:TOTAL_OUTPUT_SAMPLES-1];
reg signed [15:0] cap_out_q [0:TOTAL_OUTPUT_SAMPLES-1];
reg [5:0]  cap_rbin  [0:TOTAL_OUTPUT_SAMPLES-1];
reg [4:0]  cap_dbin  [0:TOTAL_OUTPUT_SAMPLES-1];
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
// COUNT DECIMATOR OUTPUTS (always block)
// ============================================================================
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        decim_out_count <= 0;
    end else if (decim_valid_out) begin
        if (decim_out_count < CHIRPS * RANGE_BINS) begin
            decim_cap_i[decim_out_count] <= decim_i_out;
            decim_cap_q[decim_out_count] <= decim_q_out;
        end
        decim_out_count <= decim_out_count + 1;
    end
end

// ============================================================================
// MAIN TEST SEQUENCE
// ============================================================================
integer i, chirp, sample_idx, cycle_count;
integer n_exact, n_within_tol;
integer max_err_i, max_err_q;
integer abs_diff_i, abs_diff_q;
reg signed [31:0] diff_i, diff_q;
integer mismatches_printed;
reg [31:0] packed_iq;

initial begin
    // ---- Init ----
    pass_count = 0;
    fail_count = 0;
    test_count = 0;
    out_count  = 0;
    decim_i_in = 0;
    decim_q_in = 0;
    decim_valid_in = 0;
    new_chirp_frame = 0;
    reset_n = 0;

    // ---- Reset ----
    #(CLK_PERIOD * 10);
    reset_n = 1;
    #(CLK_PERIOD * 5);

    $display("============================================================");
    $display("  Full-Chain Real-Data Co-Simulation");
    $display("  range_bin_decimator (peak, 1024->64)");
    $display("    -> doppler_processor_optimized (Hamming + dual 16-pt FFT)");
    $display("  ADI CN0566 Phaser 10.525 GHz X-band FMCW");
    $display("  Input:    %0d chirps x %0d range FFT bins = %0d samples",
             CHIRPS, INPUT_BINS, TOTAL_INPUT_SAMPLES);
    $display("  Expected: %0d range bins x %0d Doppler bins = %0d outputs",
             RANGE_BINS, DOPPLER_FFT, TOTAL_OUTPUT_SAMPLES);
    $display("============================================================");

    // ---- Debug: check hex files loaded ----
    $display("  input_mem[0]     = %08h", input_mem[0]);
    $display("  input_mem[1023]  = %08h", input_mem[1023]);
    $display("  input_mem[32767] = %08h", input_mem[32767]);
    $display("  ref_i[0] = %04h, ref_q[0] = %04h", ref_i[0], ref_q[0]);

    // ---- Check 1: Both DUTs start in IDLE ----
    check(decim_state == 3'd0,
          "Decimator starts in ST_IDLE after reset");
    check(doppler_state == 3'b000,
          "Doppler starts in S_IDLE after reset");

    // ---- Pulse new_chirp_frame to start Doppler accumulation ----
    @(posedge clk);
    new_chirp_frame <= 1;
    @(posedge clk);
    @(posedge clk);
    new_chirp_frame <= 0;
    @(posedge clk);

    // ---- Feed input data: 32 chirps x 1024 range bins ----
    // Each chirp is 1024 consecutive samples. Between chirps, the
    // decimator completes (ST_DONE → ST_IDLE) and restarts on the
    // next valid input.
    $display("\n--- Feeding %0d chirps x %0d bins = %0d samples ---",
             CHIRPS, INPUT_BINS, TOTAL_INPUT_SAMPLES);

    for (chirp = 0; chirp < CHIRPS; chirp = chirp + 1) begin
        // Feed 1024 range bins for this chirp
        for (i = 0; i < INPUT_BINS; i = i + 1) begin
            @(posedge clk);
            sample_idx = chirp * INPUT_BINS + i;
            packed_iq = input_mem[sample_idx];
            decim_i_in <= packed_iq[15:0];
            decim_q_in <= packed_iq[31:16];
            decim_valid_in <= 1;
        end

        // Deassert valid after each chirp to let decimator finish
        // (ST_PROCESS → ST_EMIT → ... → ST_DONE → ST_IDLE)
        @(posedge clk);
        decim_valid_in <= 0;
        decim_i_in <= 0;
        decim_q_in <= 0;

        // Wait for decimator to return to IDLE
        // The decimator needs a few cycles for the last EMIT + DONE
        cycle_count = 0;
        while (decim_state != 3'd0 && cycle_count < 200) begin
            @(posedge clk);
            cycle_count = cycle_count + 1;
        end

        if (chirp < 3 || chirp == CHIRPS - 1) begin
            $display("  Chirp %0d: IDLE after %0d extra cycles, decim_out=%0d",
                     chirp, cycle_count, decim_out_count);
        end
    end

    $display("  All input fed. Total decimator outputs: %0d (expected %0d)",
             decim_out_count, CHIRPS * RANGE_BINS);

    // ---- Check 3: Decimator produced correct number of outputs ----
    check(decim_out_count == CHIRPS * RANGE_BINS,
          "Decimator output count == 2048");

    // ---- Wait for Doppler processing to complete ----
    $display("\n--- Waiting for Doppler to process and emit %0d outputs ---",
             TOTAL_OUTPUT_SAMPLES);

    cycle_count = 0;
    while (out_count < TOTAL_OUTPUT_SAMPLES && cycle_count < MAX_CYCLES) begin
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

    $display("  Collected %0d Doppler outputs in %0d cycles", out_count,
             cycle_count);

    // ---- Check 4: Correct Doppler output count ----
    check(out_count == TOTAL_OUTPUT_SAMPLES,
          "Doppler output count == 2048");

    // ---- Check 5: Did not timeout ----
    check(cycle_count < MAX_CYCLES,
          "Processing completed within timeout");

    // ---- Check 6: Doppler returns to IDLE ----
    #(CLK_PERIOD * 20);
    check(doppler_state == 3'b000,
          "Doppler returned to S_IDLE after processing");

    // ---- Check 7: Output ordering ----
    if (out_count > 0) begin
        check(cap_rbin[0] == 0 && cap_dbin[0] == 0,
              "First output: range_bin=0, doppler_bin=0");
    end
    if (out_count == TOTAL_OUTPUT_SAMPLES) begin
        check(cap_rbin[TOTAL_OUTPUT_SAMPLES-1] == RANGE_BINS - 1,
              "Last output: range_bin=63");
        check(cap_dbin[TOTAL_OUTPUT_SAMPLES-1] == DOPPLER_FFT - 1,
              "Last output: doppler_bin=31");
    end

    // ==================================================================
    // BIT-FOR-BIT COMPARISON against golden reference
    // ==================================================================
    $display("");
    $display("--- Comparing Doppler RTL output vs Python golden reference ---");
    $display("    (full-chain: range FFT -> decimator -> Doppler)");

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

    // Per-sample pass/fail check
    for (i = 0; i < out_count; i = i + 1) begin
        diff_i = cap_out_i[i] - ref_i[i];
        diff_q = cap_out_q[i] - ref_q[i];
        abs_diff_i = (diff_i < 0) ? -diff_i : diff_i;
        abs_diff_q = (diff_q < 0) ? -diff_q : diff_q;
        check(abs_diff_i <= MAX_ERROR && abs_diff_q <= MAX_ERROR,
              "Full-chain Doppler output bin match");
    end

    // ==================================================================
    // SUMMARY
    // ==================================================================
    $display("");
    $display("============================================================");
    $display("  SUMMARY: Full-Chain Real-Data Co-Simulation");
    $display("============================================================");
    $display("  Chain: range_bin_decimator(peak) -> doppler_processor");
    $display("  Input samples:    %0d (%0d chirps x %0d bins)",
             TOTAL_INPUT_SAMPLES, CHIRPS, INPUT_BINS);
    $display("  Decimator outputs: %0d (expected %0d)",
             decim_out_count, CHIRPS * RANGE_BINS);
    $display("  Doppler outputs:   %0d (expected %0d)",
             out_count, TOTAL_OUTPUT_SAMPLES);
    $display("  Exact match:       %0d / %0d", n_exact, out_count);
    $display("  Within tolerance:  %0d / %0d (tol=%0d)",
             n_within_tol, out_count, MAX_ERROR);
    $display("  Max error (I):     %0d", max_err_i);
    $display("  Max error (Q):     %0d", max_err_q);
    $display("  Structural checks: %0d", 9);
    $display("  Data match checks: %0d", out_count);
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
