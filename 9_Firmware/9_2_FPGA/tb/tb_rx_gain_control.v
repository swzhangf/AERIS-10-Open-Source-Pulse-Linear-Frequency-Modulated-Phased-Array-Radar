`timescale 1ns / 1ps

/**
 * tb_rx_gain_control.v
 *
 * Unit test for rx_gain_control — host-configurable digital gain
 * between DDC output and matched filter input.
 *
 * Tests:
 *   1. Pass-through (shift=0): output == input
 *   2. Left shift (amplify): correct gain, saturation on overflow
 *   3. Right shift (attenuate): correct arithmetic shift
 *   4. Saturation counter: counts clipped samples
 *   5. Negative inputs: sign-correct shifting
 *   6. Max shift amounts (7 bits each direction)
 *   7. Valid signal pipeline: 1-cycle latency
 *   8. Dynamic gain change: gain_shift can change between samples
 *   9. Counter stops at 255 (no wrap)
 *  10. Reset clears everything
 */

module tb_rx_gain_control;

// ---------------------------------------------------------------
// Clock and reset
// ---------------------------------------------------------------
reg clk;
reg reset_n;

initial clk = 0;
always #5 clk = ~clk;  // 100 MHz

// ---------------------------------------------------------------
// DUT signals
// ---------------------------------------------------------------
reg signed [15:0] data_i_in;
reg signed [15:0] data_q_in;
reg               valid_in;
reg [3:0]         gain_shift;

// AGC configuration (default: AGC disabled — manual mode)
reg               agc_enable;
reg [7:0]         agc_target;
reg [3:0]         agc_attack;
reg [3:0]         agc_decay;
reg [3:0]         agc_holdoff;
reg               frame_boundary;

wire signed [15:0] data_i_out;
wire signed [15:0] data_q_out;
wire               valid_out;
wire [7:0]         saturation_count;
wire [7:0]         peak_magnitude;
wire [3:0]         current_gain;

rx_gain_control dut (
    .clk(clk),
    .reset_n(reset_n),
    .data_i_in(data_i_in),
    .data_q_in(data_q_in),
    .valid_in(valid_in),
    .gain_shift(gain_shift),
    .agc_enable(agc_enable),
    .agc_target(agc_target),
    .agc_attack(agc_attack),
    .agc_decay(agc_decay),
    .agc_holdoff(agc_holdoff),
    .frame_boundary(frame_boundary),
    .data_i_out(data_i_out),
    .data_q_out(data_q_out),
    .valid_out(valid_out),
    .saturation_count(saturation_count),
    .peak_magnitude(peak_magnitude),
    .current_gain(current_gain)
);

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

// Send one sample and wait for output (1-cycle latency)
task send_sample;
    input signed [15:0] i_val;
    input signed [15:0] q_val;
    begin
        @(negedge clk);
        data_i_in = i_val;
        data_q_in = q_val;
        valid_in  = 1'b1;
        @(posedge clk);  // DUT registers input
        @(negedge clk);
        valid_in = 1'b0;
        @(posedge clk);  // output available after this edge
        #1;              // let NBA settle
    end
endtask

// ---------------------------------------------------------------
// Test sequence
// ---------------------------------------------------------------
initial begin
    $display("=== RX Gain Control Unit Test ===");

    // Init
    reset_n    = 0;
    data_i_in  = 0;
    data_q_in  = 0;
    valid_in   = 0;
    gain_shift = 4'd0;
    // AGC disabled for backward-compatible tests (Tests 1-12)
    agc_enable     = 0;
    agc_target     = 8'd200;
    agc_attack     = 4'd1;
    agc_decay      = 4'd1;
    agc_holdoff    = 4'd4;
    frame_boundary = 0;

    repeat (4) @(posedge clk);
    reset_n = 1;
    repeat (2) @(posedge clk);

    // ---------------------------------------------------------------
    // TEST 1: Pass-through (gain_shift = 0)
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 1: Pass-through (shift=0) ---");

    gain_shift = 4'b0_000;  // left shift 0 = pass-through
    send_sample(16'sd1000, 16'sd2000);
    check(data_i_out == 16'sd1000,
          "T1.1: I pass-through (1000)");
    check(data_q_out == 16'sd2000,
          "T1.2: Q pass-through (2000)");
    check(saturation_count == 8'd0,
          "T1.3: No saturation on pass-through");

    // ---------------------------------------------------------------
    // TEST 2: Left shift (amplify) without overflow
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 2: Left shift (amplify) ---");

    gain_shift = 4'b0_010;  // left shift 2 = x4
    send_sample(16'sd500, -16'sd300);
    check(data_i_out == 16'sd2000,
          "T2.1: I amplified 500<<2 = 2000");
    check(data_q_out == -16'sd1200,
          "T2.2: Q amplified -300<<2 = -1200");

    // ---------------------------------------------------------------
    // TEST 3: Left shift with overflow → saturation
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 3: Left shift with saturation ---");

    gain_shift = 4'b0_011;  // left shift 3 = x8
    send_sample(16'sd10000, -16'sd10000);
    // 10000 << 3 = 80000 > 32767 → clamp to 32767
    // -10000 << 3 = -80000 < -32768 → clamp to -32768
    check(data_i_out == 16'sd32767,
          "T3.1: I saturated to +32767");
    check(data_q_out == -16'sd32768,
          "T3.2: Q saturated to -32768");
    // Pulse frame_boundary to snapshot the per-frame saturation count
    @(negedge clk); frame_boundary = 1; @(posedge clk); #1;
    @(negedge clk); frame_boundary = 0; @(posedge clk); #1;
    check(saturation_count == 8'd1,
          "T3.3: Saturation counter = 1 (both channels clipped counts as 1)");

    // ---------------------------------------------------------------
    // TEST 4: Right shift (attenuate)
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 4: Right shift (attenuate) ---");

    // Reset to clear saturation counter
    reset_n = 0;
    repeat (2) @(posedge clk);
    reset_n = 1;
    repeat (2) @(posedge clk);

    gain_shift = 4'b1_010;  // right shift 2 = /4
    send_sample(16'sd4000, -16'sd2000);
    check(data_i_out == 16'sd1000,
          "T4.1: I attenuated 4000>>2 = 1000");
    check(data_q_out == -16'sd500,
          "T4.2: Q attenuated -2000>>2 = -500");
    // Pulse frame_boundary to snapshot (should be 0 — no clipping)
    @(negedge clk); frame_boundary = 1; @(posedge clk); #1;
    @(negedge clk); frame_boundary = 0; @(posedge clk); #1;
    check(saturation_count == 8'd0,
          "T4.3: No saturation on right shift");

    // ---------------------------------------------------------------
    // TEST 5: Right shift preserves sign (arithmetic shift)
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 5: Arithmetic right shift (sign preservation) ---");

    gain_shift = 4'b1_001;  // right shift 1
    send_sample(-16'sd1, -16'sd3);
    // -1 >>> 1 = -1 (sign extension)
    // -3 >>> 1 = -2 (floor division)
    check(data_i_out == -16'sd1,
          "T5.1: -1 >>> 1 = -1 (sign preserved)");
    check(data_q_out == -16'sd2,
          "T5.2: -3 >>> 1 = -2 (arithmetic floor)");

    // ---------------------------------------------------------------
    // TEST 6: Max left shift (7 bits)
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 6: Max left shift (x128) ---");

    gain_shift = 4'b0_111;  // left shift 7 = x128
    send_sample(16'sd100, -16'sd50);
    // 100 << 7 = 12800 (no overflow)
    // -50 << 7 = -6400 (no overflow)
    check(data_i_out == 16'sd12800,
          "T6.1: 100 << 7 = 12800");
    check(data_q_out == -16'sd6400,
          "T6.2: -50 << 7 = -6400");

    // Now with values that overflow at max shift
    send_sample(16'sd300, 16'sd300);
    // 300 << 7 = 38400 > 32767 → saturate
    check(data_i_out == 16'sd32767,
          "T6.3: 300 << 7 saturates to +32767");

    // ---------------------------------------------------------------
    // TEST 7: Max right shift (7 bits)
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 7: Max right shift (/128) ---");

    gain_shift = 4'b1_111;  // right shift 7 = /128
    send_sample(16'sd32767, -16'sd32768);
    // 32767 >>> 7 = 255
    // -32768 >>> 7 = -256
    check(data_i_out == 16'sd255,
          "T7.1: 32767 >>> 7 = 255");
    check(data_q_out == -16'sd256,
          "T7.2: -32768 >>> 7 = -256");

    // ---------------------------------------------------------------
    // TEST 8: Valid pipeline (1-cycle latency)
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 8: Valid pipeline ---");

    gain_shift = 4'b0_000;  // pass-through

    // Check that valid_out is low when we haven't sent anything
    @(posedge clk); #1;
    check(valid_out == 1'b0,
          "T8.1: valid_out low when no input");

    // Send a sample and check valid_out appears 1 cycle later
    @(negedge clk);
    data_i_in = 16'sd42;
    data_q_in = 16'sd43;
    valid_in  = 1'b1;
    @(posedge clk); #1;
    // This posedge just registered the input; valid_out should now be 1
    check(valid_out == 1'b1,
          "T8.2: valid_out asserts 1 cycle after valid_in");
    check(data_i_out == 16'sd42,
          "T8.3: data passes through with valid");

    @(negedge clk);
    valid_in = 1'b0;
    @(posedge clk); #1;
    check(valid_out == 1'b0,
          "T8.4: valid_out deasserts after valid_in drops");

    // ---------------------------------------------------------------
    // TEST 9: Dynamic gain change
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 9: Dynamic gain change ---");

    gain_shift = 4'b0_001;  // x2
    send_sample(16'sd1000, 16'sd1000);
    check(data_i_out == 16'sd2000,
          "T9.1: x2 gain applied");

    gain_shift = 4'b1_001;  // /2
    send_sample(16'sd1000, 16'sd1000);
    check(data_i_out == 16'sd500,
          "T9.2: /2 gain applied after change");

    // ---------------------------------------------------------------
    // TEST 10: Zero input
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 10: Zero input ---");

    gain_shift = 4'b0_111;  // max amplify
    send_sample(16'sd0, 16'sd0);
    check(data_i_out == 16'sd0,
          "T10.1: Zero stays zero at max gain");
    check(data_q_out == 16'sd0,
          "T10.2: Zero Q stays zero at max gain");

    // ---------------------------------------------------------------
    // TEST 11: Saturation counter stops at 255
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 11: Saturation counter caps at 255 ---");

    // Reset first
    reset_n = 0;
    repeat (2) @(posedge clk);
    reset_n = 1;
    repeat (2) @(posedge clk);

    gain_shift = 4'b0_111;  // x128 — will saturate most inputs
    // Send 256 saturating samples to overflow the counter
    begin : sat_loop
        integer j;
        for (j = 0; j < 256; j = j + 1) begin
            @(negedge clk);
            data_i_in = 16'sd20000;
            data_q_in = 16'sd20000;
            valid_in  = 1'b1;
            @(posedge clk);
        end
    end
    @(negedge clk);
    valid_in = 1'b0;
    @(posedge clk); #1;

    // Pulse frame_boundary to snapshot per-frame saturation count
    @(negedge clk); frame_boundary = 1; @(posedge clk); #1;
    @(negedge clk); frame_boundary = 0; @(posedge clk); #1;
    check(saturation_count == 8'd255,
          "T11.1: Counter capped at 255 after 256 saturating samples");

    // One more sample + frame boundary — should still be capped at 1 (new frame)
    send_sample(16'sd20000, 16'sd20000);
    @(negedge clk); frame_boundary = 1; @(posedge clk); #1;
    @(negedge clk); frame_boundary = 0; @(posedge clk); #1;
    check(saturation_count == 8'd1,
          "T11.2: New frame counter = 1 (single sample)");

    // ---------------------------------------------------------------
    // TEST 12: Reset clears everything
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 12: Reset clears all ---");

    gain_shift = 4'd0;  // Reset gain_shift to 0 so current_gain reads 0
    agc_enable = 0;
    reset_n = 0;
    repeat (2) @(posedge clk);
    reset_n = 1;
    @(posedge clk); #1;

    check(data_i_out == 16'sd0,
          "T12.1: I output cleared on reset");
    check(data_q_out == 16'sd0,
          "T12.2: Q output cleared on reset");
    check(valid_out == 1'b0,
          "T12.3: valid_out cleared on reset");
    check(saturation_count == 8'd0,
          "T12.4: Saturation counter cleared on reset");
    check(current_gain == 4'd0,
          "T12.5: current_gain cleared on reset");

    // ---------------------------------------------------------------
    // TEST 13: current_gain reflects gain_shift in manual mode
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 13: current_gain tracks gain_shift (manual) ---");

    gain_shift = 4'b0_011;  // amplify x8
    @(posedge clk); @(posedge clk); #1;
    check(current_gain == 4'b0011,
          "T13.1: current_gain = 0x3 (amplify x8)");

    gain_shift = 4'b1_010;  // attenuate /4
    @(posedge clk); @(posedge clk); #1;
    check(current_gain == 4'b1010,
          "T13.2: current_gain = 0xA (attenuate /4)");

    // ---------------------------------------------------------------
    // TEST 14: Peak magnitude tracking
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 14: Peak magnitude tracking ---");

    reset_n = 0;
    repeat (2) @(posedge clk);
    reset_n = 1;
    repeat (2) @(posedge clk);

    gain_shift = 4'b0_000;  // pass-through
    // Send samples with increasing magnitude
    send_sample(16'sd100, 16'sd50);
    send_sample(16'sd1000, 16'sd500);
    send_sample(16'sd8000, 16'sd2000);   // peak = 8000
    send_sample(16'sd200, 16'sd100);
    // Pulse frame_boundary to snapshot
    @(negedge clk); frame_boundary = 1; @(posedge clk); #1;
    @(negedge clk); frame_boundary = 0; @(posedge clk); #1;
    // peak_magnitude = upper 8 bits of 15-bit peak (8000)
    // 8000 = 0x1F40, 15-bit = 0x1F40, [14:7] = 0x3E = 62
    check(peak_magnitude == 8'd62,
          "T14.1: Peak magnitude = 62 (8000 >> 7)");

    // ---------------------------------------------------------------
    // TEST 15: AGC auto gain-down on saturation
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 15: AGC gain-down on saturation ---");

    reset_n = 0;
    repeat (2) @(posedge clk);
    reset_n = 1;
    repeat (2) @(posedge clk);

    // Start with amplify x4 (gain_shift = 0x02), then enable AGC
    gain_shift  = 4'b0_010;  // amplify x4, internal gain = +2
    agc_enable  = 0;
    agc_attack  = 4'd1;
    agc_decay   = 4'd1;
    agc_holdoff = 4'd2;
    agc_target  = 8'd100;
    @(posedge clk); @(posedge clk);

    // Enable AGC — should initialize from gain_shift
    agc_enable = 1;
    @(posedge clk); @(posedge clk); @(posedge clk); #1;
    check(current_gain == 4'b0010,
          "T15.1: AGC initialized from gain_shift (amplify x4)");

    // Send saturating samples (will clip at x4 gain)
    send_sample(16'sd20000, 16'sd20000);
    send_sample(16'sd20000, 16'sd20000);

    // Pulse frame_boundary — AGC should reduce gain by attack=1
    @(negedge clk); frame_boundary = 1; @(posedge clk); #1;
    @(negedge clk); frame_boundary = 0; @(posedge clk); #1;
    // current_gain lags agc_gain by 1 cycle (NBA), wait one extra cycle
    @(posedge clk); #1;
    // Internal gain was +2, attack=1 → new gain = +1 (0x01)
    check(current_gain == 4'b0001,
          "T15.2: AGC reduced gain to x2 after saturation");

    // Another frame with saturation (20000*2 = 40000 > 32767)
    send_sample(16'sd20000, 16'sd20000);
    @(negedge clk); frame_boundary = 1; @(posedge clk); #1;
    @(negedge clk); frame_boundary = 0; @(posedge clk); #1;
    @(posedge clk); #1;
    // gain was +1, attack=1 → new gain = 0 (0x00)
    check(current_gain == 4'b0000,
          "T15.3: AGC reduced gain to x1 (pass-through)");

    // At gain 0 (pass-through), 20000 does NOT overflow 16-bit range,
    // so no saturation occurs. Signal peak = 20000 >> 7 = 156 > target(100),
    // so AGC correctly holds gain at 0. This is expected behavior.
    // To test crossing into attenuation: increase attack to 3.
    agc_attack = 4'd3;
    // Reset and start fresh with gain +2, attack=3
    reset_n = 0;
    repeat (2) @(posedge clk);
    reset_n = 1;
    repeat (2) @(posedge clk);

    gain_shift = 4'b0_010;  // amplify x4, internal gain = +2
    agc_enable = 0;
    @(posedge clk);
    agc_enable = 1;
    @(posedge clk); @(posedge clk); @(posedge clk); #1;

    // Send saturating samples
    send_sample(16'sd20000, 16'sd20000);
    @(negedge clk); frame_boundary = 1; @(posedge clk); #1;
    @(negedge clk); frame_boundary = 0; @(posedge clk); #1;
    @(posedge clk); #1;
    // gain was +2, attack=3 → new gain = -1 → encoding 0x09
    check(current_gain == 4'b1001,
          "T15.4: Large attack step crosses to attenuation (gain +2 - 3 = -1 → 0x9)");

    // ---------------------------------------------------------------
    // TEST 16: AGC auto gain-up after holdoff
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 16: AGC gain-up after holdoff ---");

    reset_n = 0;
    repeat (2) @(posedge clk);
    reset_n = 1;
    repeat (2) @(posedge clk);

    // Start with low gain, weak signal, holdoff=2
    gain_shift  = 4'b0_000;  // pass-through (internal gain = 0)
    agc_enable  = 0;
    agc_attack  = 4'd1;
    agc_decay   = 4'd1;
    agc_holdoff = 4'd2;
    agc_target  = 8'd100;  // target peak = 100 (in upper 8 bits = 12800 raw)
    @(posedge clk); @(posedge clk);

    agc_enable = 1;
    @(posedge clk); @(posedge clk); #1;

    // Frame 1: send weak signal (peak < target), holdoff counter = 2
    send_sample(16'sd100, 16'sd50);  // peak=100, [14:7]=0 (very weak)
    @(negedge clk); frame_boundary = 1; @(posedge clk); #1;
    @(negedge clk); frame_boundary = 0; @(posedge clk); #1;
    @(posedge clk); #1;
    check(current_gain == 4'b0000,
          "T16.1: Gain held during holdoff (frame 1, holdoff=2)");

    // Frame 2: still weak, holdoff counter decrements to 1
    send_sample(16'sd100, 16'sd50);
    @(negedge clk); frame_boundary = 1; @(posedge clk); #1;
    @(negedge clk); frame_boundary = 0; @(posedge clk); #1;
    @(posedge clk); #1;
    check(current_gain == 4'b0000,
          "T16.2: Gain held during holdoff (frame 2, holdoff=1)");

    // Frame 3: holdoff expired (was 0 at start of frame) → gain up
    send_sample(16'sd100, 16'sd50);
    @(negedge clk); frame_boundary = 1; @(posedge clk); #1;
    @(negedge clk); frame_boundary = 0; @(posedge clk); #1;
    @(posedge clk); #1;
    check(current_gain == 4'b0001,
          "T16.3: Gain increased after holdoff expired (gain 0->1)");

    // ---------------------------------------------------------------
    // TEST 17: Repeated attacks drive gain negative, clamp at -7,
    //          then decay recovers
    // ---------------------------------------------------------------
    $display("");
    $display("--- Test 17: Repeated attack → negative clamp → decay recovery ---");

    // ----- 17a: Walk gain from +7 down through zero via repeated attack -----
    reset_n = 0;
    repeat (2) @(posedge clk);
    reset_n = 1;
    repeat (2) @(posedge clk);

    gain_shift  = 4'b0_111;  // amplify x128, internal gain = +7
    agc_enable  = 0;
    agc_attack  = 4'd2;
    agc_decay   = 4'd1;
    agc_holdoff = 4'd2;
    agc_target  = 8'd100;
    @(posedge clk);
    agc_enable = 1;
    @(posedge clk); @(posedge clk); @(posedge clk); #1;
    check(current_gain == 4'b0_111,
          "T17a.1: AGC initialized at gain +7 (0x7)");

    // Frame 1: saturating at gain +7 → gain 7-2=5
    send_sample(16'sd1000, 16'sd1000);  // 1000<<7 = 128000 → overflow
    @(negedge clk); frame_boundary = 1; @(posedge clk); #1;
    @(negedge clk); frame_boundary = 0; @(posedge clk); #1;
    @(posedge clk); #1;
    check(current_gain == 4'b0_101,
          "T17a.2: After attack: gain +5 (0x5)");

    // Frame 2: still saturating at gain +5 → gain 5-2=3
    send_sample(16'sd1000, 16'sd1000);  // 1000<<5 = 32000 → no overflow
    send_sample(16'sd2000, 16'sd2000);  // 2000<<5 = 64000 → overflow
    @(negedge clk); frame_boundary = 1; @(posedge clk); #1;
    @(negedge clk); frame_boundary = 0; @(posedge clk); #1;
    @(posedge clk); #1;
    check(current_gain == 4'b0_011,
          "T17a.3: After attack: gain +3 (0x3)");

    // Frame 3: saturating at gain +3 → gain 3-2=1
    send_sample(16'sd5000, 16'sd5000);  // 5000<<3 = 40000 → overflow
    @(negedge clk); frame_boundary = 1; @(posedge clk); #1;
    @(negedge clk); frame_boundary = 0; @(posedge clk); #1;
    @(posedge clk); #1;
    check(current_gain == 4'b0_001,
          "T17a.4: After attack: gain +1 (0x1)");

    // Frame 4: saturating at gain +1 → gain 1-2=-1 → encoding 0x9
    send_sample(16'sd20000, 16'sd20000); // 20000<<1 = 40000 → overflow
    @(negedge clk); frame_boundary = 1; @(posedge clk); #1;
    @(negedge clk); frame_boundary = 0; @(posedge clk); #1;
    @(posedge clk); #1;
    check(current_gain == 4'b1_001,
          "T17a.5: Attack crossed zero: gain -1 (0x9)");

    // Frame 5: at gain -1 (right shift 1), 20000>>>1=10000, NO overflow.
    // peak = 20000 → [14:7]=156 > target(100) → HOLD, gain stays -1
    send_sample(16'sd20000, 16'sd20000);
    @(negedge clk); frame_boundary = 1; @(posedge clk); #1;
    @(negedge clk); frame_boundary = 0; @(posedge clk); #1;
    @(posedge clk); #1;
    check(current_gain == 4'b1_001,
          "T17a.6: No overflow at -1, peak>target → HOLD, gain stays -1");

    // ----- 17b: Max attack step clamps at -7 -----
    $display("");
    $display("--- Test 17b: Max attack clamps at -7 ---");

    reset_n = 0;
    repeat (2) @(posedge clk);
    reset_n = 1;
    repeat (2) @(posedge clk);

    gain_shift  = 4'b0_011;  // amplify x8, internal gain = +3
    agc_attack  = 4'd15;     // max attack step
    agc_enable  = 0;
    @(posedge clk);
    agc_enable = 1;
    @(posedge clk); @(posedge clk); @(posedge clk); #1;
    check(current_gain == 4'b0_011,
          "T17b.1: Initialized at gain +3");

    // One saturating frame: gain = clamp(3 - 15) = clamp(-12) = -7 → 0xF
    send_sample(16'sd5000, 16'sd5000);  // 5000<<3 = 40000 → overflow
    @(negedge clk); frame_boundary = 1; @(posedge clk); #1;
    @(negedge clk); frame_boundary = 0; @(posedge clk); #1;
    @(posedge clk); #1;
    check(current_gain == 4'b1_111,
          "T17b.2: Gain clamped at -7 (0xF) after max attack");

    // Another frame at gain -7: 5000>>>7 = 39, peak = 5000→[14:7]=39 < target(100)
    // → decay path, but holdoff counter was reset to 2 by the attack above
    send_sample(16'sd5000, 16'sd5000);
    @(negedge clk); frame_boundary = 1; @(posedge clk); #1;
    @(negedge clk); frame_boundary = 0; @(posedge clk); #1;
    @(posedge clk); #1;
    check(current_gain == 4'b1_111,
          "T17b.3: Gain still -7 (holdoff active, 2→1)");

    // ----- 17c: Decay recovery from -7 after holdoff -----
    $display("");
    $display("--- Test 17c: Decay recovery from deep negative ---");

    // Holdoff was 2. After attack (frame above), holdoff=2.
    // Frame after 17b.3: holdoff decrements to 0
    send_sample(16'sd5000, 16'sd5000);
    @(negedge clk); frame_boundary = 1; @(posedge clk); #1;
    @(negedge clk); frame_boundary = 0; @(posedge clk); #1;
    @(posedge clk); #1;
    check(current_gain == 4'b1_111,
          "T17c.1: Gain still -7 (holdoff 1→0)");

    // Now holdoff=0, next weak frame should trigger decay: -7 + 1 = -6 → 0xE
    send_sample(16'sd5000, 16'sd5000);
    @(negedge clk); frame_boundary = 1; @(posedge clk); #1;
    @(negedge clk); frame_boundary = 0; @(posedge clk); #1;
    @(posedge clk); #1;
    check(current_gain == 4'b1_110,
          "T17c.2: Decay from -7 to -6 (0xE) after holdoff expired");

    // One more decay: -6 + 1 = -5 → 0xD
    send_sample(16'sd5000, 16'sd5000);
    @(negedge clk); frame_boundary = 1; @(posedge clk); #1;
    @(negedge clk); frame_boundary = 0; @(posedge clk); #1;
    @(posedge clk); #1;
    check(current_gain == 4'b1_101,
          "T17c.3: Decay from -6 to -5 (0xD)");

    // Verify output is actually attenuated: at gain -5 (right shift 5),
    // 5000 >>> 5 = 156
    send_sample(16'sd5000, 16'sd0);
    check(data_i_out == 16'sd156,
          "T17c.4: Output correctly attenuated: 5000>>>5 = 156");

    // =================================================================
    // Test 18: valid_in + frame_boundary on the SAME cycle
    // Verify the coincident sample is included in the frame snapshot
    // (Bug #7 fix — previously lost due to NBA last-write-wins)
    // =================================================================
    $display("");
    $display("--- Test 18: valid_in + frame_boundary simultaneous ---");

    // ----- 18a: Coincident saturating sample included in sat count -----
    reset_n = 0;
    repeat (2) @(posedge clk);
    reset_n = 1;
    repeat (2) @(posedge clk);

    gain_shift  = 4'b0_011;  // amplify x8 (shift left 3)
    agc_attack  = 4'd1;
    agc_decay   = 4'd1;
    agc_holdoff = 4'd2;
    agc_target  = 8'd100;
    agc_enable  = 1;
    @(posedge clk); @(posedge clk); @(posedge clk); #1;

    // Send one normal sample first (establishes a non-zero frame)
    send_sample(16'sd100, 16'sd100);  // small, no overflow at gain +3

    // Now: assert valid_in AND frame_boundary on the SAME posedge.
    // The sample is large enough to overflow at gain +3: 5000<<3 = 40000 > 32767
    @(negedge clk);
    data_i_in      = 16'sd5000;
    data_q_in      = 16'sd5000;
    valid_in       = 1'b1;
    frame_boundary = 1'b1;
    @(posedge clk); #1;  // DUT samples both signals
    @(negedge clk);
    valid_in       = 1'b0;
    frame_boundary = 1'b0;
    @(posedge clk); #1;  // let NBA settle
    @(posedge clk); #1;

    // Saturation count should be 1 (the coincident sample overflowed)
    check(saturation_count == 8'd1,
          "T18a.1: Coincident saturating sample counted in snapshot (sat_count=1)");

    // Peak should reflect pre-gain max(|5000|,|5000|) = 5000 → [14:7] = 39
    // (or at least >= the first sample's peak of 100→[14:7]=0)
    check(peak_magnitude == 8'd39,
          "T18a.2: Coincident sample peak included in snapshot (peak=39)");

    // AGC should have attacked (sat > 0): gain +3 → +3-1 = +2
    check(current_gain == 4'b0_010,
          "T18a.3: AGC attacked on coincident saturation (gain +3 → +2)");

    // ----- 18b: Coincident non-saturating peak updates snapshot -----
    $display("");
    $display("--- Test 18b: Coincident peak-only sample ---");

    reset_n = 0;
    agc_enable  = 0;  // deassert so transition fires with NEW gain_shift
    repeat (2) @(posedge clk);
    reset_n = 1;
    repeat (2) @(posedge clk);

    gain_shift  = 4'b0_000;  // no amplification (shift 0)
    agc_attack  = 4'd1;
    agc_decay   = 4'd1;
    agc_holdoff = 4'd0;
    agc_target  = 8'd200;    // high target so signal is "weak"
    agc_enable  = 1;
    @(posedge clk); @(posedge clk); @(posedge clk); #1;

    // Send a small sample
    send_sample(16'sd50, 16'sd50);

    // Coincident frame_boundary + valid_in with a LARGER sample (not saturating)
    @(negedge clk);
    data_i_in      = 16'sd10000;
    data_q_in      = 16'sd10000;
    valid_in       = 1'b1;
    frame_boundary = 1'b1;
    @(posedge clk); #1;
    @(negedge clk);
    valid_in       = 1'b0;
    frame_boundary = 1'b0;
    @(posedge clk); #1;
    @(posedge clk); #1;

    // Peak should be max(|10000|,|10000|) = 10000 → [14:7] = 78
    check(peak_magnitude == 8'd78,
          "T18b.1: Coincident larger peak included (peak=78)");
    // No saturation at gain 0
    check(saturation_count == 8'd0,
          "T18b.2: No saturation (gain=0, no overflow)");

    // =================================================================
    // Test 19: AGC enable toggle mid-frame
    // Verify gain initializes from gain_shift and holdoff resets
    // =================================================================
    $display("");
    $display("--- Test 19: AGC enable toggle mid-frame ---");

    // ----- 19a: Enable AGC mid-frame, verify gain init -----
    reset_n = 0;
    repeat (2) @(posedge clk);
    reset_n = 1;
    repeat (2) @(posedge clk);

    gain_shift  = 4'b0_101;  // amplify x32 (shift left 5), internal = +5
    agc_attack  = 4'd2;
    agc_decay   = 4'd1;
    agc_holdoff = 4'd3;
    agc_target  = 8'd100;
    agc_enable  = 0;         // start disabled
    @(posedge clk); #1;

    // With AGC off, current_gain should follow gain_shift directly
    check(current_gain == 4'b0_101,
          "T19a.1: AGC disabled → current_gain = gain_shift (0x5)");

    // Send a few samples (building up frame metrics)
    send_sample(16'sd1000, 16'sd1000);
    send_sample(16'sd2000, 16'sd2000);

    // Toggle AGC enable ON mid-frame
    @(negedge clk);
    agc_enable = 1;
    @(posedge clk); #1;
    @(posedge clk); #1;  // let enable transition register

    // Gain should initialize from gain_shift encoding (0b0_101 → +5)
    check(current_gain == 4'b0_101,
          "T19a.2: AGC enabled mid-frame → gain initialized from gain_shift (+5)");

    // Send a saturating sample, then boundary
    send_sample(16'sd5000, 16'sd5000);  // 5000<<5 overflows
    @(negedge clk); frame_boundary = 1; @(posedge clk); #1;
    @(negedge clk); frame_boundary = 0; @(posedge clk); #1;
    @(posedge clk); #1;

    // AGC should attack: gain +5 → +5-2 = +3
    check(current_gain == 4'b0_011,
          "T19a.3: After boundary, AGC attacked (gain +5 → +3)");

    // ----- 19b: Disable AGC mid-frame, verify passthrough -----
    $display("");
    $display("--- Test 19b: Disable AGC mid-frame ---");

    // Change gain_shift to a new value
    @(negedge clk);
    gain_shift = 4'b1_010;  // attenuate by 2 (right shift 2)
    agc_enable = 0;
    @(posedge clk); #1;
    @(posedge clk); #1;

    // With AGC off, current_gain should follow gain_shift
    check(current_gain == 4'b1_010,
          "T19b.1: AGC disabled → current_gain = gain_shift (0xA, atten 2)");

    // Send sample: 1000 >> 2 = 250
    send_sample(16'sd1000, 16'sd0);
    check(data_i_out == 16'sd250,
          "T19b.2: Output uses host gain_shift when AGC off: 1000>>2=250");

    // ----- 19c: Re-enable, verify gain re-initializes -----
    @(negedge clk);
    gain_shift = 4'b0_010;  // amplify by 4 (shift left 2), internal = +2
    agc_enable = 1;
    @(posedge clk); #1;
    @(posedge clk); #1;

    check(current_gain == 4'b0_010,
          "T19c.1: AGC re-enabled → gain re-initialized from gain_shift (+2)");

    // ---------------------------------------------------------------
    // SUMMARY
    // ---------------------------------------------------------------
    $display("");
    $display("=== RX Gain Control: %0d passed, %0d failed ===",
             pass_count, fail_count);

    if (fail_count > 0)
        $display("[FAIL] RX gain control test FAILED");
    else
        $display("[PASS] All RX gain control tests passed");

    $finish;
end

endmodule
