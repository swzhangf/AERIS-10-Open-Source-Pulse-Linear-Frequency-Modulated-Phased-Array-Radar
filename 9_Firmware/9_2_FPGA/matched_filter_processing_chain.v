`timescale 1ns / 1ps

/**
 * matched_filter_processing_chain.v
 *
 * Pulse compression processing chain for AERIS-10 FMCW radar.
 * Implements: FFT(signal) → FFT(reference) → Conjugate multiply → IFFT
 *
 * This is a SIMULATION-COMPATIBLE implementation that replaces the Xilinx
 * FFT IP cores (FFT_enhanced) with behavioral Radix-2 DIT FFT engines.
 * For synthesis, replace the behavioral FFT instances with the actual
 * Xilinx xfft IP blocks.
 *
 * Interface contract (from matched_filter_multi_segment.v line 361):
 *   .clk, .reset_n
 *   .adc_data_i, .adc_data_q, .adc_valid      <- from input buffer
 *   .chirp_counter                              <- 6-bit frame counter
 *   .long_chirp_real/imag, .short_chirp_real/imag <- reference (time-domain)
 *   .range_profile_i, .range_profile_q, .range_profile_valid -> output
 *   .chain_state                                -> 4-bit status
 *
 * Clock domain: clk (100 MHz system clock)
 * Data format:  16-bit signed (Q15 fixed-point)
 * FFT size:     1024 points
 *
 * Pipeline states:
 *   IDLE -> FWD_FFT (collect 1024 samples + bit-reverse copy)
 *        -> FWD_BUTTERFLY (forward FFT of signal)
 *        -> REF_BITREV (bit-reverse copy reference into work arrays)
 *        -> REF_BUTTERFLY (forward FFT of reference)
 *        -> MULTIPLY (conjugate multiply in freq domain)
 *        -> INV_BITREV (bit-reverse copy product)
 *        -> INV_BUTTERFLY (inverse FFT + 1/N scaling)
 *        -> OUTPUT (stream 1024 samples)
 *        -> DONE -> IDLE
 */

module matched_filter_processing_chain (
    input wire clk,
    input wire reset_n,

    // Input ADC data (from matched_filter_multi_segment buffer)
    input wire [15:0] adc_data_i,
    input wire [15:0] adc_data_q,
    input wire adc_valid,

    // Chirp counter (for future multi-chirp modes)
    input wire [5:0] chirp_counter,

    // Reference chirp (time-domain, latency-aligned by upstream buffer)
    input wire [15:0] long_chirp_real,
    input wire [15:0] long_chirp_imag,
    input wire [15:0] short_chirp_real,
    input wire [15:0] short_chirp_imag,

    // Output: range profile (pulse-compressed)
    output wire signed [15:0] range_profile_i,
    output wire signed [15:0] range_profile_q,
    output wire range_profile_valid,

    // Status
    output wire [3:0] chain_state
);

`ifdef SIMULATION
// ============================================================================
// PARAMETERS
// ============================================================================
localparam FFT_SIZE   = 1024;
localparam ADDR_BITS  = 10;    // log2(1024)

// State encoding (4-bit, up to 16 states)
localparam [3:0] ST_IDLE           = 4'd0;
localparam [3:0] ST_FWD_FFT        = 4'd1;   // Collect samples + bit-reverse
localparam [3:0] ST_FWD_BUTTERFLY  = 4'd2;   // Signal FFT butterflies
localparam [3:0] ST_REF_BITREV     = 4'd3;   // Bit-reverse copy reference
localparam [3:0] ST_REF_BUTTERFLY  = 4'd4;   // Reference FFT butterflies
localparam [3:0] ST_MULTIPLY       = 4'd5;   // Conjugate multiply
localparam [3:0] ST_INV_BITREV     = 4'd6;   // Bit-reverse copy product
localparam [3:0] ST_INV_BUTTERFLY  = 4'd7;   // IFFT butterflies + scale
localparam [3:0] ST_OUTPUT         = 4'd8;   // Stream results
localparam [3:0] ST_DONE           = 4'd9;   // Return to idle

reg [3:0] state;

// ============================================================================
// SIGNAL BUFFERS
// ============================================================================
// Input sample counter
reg [ADDR_BITS:0] fwd_in_count;     // 0..1024
reg fwd_frame_done;                  // All 1024 samples received

// Signal time-domain buffer
reg signed [15:0] fwd_buf_i [0:FFT_SIZE-1];
reg signed [15:0] fwd_buf_q [0:FFT_SIZE-1];

// Signal FFT output (frequency domain)
reg signed [15:0] fwd_out_i [0:FFT_SIZE-1];
reg signed [15:0] fwd_out_q [0:FFT_SIZE-1];
reg fwd_out_valid;

// Reference time-domain buffer
reg signed [15:0] ref_buf_i [0:FFT_SIZE-1];
reg signed [15:0] ref_buf_q [0:FFT_SIZE-1];

// Reference FFT output (frequency domain)
reg signed [15:0] ref_fft_i [0:FFT_SIZE-1];
reg signed [15:0] ref_fft_q [0:FFT_SIZE-1];

// ============================================================================
// CONJUGATE MULTIPLY OUTPUT
// ============================================================================
reg signed [15:0] mult_out_i [0:FFT_SIZE-1];
reg signed [15:0] mult_out_q [0:FFT_SIZE-1];
reg mult_done;

// ============================================================================
// INVERSE FFT OUTPUT
// ============================================================================
reg signed [15:0] ifft_out_i [0:FFT_SIZE-1];
reg signed [15:0] ifft_out_q [0:FFT_SIZE-1];
reg ifft_done;

// Output streaming
reg [ADDR_BITS:0] out_count;
reg out_valid_reg;
reg signed [15:0] out_i_reg, out_q_reg;

// ============================================================================
// BEHAVIORAL RADIX-2 DIT FFT (simulation only)
// ============================================================================
// Working arrays for FFT computation (shared between fwd, ref, and inv FFTs)
reg signed [31:0] work_re [0:FFT_SIZE-1];
reg signed [31:0] work_im [0:FFT_SIZE-1];

