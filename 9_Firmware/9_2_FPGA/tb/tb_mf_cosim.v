`timescale 1ns / 1ps
/**
 * tb_mf_cosim.v
 *
 * Co-simulation testbench for matched_filter_processing_chain.v
 * (SIMULATION behavioral branch).
 *
 * Loads signal and reference hex files, feeds 1024 samples,
 * captures range profile output to CSV for comparison with
 * the Python model golden reference.
 *
 * Compile:
 *   iverilog -g2001 -DSIMULATION -o tb/tb_mf_cosim.vvp \
 *     tb/tb_mf_cosim.v matched_filter_processing_chain.v
 *
 * Scenarios (select one via -D):
 *   -DSCENARIO_CHIRP   : bb_mf_test + ref_chirp (default if none)
 *   -DSCENARIO_DC      : DC autocorrelation
 *   -DSCENARIO_IMPULSE : Impulse autocorrelation
 *   -DSCENARIO_TONE5   : Tone at bin 5 autocorrelation
 */

module tb_mf_cosim;

// ============================================================================
// Parameters
// ============================================================================
localparam FFT_SIZE   = 1024;
localparam CLK_PERIOD = 10.0;    // 100 MHz
localparam TIMEOUT    = 200000;  // Max clocks to wait for completion

// ============================================================================
// Scenario selection
// ============================================================================

`ifdef SCENARIO_DC
  localparam [511:0] SCENARIO_NAME    = "dc";
  localparam [511:0] SIG_I_HEX        = "tb/cosim/mf_sig_dc_i.hex";
  localparam [511:0] SIG_Q_HEX        = "tb/cosim/mf_sig_dc_q.hex";
  localparam [511:0] REF_I_HEX        = "tb/cosim/mf_ref_dc_i.hex";
  localparam [511:0] REF_Q_HEX        = "tb/cosim/mf_ref_dc_q.hex";
  localparam [511:0] OUTPUT_CSV       = "tb/cosim/rtl_mf_dc.csv";
`elsif SCENARIO_IMPULSE
  localparam [511:0] SCENARIO_NAME    = "impulse";
  localparam [511:0] SIG_I_HEX        = "tb/cosim/mf_sig_impulse_i.hex";
  localparam [511:0] SIG_Q_HEX        = "tb/cosim/mf_sig_impulse_q.hex";
  localparam [511:0] REF_I_HEX        = "tb/cosim/mf_ref_impulse_i.hex";
  localparam [511:0] REF_Q_HEX        = "tb/cosim/mf_ref_impulse_q.hex";
  localparam [511:0] OUTPUT_CSV       = "tb/cosim/rtl_mf_impulse.csv";
`elsif SCENARIO_TONE5
  localparam [511:0] SCENARIO_NAME    = "tone5";
  localparam [511:0] SIG_I_HEX        = "tb/cosim/mf_sig_tone5_i.hex";
  localparam [511:0] SIG_Q_HEX        = "tb/cosim/mf_sig_tone5_q.hex";
  localparam [511:0] REF_I_HEX        = "tb/cosim/mf_ref_tone5_i.hex";
  localparam [511:0] REF_Q_HEX        = "tb/cosim/mf_ref_tone5_q.hex";
  localparam [511:0] OUTPUT_CSV       = "tb/cosim/rtl_mf_tone5.csv";
`else
  // Default: SCENARIO_CHIRP
  localparam [511:0] SCENARIO_NAME    = "chirp";
  localparam [511:0] SIG_I_HEX        = "tb/cosim/bb_mf_test_i.hex";
  localparam [511:0] SIG_Q_HEX        = "tb/cosim/bb_mf_test_q.hex";
  localparam [511:0] REF_I_HEX        = "tb/cosim/ref_chirp_i.hex";
  localparam [511:0] REF_Q_HEX        = "tb/cosim/ref_chirp_q.hex";
  localparam [511:0] OUTPUT_CSV       = "tb/cosim/rtl_mf_chirp.csv";
`endif

// ============================================================================
// Clock and reset
// ============================================================================
reg clk;
reg reset_n;

initial clk = 0;
always #(CLK_PERIOD / 2) clk = ~clk;

// ============================================================================
// Test data memory
// ============================================================================
reg signed [15:0] sig_mem_i [0:FFT_SIZE-1];
reg signed [15:0] sig_mem_q [0:FFT_SIZE-1];
reg signed [15:0] ref_mem_i [0:FFT_SIZE-1];
reg signed [15:0] ref_mem_q [0:FFT_SIZE-1];

// ============================================================================
// DUT signals
// ============================================================================
reg [15:0] adc_data_i;
reg [15:0] adc_data_q;
reg        adc_valid;
reg [5:0]  chirp_counter;
reg [15:0] long_chirp_real;
reg [15:0] long_chirp_imag;
reg [15:0] short_chirp_real;
reg [15:0] short_chirp_imag;

wire signed [15:0] range_profile_i;
wire signed [15:0] range_profile_q;
wire               range_profile_valid;
wire [3:0]         chain_state;

// ============================================================================
// DUT instantiation
// ============================================================================
matched_filter_processing_chain dut (
    .clk(clk),
    .reset_n(reset_n),
    .adc_data_i(adc_data_i),
    .adc_data_q(adc_data_q),
    .adc_valid(adc_valid),
    .chirp_counter(chirp_counter),
    .long_chirp_real(long_chirp_real),
    .long_chirp_imag(long_chirp_imag),
    .short_chirp_real(short_chirp_real),
    .short_chirp_imag(short_chirp_imag),
    .range_profile_i(range_profile_i),
    .range_profile_q(range_profile_q),
    .range_profile_valid(range_profile_valid),
    .chain_state(chain_state)
);

