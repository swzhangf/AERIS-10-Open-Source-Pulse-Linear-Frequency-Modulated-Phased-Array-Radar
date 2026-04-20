`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////
// Testbench: fpga_self_test
// Tests board bring-up smoke test controller.
//
// Compile & run:
//   iverilog -Wall -DSIMULATION -g2012 \
//     -o tb/tb_fpga_self_test.vvp \
//     tb/tb_fpga_self_test.v fpga_self_test.v
//   vvp tb/tb_fpga_self_test.vvp
//////////////////////////////////////////////////////////////////////////////

module tb_fpga_self_test;

// =========================================================================
// Clock / Reset
// =========================================================================
reg clk;
reg reset_n;

initial clk = 0;
always #5 clk = ~clk;  // 100 MHz

// =========================================================================
// DUT Signals
// =========================================================================
reg        trigger;
wire       busy;
wire       result_valid;
wire [4:0] result_flags;
wire [7:0] result_detail;

// ADC mock interface
reg  [15:0] adc_data_in;
reg         adc_valid_in;
wire        capture_active;
wire [15:0] capture_data;
wire        capture_valid;

// =========================================================================
// DUT
// =========================================================================
fpga_self_test dut (
    .clk(clk),
    .reset_n(reset_n),
    .trigger(trigger),
    .busy(busy),
    .result_valid(result_valid),
    .result_flags(result_flags),
    .result_detail(result_detail),
    .adc_data_in(adc_data_in),
    .adc_valid_in(adc_valid_in),
    .capture_active(capture_active),
    .capture_data(capture_data),
    .capture_valid(capture_valid)
);

// =========================================================================
// Test Infrastructure
// =========================================================================
integer test_num;
integer pass_count;
integer fail_count;

task check;
    input [255:0] test_name;
    input condition;
    begin
        test_num = test_num + 1;
        if (condition) begin
            $display("  [PASS] Test %0d: %0s", test_num, test_name);
            pass_count = pass_count + 1;
        end else begin
            $display("  [FAIL] Test %0d: %0s", test_num, test_name);
            fail_count = fail_count + 1;
        end
    end
endtask

// ADC data generator: provides synthetic samples when capture is active
reg [15:0] adc_sample_cnt;
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        adc_data_in   <= 16'd0;
        adc_valid_in  <= 1'b0;
        adc_sample_cnt <= 16'd0;
    end else begin
        if (capture_active) begin
            // Provide a new ADC sample every 4 cycles (simulating 25 MHz sample rate)
            adc_sample_cnt <= adc_sample_cnt + 1;
            if (adc_sample_cnt[1:0] == 2'b11) begin
                adc_data_in  <= adc_sample_cnt[15:0];
                adc_valid_in <= 1'b1;
            end else begin
                adc_valid_in <= 1'b0;
            end
        end else begin
            adc_valid_in   <= 1'b0;
            adc_sample_cnt <= 16'd0;
        end
    end
end

// Count captured samples
integer captured_count;
always @(posedge clk or negedge reset_n) begin
    if (!reset_n)
        captured_count <= 0;
    else if (trigger)
        captured_count <= 0;
    else if (capture_valid)
        captured_count <= captured_count + 1;
end

// =========================================================================
// Main Test Sequence
// =========================================================================
initial begin
    $dumpfile("tb_fpga_self_test.vcd");
    $dumpvars(0, tb_fpga_self_test);

    test_num   = 0;
    pass_count = 0;
    fail_count = 0;

    trigger = 0;

    $display("");
    $display("============================================================");
    $display("  FPGA SELF-TEST CONTROLLER TESTBENCH");
    $display("============================================================");
    $display("");

    // =====================================================================
    // Reset
    // =====================================================================
    reset_n = 0;
    repeat (10) @(posedge clk);
    reset_n = 1;
    repeat (5) @(posedge clk);

    $display("--- Group 1: Initial State ---");
    check("Idle after reset",     !busy);
    check("No result valid",      !result_valid);
    check("Flags zero",           result_flags == 5'b00000);

    // =====================================================================
    // Trigger self-test
    // =====================================================================
    $display("");
    $display("--- Group 2: Self-Test Execution ---");

    @(posedge clk);
    trigger = 1;
    @(posedge clk);
    trigger = 0;

    // Should go busy immediately
    repeat (2) @(posedge clk);
    check("Busy after trigger",   busy);

    // Wait for completion (BRAM + CIC + FFT + Arith + ADC capture)
    // ADC capture takes ~256*4 = 1024 cycles + overhead
    // Total budget: ~2000 cycles
    begin : wait_for_done
        integer i;
        for (i = 0; i < 5000; i = i + 1) begin
            @(posedge clk);
            if (result_valid) begin
                i = 5000;  // break
            end
        end
    end

    check("Result valid received", result_valid);
    check("Not busy after done",  !busy);

    // =====================================================================
    // Check individual test results
    // =====================================================================
    $display("");
    $display("--- Group 3: Test Results ---");
    $display("  result_flags = %05b", result_flags);
    $display("  result_detail = 0x%02h", result_detail);

    check("Test 0 BRAM pass",     result_flags[0]);
    check("Test 1 CIC pass",      result_flags[1]);
    check("Test 2 FFT pass",      result_flags[2]);
    check("Test 3 Arith pass",    result_flags[3]);
    check("Test 4 ADC cap pass",  result_flags[4]);
    check("All tests pass",       result_flags == 5'b11111);

    $display("  ADC samples captured: %0d", captured_count);
    check("ADC captured 256 samples", captured_count == 256);

    // =====================================================================
    // Re-trigger: verify can run again
    // =====================================================================
    $display("");
    $display("--- Group 4: Re-trigger ---");

    repeat (10) @(posedge clk);
    @(posedge clk);
    trigger = 1;
    @(posedge clk);
    trigger = 0;

    repeat (2) @(posedge clk);
    check("Busy on re-trigger",   busy);

    begin : wait_for_done2
        integer i;
        for (i = 0; i < 5000; i = i + 1) begin
            @(posedge clk);
            if (result_valid) begin
                i = 5000;
            end
        end
    end

    check("Re-trigger completes", result_valid);
    check("All pass on re-run",   result_flags == 5'b11111);

    // =====================================================================
    // Summary
    // =====================================================================
    $display("");
    $display("============================================================");
    if (fail_count == 0) begin
        $display("  ALL %0d TESTS PASSED", pass_count);
    end else begin
        $display("  %0d PASSED, %0d FAILED (of %0d)", pass_count, fail_count, pass_count + fail_count);
    end
    $display("============================================================");
    $display("");

    $finish;
end

// Watchdog
initial begin
    #200000;
    $display("WATCHDOG: Timeout at 200us");
    $finish;
end

endmodule