// Bit-reverse function
function [ADDR_BITS-1:0] bit_reverse;
    input [ADDR_BITS-1:0] val;
    integer b;
    begin
        bit_reverse = 0;
        for (b = 0; b < ADDR_BITS; b = b + 1)
            bit_reverse[ADDR_BITS-1-b] = val[b];
    end
endfunction

// FFT computation variables
integer fft_stage, fft_k, fft_j, fft_half, fft_span;
integer fft_idx_even, fft_idx_odd;
reg signed [31:0] tw_re, tw_im;
reg signed [31:0] t_re, t_im;
reg signed [31:0] u_re, u_im;
real tw_angle;

// ============================================================================
// MAIN STATE MACHINE
// ============================================================================
integer i;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        state          <= ST_IDLE;
        fwd_in_count   <= 0;
        fwd_frame_done <= 0;
        fwd_out_valid  <= 0;
        mult_done      <= 0;
        ifft_done      <= 0;
        out_count      <= 0;
        out_valid_reg  <= 0;
        out_i_reg      <= 16'd0;
        out_q_reg      <= 16'd0;
    end else begin
        // Defaults
        out_valid_reg <= 1'b0;

        case (state)
        // ================================================================
        // IDLE: Wait for valid ADC data, start collecting 1024 samples
        // ================================================================
        ST_IDLE: begin
            fwd_in_count   <= 0;
            fwd_frame_done <= 0;
            fwd_out_valid  <= 0;
            mult_done      <= 0;
            ifft_done      <= 0;
            out_count      <= 0;

            if (adc_valid) begin
                // Store first sample (signal + reference)
                fwd_buf_i[0] <= $signed(adc_data_i);
                fwd_buf_q[0] <= $signed(adc_data_q);
                ref_buf_i[0] <= $signed(long_chirp_real);
                ref_buf_q[0] <= $signed(long_chirp_imag);
                fwd_in_count <= 1;
                state        <= ST_FWD_FFT;
            end
        end

        // ================================================================
        // FWD_FFT: Collect remaining samples, then bit-reverse copy signal
        // ================================================================
        ST_FWD_FFT: begin
            if (!fwd_frame_done) begin
                // Still collecting samples
                if (adc_valid && fwd_in_count < FFT_SIZE) begin
                    fwd_buf_i[fwd_in_count] <= $signed(adc_data_i);
                    fwd_buf_q[fwd_in_count] <= $signed(adc_data_q);
                    ref_buf_i[fwd_in_count] <= $signed(long_chirp_real);
                    ref_buf_q[fwd_in_count] <= $signed(long_chirp_imag);
                    fwd_in_count <= fwd_in_count + 1;
                end

                if (fwd_in_count == FFT_SIZE) begin
                    fwd_frame_done <= 1;

                    // Bit-reverse copy SIGNAL into work arrays (via <=)
                    for (i = 0; i < FFT_SIZE; i = i + 1) begin
                        work_re[bit_reverse(i[ADDR_BITS-1:0])] <= {{16{fwd_buf_i[i][15]}}, fwd_buf_i[i]};
                        work_im[bit_reverse(i[ADDR_BITS-1:0])] <= {{16{fwd_buf_q[i][15]}}, fwd_buf_q[i]};
                    end
                end
            end else begin
                // Bit-reverse copy settled on previous clock.
                // Now transition to butterfly computation.
                state <= ST_FWD_BUTTERFLY;
            end
        end

        // ================================================================
        // FWD_BUTTERFLY: Forward FFT of signal (all stages, simulation only)
        // ================================================================
        ST_FWD_BUTTERFLY: begin
            // In-place radix-2 DIT butterflies (blocking assignments)
            for (fft_stage = 0; fft_stage < ADDR_BITS; fft_stage = fft_stage + 1) begin
                fft_half = 1 << fft_stage;
                fft_span = fft_half << 1;
                for (fft_k = 0; fft_k < FFT_SIZE; fft_k = fft_k + fft_span) begin
                    for (fft_j = 0; fft_j < fft_half; fft_j = fft_j + 1) begin
                        fft_idx_even = fft_k + fft_j;
                        fft_idx_odd  = fft_idx_even + fft_half;

                        tw_angle = -2.0 * 3.14159265358979 * fft_j / (fft_span * 1.0);
                        tw_re = $rtoi($cos(tw_angle) * 32767.0);
                        tw_im = $rtoi($sin(tw_angle) * 32767.0);

                        t_re = (work_re[fft_idx_odd] * tw_re - work_im[fft_idx_odd] * tw_im) >>> 15;
                        t_im = (work_re[fft_idx_odd] * tw_im + work_im[fft_idx_odd] * tw_re) >>> 15;

                        u_re = work_re[fft_idx_even];
                        u_im = work_im[fft_idx_even];

                        work_re[fft_idx_even] = u_re + t_re;
                        work_im[fft_idx_even] = u_im + t_im;
                        work_re[fft_idx_odd]  = u_re - t_re;
                        work_im[fft_idx_odd]  = u_im - t_im;
                    end
                end
            end

            // Copy signal FFT results to fwd_out (saturate to 16-bit)
            for (i = 0; i < FFT_SIZE; i = i + 1) begin
                if (work_re[i] > 32767)
                    fwd_out_i[i] <= 16'sh7FFF;
                else if (work_re[i] < -32768)
                    fwd_out_i[i] <= 16'sh8000;
                else
                    fwd_out_i[i] <= work_re[i][15:0];

                if (work_im[i] > 32767)
                    fwd_out_q[i] <= 16'sh7FFF;
                else if (work_im[i] < -32768)
                    fwd_out_q[i] <= 16'sh8000;
                else
                    fwd_out_q[i] <= work_im[i][15:0];
            end

            fwd_out_valid <= 1;
            state <= ST_REF_BITREV;

            `ifdef SIMULATION
            $display("[MF_CHAIN] Forward FFT complete");
            `endif
        end

        // ================================================================
        // REF_BITREV: Bit-reverse copy reference into work arrays
        // ================================================================
        ST_REF_BITREV: begin
            for (i = 0; i < FFT_SIZE; i = i + 1) begin
                work_re[bit_reverse(i[ADDR_BITS-1:0])] <= {{16{ref_buf_i[i][15]}}, ref_buf_i[i]};
                work_im[bit_reverse(i[ADDR_BITS-1:0])] <= {{16{ref_buf_q[i][15]}}, ref_buf_q[i]};
            end
            state <= ST_REF_BUTTERFLY;
        end

        // ================================================================
        // REF_BUTTERFLY: Forward FFT of reference (same algorithm as signal)
        // ================================================================
        ST_REF_BUTTERFLY: begin
            for (fft_stage = 0; fft_stage < ADDR_BITS; fft_stage = fft_stage + 1) begin
                fft_half = 1 << fft_stage;
                fft_span = fft_half << 1;
                for (fft_k = 0; fft_k < FFT_SIZE; fft_k = fft_k + fft_span) begin
                    for (fft_j = 0; fft_j < fft_half; fft_j = fft_j + 1) begin
                        fft_idx_even = fft_k + fft_j;
                        fft_idx_odd  = fft_idx_even + fft_half;

                        tw_angle = -2.0 * 3.14159265358979 * fft_j / (fft_span * 1.0);
                        tw_re = $rtoi($cos(tw_angle) * 32767.0);
                        tw_im = $rtoi($sin(tw_angle) * 32767.0);

                        t_re = (work_re[fft_idx_odd] * tw_re - work_im[fft_idx_odd] * tw_im) >>> 15;
                        t_im = (work_re[fft_idx_odd] * tw_im + work_im[fft_idx_odd] * tw_re) >>> 15;

                        u_re = work_re[fft_idx_even];
                        u_im = work_im[fft_idx_even];

                        work_re[fft_idx_even] = u_re + t_re;
                        work_im[fft_idx_even] = u_im + t_im;
                        work_re[fft_idx_odd]  = u_re - t_re;
                        work_im[fft_idx_odd]  = u_im - t_im;
                    end
                end
            end

            // Copy reference FFT results to ref_fft (saturate to 16-bit)
            for (i = 0; i < FFT_SIZE; i = i + 1) begin
                if (work_re[i] > 32767)
                    ref_fft_i[i] <= 16'sh7FFF;
                else if (work_re[i] < -32768)
                    ref_fft_i[i] <= 16'sh8000;
                else
                    ref_fft_i[i] <= work_re[i][15:0];

                if (work_im[i] > 32767)
                    ref_fft_q[i] <= 16'sh7FFF;
                else if (work_im[i] < -32768)
                    ref_fft_q[i] <= 16'sh8000;
                else
                    ref_fft_q[i] <= work_im[i][15:0];
            end

            state <= ST_MULTIPLY;

            `ifdef SIMULATION
            $display("[MF_CHAIN] Reference FFT complete");
            `endif
        end

        // ================================================================
        // MULTIPLY: Conjugate multiply FFT(signal) x conj(FFT(reference))
        // (a+jb)(c-jd) = (ac+bd) + j(bc-ad)
        // Uses fwd_out (signal FFT) and ref_fft (reference FFT)
        // ================================================================
        ST_MULTIPLY: begin
            for (i = 0; i < FFT_SIZE; i = i + 1) begin : mult_loop
                reg signed [31:0] a, b, c, d;
                reg signed [31:0] ac, bd, bc, ad;
                reg signed [31:0] re_result, im_result;
                
                a = {{16{fwd_out_i[i][15]}}, fwd_out_i[i]};
                b = {{16{fwd_out_q[i][15]}}, fwd_out_q[i]};
                c = {{16{ref_fft_i[i][15]}}, ref_fft_i[i]};
                d = {{16{ref_fft_q[i][15]}}, ref_fft_q[i]};

                ac = (a * c) >>> 15;
                bd = (b * d) >>> 15;
                bc = (b * c) >>> 15;
                ad = (a * d) >>> 15;

                re_result = ac + bd;
                im_result = bc - ad;

                // Saturate
                if (re_result > 32767)
                    mult_out_i[i] <= 16'sh7FFF;
                else if (re_result < -32768)
                    mult_out_i[i] <= 16'sh8000;
                else
                    mult_out_i[i] <= re_result[15:0];

                if (im_result > 32767)
                    mult_out_q[i] <= 16'sh7FFF;
                else if (im_result < -32768)
                    mult_out_q[i] <= 16'sh8000;
                else
                    mult_out_q[i] <= im_result[15:0];
            end

            mult_done <= 1;
            state     <= ST_INV_BITREV;

            `ifdef SIMULATION
            $display("[MF_CHAIN] Conjugate multiply complete");
            `endif
        end

        // ================================================================
        // INV_BITREV: Bit-reverse copy conjugate-multiply product
        // ================================================================
        ST_INV_BITREV: begin
            for (i = 0; i < FFT_SIZE; i = i + 1) begin
                work_re[bit_reverse(i[ADDR_BITS-1:0])] <= {{16{mult_out_i[i][15]}}, mult_out_i[i]};
                work_im[bit_reverse(i[ADDR_BITS-1:0])] <= {{16{mult_out_q[i][15]}}, mult_out_q[i]};
            end
            state <= ST_INV_BUTTERFLY;
        end

        // ================================================================
        // INV_BUTTERFLY: IFFT butterflies (positive twiddle) + 1/N scaling
        // ================================================================
        ST_INV_BUTTERFLY: begin
            for (fft_stage = 0; fft_stage < ADDR_BITS; fft_stage = fft_stage + 1) begin
                fft_half = 1 << fft_stage;
                fft_span = fft_half << 1;
                for (fft_k = 0; fft_k < FFT_SIZE; fft_k = fft_k + fft_span) begin
                    for (fft_j = 0; fft_j < fft_half; fft_j = fft_j + 1) begin
                        fft_idx_even = fft_k + fft_j;
                        fft_idx_odd  = fft_idx_even + fft_half;

                        // IFFT twiddle: +2*pi (positive exponent for inverse)
                        tw_angle = +2.0 * 3.14159265358979 * fft_j / (fft_span * 1.0);
                        tw_re = $rtoi($cos(tw_angle) * 32767.0);
                        tw_im = $rtoi($sin(tw_angle) * 32767.0);

                        t_re = (work_re[fft_idx_odd] * tw_re - work_im[fft_idx_odd] * tw_im) >>> 15;
                        t_im = (work_re[fft_idx_odd] * tw_im + work_im[fft_idx_odd] * tw_re) >>> 15;

                        u_re = work_re[fft_idx_even];
                        u_im = work_im[fft_idx_even];

                        work_re[fft_idx_even] = u_re + t_re;
                        work_im[fft_idx_even] = u_im + t_im;
                        work_re[fft_idx_odd]  = u_re - t_re;
                        work_im[fft_idx_odd]  = u_im - t_im;
                    end
                end
            end

            // Scale by 1/N (right shift by log2(1024) = 10) and store
            for (i = 0; i < FFT_SIZE; i = i + 1) begin : ifft_scale
                reg signed [31:0] scaled_re, scaled_im;
                scaled_re = work_re[i] >>> ADDR_BITS;
                scaled_im = work_im[i] >>> ADDR_BITS;

                if (scaled_re > 32767)
                    ifft_out_i[i] <= 16'sh7FFF;
                else if (scaled_re < -32768)
                    ifft_out_i[i] <= 16'sh8000;
                else
                    ifft_out_i[i] <= scaled_re[15:0];

                if (scaled_im > 32767)
                    ifft_out_q[i] <= 16'sh7FFF;
                else if (scaled_im < -32768)
                    ifft_out_q[i] <= 16'sh8000;
                else
                    ifft_out_q[i] <= scaled_im[15:0];
            end

            ifft_done <= 1;
            state     <= ST_OUTPUT;

            `ifdef SIMULATION
            $display("[MF_CHAIN] Inverse FFT complete — range profile ready");
            `endif
        end

        // ================================================================
        // OUTPUT: Stream out 1024 range profile samples, one per clock
        // ================================================================
        ST_OUTPUT: begin
            if (out_count < FFT_SIZE) begin
                out_i_reg     <= ifft_out_i[out_count];
                out_q_reg     <= ifft_out_q[out_count];
                out_valid_reg <= 1'b1;
                out_count     <= out_count + 1;
            end else begin
                state <= ST_DONE;
            end
        end

        // ================================================================
        // DONE: Return to idle, ready for next frame
        // ================================================================
        ST_DONE: begin
            state <= ST_IDLE;

            `ifdef SIMULATION
            $display("[MF_CHAIN] Frame complete, returning to IDLE");
            `endif
        end

        default: state <= ST_IDLE;
        endcase
    end
