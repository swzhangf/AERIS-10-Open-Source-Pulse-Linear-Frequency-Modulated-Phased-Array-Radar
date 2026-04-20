`timescale 1ns / 1ps

module tb_frequency_matched_filter;

    // ── Parameters ─────────────────────────────────────────────
    localparam CLK_PERIOD = 10.0;  // 100 MHz

    // Q15 constants: 1.0 ≈ 32767 (0x7FFF), -1.0 = -32768 (0x8000)
    localparam signed [15:0] Q15_ONE     = 16'sh7FFF;  // ≈ +0.99997
    localparam signed [15:0] Q15_NEG_ONE = 16'sh8000;  // -1.0
    localparam signed [15:0] Q15_HALF    = 16'sh4000;  // +0.5
    localparam signed [15:0] Q15_ZERO    = 16'sh0000;

    // ── Signals ────────────────────────────────────────────────
    reg         clk;
    reg         reset_n;
    reg  signed [15:0] fft_real_in;
    reg  signed [15:0] fft_imag_in;
    reg         fft_valid_in;
    reg  signed [15:0] ref_chirp_real;
    reg  signed [15:0] ref_chirp_imag;
    wire signed [15:0] filtered_real;
    wire signed [15:0] filtered_imag;
    wire        filtered_valid;
    wire [1:0]  state;

    // ── Test variables ─────────────────────────────────────────
    integer pass_count;
    integer fail_count;
    integer test_num;
    integer csv_file;
    integer sample_count;
    integer output_count;

    reg signed [15:0] captured_real;
    reg signed [15:0] captured_imag;

    // ── Clock ──────────────────────────────────────────────────
    always #(CLK_PERIOD/2) clk = ~clk;

    // ── DUT ────────────────────────────────────────────────────
    frequency_matched_filter uut (
        .clk            (clk),
        .reset_n        (reset_n),
        .fft_real_in    (fft_real_in),
        .fft_imag_in    (fft_imag_in),
        .fft_valid_in   (fft_valid_in),
        .ref_chirp_real (ref_chirp_real),
        .ref_chirp_imag (ref_chirp_imag),
        .filtered_real  (filtered_real),
        .filtered_imag  (filtered_imag),
        .filtered_valid (filtered_valid),
        .state          (state)
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

    // Helper: wait for valid output after asserting inputs
    // 4-stage pipeline: need 4 clocks after input valid for output valid
    task wait_for_output;
        begin
            repeat (5) @(posedge clk);
            #1;
        end
    endtask

    // ── Stimulus ───────────────────────────────────────────────
    initial begin
        $dumpfile("tb_freq_matched_filter.vcd");
        $dumpvars(0, tb_frequency_matched_filter);

        // Init
        clk            = 0;
        reset_n        = 0;
        fft_real_in    = 0;
        fft_imag_in    = 0;
        fft_valid_in   = 0;
        ref_chirp_real = 0;
        ref_chirp_imag = 0;
        pass_count     = 0;
        fail_count     = 0;
        test_num       = 0;

        // ════════════════════════════════════════════════════════
        // TEST GROUP 1: Reset behaviour
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 1: Reset Behaviour ---");
        repeat (4) @(posedge clk);
        #1;
        check(filtered_real === 16'd0,     "filtered_real = 0 during reset");
        check(filtered_imag === 16'd0,     "filtered_imag = 0 during reset");
        check(filtered_valid === 1'b0,     "filtered_valid = 0 during reset");

        // Release reset
        reset_n = 1;
        @(posedge clk); #1;

        // ════════════════════════════════════════════════════════
        // TEST GROUP 2: Identity multiplication
        // (1+0j) * conj(1+0j) = (1+0j) * (1-0j) = 1+0j
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 2: Identity (1+0j) * conj(1+0j) ---");
        reset_n = 0;
        fft_valid_in = 0;
        repeat (4) @(posedge clk);
        reset_n = 1;
        @(posedge clk);

        fft_real_in    = Q15_ONE;   // a = 1.0
        fft_imag_in    = Q15_ZERO;  // b = 0
        ref_chirp_real = Q15_ONE;   // c = 1.0
        ref_chirp_imag = Q15_ZERO;  // d = 0
        fft_valid_in   = 1;
        @(posedge clk);
        fft_valid_in   = 0;

        wait_for_output;
        captured_real = filtered_real;
        captured_imag = filtered_imag;

        $display("  (1+0j)*conj(1+0j): real=%0d, imag=%0d (expect ~32767, 0)",
                 captured_real, captured_imag);
        // ac+bd = 1*1+0*0 = 1, bc-ad = 0*1-1*0 = 0
        // Q15: 32767*32767 = 1073676289, in Q30 → scaled to Q15 = 32767
        // Actually: (32767*32767 + 16384) >> 15 = (1073676289+16384)>>15 = 32767
        check(captured_real > 16'sh7F00, "Real ≈ +1.0 (> 0x7F00)");
        check(captured_imag < 16'sh0100 && captured_imag > -16'sh0100,
              "Imag ≈ 0 (near zero)");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 3: Purely imaginary * conj(purely imaginary)
        // (0+j) * conj(0+j) = (0+j) * (0-j) = j*(-j) = -j^2 = 1
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 3: (0+j) * conj(0+j) = 1 ---");
        reset_n = 0;
        fft_valid_in = 0;
        repeat (4) @(posedge clk);
        reset_n = 1;
        @(posedge clk);

        fft_real_in    = Q15_ZERO;  // a = 0
        fft_imag_in    = Q15_ONE;   // b = 1.0
        ref_chirp_real = Q15_ZERO;  // c = 0
        ref_chirp_imag = Q15_ONE;   // d = 1.0
        fft_valid_in   = 1;
        @(posedge clk);
        fft_valid_in   = 0;

        wait_for_output;
        captured_real = filtered_real;
        captured_imag = filtered_imag;

        $display("  (0+j)*conj(0+j): real=%0d, imag=%0d (expect ~32767, 0)",
                 captured_real, captured_imag);
        // ac+bd = 0+1*1 = 1, bc-ad = 1*0-0*1 = 0
        check(captured_real > 16'sh7F00, "Real ≈ +1.0");
        check(captured_imag < 16'sh0100 && captured_imag > -16'sh0100,
              "Imag ≈ 0");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 4: 90-degree phase shift
        // (1+0j) * conj(0+j) = (1+0j) * (0-j) = -j
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 4: (1+0j) * conj(0+j) = -j ---");
        reset_n = 0;
        fft_valid_in = 0;
        repeat (4) @(posedge clk);
        reset_n = 1;
        @(posedge clk);

        fft_real_in    = Q15_ONE;   // a = 1
        fft_imag_in    = Q15_ZERO;  // b = 0
        ref_chirp_real = Q15_ZERO;  // c = 0
        ref_chirp_imag = Q15_ONE;   // d = 1
        fft_valid_in   = 1;
        @(posedge clk);
        fft_valid_in   = 0;

        wait_for_output;
        captured_real = filtered_real;
        captured_imag = filtered_imag;

        $display("  (1+0j)*conj(0+j): real=%0d, imag=%0d (expect 0, ~-32767)",
                 captured_real, captured_imag);
        // ac+bd = 1*0+0*1 = 0, bc-ad = 0*0-1*1 = -1
        check(captured_real < 16'sh0100 && captured_real > -16'sh0100,
              "Real ≈ 0");
        check(captured_imag < -16'sh7F00, "Imag ≈ -1.0");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 5: Self-conjugate (magnitude squared)
        // (0.5+0.5j) * conj(0.5+0.5j) = 0.5 + 0j
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 5: (0.5+0.5j) * conj(0.5+0.5j) ---");
        reset_n = 0;
        fft_valid_in = 0;
        repeat (4) @(posedge clk);
        reset_n = 1;
        @(posedge clk);

        fft_real_in    = Q15_HALF;  // a = 0.5
        fft_imag_in    = Q15_HALF;  // b = 0.5
        ref_chirp_real = Q15_HALF;  // c = 0.5
        ref_chirp_imag = Q15_HALF;  // d = 0.5
        fft_valid_in   = 1;
        @(posedge clk);
        fft_valid_in   = 0;

        wait_for_output;
        captured_real = filtered_real;
        captured_imag = filtered_imag;

        $display("  (0.5+0.5j)*conj(0.5+0.5j): real=%0d, imag=%0d (expect ~16384, 0)",
                 captured_real, captured_imag);
        // ac+bd = 0.5*0.5+0.5*0.5 = 0.5, bc-ad = 0.5*0.5-0.5*0.5 = 0
        check(captured_real > 16'sh3800 && captured_real < 16'sh4800,
              "Real ≈ 0.5 (16384 ± tolerance)");
        check(captured_imag < 16'sh0200 && captured_imag > -16'sh0200,
              "Imag ≈ 0");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 6: Pipeline throughput
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 6: Pipeline Throughput ---");
        reset_n = 0;
        fft_valid_in = 0;
        repeat (4) @(posedge clk);
        reset_n = 1;
        @(posedge clk);

        // Stream 20 samples continuously
        fft_valid_in = 1;
        output_count = 0;

        csv_file = $fopen("mf_pipeline_output.csv", "w");
        $fwrite(csv_file, "sample,fft_real,fft_imag,ref_real,ref_imag,out_real,out_imag,valid\n");

        for (sample_count = 0; sample_count < 30; sample_count = sample_count + 1) begin
            // Varying input: rotating phasor
            fft_real_in = $rtoi(16383.0 * $cos(6.2831853 * sample_count / 10.0));
            fft_imag_in = $rtoi(16383.0 * $sin(6.2831853 * sample_count / 10.0));
            // Reference: fixed chirp
            ref_chirp_real = Q15_HALF;
            ref_chirp_imag = 16'sh2000;  // 0.25

            @(posedge clk); #1;
            $fwrite(csv_file, "%0d,%0d,%0d,%0d,%0d,%0d,%0d,%0d\n",
                    sample_count, fft_real_in, fft_imag_in,
                    ref_chirp_real, ref_chirp_imag,
                    filtered_real, filtered_imag, filtered_valid);
            if (filtered_valid) output_count = output_count + 1;
        end

        fft_valid_in = 0;
        // Flush pipeline
        repeat (5) begin
            @(posedge clk); #1;
            if (filtered_valid) output_count = output_count + 1;
        end
        $fclose(csv_file);

        $display("  Pipeline: %0d valid outputs from 30 input samples", output_count);
        // After 4-cycle pipeline fill, should get continuous output
        // 30 inputs - 4 pipeline delay = 26 expected
        check(output_count >= 25, "Pipeline produces near-continuous output");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 7: Saturation handling
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 7: Saturation Handling ---");
        reset_n = 0;
        fft_valid_in = 0;
        repeat (4) @(posedge clk);
        reset_n = 1;
        @(posedge clk);

        // (-1+0j) * conj(-1+0j) = (-1)*(-1) + 0 = 1
        // But in Q15: -32768 * -32768 = 2^30 which may overflow Q30 representation
        fft_real_in    = Q15_NEG_ONE;
        fft_imag_in    = Q15_ZERO;
        ref_chirp_real = Q15_NEG_ONE;
        ref_chirp_imag = Q15_ZERO;
        fft_valid_in   = 1;
        @(posedge clk);
        fft_valid_in   = 0;

        wait_for_output;
        captured_real = filtered_real;
        captured_imag = filtered_imag;

        $display("  (-1)*conj(-1): real=%0d, imag=%0d (expect saturated to +32767)",
                 captured_real, captured_imag);
        // -32768 * -32768 = 1073741824 = 2^30 (exactly), this is the max Q30 value
        // After rounding and scaling, should saturate to 32767
        check(captured_real >= 16'sh7F00, "Saturation: real at max positive");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 8: Valid signal timing
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 8: Valid Signal Timing ---");
        reset_n = 0;
        fft_valid_in = 0;
        repeat (4) @(posedge clk);
        reset_n = 1;
        @(posedge clk);

        // No input valid → no output valid
        output_count = 0;
        for (sample_count = 0; sample_count < 20; sample_count = sample_count + 1) begin
            @(posedge clk); #1;
            if (filtered_valid) output_count = output_count + 1;
        end
        check(output_count == 0, "No output when fft_valid_in=0");

        // ════════════════════════════════════════════════════════
        // Summary
        // ════════════════════════════════════════════════════════
        $display("");
        $display("========================================");
        $display("  FREQUENCY MATCHED FILTER RESULTS");
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
