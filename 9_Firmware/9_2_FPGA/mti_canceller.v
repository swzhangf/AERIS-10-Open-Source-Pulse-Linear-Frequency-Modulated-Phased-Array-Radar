`timescale 1ns / 1ps

/**
 * mti_canceller.v
 *
 * Moving Target Indication (MTI) — 2-pulse canceller for ground clutter removal.
 *
 * Sits between the range bin decimator and the Doppler processor in the
 * AERIS-10 receiver chain. Subtracts the previous chirp's range profile
 * from the current chirp's profile, implementing H(z) = 1 - z^{-1} in
 * slow-time. This places a null at zero Doppler (DC), removing stationary
 * ground clutter while passing moving targets through.
 *
 * Signal chain position:
 *   Range Bin Decimator → [MTI Canceller] → Doppler Processor
 *
 * Algorithm:
 *   For each range bin r (0..NUM_RANGE_BINS-1):
 *     mti_out_i[r] = current_i[r] - previous_i[r]
 *     mti_out_q[r] = current_q[r] - previous_q[r]
 *
 * The previous chirp's 64 range bins are stored in a small BRAM.
 * On the very first chirp after reset (or enable), there is no previous
 * data — output is zero (muted) for that first chirp.
 *
 * When mti_enable=0, the module is a transparent pass-through with zero
 * latency penalty (data goes straight through combinationally registered).
 *
 * Resources:
 *   - 2 BRAM18 (64 x 16-bit I + 64 x 16-bit Q) or distributed RAM
 *   - ~30 LUTs (subtract + mux)
 *   - ~40 FFs (pipeline + control)
 *   - 0 DSP48
 *
 * Clock domain: clk (100 MHz)
 */

module mti_canceller #(
    parameter NUM_RANGE_BINS = 64,
    parameter DATA_WIDTH     = 16
) (
    input wire clk,
    input wire reset_n,

    // ========== INPUT (from range bin decimator) ==========
    input wire signed [DATA_WIDTH-1:0] range_i_in,
    input wire signed [DATA_WIDTH-1:0] range_q_in,
    input wire                         range_valid_in,
    input wire [5:0]                   range_bin_in,

    // ========== OUTPUT (to Doppler processor) ==========
    output reg signed [DATA_WIDTH-1:0] range_i_out,
    output reg signed [DATA_WIDTH-1:0] range_q_out,
    output reg                         range_valid_out,
    output reg [5:0]                   range_bin_out,

    // ========== CONFIGURATION ==========
    input wire mti_enable,   // 1=MTI active, 0=pass-through

    // ========== STATUS ==========
    output reg mti_first_chirp  // 1 during first chirp (output muted)
);

// ============================================================================
// PREVIOUS CHIRP BUFFER (64 x 16-bit I, 64 x 16-bit Q)
// ============================================================================
// Small enough for distributed RAM on XC7A200T (64 entries).
// Using separate I/Q arrays for clean read/write.

reg signed [DATA_WIDTH-1:0] prev_i [0:NUM_RANGE_BINS-1];
reg signed [DATA_WIDTH-1:0] prev_q [0:NUM_RANGE_BINS-1];

// Track whether we have valid previous data
reg has_previous;

// ============================================================================
// MTI PROCESSING
// ============================================================================

// Read previous chirp data (combinational)
wire signed [DATA_WIDTH-1:0] prev_i_rd = prev_i[range_bin_in];
wire signed [DATA_WIDTH-1:0] prev_q_rd = prev_q[range_bin_in];

// Compute difference with saturation
// Subtraction can produce DATA_WIDTH+1 bits; saturate back to DATA_WIDTH.
wire signed [DATA_WIDTH:0] diff_i_full = {range_i_in[DATA_WIDTH-1], range_i_in}
                                        - {prev_i_rd[DATA_WIDTH-1], prev_i_rd};
wire signed [DATA_WIDTH:0] diff_q_full = {range_q_in[DATA_WIDTH-1], range_q_in}
                                        - {prev_q_rd[DATA_WIDTH-1], prev_q_rd};

// Saturate to DATA_WIDTH bits
wire signed [DATA_WIDTH-1:0] diff_i_sat;
wire signed [DATA_WIDTH-1:0] diff_q_sat;

assign diff_i_sat = (diff_i_full > $signed({{2{1'b0}}, {(DATA_WIDTH-1){1'b1}}}))
                  ? $signed({1'b0, {(DATA_WIDTH-1){1'b1}}})           // +max
                  : (diff_i_full < $signed({{2{1'b1}}, {(DATA_WIDTH-1){1'b0}}}))
                  ? $signed({1'b1, {(DATA_WIDTH-1){1'b0}}})           // -max
                  : diff_i_full[DATA_WIDTH-1:0];

assign diff_q_sat = (diff_q_full > $signed({{2{1'b0}}, {(DATA_WIDTH-1){1'b1}}}))
                  ? $signed({1'b0, {(DATA_WIDTH-1){1'b1}}})
                  : (diff_q_full < $signed({{2{1'b1}}, {(DATA_WIDTH-1){1'b0}}}))
                  ? $signed({1'b1, {(DATA_WIDTH-1){1'b0}}})
                  : diff_q_full[DATA_WIDTH-1:0];

// ============================================================================
// MAIN LOGIC
// ============================================================================
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        range_i_out     <= {DATA_WIDTH{1'b0}};
        range_q_out     <= {DATA_WIDTH{1'b0}};
        range_valid_out <= 1'b0;
        range_bin_out   <= 6'd0;
        has_previous    <= 1'b0;
        mti_first_chirp <= 1'b1;
    end else begin
        // Default: no valid output
        range_valid_out <= 1'b0;

        if (range_valid_in) begin
            // Always store current sample as "previous" for next chirp
            prev_i[range_bin_in] <= range_i_in;
            prev_q[range_bin_in] <= range_q_in;

            // Output path
            range_bin_out <= range_bin_in;

            if (!mti_enable) begin
                // Pass-through mode: no MTI processing
                range_i_out     <= range_i_in;
                range_q_out     <= range_q_in;
                range_valid_out <= 1'b1;
                // Reset first-chirp state when MTI is disabled
                has_previous    <= 1'b0;
                mti_first_chirp <= 1'b1;
            end else if (!has_previous) begin
                // First chirp after enable: mute output (no subtraction possible).
                // Still emit valid=1 with zero data so Doppler processor gets
                // the expected number of samples per frame.
                range_i_out     <= {DATA_WIDTH{1'b0}};
                range_q_out     <= {DATA_WIDTH{1'b0}};
                range_valid_out <= 1'b1;

                // After last range bin of first chirp, mark previous as valid
                if (range_bin_in == NUM_RANGE_BINS - 1) begin
                    has_previous    <= 1'b1;
                    mti_first_chirp <= 1'b0;
                end
            end else begin
                // Normal MTI: subtract previous from current
                range_i_out     <= diff_i_sat;
                range_q_out     <= diff_q_sat;
                range_valid_out <= 1'b1;
            end
        end
    end
end

// ============================================================================
// MEMORY INITIALIZATION (simulation only)
// ============================================================================
`ifdef SIMULATION
integer init_k;
initial begin
    for (init_k = 0; init_k < NUM_RANGE_BINS; init_k = init_k + 1) begin
        prev_i[init_k] = 0;
        prev_q[init_k] = 0;
    end
end
`endif

endmodule
