`timescale 1ns / 1ps

// ============================================================================
// Formal Verification Wrapper: doppler_processor_optimized
// AERIS-10 Radar FPGA — Doppler processing FSM with FFT
// Target: SymbiYosys with smtbmc/z3
//
// Single-clock design: clk is an input wire, async2sync handles async reset.
// Each formal step = one clock edge.
//
// Parameters: RANGE_BINS reduced for tractability, but the FFT/sub-frame size
// remains 16 so the wrapper matches the real xfft_16 interface.
// Includes full xfft_16 and fft_engine sub-modules.
//
// Focus: memory address bounds (highest-value finding) and state encoding.
// ============================================================================
module fv_doppler_processor (
    input wire clk
);

    // Only RANGE_BINS is reduced; the FFT wrapper still expects 16 samples.
    localparam RANGE_BINS       = 2;
    localparam CHIRPS_PER_FRAME = 32;
    localparam CHIRPS_PER_SUBFRAME = 16;
    localparam DOPPLER_FFT_SIZE = 16;
    localparam MEM_DEPTH        = RANGE_BINS * CHIRPS_PER_FRAME;

    // State encoding (mirrors DUT localparams)
    localparam S_IDLE       = 3'b000;
    localparam S_ACCUMULATE = 3'b001;
    localparam S_PRE_READ   = 3'b101;
    localparam S_LOAD_FFT   = 3'b010;
    localparam S_FFT_WAIT   = 3'b011;
    localparam S_OUTPUT     = 3'b100;

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
    // DUT inputs (solver-driven each cycle)
    // ================================================================
    (* anyseq *) wire [31:0] range_data;
    (* anyseq *) wire        data_valid;
    (* anyseq *) wire        new_chirp_frame;

    // ================================================================
    // DUT outputs
    // ================================================================
    wire [31:0] doppler_output;
    wire        doppler_valid;
    wire [4:0]  doppler_bin;
    wire [5:0]  range_bin;
    wire        sub_frame;
    wire        processing_active;
    wire        frame_complete;
    wire [3:0]  status;

    // Formal-only DUT outputs (internal state)
    wire [2:0]  state;
    wire [10:0] mem_write_addr;
    wire [10:0] mem_read_addr;
    wire [5:0]  write_range_bin;
    wire [4:0]  write_chirp_index;
    wire [5:0]  read_range_bin;
    wire [4:0]  read_doppler_index;
    wire [9:0]  processing_timeout;
    wire        frame_buffer_full;
    wire        mem_we;
    wire [10:0] mem_waddr_r;

    // ================================================================
    // DUT instantiation
    // ================================================================
    doppler_processor_optimized #(
        .DOPPLER_FFT_SIZE (DOPPLER_FFT_SIZE),
        .RANGE_BINS       (RANGE_BINS),
        .CHIRPS_PER_FRAME (CHIRPS_PER_FRAME),
        .CHIRPS_PER_SUBFRAME (CHIRPS_PER_SUBFRAME),
        .WINDOW_TYPE      (1),   // Rectangular — simpler for formal
        .DATA_WIDTH       (16)
    ) dut (
        .clk              (clk),
        .reset_n          (reset_n),
        .range_data       (range_data),
        .data_valid       (data_valid),
        .new_chirp_frame  (new_chirp_frame),
        .doppler_output   (doppler_output),
        .doppler_valid    (doppler_valid),
        .doppler_bin      (doppler_bin),
        .range_bin        (range_bin),
        .sub_frame        (sub_frame),
        .processing_active(processing_active),
        .frame_complete   (frame_complete),
        .status           (status),
        .fv_state              (state),
        .fv_mem_write_addr     (mem_write_addr),
        .fv_mem_read_addr      (mem_read_addr),
        .fv_write_range_bin    (write_range_bin),
        .fv_write_chirp_index  (write_chirp_index),
        .fv_read_range_bin     (read_range_bin),
        .fv_read_doppler_index (read_doppler_index),
        .fv_processing_timeout (processing_timeout),
        .fv_frame_buffer_full  (frame_buffer_full),
        .fv_mem_we             (mem_we),
        .fv_mem_waddr_r        (mem_waddr_r)
    );

    // Internals now accessed via formal output ports

    // ================================================================
    // Input assumptions
    // ================================================================

    // data_valid should not assert when frame buffer is already full
    always @(posedge clk) begin
        if (reset_n && frame_buffer_full)
            assume(!data_valid);
    end

    // new_chirp_frame may assert during accumulation at the 16-chirp boundary.
    // Only suppress it during FFT-processing states.
    always @(posedge clk) begin
        if (reset_n && (state == S_PRE_READ || state == S_LOAD_FFT ||
                        state == S_FFT_WAIT || state == S_OUTPUT))
            assume(!new_chirp_frame);
    end

    // ================================================================
    // PROPERTY 1: Memory write address bounds
    // mem_waddr_r must be within MEM_DEPTH whenever mem_we is active
    // ================================================================
    always @(posedge clk) begin
        if (reset_n && mem_we)
            assert(mem_waddr_r < MEM_DEPTH);
    end

    // ================================================================
    // PROPERTY 2: Memory read address bounds
    // KEY BUG TARGET: read_doppler_index overflow from
    //   fft_sample_counter + 2 truncation (doppler_processor.v:329)
    //   causes wrong mem_read_addr.
    // ================================================================
    always @(posedge clk) begin
        if (reset_n) begin
            if (state == S_PRE_READ || state == S_LOAD_FFT ||
                state == S_FFT_WAIT)
                assert(mem_read_addr < MEM_DEPTH);
        end
    end

    // ================================================================
    // PROPERTY 3: Write pointer bounds
    // ================================================================
    always @(posedge clk) begin
        if (reset_n) begin
            assert(write_range_bin < RANGE_BINS);
            assert(write_chirp_index < CHIRPS_PER_FRAME);
        end
    end

    // ================================================================
    // PROPERTY 4: State encoding — only 6 valid states
    // ================================================================
    always @(posedge clk) begin
        if (reset_n) begin
            assert(state == S_IDLE       ||
                   state == S_ACCUMULATE ||
                   state == S_PRE_READ   ||
                   state == S_LOAD_FFT   ||
                   state == S_FFT_WAIT   ||
                   state == S_OUTPUT);
        end
    end

    // ================================================================
    // PROPERTY 5: Timeout bound
    // processing_timeout is loaded with 1000 and counts down.
    // ================================================================
    always @(posedge clk) begin
        if (reset_n)
            assert(processing_timeout < 1001);
    end

    // ================================================================
    // PROPERTY 6: Read range bin bound
    // ================================================================
    always @(posedge clk) begin
        if (reset_n)
            assert(read_range_bin < RANGE_BINS);
    end

    // ================================================================
    // COVER 1: Complete processing of all range bins after a full frame was
    // actually accumulated.
    // ================================================================
    reg f_seen_full;
    initial f_seen_full = 1'b0;
    always @(posedge clk)
        if (frame_buffer_full) f_seen_full <= 1'b1;

    always @(posedge clk) begin
        if (reset_n)
            cover(frame_complete && f_seen_full);
    end

    // ================================================================
    // COVER 2: Each state is reachable
    // ================================================================
    always @(posedge clk) begin
        if (reset_n) begin
            cover(state == S_IDLE);
            cover(state == S_ACCUMULATE);
            cover(state == S_PRE_READ);
            cover(state == S_LOAD_FFT);
            cover(state == S_FFT_WAIT);
            cover(state == S_OUTPUT);
        end
    end

`endif // FORMAL

endmodule
