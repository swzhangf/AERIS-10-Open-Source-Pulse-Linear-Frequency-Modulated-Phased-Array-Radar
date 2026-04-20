`timescale 1ns / 1ps

module tb_ddc_400m;

    // ── Clock parameters ───────────────────────────────────────
    localparam CLK_400M_PERIOD = 2.5;   // 400 MHz
    localparam CLK_100M_PERIOD = 10.0;  // 100 MHz

    // ── Signals ────────────────────────────────────────────────
    reg         clk_400m;
    reg         clk_100m;
    reg         reset_n;
    reg         mixers_enable;
    reg  [7:0]  adc_data;
    reg         adc_data_valid_i;
    reg         adc_data_valid_q;
    wire signed [17:0] baseband_i;
    wire signed [17:0] baseband_q;
    wire        baseband_valid_i;
    wire        baseband_valid_q;
    wire [1:0]  ddc_status;
    wire [7:0]  ddc_diagnostics;
    wire        mixer_saturation;
    wire        filter_overflow;
    reg  [1:0]  test_mode;
    reg  [15:0] test_phase_inc;
    reg         force_saturation;
    reg         reset_monitors;
    wire [31:0] debug_sample_count;
    wire [17:0] debug_internal_i;
    wire [17:0] debug_internal_q;

    // ── Test variables ─────────────────────────────────────────
    integer pass_count;
    integer fail_count;
    integer test_num;
    integer csv_file;
    integer sample_count;
    integer output_count;

    reg signed [17:0] bb_i_max, bb_i_min, bb_q_max, bb_q_min;

    // ── Clocks ─────────────────────────────────────────────────
    always #(CLK_400M_PERIOD/2) clk_400m = ~clk_400m;
    always #(CLK_100M_PERIOD/2) clk_100m = ~clk_100m;

    // ── DUT ────────────────────────────────────────────────────
    ddc_400m_enhanced uut (
        .clk_400m          (clk_400m),
        .clk_100m          (clk_100m),
        .reset_n           (reset_n),
        .mixers_enable     (mixers_enable),
        .adc_data          (adc_data),
        .adc_data_valid_i  (adc_data_valid_i),
        .adc_data_valid_q  (adc_data_valid_q),
        .baseband_i        (baseband_i),
        .baseband_q        (baseband_q),
        .baseband_valid_i  (baseband_valid_i),
        .baseband_valid_q  (baseband_valid_q),
        .ddc_status        (ddc_status),
        .ddc_diagnostics   (ddc_diagnostics),
        .mixer_saturation  (mixer_saturation),
        .filter_overflow   (filter_overflow),
        .test_mode         (test_mode),
        .test_phase_inc    (test_phase_inc),
        .force_saturation  (force_saturation),
        .reset_monitors    (reset_monitors),
        .debug_sample_count(debug_sample_count),
        .debug_internal_i  (debug_internal_i),
        .debug_internal_q  (debug_internal_q)
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
        $dumpfile("tb_ddc_400m.vcd");
        $dumpvars(0, tb_ddc_400m);

        // Init
        clk_400m         = 0;
        clk_100m         = 0;
        reset_n          = 0;
        mixers_enable    = 0;
        adc_data         = 0;
        adc_data_valid_i = 0;
        adc_data_valid_q = 0;
        test_mode        = 2'b00;
        test_phase_inc   = 0;
        force_saturation = 0;
        reset_monitors   = 0;
        pass_count       = 0;
        fail_count       = 0;
        test_num         = 0;

        // ════════════════════════════════════════════════════════
        // TEST GROUP 1: Reset behaviour
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 1: Reset Behaviour ---");
        repeat (10) @(posedge clk_400m);
        #1;
        check(baseband_i === 18'sd0,      "baseband_i = 0 during reset");
        check(baseband_q === 18'sd0,      "baseband_q = 0 during reset");
        check(baseband_valid_i === 1'b0,  "baseband_valid_i = 0 during reset");

        // Release reset
        reset_n = 1;
        repeat (10) @(posedge clk_400m);
        #1;

        // ════════════════════════════════════════════════════════
        // TEST GROUP 2: Full DDC chain with 120 MHz IF tone
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 2: 120 MHz IF Tone Through DDC ---");
        // Generate a 120 MHz sinusoid as 8-bit ADC data
        // At 400 MSPS: sin(2*pi*120e6/400e6 * n) = sin(0.6*pi*n)
        // 8-bit unsigned: mid=128, amplitude=100

        mixers_enable    = 1;
        adc_data_valid_i = 1;
        adc_data_valid_q = 1;

        csv_file = $fopen("ddc_120mhz_output.csv", "w");
        $fwrite(csv_file, "input_n,adc_data,bb_i,bb_q,bb_valid_i\n");

        output_count = 0;
        bb_i_max = -18'sh1FFFF;
        bb_i_min =  18'sh1FFFF;
        bb_q_max = -18'sh1FFFF;
        bb_q_min =  18'sh1FFFF;

        // Run for 4000 clocks at 400 MHz
        // CIC decimates 4x, CDC adds latency, FIR adds 32 taps
        // Expect first output after ~50+ clocks, then continuous
        for (sample_count = 0; sample_count < 4000; sample_count = sample_count + 1) begin
            // 120 MHz tone in 8-bit unsigned: 128 + 100*sin(2*pi*120/400*n)
            adc_data = 128 + $rtoi(100.0 * $sin(6.2831853 * 120.0 / 400.0 * sample_count));
            @(posedge clk_400m); #1;

            if (baseband_valid_i && baseband_valid_q) begin
                $fwrite(csv_file, "%0d,%0d,%0d,%0d,1\n",
                        sample_count, adc_data, baseband_i, baseband_q);
                output_count = output_count + 1;
                if (output_count > 50) begin  // skip transient
                    if (baseband_i > bb_i_max) bb_i_max = baseband_i;
                    if (baseband_i < bb_i_min) bb_i_min = baseband_i;
                    if (baseband_q > bb_q_max) bb_q_max = baseband_q;
                    if (baseband_q < bb_q_min) bb_q_min = baseband_q;
                end
            end
        end
        $fclose(csv_file);

        $display("  120 MHz IF: %0d baseband outputs", output_count);
        $display("  BB I range: [%0d, %0d]", bb_i_min, bb_i_max);
        $display("  BB Q range: [%0d, %0d]", bb_q_min, bb_q_max);
        $display("  DDC status: %b, diagnostics: %h", ddc_status, ddc_diagnostics);

        check(output_count > 0, "DDC chain produces baseband output");
        check(ddc_status[0] === 1'b1, "NCO ready (ddc_status[0])");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 3: Off-frequency tone (should be attenuated)
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 3: Off-Frequency Tone (150 MHz) ---");
        reset_n = 0;
        mixers_enable = 0;
        adc_data_valid_i = 0;
        adc_data_valid_q = 0;
        repeat (20) @(posedge clk_400m);
        reset_n = 1;
        repeat (10) @(posedge clk_400m);

        mixers_enable    = 1;
        adc_data_valid_i = 1;
        adc_data_valid_q = 1;

        output_count = 0;
        bb_i_max = -18'sh1FFFF;
        bb_i_min =  18'sh1FFFF;

        // 150 MHz tone — 30 MHz away from 120 MHz IF
        // After mixing, this becomes a 30 MHz baseband signal
        // CIC + FIR should pass or attenuate depending on their bandwidth
        for (sample_count = 0; sample_count < 4000; sample_count = sample_count + 1) begin
            adc_data = 128 + $rtoi(100.0 * $sin(6.2831853 * 150.0 / 400.0 * sample_count));
            @(posedge clk_400m); #1;

            if (baseband_valid_i && baseband_valid_q) begin
                output_count = output_count + 1;
                if (output_count > 50) begin
                    if (baseband_i > bb_i_max) bb_i_max = baseband_i;
                    if (baseband_i < bb_i_min) bb_i_min = baseband_i;
                end
            end
        end

        $display("  150 MHz IF: %0d outputs, BB I range [%0d, %0d]",
                 output_count, bb_i_min, bb_i_max);

        check(output_count > 0, "DDC produces output for off-frequency tone");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 4: Debug sample counter
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 4: Debug Counters ---");
        $display("  debug_sample_count = %0d", debug_sample_count);
        check(debug_sample_count > 0, "Sample counter increments");

        // ════════════════════════════════════════════════════════
        // Summary
        // ════════════════════════════════════════════════════════
        $display("");
        $display("========================================");
        $display("  DDC 400M CHAIN TESTBENCH RESULTS");
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
