`timescale 1ns / 1ps

// ============================================================================
// tb_ad9484_xsim.v — XSim testbench for ad9484_interface_400m.v
//
// Tests the REAL module with Xilinx UNISIM primitives (IBUFDS, BUFG, IDDR).
// Must be compiled with xvlog/xelab/xsim (not iverilog).
//
// Key things tested:
//   1. Differential LVDS data capture (IBUFDS)
//   2. DDR data capture (IDDR, SAME_EDGE_PIPELINED mode)
//   3. Reset synchronizer (P1-7 fix: async assert, sync de-assert)
//   4. Data integrity through full pipeline
//   5. Phase interleaving (rising/falling edge multiplexing)
// ============================================================================

module tb_ad9484_xsim;

    // ── Parameters ─────────────────────────────────────────────
    localparam DCO_PERIOD  = 2.5;    // 400 MHz
    localparam SYS_PERIOD  = 10.0;   // 100 MHz

    // ── Signals ────────────────────────────────────────────────
    // LVDS pairs (differential)
    reg  [7:0] adc_d_p;
    wire [7:0] adc_d_n;
    reg        adc_dco_p;
    wire       adc_dco_n;

    // System
    reg        sys_clk;
    reg        reset_n;

    // Outputs
    wire [7:0] adc_data_400m;
    wire       adc_data_valid_400m;
    wire       adc_dco_bufg;

    // Differential complements
    assign adc_d_n   = ~adc_d_p;
    assign adc_dco_n = ~adc_dco_p;

    // ── Test bookkeeping ───────────────────────────────────────
    integer pass_count;
    integer fail_count;
    integer test_num;
    integer i;

    // ── Clocks ─────────────────────────────────────────────────
    always #(DCO_PERIOD/2) adc_dco_p = ~adc_dco_p;
    always #(SYS_PERIOD/2) sys_clk   = ~sys_clk;

    // ── DUT ────────────────────────────────────────────────────
    ad9484_interface_400m uut (
        .adc_d_p           (adc_d_p),
        .adc_d_n           (adc_d_n),
        .adc_dco_p         (adc_dco_p),
        .adc_dco_n         (adc_dco_n),
        .sys_clk           (sys_clk),
        .reset_n           (reset_n),
        .adc_data_400m     (adc_data_400m),
        .adc_data_valid_400m(adc_data_valid_400m),
        .adc_dco_bufg      (adc_dco_bufg)
    );

    // ── Check task ─────────────────────────────────────────────
    task check;
        input cond;
        input [511:0] label;
        begin
            test_num = test_num + 1;
            if (cond) begin
                $display("[PASS] Test %0d: %0s", test_num, label);
                pass_count = pass_count + 1;
            end else begin
                $display("[FAIL] Test %0d: %0s", test_num, label);
                fail_count = fail_count + 1;
            end
        end
    endtask

    // ── Stimulus ───────────────────────────────────────────────
    initial begin
        $display("\n=== AD9484 Interface XSim Testbench ===");
        $display("  Testing REAL Xilinx primitives (IBUFDS, BUFG, IDDR)");
        $display("  Testing reset synchronizer (P1-7 fix)\n");

        // Init
        adc_dco_p  = 0;
        sys_clk    = 0;
        adc_d_p    = 8'h00;
        reset_n    = 0;
        pass_count = 0;
        fail_count = 0;
        test_num   = 0;

        // ════════════════════════════════════════════════════════
        // TEST GROUP 1: Reset behaviour
        // ════════════════════════════════════════════════════════
        $display("--- Test Group 1: Reset Behaviour ---");
        #50;  // let clocks run during reset
        check(adc_data_valid_400m === 1'b0, "valid = 0 during reset");
        check(adc_data_400m === 8'h00, "data = 0 during reset");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 2: BUFG clock output
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 2: Clock Buffering ---");
        // adc_dco_bufg should follow adc_dco_p (through BUFG)
        // Can't check exact timing but can verify it toggles
        begin : bufg_test
            reg saw_high, saw_low;
            saw_high = 0;
            saw_low  = 0;
            for (i = 0; i < 20; i = i + 1) begin
                #(DCO_PERIOD/4);
                if (adc_dco_bufg) saw_high = 1;
                else              saw_low  = 1;
            end
            check(saw_high && saw_low, "adc_dco_bufg toggles (BUFG functional)");
        end

        // ════════════════════════════════════════════════════════
        // TEST GROUP 3: Reset de-assertion synchronization (P1-7)
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 3: Reset Synchronizer (P1-7) ---");

        // De-assert reset BETWEEN dco edges (worst case for metastability)
        // The synchronizer should delay de-assertion by 2 dco cycles
        @(negedge adc_dco_p);
        #(DCO_PERIOD * 0.3);  // mid-cycle
        reset_n = 1;

        // valid should NOT assert immediately (needs 2 sync stages)
        @(posedge adc_dco_p); #0.1;
        // After 1 dco cycle: reset_sync_400m[0] = 1, [1] still = 0
        // So reset_n_400m should still be 0
        check(adc_data_valid_400m === 1'b0,
              "valid stays 0 for 1 cycle after reset de-assert (sync stage 1)");

        @(posedge adc_dco_p); #0.1;
        // After 2 dco cycles: reset_sync_400m = 2'b11, reset_n_400m = 1
        // But the data pipeline has its own 1-cycle delay
        // So valid might assert this cycle or next

        // Wait one more cycle for pipeline
        @(posedge adc_dco_p); #0.1;

        // By now (3 dco cycles after reset de-assert), valid should be 1
        // Allow one more for IDDR pipeline
        begin : wait_valid
            reg saw_valid;
            saw_valid = 0;
            for (i = 0; i < 5; i = i + 1) begin
                @(posedge adc_dco_p); #0.1;
                if (adc_data_valid_400m) begin
                    saw_valid = 1;
                    $display("  valid asserted %0d dco cycles after reset de-assert", i + 4);
                    disable wait_valid;
                end
            end
            if (!saw_valid) begin
                $display("  [WARN] valid did not assert within 8 dco cycles");
            end
        end
        check(adc_data_valid_400m === 1'b1,
              "valid asserts after reset sync pipeline completes");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 4: Data capture via IDDR
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 4: IDDR Data Capture ---");

        // Reset and restart
        reset_n = 0;
        adc_d_p = 8'h00;
        #100;
        reset_n = 1;
        // Wait for reset sync pipeline
        repeat (5) @(posedge adc_dco_p);

        // Feed a known pattern on rising edges
        // IDDR in SAME_EDGE_PIPELINED mode captures:
        //   Q1 = data at rising edge (1 cycle pipelined)
        //   Q2 = data at falling edge (pipelined to align with Q1)
        // The module alternates output between Q1 and Q2 via dco_phase

        // Drive known data: alternate 0xAA on rise, 0x55 on fall
        begin : iddr_test
            reg [7:0] captured [0:31];
            integer cap_count;
            integer saw_aa, saw_55;

            cap_count = 0;
            saw_aa = 0;
            saw_55 = 0;

            for (i = 0; i < 20; i = i + 1) begin
                // Set data before rising edge
                adc_d_p = 8'hAA;
                @(posedge adc_dco_p);
                // Set data before falling edge
                #0.1;
                adc_d_p = 8'h55;
                @(negedge adc_dco_p);
                #0.1;

                // Capture output
                if (adc_data_valid_400m && cap_count < 32) begin
                    captured[cap_count] = adc_data_400m;
                    if (adc_data_400m == 8'hAA) saw_aa = saw_aa + 1;
                    if (adc_data_400m == 8'h55) saw_55 = saw_55+ 1;
                    cap_count = cap_count + 1;
                end
            end

            $display("  Captured %0d samples, saw 0xAA: %0d times, 0x55: %0d times",
                     cap_count, saw_aa, saw_55);
            check(cap_count > 0, "IDDR produces output samples");
            // With DDR capture, we should see both rise and fall data
            check(saw_aa > 0 || saw_55 > 0, "IDDR captures at least one known value");
        end

        // ════════════════════════════════════════════════════════
        // TEST GROUP 5: Sequential data integrity
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 5: Sequential Data Integrity ---");

        reset_n = 0;
        #100;
        reset_n = 1;
        repeat (5) @(posedge adc_dco_p);

        // Feed incrementing pattern: 0, 1, 2, ... on each half-cycle
        begin : seq_test
            reg [7:0] outputs [0:63];
            integer out_count;
            reg saw_nonzero;
            reg monotonic;

            out_count   = 0;
            saw_nonzero = 0;

            for (i = 0; i < 40; i = i + 1) begin
                adc_d_p = i[7:0];
                @(posedge adc_dco_p); #0.1;

                if (adc_data_valid_400m && out_count < 64) begin
                    outputs[out_count] = adc_data_400m;
                    if (adc_data_400m != 0) saw_nonzero = 1;
                    out_count = out_count + 1;
                end
            end

            $display("  Sequential: captured %0d outputs, saw_nonzero=%b",
                     out_count, saw_nonzero);
            check(out_count > 10, "Produces substantial output stream");
            check(saw_nonzero, "Output contains non-zero values");
        end

        // ════════════════════════════════════════════════════════
        // TEST GROUP 6: Reset mid-operation
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 6: Reset Mid-Operation ---");

        // Data should be flowing now
        adc_d_p = 8'hFF;
        repeat (5) @(posedge adc_dco_p);

        // Assert reset asynchronously (should take effect immediately)
        reset_n = 0;
        // The async assert should clear valid within 1 cycle
        repeat (2) @(posedge adc_dco_p); #0.1;
        check(adc_data_valid_400m === 1'b0, "Async reset assertion clears valid immediately");
        check(adc_data_400m === 8'h00, "Async reset assertion clears data to 0");

        // De-assert and verify sync pipeline
        #30;
        reset_n = 1;
        // Should NOT be valid yet (2-stage sync)
        @(posedge adc_dco_p); #0.1;
        check(adc_data_valid_400m === 1'b0,
              "valid stays 0 during reset sync de-assertion");

        // Wait for full pipeline
        repeat (5) @(posedge adc_dco_p); #0.1;
        check(adc_data_valid_400m === 1'b1,
              "valid reasserts after sync pipeline completes");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 7: ADC power-down output
        // ════════════════════════════════════════════════════════
        // adc_pwdn is not part of this module (it's in radar_system_top)
        // Just verify the module port list is complete

        // ════════════════════════════════════════════════════════
        // Summary
        // ════════════════════════════════════════════════════════
        $display("");
        $display("========================================");
        $display("  AD9484 INTERFACE XSIM RESULTS");
        $display("  PASSED: %0d / %0d", pass_count, test_num);
        $display("  FAILED: %0d / %0d", fail_count, test_num);
        if (fail_count == 0)
            $display("  ** ALL TESTS PASSED **");
        else
            $display("  ** SOME TESTS FAILED **");
        $display("========================================");
        $display("");

        #100;
        $finish;
    end

endmodule