end

// ============================================================================
// OUTPUT ASSIGNMENTS
// ============================================================================
assign range_profile_i     = out_i_reg;
assign range_profile_q     = out_q_reg;
assign range_profile_valid = out_valid_reg;
assign chain_state         = state;

// ============================================================================
// BUFFER INITIALIZATION (simulation)
// ============================================================================
integer init_idx;
initial begin
    for (init_idx = 0; init_idx < FFT_SIZE; init_idx = init_idx + 1) begin
        fwd_buf_i[init_idx]  = 16'd0;
        fwd_buf_q[init_idx]  = 16'd0;
        fwd_out_i[init_idx]  = 16'd0;
        fwd_out_q[init_idx]  = 16'd0;
        ref_buf_i[init_idx]  = 16'd0;
        ref_buf_q[init_idx]  = 16'd0;
        ref_fft_i[init_idx]  = 16'd0;
        ref_fft_q[init_idx]  = 16'd0;
        mult_out_i[init_idx] = 16'd0;
        mult_out_q[init_idx] = 16'd0;
        ifft_out_i[init_idx] = 16'd0;
        ifft_out_q[init_idx] = 16'd0;
        work_re[init_idx]    = 32'd0;
        work_im[init_idx]    = 32'd0;
    end
end

`else
// ============================================================================
// SYNTHESIS IMPLEMENTATION — Radix-2 DIT FFT via fft_engine
// ============================================================================
// Uses a single fft_engine instance (1024-pt) reused 3 times:
//   1. Forward FFT of signal
//   2. Forward FFT of reference
//   3. Inverse FFT of conjugate product
// Conjugate multiply done via frequency_matched_filter (4-stage pipeline).
//
// Buffer scheme (BRAM-inferrable):
//   sig_buf[1024]:  ADC input -> signal FFT output
//   ref_buf[1024]:  Reference input -> reference FFT output
//   prod_buf[1024]: Conjugate multiply output -> IFFT output
//
// Memory access is INSIDE always @(posedge clk) blocks (no async reset)
// using local blocking variables. This eliminates NBA race conditions
// and enables Vivado BRAM inference (same pattern as fft_engine.v).
//
// BRAM read latency (1 cycle) is handled by "primed" flags:
//   feed_primed  — for FFT feed operations
//   mult_primed  — for conjugate multiply feed
//   out_primed   — for output streaming
// ============================================================================

localparam FFT_SIZE  = 1024;
localparam ADDR_BITS = 10;

// State encoding
localparam [3:0] ST_IDLE     = 4'd0,
                 ST_COLLECT  = 4'd1,   // Collect 1024 ADC + ref samples
                 ST_SIG_FFT  = 4'd2,   // Forward FFT of signal
                 ST_SIG_CAP  = 4'd3,   // Capture signal FFT output
                 ST_REF_FFT  = 4'd4,   // Forward FFT of reference
                 ST_REF_CAP  = 4'd5,   // Capture reference FFT output
                 ST_MULTIPLY = 4'd6,   // Conjugate multiply (pipelined)
                 ST_INV_FFT  = 4'd7,   // Inverse FFT of product
                 ST_INV_CAP  = 4'd8,   // Capture IFFT output
                 ST_OUTPUT   = 4'd9,   // Stream 1024 results
                 ST_DONE     = 4'd10;

reg [3:0] state;

// ============================================================================
// DATA BUFFERS (block RAM) — declared here, accessed in BRAM port blocks
// ============================================================================
(* ram_style = "block" *) reg signed [15:0] sig_buf_i [0:FFT_SIZE-1];
(* ram_style = "block" *) reg signed [15:0] sig_buf_q [0:FFT_SIZE-1];
(* ram_style = "block" *) reg signed [15:0] ref_buf_i [0:FFT_SIZE-1];
(* ram_style = "block" *) reg signed [15:0] ref_buf_q [0:FFT_SIZE-1];
(* ram_style = "block" *) reg signed [15:0] prod_buf_i [0:FFT_SIZE-1];
(* ram_style = "block" *) reg signed [15:0] prod_buf_q [0:FFT_SIZE-1];

// BRAM read data (registered outputs from port blocks)
reg signed [15:0] sig_rdata_i, sig_rdata_q;
reg signed [15:0] ref_rdata_i, ref_rdata_q;
reg signed [15:0] prod_rdata_i, prod_rdata_q;

// ============================================================================
// COUNTERS
// ============================================================================
reg [ADDR_BITS:0] collect_count;   // 0..1024 for sample collection
reg [ADDR_BITS:0] feed_count;      // 0..1024 for feeding FFT engine
reg [ADDR_BITS:0] cap_count;       // 0..1024 for capturing FFT output
reg [ADDR_BITS:0] mult_count;      // 0..1024 for multiply feeding
reg [ADDR_BITS:0] out_count;       // 0..1024 for output streaming

// BRAM read latency pipeline flags
reg feed_primed;   // 1 = BRAM rdata valid for feed operations
reg mult_primed;   // 1 = BRAM rdata valid for multiply reads
reg out_primed;    // 1 = BRAM rdata valid for output reads

// ============================================================================
// FFT ENGINE INTERFACE (single instance, reused 3 times)
// ============================================================================
reg fft_start;
reg fft_inverse;
reg signed [15:0] fft_din_re, fft_din_im;
reg fft_din_valid;
wire signed [15:0] fft_dout_re, fft_dout_im;
wire fft_dout_valid;
wire fft_busy;
wire fft_done;

fft_engine #(
    .N(FFT_SIZE),
    .LOG2N(ADDR_BITS),
    .DATA_W(16),
    .INTERNAL_W(32),
    .TWIDDLE_W(16),
    .TWIDDLE_FILE("fft_twiddle_1024.mem")
) fft_inst (
    .clk(clk),
    .reset_n(reset_n),
    .start(fft_start),
    .inverse(fft_inverse),
    .din_re(fft_din_re),
    .din_im(fft_din_im),
    .din_valid(fft_din_valid),
    .dout_re(fft_dout_re),
    .dout_im(fft_dout_im),
    .dout_valid(fft_dout_valid),
    .busy(fft_busy),
    .done(fft_done)
);

// ============================================================================
// CONJUGATE MULTIPLY INTERFACE (frequency_matched_filter)
// ============================================================================
reg signed [15:0] mf_sig_re, mf_sig_im;
reg signed [15:0] mf_ref_re, mf_ref_im;
reg mf_valid_in;
wire signed [15:0] mf_out_re, mf_out_im;
wire mf_valid_out;

frequency_matched_filter mf_inst (
    .clk(clk),
    .reset_n(reset_n),
    .fft_real_in(mf_sig_re),
    .fft_imag_in(mf_sig_im),
    .fft_valid_in(mf_valid_in),
    .ref_chirp_real(mf_ref_re),
    .ref_chirp_imag(mf_ref_im),
    .filtered_real(mf_out_re),
    .filtered_imag(mf_out_im),
    .filtered_valid(mf_valid_out),
    .state()
);

// Pipeline flush counter for matched filter (4-stage pipeline)
reg [2:0] mf_flush_count;

// ============================================================================
// OUTPUT REGISTERS
// ============================================================================
reg out_valid_reg;
reg signed [15:0] out_i_reg, out_q_reg;

// ============================================================================
// BRAM PORT: sig_buf — all address/we/wdata computed inline (race-free)
// ============================================================================
// Handles: IDLE/COLLECT writes, SIG_FFT/SIG_CAP capture writes,
//          SIG_FFT feed reads, MULTIPLY signal reads
// No async reset in sensitivity list — enables Vivado BRAM inference.
// ============================================================================
always @(posedge clk) begin : sig_bram_port
    reg                    we;
    reg  [ADDR_BITS-1:0]   addr;
    reg  signed [15:0]     wdata_i, wdata_q;

    // Defaults
    we      = 1'b0;
    addr    = 0;
    wdata_i = 0;
    wdata_q = 0;

    case (state)
    ST_IDLE: begin
        if (adc_valid) begin
            we      = 1'b1;
            addr    = 0;
            wdata_i = $signed(adc_data_i);
            wdata_q = $signed(adc_data_q);
        end
    end
    ST_COLLECT: begin
        if (adc_valid && collect_count < FFT_SIZE) begin
            we      = 1'b1;
            addr    = collect_count[ADDR_BITS-1:0];
            wdata_i = $signed(adc_data_i);
            wdata_q = $signed(adc_data_q);
        end
    end
    ST_SIG_FFT: begin
        if (feed_count < FFT_SIZE && !feed_primed) begin
            // Pre-read cycle: present address, no write
            addr = feed_count[ADDR_BITS-1:0];
        end else if (feed_count <= FFT_SIZE && feed_primed) begin
            // Primed: read address for NEXT sample (or hold last)
            if (feed_count < FFT_SIZE)
                addr = feed_count[ADDR_BITS-1:0];
            else
                addr = 0; // don't care, past last sample
        end
        // Capture FFT output (write) — happens after feeding is done
        if (fft_dout_valid && cap_count < FFT_SIZE) begin
            we      = 1'b1;
            addr    = cap_count[ADDR_BITS-1:0];
            wdata_i = fft_dout_re;
            wdata_q = fft_dout_im;
        end
    end
    ST_SIG_CAP: begin
        if (fft_dout_valid && cap_count < FFT_SIZE) begin
            we      = 1'b1;
            addr    = cap_count[ADDR_BITS-1:0];
            wdata_i = fft_dout_re;
            wdata_q = fft_dout_im;
        end
    end
    ST_MULTIPLY: begin
        // Read signal FFT results for conjugate multiply
        if (mult_count < FFT_SIZE && !mult_primed) begin
            addr = mult_count[ADDR_BITS-1:0];
        end else if (mult_count <= FFT_SIZE && mult_primed) begin
            if (mult_count < FFT_SIZE)
                addr = mult_count[ADDR_BITS-1:0];
            else
                addr = 0;
        end
    end
    default: begin
        // keep defaults
    end
    endcase

    // BRAM write
    if (we) begin
        sig_buf_i[addr] <= wdata_i;
        sig_buf_q[addr] <= wdata_q;
    end
    // BRAM read (1-cycle latency)
    sig_rdata_i <= sig_buf_i[addr];
    sig_rdata_q <= sig_buf_q[addr];
end

// ============================================================================
// BRAM PORT: ref_buf — all address/we/wdata computed inline (race-free)
// ============================================================================
// Handles: IDLE/COLLECT writes, REF_FFT/REF_CAP capture writes,
//          REF_FFT feed reads, MULTIPLY reference reads
// ============================================================================
always @(posedge clk) begin : ref_bram_port
    reg                    we;
    reg  [ADDR_BITS-1:0]   addr;
    reg  signed [15:0]     wdata_i, wdata_q;

    // Defaults
    we      = 1'b0;
    addr    = 0;
    wdata_i = 0;
    wdata_q = 0;

    case (state)
    ST_IDLE: begin
        if (adc_valid) begin
            we      = 1'b1;
            addr    = 0;
            wdata_i = $signed(long_chirp_real);
            wdata_q = $signed(long_chirp_imag);
        end
    end
    ST_COLLECT: begin
        if (adc_valid && collect_count < FFT_SIZE) begin
            we      = 1'b1;
            addr    = collect_count[ADDR_BITS-1:0];
            wdata_i = $signed(long_chirp_real);
            wdata_q = $signed(long_chirp_imag);
        end
    end
    ST_REF_FFT: begin
        if (feed_count < FFT_SIZE && !feed_primed) begin
            addr = feed_count[ADDR_BITS-1:0];
        end else if (feed_count <= FFT_SIZE && feed_primed) begin
            if (feed_count < FFT_SIZE)
                addr = feed_count[ADDR_BITS-1:0];
            else
                addr = 0;
        end
        // Capture FFT output
        if (fft_dout_valid && cap_count < FFT_SIZE) begin
            we      = 1'b1;
            addr    = cap_count[ADDR_BITS-1:0];
            wdata_i = fft_dout_re;
            wdata_q = fft_dout_im;
        end
    end
    ST_REF_CAP: begin
        if (fft_dout_valid && cap_count < FFT_SIZE) begin
            we      = 1'b1;
            addr    = cap_count[ADDR_BITS-1:0];
            wdata_i = fft_dout_re;
            wdata_q = fft_dout_im;
        end
    end
    ST_MULTIPLY: begin
        // Read reference FFT results for conjugate multiply
        if (mult_count < FFT_SIZE && !mult_primed) begin
            addr = mult_count[ADDR_BITS-1:0];
        end else if (mult_count <= FFT_SIZE && mult_primed) begin
            if (mult_count < FFT_SIZE)
                addr = mult_count[ADDR_BITS-1:0];
            else
                addr = 0;
        end
    end
    default: begin
        // keep defaults
    end
    endcase

    // BRAM write
    if (we) begin
        ref_buf_i[addr] <= wdata_i;
        ref_buf_q[addr] <= wdata_q;
    end
    // BRAM read (1-cycle latency)
    ref_rdata_i <= ref_buf_i[addr];
    ref_rdata_q <= ref_buf_q[addr];
end

// ============================================================================
// BRAM PORT: prod_buf — all address/we/wdata computed inline (race-free)
// ============================================================================
// Handles: MULTIPLY capture writes, INV_FFT/INV_CAP capture writes,
//          INV_FFT feed reads, OUTPUT reads
// ============================================================================
always @(posedge clk) begin : prod_bram_port
    reg                    we;
    reg  [ADDR_BITS-1:0]   addr;
    reg  signed [15:0]     wdata_i, wdata_q;

    // Defaults
    we      = 1'b0;
    addr    = 0;
    wdata_i = 0;
    wdata_q = 0;

    case (state)
    ST_MULTIPLY: begin
        // Capture conjugate multiply output
        if (mf_valid_out && cap_count < FFT_SIZE) begin
            we      = 1'b1;
            addr    = cap_count[ADDR_BITS-1:0];
            wdata_i = mf_out_re;
            wdata_q = mf_out_im;
        end
    end
    ST_INV_FFT: begin
        if (feed_count < FFT_SIZE && !feed_primed) begin
            addr = feed_count[ADDR_BITS-1:0];
        end else if (feed_count <= FFT_SIZE && feed_primed) begin
            if (feed_count < FFT_SIZE)
                addr = feed_count[ADDR_BITS-1:0];
            else
                addr = 0;
        end
        // Capture IFFT output
        if (fft_dout_valid && cap_count < FFT_SIZE) begin
            we      = 1'b1;
            addr    = cap_count[ADDR_BITS-1:0];
            wdata_i = fft_dout_re;
            wdata_q = fft_dout_im;
        end
    end
    ST_INV_CAP: begin
        if (fft_dout_valid && cap_count < FFT_SIZE) begin
            we      = 1'b1;
            addr    = cap_count[ADDR_BITS-1:0];
            wdata_i = fft_dout_re;
            wdata_q = fft_dout_im;
        end
    end
    ST_OUTPUT: begin
        // Read product buffer for output streaming
        if (out_count < FFT_SIZE && !out_primed) begin
            addr = out_count[ADDR_BITS-1:0];
        end else if (out_count <= FFT_SIZE && out_primed) begin
            if (out_count < FFT_SIZE)
                addr = out_count[ADDR_BITS-1:0];
            else
                addr = 0;
        end
    end
    default: begin
        // keep defaults
    end
    endcase

    // BRAM write
    if (we) begin
        prod_buf_i[addr] <= wdata_i;
        prod_buf_q[addr] <= wdata_q;
    end
    // BRAM read (1-cycle latency)
    prod_rdata_i <= prod_buf_i[addr];
    prod_rdata_q <= prod_buf_q[addr];
end

// ============================================================================
// MAIN FSM — no buffer array accesses here (all via BRAM ports above)
// ============================================================================
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        state          <= ST_IDLE;
        collect_count  <= 0;
        feed_count     <= 0;
        cap_count      <= 0;
        mult_count     <= 0;
        out_count      <= 0;
        feed_primed    <= 1'b0;
        mult_primed    <= 1'b0;
        out_primed     <= 1'b0;
        fft_start      <= 1'b0;
        fft_inverse    <= 1'b0;
        fft_din_re     <= 0;
        fft_din_im     <= 0;
        fft_din_valid  <= 1'b0;
        mf_sig_re      <= 0;
        mf_sig_im      <= 0;
        mf_ref_re      <= 0;
        mf_ref_im      <= 0;
        mf_valid_in    <= 1'b0;
        mf_flush_count <= 0;
        out_valid_reg  <= 1'b0;
        out_i_reg      <= 0;
        out_q_reg      <= 0;
    end else begin
        // Defaults
        fft_start     <= 1'b0;
        fft_din_valid <= 1'b0;
        mf_valid_in   <= 1'b0;
        out_valid_reg <= 1'b0;

        case (state)

        // ================================================================
        ST_IDLE: begin
            collect_count <= 0;
            feed_primed   <= 1'b0;
            mult_primed   <= 1'b0;
            out_primed    <= 1'b0;
            if (adc_valid) begin
                // First sample written by sig/ref BRAM ports (they see
                // state==ST_IDLE && adc_valid)
                collect_count <= 1;
                state <= ST_COLLECT;
            end
        end

        // ================================================================
        // COLLECT: Gather 1024 ADC + reference samples
        // Writes happen in sig/ref BRAM ports (they see state==ST_COLLECT)
        // ================================================================
        ST_COLLECT: begin
            if (adc_valid && collect_count < FFT_SIZE) begin
                collect_count <= collect_count + 1;
            end

            if (collect_count == FFT_SIZE) begin
                // All 1024 samples collected — start signal FFT
                state       <= ST_SIG_FFT;
                fft_start   <= 1'b1;
                fft_inverse <= 1'b0;  // Forward FFT
                feed_count  <= 0;
                cap_count   <= 0;
                feed_primed <= 1'b0;
            end
        end

        // ================================================================
        // SIG_FFT: Feed signal buffer to FFT engine (forward)
        // BRAM read has 1-cycle latency: address presented in BRAM port,
        // data available in sig_rdata_i/q next cycle.
        // ================================================================
        ST_SIG_FFT: begin
            // Feed phase: read sig_buf -> fft_din
            if (feed_count < FFT_SIZE) begin
                if (!feed_primed) begin
                    // Pre-read cycle: address presented to BRAM, wait 1 cycle
                    feed_primed <= 1'b1;
                    feed_count  <= feed_count + 1;
                    // fft_din_valid stays 0 (default)
                end else begin
                    // Primed: BRAM rdata is valid for previous address
                    fft_din_re    <= sig_rdata_i;
                    fft_din_im    <= sig_rdata_q;
                    fft_din_valid <= 1'b1;
                    feed_count    <= feed_count + 1;
                end
            end else if (feed_count == FFT_SIZE && feed_primed) begin
                // Last sample: BRAM rdata has data for address 1023
                fft_din_re    <= sig_rdata_i;
                fft_din_im    <= sig_rdata_q;
                fft_din_valid <= 1'b1;
                feed_count    <= feed_count + 1; // -> 1025, stops feeding
            end

            // Capture FFT output (writes happen in BRAM port)
            if (fft_dout_valid && cap_count < FFT_SIZE) begin
                cap_count <= cap_count + 1;
            end

            if (fft_done) begin
                state <= ST_SIG_CAP;
            end
        end

        // ================================================================
        // SIG_CAP: Ensure all signal FFT outputs captured
        // ================================================================
        ST_SIG_CAP: begin
            if (fft_dout_valid && cap_count < FFT_SIZE) begin
                cap_count <= cap_count + 1;
            end

            // Start reference FFT
            state       <= ST_REF_FFT;
            fft_start   <= 1'b1;
            fft_inverse <= 1'b0;  // Forward FFT
            feed_count  <= 0;
            cap_count   <= 0;
            feed_primed <= 1'b0;
        end

        // ================================================================
        // REF_FFT: Feed reference buffer to FFT engine (forward)
        // ================================================================
        ST_REF_FFT: begin
            // Feed phase: read ref_buf -> fft_din
            if (feed_count < FFT_SIZE) begin
                if (!feed_primed) begin
                    feed_primed <= 1'b1;
                    feed_count  <= feed_count + 1;
                end else begin
                    fft_din_re    <= ref_rdata_i;
                    fft_din_im    <= ref_rdata_q;
                    fft_din_valid <= 1'b1;
                    feed_count    <= feed_count + 1;
                end
            end else if (feed_count == FFT_SIZE && feed_primed) begin
                fft_din_re    <= ref_rdata_i;
                fft_din_im    <= ref_rdata_q;
                fft_din_valid <= 1'b1;
                feed_count    <= feed_count + 1;
            end

            if (fft_dout_valid && cap_count < FFT_SIZE) begin
                cap_count <= cap_count + 1;
            end

            if (fft_done) begin
                state <= ST_REF_CAP;
            end
        end

        // ================================================================
        // REF_CAP: Ensure all ref FFT outputs captured
        // ================================================================
        ST_REF_CAP: begin
            if (fft_dout_valid && cap_count < FFT_SIZE) begin
                cap_count <= cap_count + 1;
            end

            state          <= ST_MULTIPLY;
            mult_count     <= 0;
            cap_count      <= 0;
            mf_flush_count <= 0;
            mult_primed    <= 1'b0;
        end

        // ================================================================
        // MULTIPLY: Stream sig FFT and ref FFT through freq_matched_filter
        // Both sig_buf and ref_buf are read simultaneously (separate BRAM
        // ports). Pipeline latency = 4 clocks. Feed 1024 pairs, then flush.
        // ================================================================
        ST_MULTIPLY: begin
            if (mult_count < FFT_SIZE) begin
                if (!mult_primed) begin
                    // Pre-read cycle
                    mult_primed <= 1'b1;
                    mult_count  <= mult_count + 1;
                end else begin
                    mf_sig_re   <= sig_rdata_i;
                    mf_sig_im   <= sig_rdata_q;
                    mf_ref_re   <= ref_rdata_i;
                    mf_ref_im   <= ref_rdata_q;
                    mf_valid_in <= 1'b1;
                    mult_count  <= mult_count + 1;
                end
            end else if (mult_count == FFT_SIZE && mult_primed) begin
                // Last sample
                mf_sig_re   <= sig_rdata_i;
                mf_sig_im   <= sig_rdata_q;
                mf_ref_re   <= ref_rdata_i;
                mf_ref_im   <= ref_rdata_q;
                mf_valid_in <= 1'b1;
                mult_count  <= mult_count + 1;
            end else begin
                // Pipeline flush — wait for remaining outputs
                mf_flush_count <= mf_flush_count + 1;
            end

            // Capture multiply outputs (writes happen in BRAM port)
            if (mf_valid_out && cap_count < FFT_SIZE) begin
                cap_count <= cap_count + 1;
            end

            // Done when all outputs captured
            if (cap_count == FFT_SIZE) begin
                state       <= ST_INV_FFT;
                fft_start   <= 1'b1;
                fft_inverse <= 1'b1;  // Inverse FFT
                feed_count  <= 0;
                cap_count   <= 0;
                feed_primed <= 1'b0;
            end
        end

        // ================================================================
        // INV_FFT: Feed product buffer to FFT engine (inverse)
        // ================================================================
        ST_INV_FFT: begin
            if (feed_count < FFT_SIZE) begin
                if (!feed_primed) begin
                    feed_primed <= 1'b1;
                    feed_count  <= feed_count + 1;
                end else begin
                    fft_din_re    <= prod_rdata_i;
                    fft_din_im    <= prod_rdata_q;
                    fft_din_valid <= 1'b1;
                    feed_count    <= feed_count + 1;
                end
            end else if (feed_count == FFT_SIZE && feed_primed) begin
                fft_din_re    <= prod_rdata_i;
                fft_din_im    <= prod_rdata_q;
                fft_din_valid <= 1'b1;
                feed_count    <= feed_count + 1;
            end

            if (fft_dout_valid && cap_count < FFT_SIZE) begin
                cap_count <= cap_count + 1;
            end

            if (fft_done) begin
                state <= ST_INV_CAP;
            end
        end

        // ================================================================
        // INV_CAP: Ensure all IFFT outputs captured
        // ================================================================
        ST_INV_CAP: begin
            if (fft_dout_valid && cap_count < FFT_SIZE) begin
                cap_count <= cap_count + 1;
            end

            state      <= ST_OUTPUT;
            out_count  <= 0;
            out_primed <= 1'b0;
        end

        // ================================================================
        // OUTPUT: Stream 1024 range profile samples
        // BRAM read latency: present address, data valid next cycle.
        // ================================================================
        ST_OUTPUT: begin
            if (out_count < FFT_SIZE) begin
                if (!out_primed) begin
                    // Pre-read cycle
                    out_primed <= 1'b1;
                    out_count  <= out_count + 1;
                end else begin
                    out_i_reg     <= prod_rdata_i;
                    out_q_reg     <= prod_rdata_q;
                    out_valid_reg <= 1'b1;
                    out_count     <= out_count + 1;
                end
            end else if (out_count == FFT_SIZE && out_primed) begin
                // Last sample
                out_i_reg     <= prod_rdata_i;
                out_q_reg     <= prod_rdata_q;
                out_valid_reg <= 1'b1;
                out_count     <= out_count + 1;
            end else begin
                state <= ST_DONE;
            end
        end

        // ================================================================
        // DONE: Return to idle
        // ================================================================
        ST_DONE: begin
            state <= ST_IDLE;
        end

        default: state <= ST_IDLE;

        endcase
    end
end

// ============================================================================
// OUTPUT ASSIGNMENTS
// ============================================================================
assign range_profile_i     = out_i_reg;
assign range_profile_q     = out_q_reg;
assign range_profile_valid = out_valid_reg;
assign chain_state         = state;

// ============================================================================
// BUFFER INIT (for simulation — Vivado ignores initial blocks on arrays)
// ============================================================================
integer init_idx;
initial begin
    for (init_idx = 0; init_idx < FFT_SIZE; init_idx = init_idx + 1) begin
        sig_buf_i[init_idx]  = 0;
        sig_buf_q[init_idx]  = 0;
        ref_buf_i[init_idx]  = 0;
        ref_buf_q[init_idx]  = 0;
        prod_buf_i[init_idx] = 0;
        prod_buf_q[init_idx] = 0;
    end
end

`endif

endmodule
