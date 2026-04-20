`timescale 1ns / 1ps

// ============================================================================
// Formal Verification Wrapper: range_bin_decimator
// AERIS-10 Radar FPGA — 5-state decimation FSM
// Target: SymbiYosys with smtbmc/z3
//
// Single-clock design: clk is an input wire, async2sync handles async reset.
// Each formal step = one clock edge.
//
// Parameters reduced: 32 input bins -> 4 output bins, factor 8.
// ============================================================================
module fv_range_bin_decimator (
    input wire clk
);

    // Reduced parameters for tractable BMC
    localparam INPUT_BINS        = 32;
    localparam OUTPUT_BINS       = 4;
    localparam DECIMATION_FACTOR = 8;

    // State encoding (mirrors DUT localparams)
    localparam ST_IDLE    = 3'd0;
    localparam ST_SKIP    = 3'd1;
    localparam ST_PROCESS = 3'd2;
    localparam ST_EMIT    = 3'd3;
    localparam ST_DONE    = 3'd4;

`ifdef FORMAL

    // ================================================================
    // Clock is an input wire — smtbmc drives it automatically.
    // async2sync (in .sby, default) converts async reset to sync.
    // ================================================================

    // Past-valid tracker
    reg f_past_valid;
    initial f_past_valid = 1'b0;
    always @(posedge clk) f_past_valid <= 1'b1;

    // Reset: asserted (low) for cycle 0, deasserted from cycle 1
    reg reset_n;
    initial reset_n = 1'b0;
    always @(posedge clk) reset_n <= 1'b1;

    // ================================================================
    // DUT inputs
    // ================================================================
    (* anyseq *) wire signed [15:0] range_i_in;
    (* anyseq *) wire signed [15:0] range_q_in;
    (* anyseq *) wire               range_valid_in;

    // decimation_mode and start_bin are constant per trace
    (* anyconst *) wire [1:0] decimation_mode;
    (* anyconst *) wire [9:0] start_bin;

    // ================================================================
    // DUT instantiation
    // ================================================================
    wire signed [15:0] range_i_out;
    wire signed [15:0] range_q_out;
    wire               range_valid_out;
    wire [5:0]         range_bin_index;
    wire [2:0]         state;
    wire [9:0]         in_bin_count;
    wire [3:0]         group_sample_count;
    wire [5:0]         output_bin_count;
    wire [9:0]         skip_count;

    range_bin_decimator #(
        .INPUT_BINS        (INPUT_BINS),
        .OUTPUT_BINS       (OUTPUT_BINS),
        .DECIMATION_FACTOR (DECIMATION_FACTOR)
    ) dut (
        .clk              (clk),
        .reset_n          (reset_n),
        .range_i_in       (range_i_in),
        .range_q_in       (range_q_in),
        .range_valid_in   (range_valid_in),
        .range_i_out      (range_i_out),
        .range_q_out      (range_q_out),
        .range_valid_out  (range_valid_out),
        .range_bin_index  (range_bin_index),
        .decimation_mode  (decimation_mode),
        .start_bin        (start_bin),
        .watchdog_timeout (),
        .fv_state              (state),
        .fv_in_bin_count       (in_bin_count),
        .fv_group_sample_count (group_sample_count),
        .fv_output_bin_count   (output_bin_count),
        .fv_skip_count         (skip_count)
    );

    // Internals now accessed via formal output ports

    // ================================================================
    // Helper counters
    // ================================================================

    // Input valid pulse counter
    reg [9:0] fv_valid_in_count;
    initial fv_valid_in_count = 10'd0;
    always @(posedge clk) begin
        if (!reset_n)
            fv_valid_in_count <= 10'd0;
        else if (range_valid_in)
            fv_valid_in_count <= fv_valid_in_count + 10'd1;
    end

    // Output valid pulse counter
    reg [5:0] fv_valid_out_count;
    initial fv_valid_out_count = 6'd0;
    always @(posedge clk) begin
        if (!reset_n)
            fv_valid_out_count <= 6'd0;
        else if (state == ST_IDLE)
            fv_valid_out_count <= 6'd0;
        else if (range_valid_out)
            fv_valid_out_count <= fv_valid_out_count + 6'd1;
    end

    // ================================================================
    // Input assumptions
    // ================================================================

    // No valid input after INPUT_BINS samples have been consumed
    always @(posedge clk) begin
        if (reset_n && fv_valid_in_count >= INPUT_BINS)
            assume(!range_valid_in);
    end

    // No valid input when FSM is in ST_DONE
    always @(posedge clk) begin
        if (reset_n && state == ST_DONE)
            assume(!range_valid_in);
    end

    // Constrain start_bin to sensible range
    always @(*) begin
        assume(start_bin < INPUT_BINS);
    end

    // Constrain decimation_mode to valid values (not reserved mode 11)
    always @(*) begin
        assume(decimation_mode != 2'b11);
    end

    // ================================================================
    // PROPERTY 1: State encoding — states 5,6,7 unreachable
    // ================================================================
    always @(posedge clk) begin
        if (reset_n)
            assert(state <= 3'd4);
    end

    // ================================================================
    // PROPERTY 2: Output bin count never exceeds OUTPUT_BINS
    // ================================================================
    always @(posedge clk) begin
        if (reset_n)
            assert(output_bin_count <= OUTPUT_BINS);
    end

    // ================================================================
    // PROPERTY 3: Group sample count stays within decimation factor
    // ================================================================
    always @(posedge clk) begin
        if (reset_n)
            assert(group_sample_count < DECIMATION_FACTOR);
    end

    // ================================================================
    // PROPERTY 4: No output in wrong states
    // range_valid_out is a registered output set in ST_EMIT on cycle N,
    // observed as high on cycle N+1 when state has already advanced.
    // So check $past(state) was ST_EMIT.
    // ================================================================
    always @(posedge clk) begin
        if (reset_n && f_past_valid && range_valid_out)
            assert($past(state) == ST_EMIT);
    end

    // ================================================================
    // PROPERTY 5a: Output count never exceeds OUTPUT_BINS
    // When state reaches ST_DONE, at most OUTPUT_BINS valid output
    // pulses have been emitted. The overflow guard in ST_PROCESS
    // (in_bin_count >= INPUT_BINS-1 → ST_DONE) may cause early
    // termination when start_bin is large, producing fewer outputs.
    //
    // Timing: The last range_valid_out is registered in ST_EMIT and
    // appears high on the same posedge that state transitions to
    // ST_DONE.  The wrapper's fv_valid_out_count absorbs that pulse
    // via NBA on that edge, so it is only visible one cycle later.
    // Check when $past(state) == ST_DONE (i.e. the cycle after entry)
    // so the counter has resolved.  At this point state == ST_IDLE,
    // but the counter's ST_IDLE reset is also an NBA that hasn't
    // resolved yet, so fv_valid_out_count still reads its final value.
    // ================================================================
    always @(posedge clk) begin
        if (reset_n && f_past_valid && $past(state) == ST_DONE)
            assert(fv_valid_out_count <= OUTPUT_BINS);
    end

    // ================================================================
    // PROPERTY 5b: Exactly OUTPUT_BINS outputs when enough samples
    // When start_bin is small enough that INPUT_BINS - start_bin >=
    // OUTPUT_BINS * DECIMATION_FACTOR, all outputs are produced.
    // With reduced params: 32 - start_bin >= 32, i.e. start_bin == 0.
    // ================================================================
    always @(posedge clk) begin
        if (reset_n && f_past_valid && $past(state) == ST_DONE &&
            start_bin == 10'd0)
            assert(fv_valid_out_count == OUTPUT_BINS);
    end

    // ================================================================
    // PROPERTY 6: Skip logic
    // When start_bin > 0, the first output must not appear until
    // at least start_bin input samples have been consumed.
    // ================================================================
    always @(posedge clk) begin
        if (reset_n && start_bin > 10'd0 && fv_valid_in_count <= start_bin)
            assert(!range_valid_out);
    end

    // ================================================================
    // COVER 1: State reachability
    // ================================================================
    always @(posedge clk) begin
        if (reset_n) begin
            cover(state == ST_IDLE);
            cover(state == ST_SKIP);
            cover(state == ST_PROCESS);
            cover(state == ST_EMIT);
            cover(state == ST_DONE);
        end
    end

    // ================================================================
    // COVER 2: Complete frame with start_bin = 0, mode = 00 (decimate)
    // ================================================================
    always @(posedge clk) begin
        if (reset_n)
            cover(state == ST_DONE && start_bin == 10'd0 &&
                  decimation_mode == 2'b00);
    end

    // ================================================================
    // COVER 3: Complete frame with peak detection mode
    // ================================================================
    always @(posedge clk) begin
        if (reset_n)
            cover(state == ST_DONE && decimation_mode == 2'b01);
    end

    // ================================================================
    // COVER 4: Overflow guard early termination
    // Verify the overflow guard path is reachable: ST_DONE reached
    // with fewer than OUTPUT_BINS outputs (start_bin too large).
    // ================================================================
    always @(posedge clk) begin
        if (reset_n && f_past_valid && $past(state) == ST_DONE)
            cover(fv_valid_out_count < OUTPUT_BINS);
    end

`endif // FORMAL

endmodule
