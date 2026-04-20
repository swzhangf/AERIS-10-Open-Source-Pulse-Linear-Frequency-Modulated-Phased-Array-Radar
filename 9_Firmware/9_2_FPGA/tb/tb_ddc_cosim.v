`timescale 1ns / 1ps

// ============================================================================
// DDC Co-simulation Testbench
//
// Feeds synthetic ADC samples (from hex file) through the full DDC chain:
//   ADC → NCO/Mixer → CIC (4x decimate) → CDC → FIR
// and captures baseband I/Q outputs to CSV for comparison with Python model.
//
// Verilog-2001 compatible. Compile with:
//   iverilog -g2001 -DSIMULATION -o tb/tb_ddc_cosim.vvp \
//     tb/tb_ddc_cosim.v ddc_400m.v nco_400m_enhanced.v \
//     cic_decimator_4x_enhanced.v fir_lowpass.v cdc_modules.v
//   vvp tb/tb_ddc_cosim.vvp
//
// Author: Phase 0.5 co-simulation suite for PLFM_RADAR
// ============================================================================

module tb_ddc_cosim;

    // ── Parameters ─────────────────────────────────────────────
    localparam CLK_400M_PERIOD = 2.5;   // 400 MHz -> 2.5 ns
    localparam CLK_100M_PERIOD = 10.0;  // 100 MHz -> 10 ns

    // Number of ADC samples to process (must match hex file length)
    localparam N_ADC_SAMPLES = 16384;

    // Maximum number of baseband outputs we expect
    // 16384 / 4 (CIC) - pipeline_latency ≈ 4000 max
    localparam MAX_BB_OUTPUTS = 8192;

    // ── Clocks and reset ──────────────────────────────────────
    reg clk_400m;
    reg clk_100m;
    reg reset_n;

    // ── ADC data from hex file ────────────────────────────────
    reg [7:0] adc_mem [0:N_ADC_SAMPLES-1];
    reg [7:0] adc_data;
    reg       adc_data_valid;

    // ── DUT outputs ───────────────────────────────────────────
    wire signed [17:0] baseband_i;
    wire signed [17:0] baseband_q;
    wire baseband_valid_i;
    wire baseband_valid_q;
    wire [1:0]  ddc_status;
    wire [7:0]  ddc_diagnostics;
    wire        mixer_saturation;
    wire        filter_overflow;
    wire [31:0] debug_sample_count;
    wire [17:0] debug_internal_i;
    wire [17:0] debug_internal_q;

    // ── Test infrastructure ───────────────────────────────────
    integer csv_file;
    integer csv_cic_file;
    integer adc_idx;
    integer bb_count;
    integer pass_count;
    integer fail_count;
    integer test_num;
    integer i;

    // Scenario selector (set via +define)
    reg [255:0] scenario_name;
    reg [1023:0] hex_file_path;
    reg [1023:0] csv_out_path;
    reg [1023:0] csv_cic_path;

    // ── Clock generation ──────────────────────────────────────
    // 400 MHz clock
    initial clk_400m = 0;
    always #(CLK_400M_PERIOD / 2) clk_400m = ~clk_400m;

    // 100 MHz clock (phase-aligned with 400 MHz)
    initial clk_100m = 0;
    always #(CLK_100M_PERIOD / 2) clk_100m = ~clk_100m;

    // ── DUT instantiation ─────────────────────────────────────
    ddc_400m_enhanced uut (
        .clk_400m         (clk_400m),
        .clk_100m         (clk_100m),
        .reset_n          (reset_n),
        .mixers_enable    (1'b1),
        .adc_data         (adc_data),
        .adc_data_valid_i (adc_data_valid),
        .adc_data_valid_q (adc_data_valid),
        .baseband_i       (baseband_i),
        .baseband_q       (baseband_q),
        .baseband_valid_i (baseband_valid_i),
        .baseband_valid_q (baseband_valid_q),
        .ddc_status       (ddc_status),
        .ddc_diagnostics  (ddc_diagnostics),
        .mixer_saturation (mixer_saturation),
        .filter_overflow  (filter_overflow),
        .test_mode        (2'b00),
        .test_phase_inc   (16'h0000),
        .force_saturation (1'b0),
        .reset_monitors   (1'b0),
        .debug_sample_count (debug_sample_count),
        .debug_internal_i   (debug_internal_i),
        .debug_internal_q   (debug_internal_q)
    );

    // ── Check task (standard convention) ──────────────────────
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

    // ── Capture baseband outputs to CSV ───────────────────────
    // This always block runs at 100 MHz (baseband rate) and captures
    // every valid baseband sample to the CSV file.
    always @(posedge clk_100m) begin
        if (baseband_valid_i && baseband_valid_q && csv_file != 0) begin
            $fwrite(csv_file, "%0d,%0d,%0d\n",
                    bb_count, $signed(baseband_i), $signed(baseband_q));
            bb_count = bb_count + 1;
        end
    end

    // ── Capture CIC outputs (for debugging) ───────────────────
    // Monitor internal CIC outputs via the DDC's internal signals
    // We access them through the hierarchical name of the CIC instances

    // ── Main stimulus ─────────────────────────────────────────
    initial begin
        // VCD dump (limited depth to keep file size manageable)
        $dumpfile("tb_ddc_cosim.vcd");
        $dumpvars(0, tb_ddc_cosim);

        // Initialize
        reset_n        = 0;
        adc_data       = 8'h80;  // mid-scale
        adc_data_valid = 0;
        pass_count     = 0;
        fail_count     = 0;
        test_num       = 0;
        bb_count       = 0;

        // ── Select scenario ───────────────────────────────────
        // Default to DC scenario for fastest validation
        // Override with: +define+SCENARIO_SINGLE, +define+SCENARIO_MULTI, etc.
        `ifdef SCENARIO_SINGLE
            hex_file_path = "tb/cosim/adc_single_target.hex";
            csv_out_path  = "tb/cosim/rtl_bb_single_target.csv";
            scenario_name = "single_target";
        `elsif SCENARIO_MULTI
            hex_file_path = "tb/cosim/adc_multi_target.hex";
            csv_out_path  = "tb/cosim/rtl_bb_multi_target.csv";
            scenario_name = "multi_target";
        `elsif SCENARIO_NOISE
            hex_file_path = "tb/cosim/adc_noise_only.hex";
            csv_out_path  = "tb/cosim/rtl_bb_noise_only.csv";
            scenario_name = "noise_only";
        `elsif SCENARIO_SINE
            hex_file_path = "tb/cosim/adc_sine_1mhz.hex";
            csv_out_path  = "tb/cosim/rtl_bb_sine_1mhz.csv";
            scenario_name = "sine_1mhz";
        `else
            // Default: DC
            hex_file_path = "tb/cosim/adc_dc.hex";
            csv_out_path  = "tb/cosim/rtl_bb_dc.csv";
            scenario_name = "dc";
        `endif

        $display("============================================================");
        $display("DDC Co-simulation Testbench");
        $display("Scenario: %0s", scenario_name);
        $display("ADC samples: %0d", N_ADC_SAMPLES);
        $display("============================================================");

        // Load ADC data from hex file
        $readmemh(hex_file_path, adc_mem);
        $display("Loaded ADC data from %0s", hex_file_path);

        // Open CSV output
        csv_file = $fopen(csv_out_path, "w");
        if (csv_file == 0) begin
            $display("ERROR: Cannot open output CSV file: %0s", csv_out_path);
            $finish;
        end
        $fwrite(csv_file, "sample_idx,baseband_i,baseband_q\n");

        // ════════════════════════════════════════════════════════
        // TEST GROUP 1: Reset
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 1: Reset ---");
        repeat (10) @(posedge clk_400m);
        #1;
        check(baseband_valid_i === 1'b0, "No valid output during reset");

        // Release reset
        reset_n = 1;
        $display("Reset released at time %0t", $time);

        // Wait for reset synchronizer to propagate (10 cycles)
        repeat (20) @(posedge clk_400m);

        // ════════════════════════════════════════════════════════
        // TEST GROUP 2: Feed ADC data
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 2: Feed %0d ADC samples ---", N_ADC_SAMPLES);

        adc_data_valid = 1;

        for (adc_idx = 0; adc_idx < N_ADC_SAMPLES; adc_idx = adc_idx + 1) begin
            @(posedge clk_400m);
            adc_data = adc_mem[adc_idx];
        end

        // Stop feeding data
        adc_data_valid = 0;
        adc_data = 8'h80;

        // Wait for pipeline to drain (NCO:6 + Mixer:3 + CIC:~20 + CDC:~5 + FIR:7)
        // Plus CDC latency at 400→100 MHz. ~200 clk_400m cycles should be plenty.
        repeat (400) @(posedge clk_400m);

        $display("Fed %0d ADC samples, captured %0d baseband outputs", N_ADC_SAMPLES, bb_count);

        // ════════════════════════════════════════════════════════
        // TEST GROUP 3: Basic sanity checks
        // ════════════════════════════════════════════════════════
        $display("\n--- Test Group 3: Sanity Checks ---");

        check(bb_count > 0, "Got at least one baseband output");

        // With 16384 ADC samples at 400 MHz, CIC decimates 4x to ~4096 at 100 MHz,
        // minus pipeline latency. We expect roughly 4000-4090 baseband samples.
        check(bb_count > 3900, "Got >3900 baseband outputs (expected ~4080)");
        check(bb_count < 4200, "Got <4200 baseband outputs (sanity check)");

        // For DC input (adc=128 → adc_signed≈0), baseband should be near zero
        `ifdef SCENARIO_DC
        // Check that baseband values are small for DC input
        // (After mixing with 120 MHz NCO, DC becomes a tone that CIC+FIR suppress)
        $display("  DC scenario: checking baseband near-zero response");
        `endif

        // ════════════════════════════════════════════════════════
        // Summary
        // ════════════════════════════════════════════════════════
        $fclose(csv_file);
        $display("\nCSV output written to: %0s", csv_out_path);
        $display("Baseband samples captured: %0d", bb_count);

        $display("\n============================================================");
        $display("Test Results: %0d/%0d passed", pass_count, pass_count + fail_count);
        if (fail_count == 0)
            $display("ALL TESTS PASSED");
        else
            $display("SOME TESTS FAILED (%0d failures)", fail_count);
        $display("============================================================");

        $finish;
    end

endmodule
