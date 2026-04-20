`timescale 1ns / 1ps
/**
 * tb_doppler_cosim.v
 *
 * Co-simulation testbench for doppler_processor_optimized (doppler_processor.v).
 *
 * Tests the complete Doppler processing pipeline:
 *   - Accumulates 32 chirps x 64 range bins into BRAM
 *   - Processes each range bin: Hamming window -> dual 16-pt FFT (staggered PRF)
 *   - Outputs 2048 samples (64 range bins x 32 packed Doppler bins)
 *
 * Validates:
 *   1. FSM state transitions (IDLE -> ACCUMULATE -> LOAD_FFT -> ... -> OUTPUT)
 *   2. Correct input sample count (2048)
 *   3. Correct output sample count (2048)
 *   4. Output ordering (range_bin, doppler_bin counters)
 *   5. Output values (compared with Python golden reference via CSV)
 *
 * Input data loaded from: tb/cosim/doppler_input_<scenario>.hex
 * RTL output written to:  tb/cosim/rtl_doppler_<scenario>.csv
 * RTL FFT inputs written:  tb/cosim/rtl_doppler_fft_in_<scenario>.csv
 *
 * Compile (SIMULATION branch — uses behavioral xfft_16/fft_engine):
 *   iverilog -g2001 -DSIMULATION \
 *     -o tb/tb_doppler_cosim.vvp \
 *     tb/tb_doppler_cosim.v doppler_processor.v xfft_16.v fft_engine.v
 *
 * Scenarios (use -D flags):
 *   default:              stationary target
 *   -DSCENARIO_MOVING:    moving target with Doppler shift
 *   -DSCENARIO_TWO:       two targets at different ranges/velocities
 */

module tb_doppler_cosim;

// ============================================================================
// Parameters
// ============================================================================
localparam CLK_PERIOD    = 10.0;           // 100 MHz
localparam DOPPLER_FFT   = 32;             // Total packed Doppler bins (2 sub-frames x 16-pt FFT)
localparam RANGE_BINS    = 64;
localparam CHIRPS        = 32;
localparam TOTAL_INPUTS  = CHIRPS * RANGE_BINS;  // 2048
localparam TOTAL_OUTPUTS = RANGE_BINS * DOPPLER_FFT;  // 2048
localparam MAX_CYCLES    = 500_000;        // Timeout: 5 ms at 100 MHz

// Scenario selection — input file name
`ifdef SCENARIO_MOVING
  localparam SCENARIO = "moving";
`else
`ifdef SCENARIO_TWO
  localparam SCENARIO = "two_targets";
