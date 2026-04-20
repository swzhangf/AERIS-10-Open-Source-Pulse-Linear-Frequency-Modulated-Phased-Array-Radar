`timescale 1ns / 1ps

module tb_cic_decimator;

    // ── Parameters ─────────────────────────────────────────────
    localparam CLK_PERIOD = 2.5;  // 400 MHz

    // ── Signals ────────────────────────────────────────────────
    reg         clk;
    reg         reset_n;
    reg  signed [17:0] data_in;
    reg         data_valid;
    wire signed [17:0] data_out;
    wire        data_out_valid;
    wire        saturation_detected;
    wire [7:0]  max_value_monitor;
    reg         reset_monitors;

    // ── Test variables ─────────────────────────────────────────
    integer pass_count;
    integer fail_count;
    integer test_num;
    integer csv_file;
    integer sample_count;
    integer output_count;
    integer i;

    reg signed [17:0] out_max, out_min;
    reg signed [17:0] last_output;
    reg        saw_output;

    // ── Clock ──────────────────────────────────────────────────
    always #(CLK_PERIOD/2) clk = ~clk;

    // ── DUT ────────────────────────────────────────────────────
    cic_decimator_4x_enhanced uut (
        .clk               (clk),
        .reset_n            (reset_n),
        .data_in            (data_in),
        .data_valid         (data_valid),
        .data_out           (data_out),
        .data_out_valid     (data_out_valid),
        .saturation_detected(saturation_detected),
        .max_value_monitor  (max_value_monitor),
        .reset_monitors     (reset_monitors)
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
        $dumpfile("tb_cic_decimator.vcd");
        $dumpvars(0, tb_cic_decimator);

        // Init
        clk            = 0;
        reset_n        = 0;
        data_in        = 0;
        data_valid     = 0;
        reset_monitors = 0;
        pass_count     = 0;
        fail_count     = 0;
        test_num       = 0;
        saw_output     = 0;

        // ════════════════════════════════════════════════════════
        // TEST GROUP 1: Reset behaviour
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 1: Reset Behaviour ---");
        repeat (4) @(posedge clk);
        #1;
        check(data_out === 18'sd0,     "data_out = 0 during reset");
        check(data_out_valid === 1'b0, "data_out_valid = 0 during reset");

        // Release reset
        reset_n = 1;
        @(posedge clk); #1;
        check(data_out_valid === 1'b0, "No output without data_valid");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 2: DC input (constant value)
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 2: DC Input Response ---");
        reset_n = 0;
        repeat (4) @(posedge clk);
        reset_n = 1;
        @(posedge clk);

        // Feed DC = 1000 for many cycles
        // CIC is lowpass, so DC should pass through
        // After CIC gain normalization (>>>10), output ≈ input for DC
        data_in = 18'sd1000;
        data_valid = 1;

        csv_file = $fopen("cic_dc_output.csv", "w");
        $fwrite(csv_file, "input_sample,output_sample,data_out,data_out_valid\n");

        output_count = 0;
        out_max = -18'sh1FFFF;
        out_min =  18'sh1FFFF;

        for (sample_count = 0; sample_count < 200; sample_count = sample_count + 1) begin
            @(posedge clk); #1;
            if (data_out_valid) begin
                $fwrite(csv_file, "%0d,%0d,%0d,1\n", sample_count, output_count, data_out);
                output_count = output_count + 1;
                last_output = data_out;
                if (data_out > out_max) out_max = data_out;
                if (data_out < out_min) out_min = data_out;
            end
        end
        $fclose(csv_file);

        $display("  DC=1000: output_count=%0d, range=[%0d, %0d], last=%0d",
                 output_count, out_min, out_max, last_output);

        // With 4x decimation from 200 input samples, expect ~50 outputs
        // (minus pipeline startup delay)
        check(output_count > 30, "Produced decimated outputs (>30)");
        // DC should produce non-zero output after settling
        check(last_output != 0, "Non-zero output for DC input");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 3: Decimation ratio verification
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 3: Decimation Ratio ---");
        reset_n = 0;
        data_valid = 0;
        repeat (4) @(posedge clk);
        reset_n = 1;
        @(posedge clk);

        data_in = 18'sd500;
        data_valid = 1;

        // Count input and output samples precisely
        output_count = 0;
        for (sample_count = 0; sample_count < 400; sample_count = sample_count + 1) begin
            @(posedge clk); #1;
            if (data_out_valid) begin
                output_count = output_count + 1;
            end
        end

        $display("  400 inputs → %0d outputs (expected ~100)", output_count);
        // Allow some tolerance for pipeline startup
        check(output_count >= 90 && output_count <= 105,
              "Decimation ratio ≈ 4:1");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 4: Impulse response
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 4: Impulse Response ---");
        reset_n = 0;
        data_valid = 0;
        repeat (4) @(posedge clk);
        reset_n = 1;
        @(posedge clk);

        // Single impulse followed by zeros
        data_in = 18'sd10000;
        data_valid = 1;
        @(posedge clk);
        data_in = 18'sd0;

        csv_file = $fopen("cic_impulse_output.csv", "w");
        $fwrite(csv_file, "sample,data_out\n");

        output_count = 0;
        saw_output = 0;
        for (sample_count = 0; sample_count < 100; sample_count = sample_count + 1) begin
            @(posedge clk); #1;
            if (data_out_valid) begin
                $fwrite(csv_file, "%0d,%0d\n", output_count, data_out);
                if (data_out != 0) saw_output = 1;
                output_count = output_count + 1;
            end
        end
        $fclose(csv_file);

        check(saw_output, "Impulse produces non-zero output");
        check(output_count > 0, "Impulse produces decimated outputs");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 5: Low-frequency sinusoid (passband)
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 5: Low-Frequency Sinusoid (Passband) ---");
        reset_n = 0;
        data_valid = 0;
        repeat (4) @(posedge clk);
        reset_n = 1;
        @(posedge clk);

        // Generate sinusoid at ~1 MHz (well within passband for 100 MHz output rate)
        // sin(2*pi*1e6/400e6 * n) = sin(2*pi*n/400)
        // At 400 MSPS, 1 MHz → period = 400 samples
        // Approximate with integer math: amplitude 5000
        data_valid = 1;

        csv_file = $fopen("cic_sine_passband.csv", "w");
        $fwrite(csv_file, "input_n,data_in,output_n,data_out\n");

        out_max = -18'sh1FFFF;
        out_min =  18'sh1FFFF;
        output_count = 0;

        for (sample_count = 0; sample_count < 1600; sample_count = sample_count + 1) begin
            // Simple sinusoid: 5000 * sin(2*pi*n/400)
            // Use quadrant-based approximation: triangular wave as proxy
            // (exact sine needs real/system function which Icarus supports)
            // phase = (sample_count % 400) out of 400
            // Use $sin if available — Icarus supports $rtoi/$itor
            data_in = $rtoi(5000.0 * $sin(6.2831853 * sample_count / 400.0));
            @(posedge clk); #1;
            if (data_out_valid) begin
                $fwrite(csv_file, "%0d,%0d,%0d,%0d\n",
                        sample_count, data_in, output_count, data_out);
                if (data_out > out_max) out_max = data_out;
                if (data_out < out_min) out_min = data_out;
                output_count = output_count + 1;
            end
        end
        $fclose(csv_file);

        $display("  1 MHz sine: output range [%0d, %0d], %0d outputs",
                 out_min, out_max, output_count);

        // Passband signal should appear at output with reasonable amplitude
        check(out_max > 100, "Passband sine has positive output");
        check(out_min < -100, "Passband sine has negative output");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 6: High-frequency sinusoid (stopband)
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 6: High-Frequency Sinusoid (Stopband) ---");
        reset_n = 0;
        data_valid = 0;
        repeat (4) @(posedge clk);
        reset_n = 1;
        @(posedge clk);

        // 180 MHz — well above Nyquist of decimated output (50 MHz)
        // Should be heavily attenuated by CIC
        data_valid = 1;

        out_max = -18'sh1FFFF;
        out_min =  18'sh1FFFF;
        output_count = 0;

        // Need enough samples for CIC to settle
        for (sample_count = 0; sample_count < 1600; sample_count = sample_count + 1) begin
            data_in = $rtoi(5000.0 * $sin(6.2831853 * sample_count * 180.0 / 400.0));
            @(posedge clk); #1;
            if (data_out_valid) begin
                // Only look at settled output (skip first 20)
                if (output_count > 20) begin
                    if (data_out > out_max) out_max = data_out;
                    if (data_out < out_min) out_min = data_out;
                end
                output_count = output_count + 1;
            end
        end

        $display("  180 MHz sine: output range [%0d, %0d] (settled)",
                 out_min, out_max);

        // Stopband attenuation: output amplitude should be much smaller
        // than passband (< 25% of input amplitude)
        check(out_max < 2000, "Stopband sine attenuated (max < 2000)");
        check(out_min > -2000, "Stopband sine attenuated (min > -2000)");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 7: Saturation detection with large input
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 7: Saturation Detection ---");
        reset_n = 0;
        data_valid = 0;
        reset_monitors = 1;
        repeat (4) @(posedge clk);
        reset_monitors = 0;
        reset_n = 1;
        @(posedge clk);

        // Feed maximum positive value continuously — should eventually saturate integrators
        data_in = 18'sd131071;  // max 18-bit signed
        data_valid = 1;

        for (sample_count = 0; sample_count < 500; sample_count = sample_count + 1) begin
            @(posedge clk);
        end
        #1;

        $display("  saturation_detected = %b, max_value_monitor = %0d",
                 saturation_detected, max_value_monitor);

        // With max input, the integrators should saturate
        check(saturation_detected === 1'b1 || max_value_monitor > 0,
              "Saturation or max value detected with max input");

        // Test monitor reset
        reset_monitors = 1;
        @(posedge clk); #1;
        reset_monitors = 0;
        @(posedge clk); #1;

        // ════════════════════════════════════════════════════════
        // TEST GROUP 8: data_valid gating
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 8: data_valid Gating ---");
        reset_n = 0;
        data_valid = 0;
        repeat (4) @(posedge clk);
        reset_n = 1;
        @(posedge clk);

        data_in = 18'sd1000;
        data_valid = 0;

        // With data_valid=0, no outputs should appear
        output_count = 0;
        for (sample_count = 0; sample_count < 50; sample_count = sample_count + 1) begin
            @(posedge clk); #1;
            if (data_out_valid) output_count = output_count + 1;
        end
        check(output_count == 0, "No output when data_valid=0");

        // ════════════════════════════════════════════════════════
        // Summary
        // ════════════════════════════════════════════════════════
        $display("");
        $display("========================================");
        $display("  CIC DECIMATOR TESTBENCH RESULTS");
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
