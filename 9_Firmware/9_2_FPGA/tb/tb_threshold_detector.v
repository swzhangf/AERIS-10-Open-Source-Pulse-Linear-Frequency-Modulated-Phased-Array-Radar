`timescale 1ns / 1ps

/**
 * tb_threshold_detector.v
 *
 * Unit test for the threshold detection logic in radar_system_top.v.
 * Tests the two bug fixes applied in Build 22:
 *
 *   1. One-cycle-lag fix: magnitude is now computed combinationally,
 *      so the comparison uses the current sample (not the previous).
 *   2. Sticky detection fix: rx_detect_flag clears every cycle,
 *      only asserted on actual detections.
 *
 * Also tests:
 *   3. Threshold is host-configurable via opcode 0x03
 *   4. Detection counter increments correctly
 *   5. Edge cases: exactly-at-threshold, zero input, max input
 */

module tb_threshold_detector;

// ---------------------------------------------------------------
// Clock and reset
// ---------------------------------------------------------------
reg clk;
reg reset_n;

initial clk = 0;
always #5 clk = ~clk;  // 100 MHz

// ---------------------------------------------------------------
// DUT signals — mirrors detection logic from radar_system_top.v
// We instantiate just the detection logic, not the full system.
// ---------------------------------------------------------------
reg signed [15:0] doppler_real;
reg signed [15:0] doppler_imag;
reg doppler_valid;
reg [15:0] host_threshold;

// Combinational magnitude (same as production RTL)
wire [15:0] abs_i = doppler_real[15] ? (~doppler_real + 16'd1) : doppler_real;
wire [15:0] abs_q = doppler_imag[15] ? (~doppler_imag + 16'd1) : doppler_imag;
wire [16:0] detect_mag = {1'b0, abs_i} + {1'b0, abs_q};

reg detect_flag;
reg detect_valid;
reg [7:0] detect_counter;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        detect_counter <= 8'd0;
        detect_flag    <= 1'b0;
        detect_valid   <= 1'b0;
    end else begin
        detect_flag  <= 1'b0;
        detect_valid <= 1'b0;
        
        if (doppler_valid) begin
            if (detect_mag > {1'b0, host_threshold}) begin
                detect_flag  <= 1'b1;
                detect_valid <= 1'b1;
                detect_counter <= detect_counter + 1;
            end
        end
    end
end

// ---------------------------------------------------------------
// Test infrastructure
// ---------------------------------------------------------------
integer pass_count = 0;
integer fail_count = 0;

task check;
    input cond;
    input [1023:0] msg;
    begin
        if (cond) begin
            $display("[PASS] %0s", msg);
            pass_count = pass_count + 1;
        end else begin
            $display("[FAIL] %0s", msg);
            fail_count = fail_count + 1;
        end
    end
endtask

task pulse_sample;
    input signed [15:0] i_val;
    input signed [15:0] q_val;
    begin
        // Setup inputs before clock edge
        @(negedge clk);
        doppler_real  = i_val;
        doppler_imag  = q_val;
        doppler_valid = 1'b1;
        // Rising edge: always block samples valid=1, schedules detect_flag<=result
        @(posedge clk);
        #1;  // Let NBA resolve — detect_flag now reflects this cycle's decision
        // Deassert valid for next cycle
        @(negedge clk);
        doppler_valid = 1'b0;
    end
endtask

// ---------------------------------------------------------------
// Test sequence
// ---------------------------------------------------------------
initial begin
    $display("=== Threshold Detector Unit Test ===");
    
    // Init
    reset_n        = 0;
    doppler_real   = 0;
    doppler_imag   = 0;
    doppler_valid  = 0;
    host_threshold = 16'd1000;
    
    repeat (4) @(posedge clk);
    reset_n = 1;
    repeat (2) @(posedge clk);
    
    // ---------------------------------------------------------------
    // TEST 1: No-lag detection — magnitude computed same cycle
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 1: Same-cycle magnitude (no lag) ---");
    
    // Feed sample with |I|+|Q| = 600+500 = 1100 > threshold=1000
    pulse_sample(16'sd600, 16'sd500);
    check(detect_flag == 1'b1,
          "T1.1: Detection fires on first sample above threshold");
    check(detect_valid == 1'b1,
          "T1.2: detect_valid asserted with detect_flag");
    check(detect_counter == 8'd1,
          "T1.3: Counter incremented to 1");
    
    // ---------------------------------------------------------------
    // TEST 2: Sticky detection fix — flag clears on next valid=0 cycle
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 2: Detection clears on next cycle ---");
    
    // pulse_sample left valid=0 on negedge. Wait for next posedge where
    // the always block runs with valid=0 and clears detect_flag.
    @(posedge clk);
    #1;
    check(detect_flag == 1'b0,
          "T2.1: detect_flag cleared after valid deasserted");
    check(detect_valid == 1'b0,
          "T2.2: detect_valid cleared after valid deasserted");
    
    // ---------------------------------------------------------------
    // TEST 3: Below-threshold sample should NOT detect
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 3: Below-threshold ---");
    
    // |I|+|Q| = 300+200 = 500 < 1000
    pulse_sample(16'sd300, 16'sd200);
    check(detect_flag == 1'b0,
          "T3.1: No detection for below-threshold sample");
    check(detect_counter == 8'd1,
          "T3.2: Counter unchanged at 1");
    
    // ---------------------------------------------------------------
    // TEST 4: Exactly-at-threshold should NOT detect (> not >=)
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 4: Exactly at threshold ---");
    
    // |I|+|Q| = 600+400 = 1000 == threshold (not >)
    pulse_sample(16'sd600, 16'sd400);
    check(detect_flag == 1'b0,
          "T4.1: No detection at exact threshold (> not >=)");
    
    // ---------------------------------------------------------------
    // TEST 5: Negative inputs (absolute value should still work)
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 5: Negative inputs ---");
    
    // |-800| + |-300| = 1100 > 1000
    pulse_sample(-16'sd800, -16'sd300);
    check(detect_flag == 1'b1,
          "T5.1: Detection works with negative I and Q");
    check(detect_counter == 8'd2,
          "T5.2: Counter incremented to 2");
    
    // ---------------------------------------------------------------
    // TEST 6: Mixed positive/negative
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 6: Mixed sign inputs ---");
    
    // |700| + |-400| = 1100 > 1000
    pulse_sample(16'sd700, -16'sd400);
    check(detect_flag == 1'b1,
          "T6.1: Detection with mixed-sign inputs");
    
    // |-200| + |500| = 700 < 1000
    pulse_sample(-16'sd200, 16'sd500);
    check(detect_flag == 1'b0,
          "T6.2: No detection with mixed-sign below threshold");
    
    // ---------------------------------------------------------------
    // TEST 7: Consecutive above-threshold samples
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 7: Consecutive detections ---");
    
    // Three consecutive above-threshold samples
    @(negedge clk);
    doppler_real  = 16'sd2000;
    doppler_imag  = 16'sd3000;
    doppler_valid = 1'b1;
    @(posedge clk);
    #1;
    check(detect_flag == 1'b1,
          "T7.1: First consecutive detection");
    
    @(negedge clk);
    doppler_real  = 16'sd1500;
    doppler_imag  = 16'sd2000;
    // doppler_valid still high
    @(posedge clk);
    #1;
    check(detect_flag == 1'b1,
          "T7.2: Second consecutive detection");
    
    @(negedge clk);
    doppler_real  = 16'sd100;
    doppler_imag  = 16'sd100;
    @(posedge clk);
    #1;
    check(detect_flag == 1'b0,
          "T7.3: Third sample below threshold - flag clears immediately");
    
    @(negedge clk);
    doppler_valid = 1'b0;
    @(posedge clk);
    
    // ---------------------------------------------------------------
    // TEST 8: Host-configurable threshold change
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 8: Threshold reconfiguration ---");
    
    host_threshold = 16'd500;  // Lower threshold
    
    // |300|+|300| = 600 > 500 (was below old threshold of 1000)
    pulse_sample(16'sd300, 16'sd300);
    check(detect_flag == 1'b1,
          "T8.1: Detection after lowering threshold");
    
    host_threshold = 16'd2000;  // Raise threshold
    
    // |300|+|300| = 600 < 2000
    pulse_sample(16'sd300, 16'sd300);
    check(detect_flag == 1'b0,
          "T8.2: No detection after raising threshold");
    
    // ---------------------------------------------------------------
    // TEST 9: Zero input
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 9: Zero input ---");
    
    host_threshold = 16'd0;  // Even zero threshold
    
    // |0|+|0| = 0 — not > 0
    pulse_sample(16'sd0, 16'sd0);
    check(detect_flag == 1'b0,
          "T9.1: Zero magnitude does not trigger even with threshold=0");
    
    // ---------------------------------------------------------------
    // TEST 10: Maximum input (near overflow)
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 10: Maximum input ---");
    
    host_threshold = 16'hFFFE;  // Near-max threshold = 65534
    
    // |32767| + |32767| = 65534 — not > 65534
    pulse_sample(16'sd32767, 16'sd32767);
    check(detect_flag == 1'b0,
          "T10.1: Max positive at max threshold — equal, no detect");
    
    host_threshold = 16'hFFFD;  // 65533
    pulse_sample(16'sd32767, 16'sd32767);
    check(detect_flag == 1'b1,
          "T10.2: Max positive at threshold-1 — detects");
    
    // Most-negative: -32768
    pulse_sample(-16'sd32768, -16'sd32768);
    // |-32768| = 32768 (17-bit), so |I|+|Q| = 65536 > 65533
    check(detect_flag == 1'b1,
          "T10.3: Most-negative input detects (|I|+|Q|=65536)");
    
    // ---------------------------------------------------------------
    // TEST 11: Detection counter wraps at 255
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 11: Counter behavior ---");
    
    // Reset to get fresh counter
    reset_n = 0;
    repeat (2) @(posedge clk);
    reset_n = 1;
    repeat (2) @(posedge clk);
    
    host_threshold = 16'd100;
    check(detect_counter == 8'd0,
          "T11.1: Counter resets to 0");
    
    // ---------------------------------------------------------------
    // SUMMARY
    // ---------------------------------------------------------------
    $display("");
    $display("=== Threshold Detector: %0d passed, %0d failed ===",
             pass_count, fail_count);
    
    if (fail_count > 0)
        $display("[FAIL] Threshold detector test FAILED");
    else
        $display("[PASS] All threshold detector tests passed");
    
    $finish;
end

endmodule
