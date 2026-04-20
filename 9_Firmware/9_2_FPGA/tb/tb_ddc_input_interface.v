`timescale 1ns / 1ps
/**
 * tb_ddc_input_interface.v
 *
 * Testbench for ddc_input_interface.v — 18-bit to 16-bit rounding + saturation.
 *
 * Tests:
 *   1. Reset state (outputs zero, adc_valid deasserted)
 *   2. Basic passthrough (small positive/negative values)
 *   3. Rounding up (bit[1]=1 adds 1 to truncated value)
 *   4. Rounding down (bit[1]=0, truncation only)
 *   5. Positive overflow saturation (0x1FFFC..0x1FFFF -> 0x7FFF, not 0x8000)
 *   6. Negative full scale (no overflow on negative side)
 *   7. Valid synchronization (both I and Q must be valid)
 *   8. Sync error detection (I valid without Q, and vice versa)
 *   9. Pipeline latency (2 cycles: valid_sync then adc_valid)
 *  10. Sweep from near-max-positive through overflow boundary
 *
 * Compile:
 *   iverilog -g2001 -DSIMULATION -o tb/tb_ddc_input_interface.vvp \
 *     tb/tb_ddc_input_interface.v ddc_input_interface.v
 *
 *   vvp tb/tb_ddc_input_interface.vvp
 */

module tb_ddc_input_interface;

// ============================================================================
// Parameters
// ============================================================================
localparam CLK_PERIOD = 10.0;  // 100 MHz

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
reg signed [17:0] ddc_i;
reg signed [17:0] ddc_q;
reg               valid_i;
reg               valid_q;

wire signed [15:0] adc_i;
wire signed [15:0] adc_q;
wire               adc_valid;
wire               data_sync_error;

// ============================================================================
// DUT instantiation
// ============================================================================
ddc_input_interface dut (
    .clk(clk),
    .reset_n(reset_n),
    .ddc_i(ddc_i),
    .ddc_q(ddc_q),
    .valid_i(valid_i),
    .valid_q(valid_q),
    .adc_i(adc_i),
    .adc_q(adc_q),
    .adc_valid(adc_valid),
    .data_sync_error(data_sync_error)
);

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

// Helper: apply one I/Q sample and wait for output.
//
// The DUT has a 2-stage valid pipeline + 1 cycle data capture:
//   Cycle 0: present ddc_i/q + valid_i/q = 1
//   Cycle 1: valid_i_reg/valid_q_reg capture (NBA).
//   Cycle 2: valid_sync = 1 (NBA). adc_i/q computed from ddc_i/q at posedge.
//            DATA MUST STILL BE STABLE on ddc_i/q at this edge!
//            adc_i/q result available AFTER this posedge (NBA -> next cycle).
//   Cycle 3: adc_i/q hold the result. adc_valid = 1.
//
// Total: 4 posedge waits from data presentation to result availability.
task apply_sample;
    input signed [17:0] in_i;
    input signed [17:0] in_q;
    begin
        @(posedge clk);
        ddc_i <= in_i;
        ddc_q <= in_q;
        valid_i <= 1;
        valid_q <= 1;
        @(posedge clk);
        // valid can drop but data must stay stable for valid_sync cycle
        valid_i <= 0;
        valid_q <= 0;
        // ddc_i/q stay at in_i/in_q (held by regs)
        @(posedge clk);
        // valid_sync fires this edge, data sampled into adc_i/q (NBA)
        @(posedge clk);
        // adc_i/q now hold the result. adc_valid = 1.
        @(posedge clk);
        // One more edge to ensure NBA from cycle 3 is visible
    end
endtask

// ============================================================================
// VCD dump
// ============================================================================
initial begin
    $dumpfile("tb/tb_ddc_input_interface.vcd");
    $dumpvars(0, tb_ddc_input_interface);
end

// ============================================================================
// Expected value computation (matches RTL: truncate [17:2] + round [1],
// saturate if positive overflow)
// ============================================================================
function signed [15:0] expected_output;
    input signed [17:0] val;
    reg [15:0] trunc;
    reg        rnd;
    begin
        trunc = val[17:2];
        rnd = val[1];
        if (trunc == 16'h7FFF && rnd)
            expected_output = 16'sh7FFF;  // saturate
        else
            expected_output = trunc + {15'b0, rnd};
    end
endfunction

// ============================================================================
// Main test sequence
// ============================================================================
integer i;
reg signed [17:0] test_val;
reg signed [15:0] exp_i, exp_q;

initial begin
    // ---- Init ----
    pass_count = 0;
    fail_count = 0;
    test_count = 0;
    ddc_i = 0;
    ddc_q = 0;
    valid_i = 0;
    valid_q = 0;
    reset_n = 0;

    // ---- Reset ----
    #(CLK_PERIOD * 5);
    reset_n = 1;
    #(CLK_PERIOD * 3);

    $display("============================================================");
    $display("ddc_input_interface Testbench");
    $display("18-bit to 16-bit rounding with overflow saturation");
    $display("============================================================");

    // ---- Test 1: Reset state ----
    check(adc_valid == 0, "adc_valid deasserted after reset");
    check(data_sync_error == 0, "No sync error after reset");

    // ---- Test 2: Basic passthrough — small positive ----
    // ddc_i = 18'd100 = 0x00064.  [17:2] = 25, [1] = 0. Expected: 25.
    apply_sample(18'sd100, 18'sd200);
    exp_i = expected_output(18'sd100);
    exp_q = expected_output(18'sd200);
    check(adc_i == exp_i,
          "Small positive I: 100 -> expected truncated+round");
    check(adc_q == exp_q,
          "Small positive Q: 200 -> expected truncated+round");

    // ---- Test 3: Small negative ----
    apply_sample(-18'sd100, -18'sd200);
    exp_i = expected_output(-18'sd100);
    exp_q = expected_output(-18'sd200);
    check(adc_i == exp_i,
          "Small negative I: -100 -> expected truncated+round");
    check(adc_q == exp_q,
          "Small negative Q: -200 -> expected truncated+round");

    // ---- Test 4: Rounding UP (bit[1]=1 on positive value) ----
    // 18'd6 = 0b000000000000000110. [17:2]=1, [1]=1. Expected: 1+1=2.
    apply_sample(18'sd6, 18'sd6);
    check(adc_i == 16'sd2,
          "Rounding up I: 6 -> [17:2]=1, [1]=1, result=2");
    check(adc_q == 16'sd2,
          "Rounding up Q: 6 -> [17:2]=1, [1]=1, result=2");

    // ---- Test 5: Rounding DOWN (bit[1]=0) ----
    // 18'd4 = 0b000000000000000100. [17:2]=1, [1]=0. Expected: 1.
    apply_sample(18'sd4, 18'sd4);
    check(adc_i == 16'sd1,
          "Truncation (no round) I: 4 -> [17:2]=1, [1]=0, result=1");
    check(adc_q == 16'sd1,
          "Truncation (no round) Q: 4 -> [17:2]=1, [1]=0, result=1");

    // ---- Test 6: CRITICAL — Positive overflow saturation ----
    // Maximum 18-bit positive = 131071 = 18'h1FFFF
    // [17:2] = 16'h7FFF = 32767, [1] = 1
    // WITHOUT saturation: 32767 + 1 = -32768 (sign flip!)
    // WITH saturation: 32767 (clamped)
    apply_sample(18'sd131071, 18'sd131071);
    check(adc_i == 16'sh7FFF,
          "Positive overflow saturation I: 131071 -> 0x7FFF (not 0x8000)");
    check(adc_q == 16'sh7FFF,
          "Positive overflow saturation Q: 131071 -> 0x7FFF (not 0x8000)");

    // ---- Test 7: Near-overflow, no saturation needed ----
    // 18'sd131068 = 0x1FFFC. [17:2] = 0x7FFF, [1] = 0. Expected: 0x7FFF.
    apply_sample(18'sd131068, 18'sd131068);
    check(adc_i == 16'sh7FFF,
          "Near-overflow no-round I: 131068 -> 0x7FFF (no saturation needed)");
    check(adc_q == 16'sh7FFF,
          "Near-overflow no-round Q: 131068 -> 0x7FFF (no saturation needed)");

    // ---- Test 8: Just below overflow boundary ----
    // 18'sd131066 = 0x1FFFA. [17:2] = 0x7FFE, [1] = 1. Expected: 0x7FFE+1=0x7FFF.
    apply_sample(18'sd131066, 18'sd131066);
    check(adc_i == 16'sh7FFF,
          "Below overflow, round up I: 131066 -> 0x7FFF");
    check(adc_q == 16'sh7FFF,
          "Below overflow, round up Q: 131066 -> 0x7FFF");

    // ---- Test 9: Negative full scale ----
    // Minimum 18-bit signed = -131072 = 18'h20000
    // [17:2] = 0x8000 = -32768, [1] = 0. Expected: -32768.
    apply_sample(-18'sd131072, -18'sd131072);
    check(adc_i == -16'sd32768,
          "Negative full scale I: -131072 -> -32768 (0x8000)");
    check(adc_q == -16'sd32768,
          "Negative full scale Q: -131072 -> -32768 (0x8000)");

    // ---- Test 10: Negative near-min with rounding ----
    // -131071 = 18'sh20001. [17:2] = 0x8000 = -32768, [1] = 0. Expected: -32768.
    apply_sample(-18'sd131071, -18'sd131071);
    exp_i = expected_output(-18'sd131071);
    check(adc_i == exp_i,
          "Negative near-min I: -131071 -> expected");

    // ---- Test 11: Zero ----
    apply_sample(18'sd0, 18'sd0);
    check(adc_i == 16'sd0, "Zero I: 0 -> 0");
    check(adc_q == 16'sd0, "Zero Q: 0 -> 0");

    // ---- Test 12: Valid synchronization — only I valid ----
    @(posedge clk);
    ddc_i <= 18'sd999;
    ddc_q <= 18'sd999;
    valid_i <= 1;
    valid_q <= 0;
    @(posedge clk);
    // data_sync_error = valid_i_reg ^ valid_q_reg, 1 cycle after inputs
    valid_i <= 0;
    @(posedge clk);
    check(data_sync_error == 1,
          "Sync error detected: valid_i=1, valid_q=0");
    @(posedge clk);

    // ---- Test 13: Valid synchronization — only Q valid ----
    @(posedge clk);
    ddc_i <= 18'sd999;
    ddc_q <= 18'sd999;
    valid_i <= 0;
    valid_q <= 1;
    @(posedge clk);
    valid_q <= 0;
    @(posedge clk);
    check(data_sync_error == 1,
          "Sync error detected: valid_i=0, valid_q=1");
    @(posedge clk);

    // ---- Test 14: No sync error when both valid ----
    @(posedge clk);
    valid_i <= 1;
    valid_q <= 1;
    @(posedge clk);
    valid_i <= 0;
    valid_q <= 0;
    @(posedge clk);
    check(data_sync_error == 0,
          "No sync error when both valid");
    @(posedge clk);

    // ---- Test 15: Sweep near overflow boundary ----
    // Test values from 131064 to 131071 — covers all rounding/saturation cases
    begin : sweep_test
        integer sweep_pass;
        reg signed [17:0] sv;
        reg signed [15:0] exp_sv;
        sweep_pass = 1;
        for (i = 131064; i <= 131071; i = i + 1) begin
            sv = i;
            apply_sample(sv, sv);
            exp_sv = expected_output(sv);
            if (adc_i !== exp_sv) begin
                sweep_pass = 0;
                $display("  SWEEP FAIL: input=%0d, expected=%0d, got=%0d",
                         i, exp_sv, adc_i);
            end
        end
        check(sweep_pass == 1,
              "Overflow boundary sweep (131064..131071) all correct");
    end

    // ---- Test 16: Sweep near negative boundary ----
    begin : neg_sweep_test
        integer neg_sweep_pass;
        reg signed [17:0] sv;
        reg signed [15:0] exp_sv;
        neg_sweep_pass = 1;
        for (i = -131072; i <= -131064; i = i + 1) begin
            sv = i;
            apply_sample(sv, sv);
            exp_sv = expected_output(sv);
            if (adc_i !== exp_sv) begin
                neg_sweep_pass = 0;
                $display("  NEG SWEEP FAIL: input=%0d, expected=%0d, got=%0d",
                         i, exp_sv, adc_i);
            end
        end
        check(neg_sweep_pass == 1,
              "Negative boundary sweep (-131072..-131064) all correct");
    end

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

    #(CLK_PERIOD * 5);
    $finish;
end

// ============================================================================
// Watchdog
// ============================================================================
initial begin
    #(CLK_PERIOD * 100_000);
    $display("WATCHDOG TIMEOUT");
    $display("SOME TESTS FAILED");
    $finish;
end

endmodule
