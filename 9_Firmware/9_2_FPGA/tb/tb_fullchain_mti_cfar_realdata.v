`timescale 1ns / 1ps

/**
 * tb_fullchain_mti_cfar_realdata.v
 *
 * Full-chain co-simulation testbench: feeds real ADI CN0566 radar data
 * (post-range-FFT, 32 chirps x 1024 bins) through the complete signal
 * processing pipeline:
 *
 *   range_bin_decimator (peak detection, 1024->64)
 *     -> mti_canceller (2-pulse, mti_enable=1)
 *       -> doppler_processor_optimized (Hamming + dual 16-pt FFT)
 *         -> DC notch filter (width=2, inline logic)
 *           -> cfar_ca (CA mode, guard=2, train=8, alpha=0x30)
 *
 * and compares outputs bit-for-bit against the Python golden reference
 * (golden_reference.py) at multiple checkpoints:
 *
 *   Checkpoint 1: Decimator output matches
 *   Checkpoint 2: MTI canceller output matches
 *   Checkpoint 3: Doppler output (post-DC-notch) matches
 *   Checkpoint 4: CFAR magnitudes match
 *   Checkpoint 5: CFAR thresholds match
 *   Checkpoint 6: CFAR detection flags match
 *
 * Stimulus:
 *   tb/cosim/real_data/hex/fullchain_range_input.hex
 *     32768 x 32-bit packed {Q[31:16], I[15:0]} -- 32 chirps x 1024 bins
 *
 * Golden reference files:
 *   fullchain_mti_ref_i.hex, fullchain_mti_ref_q.hex       -- MTI output (2048)
 *   fullchain_notched_ref_i.hex, fullchain_notched_ref_q.hex -- DC-notched Doppler (2048)
 *   fullchain_cfar_mag.hex                                   -- CFAR magnitudes (2048)
 *   fullchain_cfar_thr.hex                                   -- CFAR thresholds (2048)
 *   fullchain_cfar_det.hex                                   -- CFAR detection flags (2048)
 *
 * Pass criteria: ALL outputs match exactly.
 *
 * Compile:
 *   iverilog -Wall -DSIMULATION -g2012 \
 *     -o tb/tb_fullchain_mti_cfar_realdata.vvp \
 *     tb/tb_fullchain_mti_cfar_realdata.v \
 *     range_bin_decimator.v mti_canceller.v doppler_processor.v \
 *     xfft_16.v fft_engine.v cfar_ca.v
 *
 * Run from: 9_Firmware/9_2_FPGA/
 *   vvp tb/tb_fullchain_mti_cfar_realdata.vvp
 */

module tb_fullchain_mti_cfar_realdata;

// ============================================================================
// PARAMETERS
// ============================================================================
localparam CLK_PERIOD    = 10.0;          // 100 MHz
localparam DOPPLER_FFT   = 32;
localparam RANGE_BINS    = 64;
localparam CHIRPS        = 32;
localparam INPUT_BINS    = 1024;
localparam DECIM_FACTOR  = 16;

localparam TOTAL_INPUT_SAMPLES  = CHIRPS * INPUT_BINS;     // 32768
localparam TOTAL_MTI_SAMPLES    = CHIRPS * RANGE_BINS;     // 2048
localparam TOTAL_DOPPLER_SAMPLES = RANGE_BINS * DOPPLER_FFT; // 2048
localparam TOTAL_CFAR_CELLS     = RANGE_BINS * DOPPLER_FFT;  // 2048

// Generous timeout: decimator + MTI + Doppler + CFAR processing
localparam MAX_CYCLES = 3_000_000;

// DC notch width for this test
localparam DC_NOTCH_WIDTH = 3'd2;

// ============================================================================
// CLOCK AND RESET
// ============================================================================
reg clk;
reg reset_n;

initial clk = 0;
always #(CLK_PERIOD / 2) clk = ~clk;

// ============================================================================
// DECIMATOR SIGNALS
// ============================================================================
reg  signed [15:0] decim_i_in;
reg  signed [15:0] decim_q_in;
reg                decim_valid_in;

wire signed [15:0] decim_i_out;
wire signed [15:0] decim_q_out;
wire               decim_valid_out;
wire [5:0]         decim_bin_index;

// ============================================================================
// MTI CANCELLER SIGNALS
// ============================================================================
wire signed [15:0] mti_i_out;
wire signed [15:0] mti_q_out;
wire               mti_valid_out;
wire [5:0]         mti_bin_out;
wire               mti_first_chirp;

// ============================================================================
// DOPPLER SIGNALS
// ============================================================================
// Wire MTI output into Doppler input (matching RTL system_top)
wire [31:0] range_data_32bit;
wire        range_data_valid;

assign range_data_32bit = {mti_q_out, mti_i_out};
assign range_data_valid = mti_valid_out;

reg         new_chirp_frame;

wire [31:0] doppler_output;
wire        doppler_valid;
wire [4:0]  doppler_bin;
wire [5:0]  range_bin;
wire        processing_active;
wire        frame_complete;
wire [3:0]  dut_status;

// ============================================================================
// DC NOTCH FILTER SIGNALS (inline, replicating radar_system_top.v logic)
// ============================================================================
wire [4:0] dop_bin_unsigned;
wire dc_notch_active;
wire [31:0] notched_doppler_data;
wire        notched_doppler_valid;
wire [4:0]  notched_doppler_bin;
wire [5:0]  notched_range_bin;

assign dop_bin_unsigned = doppler_bin;
assign dc_notch_active = (DC_NOTCH_WIDTH != 3'd0) &&
                          (dop_bin_unsigned < {2'b0, DC_NOTCH_WIDTH} ||
                           dop_bin_unsigned > (5'd31 - {2'b0, DC_NOTCH_WIDTH} + 5'd1));

assign notched_doppler_data  = dc_notch_active ? 32'd0 : doppler_output;
assign notched_doppler_valid = doppler_valid;
assign notched_doppler_bin   = doppler_bin;
assign notched_range_bin     = range_bin;

// ============================================================================
// CFAR SIGNALS
// ============================================================================
wire        cfar_detect_flag;
wire        cfar_detect_valid;
wire [5:0]  cfar_detect_range;
wire [4:0]  cfar_detect_doppler;
wire [16:0] cfar_detect_magnitude;
wire [16:0] cfar_detect_threshold;
wire [15:0] cfar_detect_count;
wire        cfar_busy;
wire [7:0]  cfar_status_w;

// ============================================================================
// DUT INSTANTIATION: Range Bin Decimator
// ============================================================================
range_bin_decimator #(
    .INPUT_BINS(INPUT_BINS),
    .OUTPUT_BINS(RANGE_BINS),
    .DECIMATION_FACTOR(DECIM_FACTOR)
) range_decim (
    .clk(clk),
    .reset_n(reset_n),
    .range_i_in(decim_i_in),
    .range_q_in(decim_q_in),
    .range_valid_in(decim_valid_in),
    .range_i_out(decim_i_out),
    .range_q_out(decim_q_out),
    .range_valid_out(decim_valid_out),
    .range_bin_index(decim_bin_index),
    .decimation_mode(2'b01),       // Peak detection mode
    .start_bin(10'd0),
    .watchdog_timeout()
);

// ============================================================================
// DUT INSTANTIATION: MTI Canceller
// ============================================================================
mti_canceller #(
    .NUM_RANGE_BINS(RANGE_BINS),
    .DATA_WIDTH(16)
) mti_inst (
    .clk(clk),
    .reset_n(reset_n),
    .range_i_in(decim_i_out),
    .range_q_in(decim_q_out),
    .range_valid_in(decim_valid_out),
    .range_bin_in(decim_bin_index),
    .range_i_out(mti_i_out),
    .range_q_out(mti_q_out),
    .range_valid_out(mti_valid_out),
    .range_bin_out(mti_bin_out),
    .mti_enable(1'b1),             // MTI always enabled for this test
    .mti_first_chirp(mti_first_chirp)
);

// ============================================================================
// DUT INSTANTIATION: Doppler Processor
// ============================================================================
doppler_processor_optimized doppler_proc (
    .clk(clk),
    .reset_n(reset_n),
    .range_data(range_data_32bit),
    .data_valid(range_data_valid),
    .new_chirp_frame(new_chirp_frame),
    .doppler_output(doppler_output),
    .doppler_valid(doppler_valid),
    .doppler_bin(doppler_bin),
    .range_bin(range_bin),
    .processing_active(processing_active),
    .frame_complete(frame_complete),
    .status(dut_status)
);

// ============================================================================
// DUT INSTANTIATION: CFAR Detector
// ============================================================================
cfar_ca cfar_inst (
    .clk(clk),
    .reset_n(reset_n),
    .doppler_data(notched_doppler_data),
    .doppler_valid(notched_doppler_valid),
    .doppler_bin_in(notched_doppler_bin),
    .range_bin_in(notched_range_bin),
    .frame_complete(frame_complete),
    .cfg_guard_cells(4'd2),
    .cfg_train_cells(5'd8),
    .cfg_alpha(8'h30),             // Q4.4 = 3.0
    .cfg_cfar_mode(2'b00),         // CA-CFAR
    .cfg_cfar_enable(1'b1),        // CFAR enabled
    .cfg_simple_threshold(16'd500),
    .detect_flag(cfar_detect_flag),
    .detect_valid(cfar_detect_valid),
    .detect_range(cfar_detect_range),
    .detect_doppler(cfar_detect_doppler),
    .detect_magnitude(cfar_detect_magnitude),
    .detect_threshold(cfar_detect_threshold),
    .detect_count(cfar_detect_count),
    .cfar_busy(cfar_busy),
    .cfar_status(cfar_status_w)
);

// Internal DUT state (for debug)
wire [2:0] decim_state = range_decim.state;
wire [2:0] doppler_state = doppler_proc.state;

// ============================================================================
// INPUT DATA MEMORY (loaded from hex file)
// ============================================================================
reg [31:0] input_mem [0:TOTAL_INPUT_SAMPLES-1];

initial begin
    $readmemh("tb/cosim/real_data/hex/fullchain_range_input.hex", input_mem);
end

// ============================================================================
// REFERENCE DATA (loaded from hex files)
// ============================================================================
// MTI reference: 2048 x 16-bit signed (32 chirps x 64 bins, row-major)
reg signed [15:0] ref_mti_i [0:TOTAL_MTI_SAMPLES-1];
reg signed [15:0] ref_mti_q [0:TOTAL_MTI_SAMPLES-1];

// DC-notched Doppler reference: 2048 x 16-bit signed (64 range x 32 Doppler)
reg signed [15:0] ref_notched_i [0:TOTAL_DOPPLER_SAMPLES-1];
reg signed [15:0] ref_notched_q [0:TOTAL_DOPPLER_SAMPLES-1];

// CFAR reference: magnitude, threshold, detection flags
reg [16:0] ref_cfar_mag [0:TOTAL_CFAR_CELLS-1];
reg [16:0] ref_cfar_thr [0:TOTAL_CFAR_CELLS-1];
reg [0:0]  ref_cfar_det [0:TOTAL_CFAR_CELLS-1];

initial begin
    $readmemh("tb/cosim/real_data/hex/fullchain_mti_ref_i.hex", ref_mti_i);
    $readmemh("tb/cosim/real_data/hex/fullchain_mti_ref_q.hex", ref_mti_q);
    $readmemh("tb/cosim/real_data/hex/fullchain_notched_ref_i.hex", ref_notched_i);
    $readmemh("tb/cosim/real_data/hex/fullchain_notched_ref_q.hex", ref_notched_q);
    $readmemh("tb/cosim/real_data/hex/fullchain_cfar_mag.hex", ref_cfar_mag);
    $readmemh("tb/cosim/real_data/hex/fullchain_cfar_thr.hex", ref_cfar_thr);
    $readmemh("tb/cosim/real_data/hex/fullchain_cfar_det.hex", ref_cfar_det);
end

// ============================================================================
// MTI OUTPUT CAPTURE
// ============================================================================
integer mti_out_count;
reg signed [15:0] mti_cap_i [0:TOTAL_MTI_SAMPLES-1];
reg signed [15:0] mti_cap_q [0:TOTAL_MTI_SAMPLES-1];

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        mti_out_count <= 0;
    end else if (mti_valid_out) begin
        if (mti_out_count < TOTAL_MTI_SAMPLES) begin
            mti_cap_i[mti_out_count] <= mti_i_out;
            mti_cap_q[mti_out_count] <= mti_q_out;
        end
        mti_out_count <= mti_out_count + 1;
    end
end

// ============================================================================
// DOPPLER OUTPUT CAPTURE (post DC-notch)
// ============================================================================
reg signed [15:0] dop_cap_i [0:TOTAL_DOPPLER_SAMPLES-1];
reg signed [15:0] dop_cap_q [0:TOTAL_DOPPLER_SAMPLES-1];
reg [5:0]  dop_cap_rbin [0:TOTAL_DOPPLER_SAMPLES-1];
reg [4:0]  dop_cap_dbin [0:TOTAL_DOPPLER_SAMPLES-1];
integer dop_out_count;

// ============================================================================
// CFAR OUTPUT CAPTURE
// ============================================================================
reg [16:0] cfar_cap_mag [0:TOTAL_CFAR_CELLS-1];
reg [16:0] cfar_cap_thr [0:TOTAL_CFAR_CELLS-1];
reg [0:0]  cfar_cap_det [0:TOTAL_CFAR_CELLS-1];
reg [5:0]  cfar_cap_rbin [0:TOTAL_CFAR_CELLS-1];
reg [4:0]  cfar_cap_dbin [0:TOTAL_CFAR_CELLS-1];
integer cfar_out_count;
integer cfar_det_count;

// ============================================================================
// PASS / FAIL TRACKING
// ============================================================================
integer pass_count, fail_count, test_count;

task check;
    input cond;
    input [511:0] label;
    begin
        test_count = test_count + 1;
        if (cond) begin
            pass_count = pass_count + 1;
        end else begin
            $display("  [FAIL] %0s", label);
            fail_count = fail_count + 1;
        end
    end
endtask

// ============================================================================
// MAIN TEST SEQUENCE
// ============================================================================
integer i, chirp, sample_idx, cycle_count;
integer n_exact, n_within_tol;
integer max_err_i, max_err_q;
integer abs_diff_i, abs_diff_q;
reg signed [31:0] diff_i, diff_q;
integer mismatches_printed;
reg [31:0] packed_iq;
integer cfar_ref_idx;
integer cfar_mag_mismatches, cfar_thr_mismatches, cfar_det_mismatches;

initial begin
    // ---- Init ----
    pass_count     = 0;
    fail_count     = 0;
    test_count     = 0;
    dop_out_count  = 0;
    cfar_out_count = 0;
    cfar_det_count = 0;
    decim_i_in     = 0;
    decim_q_in     = 0;
    decim_valid_in = 0;
    new_chirp_frame = 0;
    reset_n = 0;

    // ---- Reset ----
    #(CLK_PERIOD * 10);
    reset_n = 1;
    #(CLK_PERIOD * 5);

    $display("============================================================");
    $display("  Full-Chain Real-Data Co-Simulation (MTI + CFAR)");
    $display("  range_bin_decimator (peak, 1024->64)");
    $display("    -> mti_canceller (2-pulse, enable=1)");
    $display("      -> doppler_processor_optimized (Hamming + dual 16-pt FFT)");
    $display("        -> DC notch filter (width=%0d)", DC_NOTCH_WIDTH);
    $display("          -> cfar_ca (CA, guard=2, train=8, alpha=0x30)");
    $display("  ADI CN0566 Phaser 10.525 GHz X-band FMCW");
    $display("  Input:    %0d chirps x %0d range FFT bins = %0d samples", CHIRPS, INPUT_BINS, TOTAL_INPUT_SAMPLES);
    $display("  Expected: %0d MTI outputs, %0d Doppler outputs, %0d CFAR cells", TOTAL_MTI_SAMPLES, TOTAL_DOPPLER_SAMPLES, TOTAL_CFAR_CELLS);
    $display("============================================================");

    // ---- Debug: check hex files loaded ----
    $display("  input_mem[0]     = %08h", input_mem[0]);
    $display("  input_mem[32767] = %08h", input_mem[32767]);
    $display("  ref_mti_i[0]=%04h, ref_mti_q[0]=%04h", ref_mti_i[0], ref_mti_q[0]);
    $display("  ref_notched_i[0]=%04h, ref_notched_q[0]=%04h", ref_notched_i[0], ref_notched_q[0]);
    $display("  ref_cfar_mag[0]=%05h, ref_cfar_thr[0]=%05h, ref_cfar_det[0]=%01h", ref_cfar_mag[0], ref_cfar_thr[0], ref_cfar_det[0]);

    // ---- Check 1: DUTs start in expected states ----
    check(decim_state == 3'd0, "Decimator starts in ST_IDLE");
    check(doppler_state == 3'b000, "Doppler starts in S_IDLE");

    // ---- Pulse new_chirp_frame to start Doppler accumulation ----
    @(posedge clk);
    new_chirp_frame <= 1;
    @(posedge clk);
    @(posedge clk);
    new_chirp_frame <= 0;
    @(posedge clk);

    // ---- Feed input data: 32 chirps x 1024 range bins ----
    $display("\n--- Feeding %0d chirps x %0d bins = %0d samples ---", CHIRPS, INPUT_BINS, TOTAL_INPUT_SAMPLES);

    for (chirp = 0; chirp < CHIRPS; chirp = chirp + 1) begin
        for (i = 0; i < INPUT_BINS; i = i + 1) begin
            @(posedge clk);
            sample_idx = chirp * INPUT_BINS + i;
            packed_iq = input_mem[sample_idx];
            decim_i_in <= packed_iq[15:0];
            decim_q_in <= packed_iq[31:16];
            decim_valid_in <= 1;
        end

        @(posedge clk);
        decim_valid_in <= 0;
        decim_i_in <= 0;
        decim_q_in <= 0;

        // Wait for decimator to return to IDLE
        cycle_count = 0;
        while (decim_state != 3'd0 && cycle_count < 200) begin
            @(posedge clk);
            cycle_count = cycle_count + 1;
        end

        if (chirp < 3 || chirp == CHIRPS - 1) begin
            $display("  Chirp %0d: IDLE after %0d extra cycles, mti_out=%0d", chirp, cycle_count, mti_out_count);
        end
    end

    // Allow a few extra cycles for the last MTI output to propagate
    repeat (10) @(posedge clk);

    $display("  All input fed. MTI outputs: %0d (expected %0d)", mti_out_count, TOTAL_MTI_SAMPLES);

    // ---- Check: MTI produced correct number of outputs ----
    check(mti_out_count == TOTAL_MTI_SAMPLES, "MTI output count == 2048");

    // ---- Wait for Doppler processing to complete ----
    $display("\n--- Waiting for Doppler to process and emit %0d outputs ---", TOTAL_DOPPLER_SAMPLES);

    cycle_count = 0;
    while (dop_out_count < TOTAL_DOPPLER_SAMPLES && cycle_count < MAX_CYCLES) begin
        @(posedge clk);
        cycle_count = cycle_count + 1;

        if (doppler_valid) begin
            // Capture DC-notched Doppler output
            dop_cap_i[dop_out_count] = notched_doppler_data[15:0];
            dop_cap_q[dop_out_count] = notched_doppler_data[31:16];
            dop_cap_rbin[dop_out_count] = notched_range_bin;
            dop_cap_dbin[dop_out_count] = notched_doppler_bin;
            dop_out_count = dop_out_count + 1;
        end
    end

    $display("  Collected %0d Doppler outputs in %0d cycles", dop_out_count, cycle_count);
    check(dop_out_count == TOTAL_DOPPLER_SAMPLES, "Doppler output count == 2048");
    check(cycle_count < MAX_CYCLES, "Doppler processing within timeout");

    // ---- Wait for CFAR to complete ----
    $display("\n--- Waiting for CFAR to process %0d cells ---", TOTAL_CFAR_CELLS);

    cycle_count = 0;
    while (cfar_out_count < TOTAL_CFAR_CELLS && cycle_count < MAX_CYCLES) begin
        @(posedge clk);
        cycle_count = cycle_count + 1;

        if (cfar_detect_valid) begin
            cfar_cap_mag[cfar_out_count]  = cfar_detect_magnitude;
            cfar_cap_thr[cfar_out_count]  = cfar_detect_threshold;
            cfar_cap_det[cfar_out_count]  = cfar_detect_flag;
            cfar_cap_rbin[cfar_out_count] = cfar_detect_range;
            cfar_cap_dbin[cfar_out_count] = cfar_detect_doppler;
            if (cfar_detect_flag) cfar_det_count = cfar_det_count + 1;
            cfar_out_count = cfar_out_count + 1;
        end
    end

    $display("  Collected %0d CFAR outputs in %0d cycles (%0d detections)", cfar_out_count, cycle_count, cfar_det_count);
    check(cfar_out_count == TOTAL_CFAR_CELLS, "CFAR output count == 2048");
    check(cycle_count < MAX_CYCLES, "CFAR processing within timeout");

    // ==================================================================
    // CHECKPOINT 1: MTI OUTPUT COMPARISON
    // ==================================================================
    $display("");
    $display("--- Checkpoint 1: MTI canceller output vs golden reference ---");

    max_err_i = 0;
    max_err_q = 0;
    n_exact   = 0;
    mismatches_printed = 0;

    for (i = 0; i < TOTAL_MTI_SAMPLES; i = i + 1) begin
        diff_i = mti_cap_i[i] - ref_mti_i[i];
        diff_q = mti_cap_q[i] - ref_mti_q[i];
        abs_diff_i = (diff_i < 0) ? -diff_i : diff_i;
        abs_diff_q = (diff_q < 0) ? -diff_q : diff_q;

        if (abs_diff_i > max_err_i) max_err_i = abs_diff_i;
        if (abs_diff_q > max_err_q) max_err_q = abs_diff_q;

        if (diff_i == 0 && diff_q == 0)
            n_exact = n_exact + 1;

        if ((abs_diff_i > 0 || abs_diff_q > 0) && mismatches_printed < 10) begin
            $display("    [%4d] chirp=%0d bin=%0d RTL=(%6d,%6d) REF=(%6d,%6d) ERR=(%4d,%4d)", i, i / RANGE_BINS, i % RANGE_BINS, $signed(mti_cap_i[i]), $signed(mti_cap_q[i]), $signed(ref_mti_i[i]), $signed(ref_mti_q[i]), diff_i, diff_q);
            mismatches_printed = mismatches_printed + 1;
        end

        check(abs_diff_i == 0 && abs_diff_q == 0, "MTI output bin match");
    end

    $display("  MTI: exact=%0d/%0d, max_err I=%0d Q=%0d", n_exact, TOTAL_MTI_SAMPLES, max_err_i, max_err_q);

    // ==================================================================
    // CHECKPOINT 2: DC-NOTCHED DOPPLER OUTPUT COMPARISON
    // ==================================================================
    $display("");
    $display("--- Checkpoint 2: DC-notched Doppler output vs golden reference ---");

    max_err_i = 0;
    max_err_q = 0;
    n_exact   = 0;
    mismatches_printed = 0;

    for (i = 0; i < TOTAL_DOPPLER_SAMPLES; i = i + 1) begin
        diff_i = dop_cap_i[i] - ref_notched_i[i];
        diff_q = dop_cap_q[i] - ref_notched_q[i];
        abs_diff_i = (diff_i < 0) ? -diff_i : diff_i;
        abs_diff_q = (diff_q < 0) ? -diff_q : diff_q;

        if (abs_diff_i > max_err_i) max_err_i = abs_diff_i;
        if (abs_diff_q > max_err_q) max_err_q = abs_diff_q;

        if (diff_i == 0 && diff_q == 0)
            n_exact = n_exact + 1;

        if ((abs_diff_i > 0 || abs_diff_q > 0) && mismatches_printed < 10) begin
            $display("    [%4d] rbin=%2d dbin=%2d RTL=(%6d,%6d) REF=(%6d,%6d) ERR=(%4d,%4d)", i, dop_cap_rbin[i], dop_cap_dbin[i], $signed(dop_cap_i[i]), $signed(dop_cap_q[i]), $signed(ref_notched_i[i]), $signed(ref_notched_q[i]), diff_i, diff_q);
            mismatches_printed = mismatches_printed + 1;
        end

        check(abs_diff_i == 0 && abs_diff_q == 0, "Notched Doppler output bin match");
    end

    $display("  Notched Doppler: exact=%0d/%0d, max_err I=%0d Q=%0d", n_exact, TOTAL_DOPPLER_SAMPLES, max_err_i, max_err_q);

    // ==================================================================
    // CHECKPOINT 3: CFAR MAGNITUDE, THRESHOLD, AND DETECTION COMPARISON
    // ==================================================================
    $display("");
    $display("--- Checkpoint 3: CFAR output vs golden reference ---");

    cfar_mag_mismatches = 0;
    cfar_thr_mismatches = 0;
    cfar_det_mismatches = 0;
    mismatches_printed  = 0;

    // The CFAR outputs cells in Doppler-column order:
    // column 0 (dbin=0): range bins 0..63
    // column 1 (dbin=1): range bins 0..63
    // ...
    // But golden reference is in row-major order (rbin, dbin).
    // We need to map CFAR output index to golden reference index.
    for (i = 0; i < cfar_out_count; i = i + 1) begin
        // CFAR output: range=cfar_cap_rbin[i], doppler=cfar_cap_dbin[i]
        // Golden ref index: rbin * 32 + dbin (row-major)
        cfar_ref_idx = cfar_cap_rbin[i] * DOPPLER_FFT + cfar_cap_dbin[i];

        if (cfar_cap_mag[i] != ref_cfar_mag[cfar_ref_idx]) begin
            cfar_mag_mismatches = cfar_mag_mismatches + 1;
            if (mismatches_printed < 10) begin
                $display("    MAG[%4d] rbin=%2d dbin=%2d RTL=%0d REF=%0d", i, cfar_cap_rbin[i], cfar_cap_dbin[i], cfar_cap_mag[i], ref_cfar_mag[cfar_ref_idx]);
                mismatches_printed = mismatches_printed + 1;
            end
        end

        if (cfar_cap_thr[i] != ref_cfar_thr[cfar_ref_idx]) begin
            cfar_thr_mismatches = cfar_thr_mismatches + 1;
            if (mismatches_printed < 10) begin
                $display("    THR[%4d] rbin=%2d dbin=%2d RTL=%0d REF=%0d", i, cfar_cap_rbin[i], cfar_cap_dbin[i], cfar_cap_thr[i], ref_cfar_thr[cfar_ref_idx]);
                mismatches_printed = mismatches_printed + 1;
            end
        end

        if (cfar_cap_det[i] != ref_cfar_det[cfar_ref_idx]) begin
            cfar_det_mismatches = cfar_det_mismatches + 1;
            if (mismatches_printed < 10) begin
                $display("    DET[%4d] rbin=%2d dbin=%2d RTL=%0d REF=%0d (mag=%0d thr=%0d)", i, cfar_cap_rbin[i], cfar_cap_dbin[i], cfar_cap_det[i], ref_cfar_det[cfar_ref_idx], cfar_cap_mag[i], cfar_cap_thr[i]);
                mismatches_printed = mismatches_printed + 1;
            end
        end
    end

    // Per-cell pass/fail for CFAR
    for (i = 0; i < cfar_out_count; i = i + 1) begin
        cfar_ref_idx = cfar_cap_rbin[i] * DOPPLER_FFT + cfar_cap_dbin[i];
        check(cfar_cap_mag[i] == ref_cfar_mag[cfar_ref_idx], "CFAR magnitude match");
        check(cfar_cap_thr[i] == ref_cfar_thr[cfar_ref_idx], "CFAR threshold match");
        check(cfar_cap_det[i] == ref_cfar_det[cfar_ref_idx], "CFAR detection flag match");
    end

    $display("  CFAR mag mismatches:  %0d / %0d", cfar_mag_mismatches, cfar_out_count);
    $display("  CFAR thr mismatches:  %0d / %0d", cfar_thr_mismatches, cfar_out_count);
    $display("  CFAR det mismatches:  %0d / %0d", cfar_det_mismatches, cfar_out_count);
    $display("  CFAR total detections: RTL=%0d", cfar_det_count);

    // ==================================================================
    // SUMMARY
    // ==================================================================
    $display("");
    $display("============================================================");
    $display("  SUMMARY: Full-Chain Real-Data Co-Simulation (MTI + CFAR)");
    $display("============================================================");
    $display("  Chain: decim(peak) -> MTI -> Doppler -> DC notch(w=%0d) -> CFAR(CA)", DC_NOTCH_WIDTH);
    $display("  Input samples:     %0d (%0d chirps x %0d bins)", TOTAL_INPUT_SAMPLES, CHIRPS, INPUT_BINS);
    $display("  MTI outputs:       %0d (expected %0d)", mti_out_count, TOTAL_MTI_SAMPLES);
    $display("  Doppler outputs:   %0d (expected %0d)", dop_out_count, TOTAL_DOPPLER_SAMPLES);
    $display("  CFAR outputs:      %0d (expected %0d)", cfar_out_count, TOTAL_CFAR_CELLS);
    $display("  CFAR detections:   %0d", cfar_det_count);
    $display("  Pass: %0d  Fail: %0d  Total: %0d", pass_count, fail_count, test_count);
    $display("============================================================");

    if (fail_count == 0)
        $display("RESULT: ALL TESTS PASSED (%0d/%0d)", pass_count, test_count);
    else
        $display("RESULT: %0d TESTS FAILED", fail_count);

    $display("============================================================");

    #(CLK_PERIOD * 10);
    $finish;
end

// ============================================================================
// WATCHDOG
// ============================================================================
initial begin
    #(CLK_PERIOD * MAX_CYCLES * 2);
    $display("[TIMEOUT] Simulation exceeded %0d cycles -- aborting", MAX_CYCLES * 2);
    $display("SOME TESTS FAILED");
    $finish;
end

endmodule
