`timescale 1ns / 1ps

/**
 * tb_mf_chain_synth.v
 *
 * Testbench for the SYNTHESIS branch of matched_filter_processing_chain.v.
 * This is compiled WITHOUT -DSIMULATION so the `else` branch (fft_engine-based)
 * is activated.
 *
 * The synthesis branch uses an iterative fft_engine (1024-pt, single butterfly),
 * so processing takes ~40K+ clock cycles per frame. Timeouts are set accordingly.
 */

module tb_mf_chain_synth;

    // ── Parameters ─────────────────────────────────────────────
    localparam CLK_PERIOD = 10.0;   // 100 MHz
    localparam FFT_SIZE   = 1024;
    // Timeout for full frame processing:
    // 3 FFTs × ~12K cycles each + multiply ~1K + overhead ≈ 40K
    // Use 200K for safety margin
    localparam FRAME_TIMEOUT = 200000;

    // ── Signals ────────────────────────────────────────────────
    reg         clk;
    reg         reset_n;
    reg  [15:0] adc_data_i;
    reg  [15:0] adc_data_q;
    reg         adc_valid;
    reg  [5:0]  chirp_counter;
    reg  [15:0] long_chirp_real;
    reg  [15:0] long_chirp_imag;
    reg  [15:0] short_chirp_real;
    reg  [15:0] short_chirp_imag;
    wire signed [15:0] range_profile_i;
    wire signed [15:0] range_profile_q;
    wire        range_profile_valid;
    wire [3:0]  chain_state;

    // ── Test bookkeeping ───────────────────────────────────────
    integer pass_count;
    integer fail_count;
    integer test_num;
    integer i;

    // Synthesis-branch states (mirror DUT)
    localparam [3:0] ST_IDLE     = 4'd0,
                     ST_COLLECT  = 4'd1,
                     ST_SIG_FFT  = 4'd2,
                     ST_SIG_CAP  = 4'd3,
                     ST_REF_FFT  = 4'd4,
                     ST_REF_CAP  = 4'd5,
                     ST_MULTIPLY = 4'd6,
                     ST_INV_FFT  = 4'd7,
                     ST_INV_CAP  = 4'd8,
                     ST_OUTPUT   = 4'd9,
                     ST_DONE     = 4'd10;

    // ── Concurrent output capture ──────────────────────────────
    integer cap_count;
    reg     cap_enable;
    integer cap_max_abs;
    integer cap_peak_bin;
    integer cap_cur_abs;

    // Output capture arrays
    reg signed [15:0] cap_out_i [0:1023];
    reg signed [15:0] cap_out_q [0:1023];

    // ── Clock ──────────────────────────────────────────────────
    always #(CLK_PERIOD/2) clk = ~clk;

    // ── DUT ────────────────────────────────────────────────────
    matched_filter_processing_chain uut (
        .clk              (clk),
        .reset_n          (reset_n),
        .adc_data_i       (adc_data_i),
        .adc_data_q       (adc_data_q),
        .adc_valid        (adc_valid),
        .chirp_counter    (chirp_counter),
        .long_chirp_real  (long_chirp_real),
        .long_chirp_imag  (long_chirp_imag),
        .short_chirp_real (short_chirp_real),
        .short_chirp_imag (short_chirp_imag),
        .range_profile_i  (range_profile_i),
        .range_profile_q  (range_profile_q),
        .range_profile_valid (range_profile_valid),
        .chain_state      (chain_state)
    );

    // ── Concurrent output capture block ────────────────────────
    always @(posedge clk) begin
        #1;
        if (cap_enable && range_profile_valid) begin
            if (cap_count < FFT_SIZE) begin
                cap_out_i[cap_count] = range_profile_i;
                cap_out_q[cap_count] = range_profile_q;
            end
            cap_cur_abs = (range_profile_i[15] ? -range_profile_i : range_profile_i)
                        + (range_profile_q[15] ? -range_profile_q : range_profile_q);
            if (cap_cur_abs > cap_max_abs) begin
                cap_max_abs  = cap_cur_abs;
                cap_peak_bin = cap_count;
            end
            cap_count = cap_count + 1;
        end
    end

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

    // ── Helper: apply reset ────────────────────────────────────
    task apply_reset;
        begin
            reset_n    = 0;
            adc_valid  = 0;
            adc_data_i = 16'd0;
            adc_data_q = 16'd0;
            chirp_counter   = 6'd0;
            long_chirp_real = 16'd0;
            long_chirp_imag = 16'd0;
            short_chirp_real = 16'd0;
            short_chirp_imag = 16'd0;
            cap_enable   = 0;
            cap_count    = 0;
            cap_max_abs  = 0;
            cap_peak_bin = -1;
            repeat (4) @(posedge clk);
            reset_n = 1;
            @(posedge clk);
            #1;
        end
    endtask

    // ── Helper: start capture ──────────────────────────────────
    task start_capture;
        begin
            cap_count    = 0;
            cap_max_abs  = 0;
            cap_peak_bin = -1;
            cap_enable   = 1;
        end
    endtask

    // ── Helper: wait for IDLE with long timeout ────────────────
    task wait_for_idle;
        integer wait_count;
        begin
            wait_count = 0;
            while (chain_state != ST_IDLE && wait_count < FRAME_TIMEOUT) begin
                @(posedge clk);
                wait_count = wait_count + 1;
            end
            #1;
            if (wait_count >= FRAME_TIMEOUT)
                $display("  WARNING: wait_for_idle timed out at %0d cycles", wait_count);
        end
    endtask

    // ── Helper: feed DC frame ──────────────────────────────────
    task feed_dc_frame;
        integer k;
        begin
            for (k = 0; k < FFT_SIZE; k = k + 1) begin
                adc_data_i       = 16'sh1000;    // +4096
                adc_data_q       = 16'sh0000;
                long_chirp_real  = 16'sh1000;
                long_chirp_imag  = 16'sh0000;
                short_chirp_real = 16'd0;
                short_chirp_imag = 16'd0;
                adc_valid        = 1'b1;
                @(posedge clk);
                #1;
            end
            adc_valid = 1'b0;
        end
    endtask

    // ── Helper: feed tone frame (signal=reference=tone at bin) ─
    task feed_tone_frame;
        input integer tone_bin;
        integer k;
        real angle;
        begin
            for (k = 0; k < FFT_SIZE; k = k + 1) begin
                angle = 6.28318530718 * tone_bin * k / (1.0 * FFT_SIZE);
                adc_data_i      = $rtoi(8000.0 * $cos(angle));
                adc_data_q      = $rtoi(8000.0 * $sin(angle));
                long_chirp_real = $rtoi(8000.0 * $cos(angle));
                long_chirp_imag = $rtoi(8000.0 * $sin(angle));
                short_chirp_real = 16'd0;
                short_chirp_imag = 16'd0;
                adc_valid       = 1'b1;
                @(posedge clk);
                #1;
            end
            adc_valid = 1'b0;
        end
    endtask

    // ── Helper: feed impulse frame (delta at sample 0) ─────────
    task feed_impulse_frame;
        integer k;
        begin
            for (k = 0; k < FFT_SIZE; k = k + 1) begin
                if (k == 0) begin
                    adc_data_i      = 16'sh4000;   // 0.5 in Q15
                    adc_data_q      = 16'sh0000;
                    long_chirp_real = 16'sh4000;
                    long_chirp_imag = 16'sh0000;
                end else begin
                    adc_data_i      = 16'sh0000;
                    adc_data_q      = 16'sh0000;
                    long_chirp_real = 16'sh0000;
                    long_chirp_imag = 16'sh0000;
                end
                short_chirp_real = 16'd0;
                short_chirp_imag = 16'd0;
                adc_valid       = 1'b1;
                @(posedge clk);
                #1;
            end
            adc_valid = 1'b0;
        end
    endtask

    // ── Stimulus ───────────────────────────────────────────────
    initial begin
        $dumpfile("tb_mf_chain_synth.vcd");
        $dumpvars(0, tb_mf_chain_synth);

        // Init
        clk        = 0;
        pass_count = 0;
        fail_count = 0;
        test_num   = 0;
        cap_enable = 0;
        cap_count  = 0;
        cap_max_abs = 0;
        cap_peak_bin = -1;

        // ════════════════════════════════════════════════════════
        // TEST GROUP 1: Reset behaviour
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 1: Reset Behaviour ---");
        apply_reset;

        reset_n = 0;
        repeat (4) @(posedge clk); #1;
        check(range_profile_valid === 1'b0, "range_profile_valid=0 during reset");
        check(chain_state === ST_IDLE,      "chain_state=IDLE during reset");
        reset_n = 1;
        @(posedge clk); #1;

        // ════════════════════════════════════════════════════════
        // TEST GROUP 2: No valid input stays IDLE
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 2: No Valid Input → Stays IDLE ---");
        apply_reset;

        repeat (100) @(posedge clk);
        #1;
        check(chain_state === ST_IDLE, "Stays in IDLE with no valid input");
        check(range_profile_valid === 1'b0, "No output when no input");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 3: DC frame — state transitions and output count
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 3: DC Frame — Full Processing ---");
        apply_reset;

        start_capture;
        feed_dc_frame;

        $display("  Waiting for processing (3 FFTs + multiply)...");
        wait_for_idle;
        cap_enable = 0;

        $display("  Output count: %0d (expected %0d)", cap_count, FFT_SIZE);
        $display("  Peak bin: %0d, magnitude: %0d", cap_peak_bin, cap_max_abs);
        check(cap_count == FFT_SIZE, "DC: Outputs exactly 1024 range profile samples");
        check(chain_state === ST_IDLE, "DC: Returns to IDLE after frame");
        // DC autocorrelation: FFT of DC = energy at bin 0 only
        // conj multiply = |bin0|^2 at bin 0, zeros elsewhere
        // IFFT of single bin = constant => peak at bin 0 (or any bin since all equal)
        // With Q15 truncation, expect non-zero output
        check(cap_max_abs > 0, "DC: Non-zero output");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 4: Zero input → zero output
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 4: Zero Input → Zero Output ---");
        apply_reset;

        start_capture;
        for (i = 0; i < FFT_SIZE; i = i + 1) begin
            adc_data_i       = 16'd0;
            adc_data_q       = 16'd0;
            long_chirp_real  = 16'd0;
            long_chirp_imag  = 16'd0;
            short_chirp_real = 16'd0;
            short_chirp_imag = 16'd0;
            adc_valid        = 1'b1;
            @(posedge clk); #1;
        end
        adc_valid = 1'b0;

        wait_for_idle;
        cap_enable = 0;

        $display("  Output count: %0d", cap_count);
        $display("  Max magnitude: %0d", cap_max_abs);
        check(cap_count == FFT_SIZE, "Zero: Got 1024 output samples");
        // Allow small rounding noise (fft_engine Q15 rounding can produce ±1)
        check(cap_max_abs <= 2, "Zero: Output magnitude <= 2 (near zero)");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 5: Tone autocorrelation (bin 5)
        // signal = reference = tone at bin 5
        // Autocorrelation peak at bin 0 (time lag 0)
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 5: Tone Autocorrelation (bin 5) ---");
        apply_reset;

        start_capture;
        feed_tone_frame(5);

        $display("  Waiting for processing...");
        wait_for_idle;
        cap_enable = 0;

        $display("  Output count: %0d", cap_count);
        $display("  Peak bin: %0d, magnitude: %0d", cap_peak_bin, cap_max_abs);
        check(cap_count == FFT_SIZE, "Tone: Got 1024 output samples");
        // Autocorrelation of a pure tone: peak at bin 0
        check(cap_peak_bin <= 5 || cap_peak_bin >= FFT_SIZE - 5,
              "Tone: Autocorrelation peak near bin 0");
        check(cap_max_abs > 0, "Tone: Peak magnitude > 0");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 6: Impulse autocorrelation
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 6: Impulse Autocorrelation ---");
        apply_reset;

        start_capture;
        feed_impulse_frame;

        $display("  Waiting for processing...");
        wait_for_idle;
        cap_enable = 0;

        $display("  Output count: %0d", cap_count);
        $display("  Peak bin: %0d, magnitude: %0d", cap_peak_bin, cap_max_abs);
        check(cap_count == FFT_SIZE, "Impulse: Got 1024 output samples");
        check(cap_max_abs > 0, "Impulse: Non-zero output");
        check(chain_state === ST_IDLE, "Impulse: Returns to IDLE");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 7: Reset mid-operation
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 7: Reset Mid-Operation ---");
        apply_reset;

        // Feed ~512 samples (halfway through collection)
        for (i = 0; i < 512; i = i + 1) begin
            adc_data_i       = 16'sh1000;
            adc_data_q       = 16'sh0000;
            long_chirp_real  = 16'sh1000;
            long_chirp_imag  = 16'sh0000;
            short_chirp_real = 16'd0;
            short_chirp_imag = 16'd0;
            adc_valid        = 1'b1;
            @(posedge clk); #1;
        end
        adc_valid = 1'b0;

        // Assert reset
        reset_n = 0;
        repeat (4) @(posedge clk); #1;
        reset_n = 1;
        @(posedge clk); #1;

        check(chain_state === ST_IDLE, "Mid-op reset: Returns to IDLE");
        check(range_profile_valid === 1'b0, "Mid-op reset: No output");

        // Feed a complete frame after reset
        start_capture;
        feed_dc_frame;
        wait_for_idle;
        cap_enable = 0;

        $display("  Post-reset frame: %0d outputs", cap_count);
        check(cap_count == FFT_SIZE, "Mid-op reset: Post-reset frame gives 1024 outputs");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 8: Back-to-back frames
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 8: Back-to-Back Frames ---");
        apply_reset;

        // Frame 1
        start_capture;
        feed_dc_frame;
        wait_for_idle;
        cap_enable = 0;
        $display("  Frame 1: %0d outputs, peak=%0d, mag=%0d", cap_count, cap_peak_bin, cap_max_abs);
        check(cap_count == FFT_SIZE, "B2B Frame 1: 1024 outputs");

        // Frame 2
        start_capture;
        feed_tone_frame(3);
        wait_for_idle;
        cap_enable = 0;
        $display("  Frame 2: %0d outputs, peak=%0d, mag=%0d", cap_count, cap_peak_bin, cap_max_abs);
        check(cap_count == FFT_SIZE, "B2B Frame 2: 1024 outputs");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 9: Mismatched signal vs reference
        // Signal at bin 5, reference at bin 10
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 9: Mismatched Signal vs Reference ---");
        apply_reset;

        start_capture;
        for (i = 0; i < FFT_SIZE; i = i + 1) begin
            adc_data_i      = $rtoi(8000.0 * $cos(6.28318530718 * 5 * i / 1024.0));
            adc_data_q      = $rtoi(8000.0 * $sin(6.28318530718 * 5 * i / 1024.0));
            long_chirp_real = $rtoi(8000.0 * $cos(6.28318530718 * 10 * i / 1024.0));
            long_chirp_imag = $rtoi(8000.0 * $sin(6.28318530718 * 10 * i / 1024.0));
            short_chirp_real = 16'd0;
            short_chirp_imag = 16'd0;
            adc_valid       = 1'b1;
            @(posedge clk); #1;
        end
        adc_valid = 1'b0;

        wait_for_idle;
        cap_enable = 0;

        $display("  Mismatched: peak bin=%0d, magnitude=%0d", cap_peak_bin, cap_max_abs);
        check(cap_count == FFT_SIZE, "Mismatch: Got 1024 output samples");
        // Signal=bin5, ref=bin10: product has energy at bin(5-10)=bin(-5)=bin(1019)
        // IFFT of that gives a tone at sample spacing of 5
        // The key check is that it completes and produces output
        check(cap_max_abs > 0, "Mismatch: Non-zero output");
        check(chain_state === ST_IDLE, "Mismatch: Returns to IDLE");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 10: Saturation — max positive values
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 10: Saturation — Max Positive ---");
        apply_reset;

        start_capture;
        for (i = 0; i < FFT_SIZE; i = i + 1) begin
            adc_data_i       = 16'sh7FFF;
            adc_data_q       = 16'sh7FFF;
            long_chirp_real  = 16'sh7FFF;
            long_chirp_imag  = 16'sh7FFF;
            short_chirp_real = 16'd0;
            short_chirp_imag = 16'd0;
            adc_valid        = 1'b1;
            @(posedge clk); #1;
        end
        adc_valid = 1'b0;

        wait_for_idle;
        cap_enable = 0;

        $display("  Saturation: count=%0d, peak=%0d, mag=%0d", cap_count, cap_peak_bin, cap_max_abs);
        check(cap_count == FFT_SIZE, "Saturation: Completes with 1024 outputs");
        check(chain_state === ST_IDLE, "Saturation: Returns to IDLE");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 11: Valid-gap / stall test
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 11: Valid-Gap Stall Test ---");
        apply_reset;

        start_capture;
        for (i = 0; i < FFT_SIZE; i = i + 1) begin
            adc_data_i       = 16'sh1000;
            adc_data_q       = 16'sh0000;
            long_chirp_real  = 16'sh1000;
            long_chirp_imag  = 16'sh0000;
            short_chirp_real = 16'd0;
            short_chirp_imag = 16'd0;
            adc_valid        = 1'b1;
            @(posedge clk); #1;

            // Every 100 samples, insert a 10-cycle gap
            if ((i % 100) == 99 && i < FFT_SIZE - 1) begin : stall_block
                integer gap_j;
                adc_valid = 1'b0;
                for (gap_j = 0; gap_j < 10; gap_j = gap_j + 1) begin
                    @(posedge clk); #1;
                end
            end
        end
        adc_valid = 1'b0;

        wait_for_idle;
        cap_enable = 0;

        $display("  Stall: count=%0d, peak=%0d, mag=%0d", cap_count, cap_peak_bin, cap_max_abs);
        check(cap_count == FFT_SIZE, "Stall: 1024 outputs emitted");
        check(chain_state === ST_IDLE, "Stall: Returns to IDLE");

        // ════════════════════════════════════════════════════════
        // Summary
        // ════════════════════════════════════════════════════════
        $display("");
        $display("========================================");
        $display("  MATCHED FILTER PROCESSING CHAIN");
        $display("  (SYNTHESIS BRANCH — fft_engine)");
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