`else
  localparam SCENARIO = "stationary";
`endif
`endif

// ============================================================================
// Clock and reset
// ============================================================================
reg clk;
reg reset_n;

initial clk = 0;
always #(CLK_PERIOD / 2) clk = ~clk;

// ============================================================================
// DUT signals
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
// DUT instantiation
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

// ============================================================================
// Input data memory (loaded from hex file)
// ============================================================================
reg [31:0] input_mem [0:TOTAL_INPUTS-1];

// Input hex file path (relative to simulation working directory)
initial begin
    $readmemh({"tb/cosim/doppler_input_", SCENARIO, ".hex"}, input_mem);
end

// ============================================================================
// Output capture
// ============================================================================
reg signed [15:0] cap_out_i [0:TOTAL_OUTPUTS-1];
reg signed [15:0] cap_out_q [0:TOTAL_OUTPUTS-1];
reg [5:0]  cap_rbin  [0:TOTAL_OUTPUTS-1];
reg [4:0]  cap_dbin  [0:TOTAL_OUTPUTS-1];
integer out_count;

// ============================================================================
// FFT input capture (for debugging pipeline alignment)
// ============================================================================
reg signed [15:0] cap_fft_in_i [0:TOTAL_OUTPUTS-1];
reg signed [15:0] cap_fft_in_q [0:TOTAL_OUTPUTS-1];
integer fft_in_count;

// Watch the FFT input signals from the DUT
wire fft_input_valid_w = dut.fft_input_valid;
wire signed [15:0] fft_input_i_w = dut.fft_input_i;
wire signed [15:0] fft_input_q_w = dut.fft_input_q;
wire [5:0] read_range_bin_w = dut.read_range_bin;
wire [4:0] read_doppler_idx_w = dut.read_doppler_index;
wire [2:0] dut_state_w = dut.state;
wire [5:0] fft_sc_w = dut.fft_sample_counter;
wire signed [15:0] mem_rdata_i_w = dut.mem_rdata_i;
wire signed [15:0] mem_rdata_q_w = dut.mem_rdata_q;
wire signed [31:0] mult_i_w = dut.mult_i;
wire signed [31:0] mult_q_w = dut.mult_q;

// ============================================================================
// Test infrastructure
// ============================================================================
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

// ============================================================================
// VCD dump
// ============================================================================
initial begin
    $dumpfile("tb/tb_doppler_cosim.vcd");
    $dumpvars(0, tb_doppler_cosim);
end

// ============================================================================
// Main test sequence
// ============================================================================
integer i, cycle_count;
integer csv_file, fft_csv_file;

initial begin
    // ---- Init ----
    pass_count = 0;
    fail_count = 0;
    test_count = 0;
    out_count  = 0;
    fft_in_count = 0;
    range_data = 0;
    data_valid = 0;
    new_chirp_frame = 0;
    reset_n = 0;

    // ---- Reset ----
    #(CLK_PERIOD * 10);
    reset_n = 1;
    #(CLK_PERIOD * 5);

    $display("============================================================");
    $display("Doppler Processor Co-Sim Testbench");
    $display("Scenario: %0s", SCENARIO);
    $display("Input samples: %0d  (32 chirps x 64 range bins)", TOTAL_INPUTS);
    $display("Expected outputs: %0d (64 range bins x 32 packed Doppler bins, dual 16-pt FFT)",
             TOTAL_OUTPUTS);
    $display("============================================================");

    // ---- Debug: check hex file loaded ----
    $display("  input_mem[0] = %08h", input_mem[0]);
    $display("  input_mem[1] = %08h", input_mem[1]);
    $display("  input_mem[2047] = %08h", input_mem[2047]);

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

    // ---- Feed input data ----
    // RTL Bug #3 is now fixed: S_IDLE -> S_ACCUMULATE writes the first
    // sample immediately, so we simply stream all 2048 samples.
    $display("\n--- Feeding %0d input samples ---", TOTAL_INPUTS);

    for (i = 0; i < TOTAL_INPUTS; i = i + 1) begin
        @(posedge clk);
        range_data <= input_mem[i];
        data_valid <= 1;
        if (i < 3 || i == TOTAL_INPUTS - 1) begin
            $display("  [feed] i=%0d data=%08h state=%0d wrbin=%0d wrchirp=%0d",
                     i, input_mem[i], dut_state_w,
                     dut.write_range_bin, dut.write_chirp_index);
        end
    end
    @(posedge clk);
    data_valid <= 0;
    range_data <= 0;

    $display("  After feeding: state=%0d wrbin=%0d wrchirp=%0d chirps_rx=%0d fbfull=%0d",
             dut_state_w, dut.write_range_bin, dut.write_chirp_index,
             dut.chirps_received, dut.frame_buffer_full);

    // ---- Check 2: DUT should be processing (not in IDLE or ACCUMULATE) ----
    // Wait a few clocks for FSM to transition
    #(CLK_PERIOD * 5);
    $display("  After wait: state=%0d", dut_state_w);
    check(dut_state_w != 3'b000 && dut_state_w != 3'b001,
          "DUT entered processing state after 2048 input samples");
    check(processing_active == 1'b1,
          "processing_active asserted during Doppler FFT");

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
    // Wait a few more cycles
    #(CLK_PERIOD * 20);
    check(dut_state_w == 3'b000,
          "DUT returned to S_IDLE after processing");

    // ---- Check 6: Output ordering ----
    // First output should be range_bin=0, doppler_bin=0
    if (out_count > 0) begin
        check(cap_rbin[0] == 0 && cap_dbin[0] == 0,
              "First output: range_bin=0, doppler_bin=0");
    end

    // Last output should be range_bin=63
    if (out_count == TOTAL_OUTPUTS) begin
        check(cap_rbin[TOTAL_OUTPUTS-1] == RANGE_BINS - 1,
              "Last output: range_bin=63");
        check(cap_dbin[TOTAL_OUTPUTS-1] == DOPPLER_FFT - 1,
              "Last output: doppler_bin=31");
    end

    // ---- Check 7: Range bins are monotonically non-decreasing ----
    begin : rbin_order_check
        integer ordering_ok;
        integer j;
        ordering_ok = 1;
        for (j = 1; j < out_count; j = j + 1) begin
            if (cap_rbin[j] < cap_rbin[j-1]) begin
                ordering_ok = 0;
                $display("  ERROR: range_bin decreased at output %0d: %0d -> %0d",
                         j, cap_rbin[j-1], cap_rbin[j]);
            end
        end
        check(ordering_ok == 1,
              "Range bins are monotonically non-decreasing");
    end

    // ---- Check 8: Each range bin has exactly 32 outputs ----
    begin : per_rbin_check
        integer count_per_rbin;
        integer rb, j, all_ok;
        all_ok = 1;
        for (rb = 0; rb < RANGE_BINS; rb = rb + 1) begin
            count_per_rbin = 0;
            for (j = 0; j < out_count; j = j + 1) begin
                if (cap_rbin[j] == rb) begin
                    count_per_rbin = count_per_rbin + 1;
                end
            end
            if (count_per_rbin != DOPPLER_FFT) begin
                all_ok = 0;
                $display("  ERROR: range_bin %0d has %0d outputs (expected %0d)",
                         rb, count_per_rbin, DOPPLER_FFT);
            end
        end
        check(all_ok == 1,
              "Each range bin has exactly 32 Doppler outputs");
    end

    // ---- Check 9: Doppler bins cycle 0..31 within each range bin ----
    begin : dbin_cycle_check
        integer j, expected_dbin, dbin_ok;
        dbin_ok = 1;
        for (j = 0; j < out_count; j = j + 1) begin
            expected_dbin = j % DOPPLER_FFT;
            if (cap_dbin[j] != expected_dbin) begin
                dbin_ok = 0;
                if (j < 5 || j > out_count - 5) begin
                    $display("  ERROR: output[%0d] doppler_bin=%0d expected=%0d",
                             j, cap_dbin[j], expected_dbin);
                end
            end
        end
        check(dbin_ok == 1,
              "Doppler bins cycle 0..31 within each range bin");
    end

    // ---- Check 10: Non-trivial output (not all zeros) ----
    begin : nontrivial_check
        integer nonzero, j;
        nonzero = 0;
        for (j = 0; j < out_count; j = j + 1) begin
            if (cap_out_i[j] != 0 || cap_out_q[j] != 0) begin
                nonzero = nonzero + 1;
            end
        end
        $display("  Non-zero outputs: %0d / %0d", nonzero, out_count);
        check(nonzero > TOTAL_OUTPUTS / 4,
              "At least 25%% of outputs are non-zero");
    end

    // ---- Write output CSV ----
    csv_file = $fopen({"tb/cosim/rtl_doppler_", SCENARIO, ".csv"}, "w");
    if (csv_file == 0) begin
        $display("ERROR: Could not open output CSV file");
    end else begin
        $fwrite(csv_file, "range_bin,doppler_bin,out_i,out_q\n");
        for (i = 0; i < out_count; i = i + 1) begin
            $fwrite(csv_file, "%0d,%0d,%0d,%0d\n",
                    cap_rbin[i], cap_dbin[i],
                    $signed(cap_out_i[i]), $signed(cap_out_q[i]));
        end
        $fclose(csv_file);
        $display("\n  RTL output written to: tb/cosim/rtl_doppler_%0s.csv",
                 SCENARIO);
    end

    // ---- Write FFT input CSV ----
    fft_csv_file = $fopen({"tb/cosim/rtl_doppler_fft_in_", SCENARIO, ".csv"}, "w");
    if (fft_csv_file == 0) begin
        $display("ERROR: Could not open FFT input CSV file");
    end else begin
        $fwrite(fft_csv_file, "index,fft_in_i,fft_in_q\n");
        for (i = 0; i < fft_in_count; i = i + 1) begin
            $fwrite(fft_csv_file, "%0d,%0d,%0d\n",
                    i, $signed(cap_fft_in_i[i]), $signed(cap_fft_in_q[i]));
        end
        $fclose(fft_csv_file);
        $display("  FFT inputs written to: tb/cosim/rtl_doppler_fft_in_%0s.csv (%0d samples)",
                 SCENARIO, fft_in_count);
    end

    // ---- Check: FFT input count ----
    check(fft_in_count == TOTAL_OUTPUTS,
          "FFT input count == 2048");

    // ---- Summary ----
    $display("\n============================================================");
    $display("RESULTS: %0d / %0d passed", pass_count, test_count);
    $display("============================================================");
    if (fail_count == 0) begin
        $display("ALL TESTS PASSED");
    end else begin
        $display("SOME TESTS FAILED");
    end
    $display("============================================================");

    #(CLK_PERIOD * 10);
    $finish;
end

// ============================================================================
// FFT input capture (runs concurrently)
// ============================================================================
always @(posedge clk) begin
    if (fft_input_valid_w && fft_in_count < TOTAL_OUTPUTS) begin
        cap_fft_in_i[fft_in_count] <= fft_input_i_w;
        cap_fft_in_q[fft_in_count] <= fft_input_q_w;
        fft_in_count <= fft_in_count + 1;
    end
end

// Debug: print pipeline state during S_LOAD_FFT/S_PRE_READ for rbin=12
// (Uncomment for debugging pipeline alignment issues)
// always @(posedge clk) begin
//     if ((dut_state_w == 3'b101 || dut_state_w == 3'b010) && read_range_bin_w == 12) begin
//         $display("  [DBG rbin=12] state=%0d sc=%0d rdidx=%0d mem_rd_i=%0d mult_i=%0d fft_in_i=%0d fft_valid=%0d",
//                  dut_state_w, fft_sc_w, read_doppler_idx_w,
//                  mem_rdata_i_w, mult_i_w, fft_input_i_w, fft_input_valid_w);
//     end
// end

// ============================================================================
// Watchdog
// ============================================================================
initial begin
    #(CLK_PERIOD * MAX_CYCLES * 2);
    $display("WATCHDOG TIMEOUT — simulation exceeded %0d cycles", MAX_CYCLES * 2);
    $display("SOME TESTS FAILED");
    $finish;
end

endmodule
