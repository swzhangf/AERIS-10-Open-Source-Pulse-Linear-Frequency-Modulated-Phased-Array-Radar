`timescale 1ns / 1ps

module tb_edge_detector;

    // ── Clock & Reset ──────────────────────────────────────────
    reg  clk;
    reg  reset_n;
    reg  signal_in;
    wire rising_falling_edge;

    // 400 MHz clock → 2.5 ns period
    localparam CLK_PERIOD = 2.5;

    always #(CLK_PERIOD/2) clk = ~clk;

    // ── DUT ────────────────────────────────────────────────────
    edge_detector_enhanced uut (
        .clk               (clk),
        .reset_n            (reset_n),
        .signal_in          (signal_in),
        .rising_falling_edge(rising_falling_edge)
    );

    // ── Test counters ──────────────────────────────────────────
    integer pass_count = 0;
    integer fail_count = 0;
    integer test_num   = 0;

    task check(input expected, input [255:0] label);
        begin
            test_num = test_num + 1;
            if (rising_falling_edge === expected) begin
                $display("[PASS] Test %0d: %0s  — got %b (expected %b)",
                         test_num, label, rising_falling_edge, expected);
                pass_count = pass_count + 1;
            end else begin
                $display("[FAIL] Test %0d: %0s  — got %b (expected %b)",
                         test_num, label, rising_falling_edge, expected);
                fail_count = fail_count + 1;
            end
        end
    endtask

    // ── Stimulus ───────────────────────────────────────────────
    initial begin
        $dumpfile("tb_edge_detector.vcd");
        $dumpvars(0, tb_edge_detector);

        // Init
        clk       = 0;
        reset_n   = 0;
        signal_in = 0;

        // ── Reset behaviour ────────────────────────────────────
        // Hold reset for 4 clocks
        repeat (4) @(posedge clk);
        #1;
        check(1'b0, "Output low during reset");

        // Release reset
        reset_n = 1;
        @(posedge clk); #1;
        check(1'b0, "Output low after reset release, no edge");

        // ── Rising edge detection ──────────────────────────────
        // Drive signal_in high → edge should appear 2 clocks later
        signal_in = 1;
        @(posedge clk); #1;  // prev = 1, prev2 = 0 → XOR = 1
        check(1'b1, "Rising edge detected (1 clk after transition)");

        @(posedge clk); #1;  // prev = 1, prev2 = 1 → XOR = 0
        check(1'b0, "No edge one cycle after rising edge");

        // ── Steady high ────────────────────────────────────────
        repeat (3) @(posedge clk);
        #1;
        check(1'b0, "No edge during steady high");

        // ── Falling edge detection ─────────────────────────────
        signal_in = 0;
        @(posedge clk); #1;  // prev = 0, prev2 = 1 → XOR = 1
        check(1'b1, "Falling edge detected (1 clk after transition)");

        @(posedge clk); #1;  // prev = 0, prev2 = 0 → XOR = 0
        check(1'b0, "No edge one cycle after falling edge");

        // ── Rapid toggling ─────────────────────────────────────
        // Toggle every clock — edge should fire every cycle
        signal_in = 1;
        @(posedge clk); #1;
        check(1'b1, "Rapid toggle 0→1 edge");

        signal_in = 0;
        @(posedge clk); #1;
        check(1'b1, "Rapid toggle 1→0 edge");

        signal_in = 1;
        @(posedge clk); #1;
        check(1'b1, "Rapid toggle 0→1 edge again");

        // ── Glitch / single-cycle pulse ────────────────────────
        signal_in = 0;
        @(posedge clk); #1;  // falling
        signal_in = 0;
        repeat(3) @(posedge clk);
        #1;
        check(1'b0, "Stable low — no edge");

        // Single cycle pulse — signal_in high for exactly one clock period
        // Must use #1 delay after posedge so prev actually captures the 1
        signal_in = 1;
        @(posedge clk); #1;  // prev captures 1 here, prev2 gets old prev (0)
        // Now: prev=1, prev2=0 → XOR=1 (rising edge)
        check(1'b1, "Single-cycle pulse — rising edge detected");

        signal_in = 0;       // drop signal_in before next posedge
        @(posedge clk); #1;  // prev captures 0, prev2 gets old prev (1)
        // Now: prev=0, prev2=1 → XOR=1 (falling edge)
        check(1'b1, "Single-cycle pulse — falling edge detected");

        @(posedge clk); #1;  // prev=0, prev2=0 → XOR=0
        check(1'b0, "After single-cycle pulse — no edge");

        // ── Reset in mid-operation ─────────────────────────────
        signal_in = 1;
        @(posedge clk); @(posedge clk);  // let signal_in=1 propagate
        // Assert reset asynchronously (between clock edges)
        #1; reset_n = 0;
        #1;  // async reset clears prev and prev2 immediately
        check(1'b0, "Output low during mid-operation reset");

        // Hold reset for a couple of clocks
        @(posedge clk); @(posedge clk);
        // Release reset between clock edges
        #1; reset_n = 1;
        // At the NEXT posedge: prev captures signal_in=1, prev2 captures prev=0
        // So: prev=1, prev2=0 → XOR=1 (looks like a rising edge)
        @(posedge clk); #1;
        check(1'b1, "Edge detected on first clock after reset (registers re-capture)");

        // Next clock: prev=1, prev2=1 → XOR=0
        @(posedge clk); #1;
        check(1'b0, "Settled after reset re-capture");

        // ── Summary ────────────────────────────────────────────
        $display("");
        $display("========================================");
        $display("  EDGE DETECTOR TESTBENCH RESULTS");
        $display("  PASSED: %0d / %0d", pass_count, test_num);
        $display("  FAILED: %0d / %0d", fail_count, test_num);
        if (fail_count == 0)
            $display("  ** ALL TESTS PASSED **");
        else
            $display("  ** SOME TESTS FAILED **");
        $display("========================================");
        $display("");

        #10;
        $finish;
    end

endmodule