// ============================================================================
// Output capture
// ============================================================================
reg signed [15:0] cap_out_i [0:FFT_SIZE-1];
reg signed [15:0] cap_out_q [0:FFT_SIZE-1];
integer           cap_count;
integer           cap_file;

// ============================================================================
// Test procedure
// ============================================================================
integer i;
integer wait_count;
integer pass_count;
integer fail_count;
integer test_count;

task check;
    input cond;
    input [511:0] label;
    begin
        test_count = test_count + 1;
        if (cond) begin
            $display("[PASS] %0s", label);
            pass_count = pass_count + 1;
        end else begin
            $display("[FAIL] %0s", label);
            fail_count = fail_count + 1;
        end
    end
endtask

task apply_reset;
    begin
        reset_n <= 1'b0;
        adc_data_i <= 16'd0;
        adc_data_q <= 16'd0;
        adc_valid <= 1'b0;
        chirp_counter <= 6'd0;
        long_chirp_real <= 16'd0;
        long_chirp_imag <= 16'd0;
        short_chirp_real <= 16'd0;
        short_chirp_imag <= 16'd0;
        repeat(4) @(posedge clk);
        reset_n <= 1'b1;
        @(posedge clk);
    end
endtask

// ============================================================================
// Main test
// ============================================================================
initial begin
    // VCD dump
    $dumpfile("tb_mf_cosim.vcd");
    $dumpvars(0, tb_mf_cosim);

    pass_count = 0;
    fail_count = 0;
    test_count = 0;
    cap_count  = 0;

    // Load test data
    $readmemh(SIG_I_HEX, sig_mem_i);
    $readmemh(SIG_Q_HEX, sig_mem_q);
    $readmemh(REF_I_HEX, ref_mem_i);
    $readmemh(REF_Q_HEX, ref_mem_q);

    $display("============================================================");
    $display("Matched Filter Co-Sim Testbench");
    $display("Scenario: %0s", SCENARIO_NAME);
    $display("============================================================");

    // ---- Reset ----
    apply_reset;
    check(chain_state == 4'd0, "State is IDLE after reset");

    // ---- Feed 1024 samples ----
    $display("\nFeeding %0d samples...", FFT_SIZE);
    for (i = 0; i < FFT_SIZE; i = i + 1) begin
        @(posedge clk);
        adc_data_i      <= sig_mem_i[i];
        adc_data_q      <= sig_mem_q[i];
        long_chirp_real  <= ref_mem_i[i];
        long_chirp_imag  <= ref_mem_q[i];
        short_chirp_real <= 16'd0;
        short_chirp_imag <= 16'd0;
        adc_valid       <= 1'b1;
    end
    @(posedge clk);
    adc_valid <= 1'b0;
    adc_data_i <= 16'd0;
    adc_data_q <= 16'd0;
    long_chirp_real <= 16'd0;
    long_chirp_imag <= 16'd0;

    $display("All samples fed. Waiting for processing...");

    // ---- Wait for first valid output ----
    // Also capture while waiting — valid may start before we see it
    wait_count = 0;
    cap_count  = 0;
    while (cap_count < FFT_SIZE && wait_count < TIMEOUT) begin
        @(posedge clk);
        #1;
        if (range_profile_valid) begin
            cap_out_i[cap_count] = range_profile_i;
            cap_out_q[cap_count] = range_profile_q;
            cap_count = cap_count + 1;
        end
        wait_count = wait_count + 1;
    end

    $display("Captured %0d output samples (waited %0d clocks)", cap_count, wait_count);

    // Check that we went through output state
    check(cap_count == FFT_SIZE, "Got 1024 output samples");

    // ---- Wait for DONE -> IDLE ----
    i = 0;
    while (chain_state != 4'd0 && i < 100) begin
        @(posedge clk);
        i = i + 1;
    end
    check(chain_state == 4'd0, "Returned to IDLE state");

    // ---- Find peak ----
    begin : find_peak
        integer peak_bin;
        reg signed [15:0] peak_i_val, peak_q_val;
        integer peak_mag, cur_mag;
        integer abs_i, abs_q;

        peak_mag = -1;
        peak_bin = 0;
        peak_i_val = 0;
        peak_q_val = 0;

        for (i = 0; i < cap_count; i = i + 1) begin
            abs_i = (cap_out_i[i] < 0) ? -cap_out_i[i] : cap_out_i[i];
            abs_q = (cap_out_q[i] < 0) ? -cap_out_q[i] : cap_out_q[i];
            cur_mag = abs_i + abs_q;
            if (cur_mag > peak_mag) begin
                peak_mag = cur_mag;
                peak_bin = i;
                peak_i_val = cap_out_i[i];
                peak_q_val = cap_out_q[i];
            end
        end

        $display("\nPeak: bin=%0d, mag=%0d, I=%0d, Q=%0d",
                 peak_bin, peak_mag, peak_i_val, peak_q_val);
    end

    // ---- Write CSV ----
    cap_file = $fopen(OUTPUT_CSV, "w");
    if (cap_file == 0) begin
        $display("ERROR: Cannot open output CSV: %0s", OUTPUT_CSV);
    end else begin
        $fwrite(cap_file, "bin,range_profile_i,range_profile_q\n");
        for (i = 0; i < cap_count; i = i + 1) begin
            $fwrite(cap_file, "%0d,%0d,%0d\n", i, cap_out_i[i], cap_out_q[i]);
        end
        $fclose(cap_file);
        $display("Output written to: %0s", OUTPUT_CSV);
    end

    // ---- Summary ----
    $display("\n============================================================");
    $display("Results: %0d/%0d PASS", pass_count, test_count);
    if (fail_count == 0)
        $display("ALL TESTS PASSED");
    else
        $display("SOME TESTS FAILED");
    $display("============================================================");

    $finish;
end

endmodule
