`timescale 1ns / 1ps

// ============================================================================
// doppler_processor.v — Staggered-PRF Doppler Processor (CORRECTED)
// ============================================================================
//
// ARCHITECTURE:
//   This module implements dual 16-point FFTs for the AERIS-10 staggered-PRF
//   waveform. The radar transmits 16 long-PRI chirps followed by 16 short-PRI
//   chirps per frame (32 total). Rather than a single 32-point FFT over the
//   non-uniformly sampled frame (which is signal-processing invalid), this
//   module processes each sub-frame independently:
//
//     Sub-frame 0 (long PRI):  chirps 0..15  → 16-pt windowed FFT
//     Sub-frame 1 (short PRI): chirps 16..31 → 16-pt windowed FFT
//
//   Each sub-frame produces 16 Doppler bins per range bin. The outputs are
//   tagged with a sub_frame bit and the 4-bit bin index is packed into the
//   existing 5-bit doppler_bin port as {sub_frame, bin[3:0]}.
//
//   This architecture enables downstream staggered-PRF ambiguity resolution:
//   the same target velocity maps to DIFFERENT Doppler bins at different PRIs,
//   and comparing the two sub-frame results resolves velocity ambiguity.
//
// INTERFACE COMPATIBILITY:
//   The port list is a superset of the original module. Existing instantiations
//   that don't connect `sub_frame` will still work. The FORMAL ports are
//   retained. CHIRPS_PER_FRAME must be 32 (16 per sub-frame).
//
// WINDOW:
//   16-point Hamming window (Q15), symmetric. Computed as:
//     w[n] = 0.54 - 0.46 * cos(2*pi*n/15), n=0..15
// ============================================================================

module doppler_processor_optimized #(
    parameter DOPPLER_FFT_SIZE   = 16,     // FFT size per sub-frame (was 32)
    parameter RANGE_BINS         = 64,
    parameter CHIRPS_PER_FRAME   = 32,     // Total chirps in frame (16+16)
    parameter CHIRPS_PER_SUBFRAME = 16,    // Chirps per sub-frame
    parameter WINDOW_TYPE        = 0,      // 0=Hamming, 1=Rectangular
    parameter DATA_WIDTH         = 16
)(
    input wire clk,
    input wire reset_n,
    input wire [31:0] range_data,
    input wire data_valid,
    input wire new_chirp_frame,
    output reg [31:0] doppler_output,
    output reg doppler_valid,
    output reg [4:0] doppler_bin,      // {sub_frame, bin[3:0]}
    output reg [5:0] range_bin,
    output reg sub_frame,              // 0=long PRI, 1=short PRI
    output wire processing_active,
    output wire frame_complete,
    output reg [3:0] status

`ifdef FORMAL
    ,
    output wire [2:0]  fv_state,
    output wire [10:0] fv_mem_write_addr,
    output wire [10:0] fv_mem_read_addr,
    output wire [5:0]  fv_write_range_bin,
    output wire [4:0]  fv_write_chirp_index,
    output wire [5:0]  fv_read_range_bin,
    output wire [4:0]  fv_read_doppler_index,
    output wire [9:0]  fv_processing_timeout,
    output wire        fv_frame_buffer_full,
    output wire        fv_mem_we,
    output wire [10:0] fv_mem_waddr_r
`endif
);

// ==============================================
// Window Coefficients — 16-point Hamming (Q15)
// ==============================================
// w[n] = 0.54 - 0.46 * cos(2*pi*n/15), n=0..15
// Symmetric: w[n] = w[15-n]
reg [DATA_WIDTH-1:0] window_coeff [0:15];

integer w;
initial begin
    if (WINDOW_TYPE == 0) begin
        // 16-point Hamming window, Q15 format
        // Computed: round(32767 * (0.54 - 0.46*cos(2*pi*n/15)))
        window_coeff[0]  = 16'h0A3D;  // 0.0800 * 32767 = 2621
        window_coeff[1]  = 16'h0E5C;  // 0.1116 * 32767 = 3676
        window_coeff[2]  = 16'h1B6D;  // 0.2138 * 32767 = 7021
        window_coeff[3]  = 16'h3088;  // 0.3790 * 32767 = 12424
        window_coeff[4]  = 16'h4B33;  // 0.5868 * 32767 = 19251
        window_coeff[5]  = 16'h6573;  // 0.7930 * 32767 = 25971
        window_coeff[6]  = 16'h7642;  // 0.9245 * 32767 = 30274
        window_coeff[7]  = 16'h7F62;  // 0.9932 * 32767 = 32610
        window_coeff[8]  = 16'h7F62;  // symmetric
        window_coeff[9]  = 16'h7642;
        window_coeff[10] = 16'h6573;
        window_coeff[11] = 16'h4B33;
        window_coeff[12] = 16'h3088;
        window_coeff[13] = 16'h1B6D;
        window_coeff[14] = 16'h0E5C;
        window_coeff[15] = 16'h0A3D;
    end else begin
        for (w = 0; w < 16; w = w + 1) begin
            window_coeff[w] = 16'h7FFF;
        end
    end
end

// ==============================================
// Memory Declaration - FIXED SIZE
// ==============================================
localparam MEM_DEPTH = RANGE_BINS * CHIRPS_PER_FRAME;
(* ram_style = "block" *) reg [DATA_WIDTH-1:0] doppler_i_mem [0:MEM_DEPTH-1];
(* ram_style = "block" *) reg [DATA_WIDTH-1:0] doppler_q_mem [0:MEM_DEPTH-1];

// ==============================================
// Control Registers
// ==============================================
reg [5:0] write_range_bin;
reg [4:0] write_chirp_index;
reg [5:0] read_range_bin;
reg [4:0] read_doppler_index;
reg frame_buffer_full;
reg [9:0] chirps_received;
reg [1:0] chirp_state;

// Sub-frame tracking
reg current_sub_frame;   // 0=processing long, 1=processing short

// ==============================================
// FFT Interface
// ==============================================
reg fft_start;
wire fft_ready;
reg [DATA_WIDTH-1:0] fft_input_i;
reg [DATA_WIDTH-1:0] fft_input_q;
reg signed [31:0] mult_i, mult_q;
reg signed [DATA_WIDTH-1:0] window_val_reg;
reg signed [31:0] mult_i_raw, mult_q_raw;

reg fft_input_valid;
reg fft_input_last;
wire [DATA_WIDTH-1:0] fft_output_i;
wire [DATA_WIDTH-1:0] fft_output_q;
wire fft_output_valid;
wire fft_output_last;

// ==============================================
// Addressing
// ==============================================
wire [10:0] mem_write_addr;
wire [10:0] mem_read_addr;

assign mem_write_addr = (write_chirp_index * RANGE_BINS) + write_range_bin;
assign mem_read_addr = (read_doppler_index * RANGE_BINS) + read_range_bin;

// ==============================================
// State Machine
// ==============================================
reg [2:0] state;
localparam S_IDLE       = 3'b000;
localparam S_ACCUMULATE = 3'b001;
localparam S_PRE_READ   = 3'b101;
localparam S_LOAD_FFT   = 3'b010;
localparam S_FFT_WAIT   = 3'b011;
localparam S_OUTPUT     = 3'b100;

// Frame sync detection
reg new_chirp_frame_d1;
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) new_chirp_frame_d1 <= 0;
    else new_chirp_frame_d1 <= new_chirp_frame;
end
wire frame_start_pulse = new_chirp_frame & ~new_chirp_frame_d1;

// ==============================================
// Main State Machine
// ==============================================
reg [4:0] fft_sample_counter;  // Reduced: only need 0..17 for 16-pt FFT
reg [9:0] processing_timeout;

// Memory write enable and data signals
reg mem_we;
reg [10:0] mem_waddr_r;
reg [DATA_WIDTH-1:0] mem_wdata_i, mem_wdata_q;

// Memory read data
reg [DATA_WIDTH-1:0] mem_rdata_i, mem_rdata_q;

`ifdef FORMAL
assign fv_state              = state;
assign fv_mem_write_addr     = mem_write_addr;
assign fv_mem_read_addr      = mem_read_addr;
assign fv_write_range_bin    = write_range_bin;
assign fv_write_chirp_index  = write_chirp_index;
assign fv_read_range_bin     = read_range_bin;
assign fv_read_doppler_index = read_doppler_index;
assign fv_processing_timeout = processing_timeout;
assign fv_frame_buffer_full  = frame_buffer_full;
assign fv_mem_we             = mem_we;
assign fv_mem_waddr_r        = mem_waddr_r;
`endif

// ----------------------------------------------------------
// Separate always block for memory writes — NO async reset
// ----------------------------------------------------------
always @(posedge clk) begin
    if (mem_we) begin
        doppler_i_mem[mem_waddr_r] <= mem_wdata_i;
        doppler_q_mem[mem_waddr_r] <= mem_wdata_q;
    end
    mem_rdata_i <= doppler_i_mem[mem_read_addr];
    mem_rdata_q <= doppler_q_mem[mem_read_addr];
end

// ----------------------------------------------------------
// Block 1: FSM / Control — async reset
// ----------------------------------------------------------
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        state <= S_IDLE;
        write_range_bin <= 0;
        write_chirp_index <= 0;
        frame_buffer_full <= 0;
        doppler_valid <= 0;
        fft_start <= 0;
        fft_input_valid <= 0;
        fft_input_last <= 0;
        fft_sample_counter <= 0;
        processing_timeout <= 0;
        status <= 0;
        chirps_received <= 0;
        chirp_state <= 0;
        doppler_output <= 0;
        doppler_bin <= 0;
        range_bin <= 0;
        sub_frame <= 0;
        current_sub_frame <= 0;
    end else begin
        doppler_valid <= 0;
        fft_input_valid <= 0;
        fft_input_last <= 0;
        
        if (processing_timeout > 0) begin
            processing_timeout <= processing_timeout - 1;
        end
        
        case (state)
            S_IDLE: begin
                if (frame_start_pulse) begin
                    write_chirp_index <= 0;
                    write_range_bin <= 0;
                    frame_buffer_full <= 0;
                    chirps_received <= 0;
                end
                
                if (data_valid && !frame_buffer_full) begin
                    state <= S_ACCUMULATE;
                    write_range_bin <= 1;
                end
            end
            
            S_ACCUMULATE: begin
                if (data_valid) begin
                    if (write_range_bin < RANGE_BINS - 1) begin
                        write_range_bin <= write_range_bin + 1;
                    end else begin
                        write_range_bin <= 0;
                        write_chirp_index <= write_chirp_index + 1;
                        chirps_received <= chirps_received + 1;
                        
                        if (write_chirp_index >= CHIRPS_PER_FRAME - 1) begin
                            frame_buffer_full <= 1;
                            chirp_state <= 0;
                            state <= S_PRE_READ;
                            fft_sample_counter <= 0;
                            write_chirp_index <= 0;
                            write_range_bin <= 0;
                            // Start with sub-frame 0 (long PRI chirps 0..15)
                            current_sub_frame <= 0;
                        end
                    end
                end 
            end
            
            S_PRE_READ: begin
                // Prime BRAM pipeline for current sub-frame
                // read_doppler_index already set in Block 2 to sub-frame base
                fft_start <= 1;
                state <= S_LOAD_FFT;
            end

            S_LOAD_FFT: begin
                fft_start <= 0;
                
                // Pipeline: 2 priming cycles + CHIRPS_PER_SUBFRAME data cycles
                if (fft_sample_counter <= 1) begin
                    fft_sample_counter <= fft_sample_counter + 1;
                end else if (fft_sample_counter <= CHIRPS_PER_SUBFRAME + 1) begin
                    fft_input_valid <= 1;

                    if (fft_sample_counter == CHIRPS_PER_SUBFRAME + 1) begin
                        fft_input_last <= 1;
                        state <= S_FFT_WAIT;
                        fft_sample_counter <= 0;
                        processing_timeout <= 1000;
                    end else begin
                        fft_sample_counter <= fft_sample_counter + 1;
                    end
                end
            end
            
            S_FFT_WAIT: begin
                if (fft_output_valid) begin
                    doppler_output <= {fft_output_q[15:0], fft_output_i[15:0]};
                    // Pack: {sub_frame, bin[3:0]}
                    doppler_bin <= {current_sub_frame, fft_sample_counter[3:0]};
                    range_bin <= read_range_bin;
                    sub_frame <= current_sub_frame;
                    doppler_valid <= 1;
                    
                    fft_sample_counter <= fft_sample_counter + 1;
                    
                    if (fft_output_last) begin
                        state <= S_OUTPUT;
                        fft_sample_counter <= 0;
                    end
                end
                
                if (processing_timeout == 0) begin
                    state <= S_OUTPUT;
                end
            end
            
            S_OUTPUT: begin
                if (current_sub_frame == 0) begin
                    // Just finished long PRI sub-frame — now do short PRI
                    current_sub_frame <= 1;
                    fft_sample_counter <= 0;
                    state <= S_PRE_READ;
                    // read_range_bin stays the same, read_doppler_index
                    // will be set to CHIRPS_PER_SUBFRAME in Block 2
                end else begin
                    // Finished both sub-frames for this range bin
                    current_sub_frame <= 0;
                    if (read_range_bin < RANGE_BINS - 1) begin
                        fft_sample_counter <= 0;
                        state <= S_PRE_READ;
                        // read_range_bin incremented in Block 2
                    end else begin
                        state <= S_IDLE;
                        frame_buffer_full <= 0;
                    end
                end
            end
            
        endcase
        
        status <= {state, frame_buffer_full};
    end
end

// ----------------------------------------------------------
// Block 2: BRAM address/data & DSP datapath — synchronous reset
// ----------------------------------------------------------
always @(posedge clk) begin
    if (!reset_n) begin
        mem_we      <= 0;
        mem_waddr_r <= 0;
        mem_wdata_i <= 0;
        mem_wdata_q <= 0;
        mult_i      <= 0;
        mult_q      <= 0;
        mult_i_raw     <= 0;
        mult_q_raw     <= 0;
        window_val_reg <= 0;
        fft_input_i <= 0;
        fft_input_q <= 0;
        read_range_bin     <= 0;
        read_doppler_index <= 0;
    end else begin
        mem_we <= 0;
        
        case (state)
            S_IDLE: begin
                if (data_valid && !frame_buffer_full) begin
                    mem_we      <= 1;
                    mem_waddr_r <= mem_write_addr;
                    mem_wdata_i <= range_data[15:0];
                    mem_wdata_q <= range_data[31:16];
                end
            end
            
            S_ACCUMULATE: begin
                if (data_valid) begin
                    mem_we      <= 1;
                    mem_waddr_r <= mem_write_addr;
                    mem_wdata_i <= range_data[15:0];
                    mem_wdata_q <= range_data[31:16];

                    if (write_range_bin >= RANGE_BINS - 1 &&
                        write_chirp_index >= CHIRPS_PER_FRAME - 1) begin
                        read_range_bin     <= 0;
                        // Start reading from chirp 0 (long PRI sub-frame)
                        read_doppler_index <= 0;
                    end
                end
            end
            
            S_PRE_READ: begin
                // Set read_doppler_index to first chirp of current sub-frame + 1
                // (because address is presented this cycle, data arrives next)
                if (current_sub_frame == 0)
                    read_doppler_index <= 1;  // Long PRI: chirps 0..15
                else
                    read_doppler_index <= CHIRPS_PER_SUBFRAME + 1;  // Short PRI: chirps 16..31

                // BREG priming: window coeff for sample 0
                window_val_reg <= $signed(window_coeff[0]);
            end

            S_LOAD_FFT: begin
                if (fft_sample_counter == 0) begin
                    // Pipe stage 1: multiply using pre-registered BREG value
                    mult_i_raw <= $signed(mem_rdata_i) * window_val_reg;
                    mult_q_raw <= $signed(mem_rdata_q) * window_val_reg;
                    window_val_reg <= $signed(window_coeff[1]);
                    // Advance to chirp base+2
                    if (current_sub_frame == 0)
                        read_doppler_index <= (2 < CHIRPS_PER_SUBFRAME) ? 2
                                              : CHIRPS_PER_SUBFRAME - 1;
                    else
                        read_doppler_index <= (CHIRPS_PER_SUBFRAME + 2 < CHIRPS_PER_FRAME)
                                              ? CHIRPS_PER_SUBFRAME + 2
                                              : CHIRPS_PER_FRAME - 1;
                end else if (fft_sample_counter == 1) begin
                    mult_i <= mult_i_raw;
                    mult_q <= mult_q_raw;
                    mult_i_raw <= $signed(mem_rdata_i) * window_val_reg;
                    mult_q_raw <= $signed(mem_rdata_q) * window_val_reg;
                    if (2 < CHIRPS_PER_SUBFRAME)
                        window_val_reg <= $signed(window_coeff[2]);
                    // Advance to chirp base+3
                    begin : advance_chirp3
                        reg [4:0] next_chirp;
                        next_chirp = (current_sub_frame == 0) ? 3 : CHIRPS_PER_SUBFRAME + 3;
                        if (next_chirp < CHIRPS_PER_FRAME)
                            read_doppler_index <= next_chirp;
                        else
                            read_doppler_index <= CHIRPS_PER_FRAME - 1;
                    end
                end else if (fft_sample_counter <= CHIRPS_PER_SUBFRAME + 1) begin
                    // Steady state
                    fft_input_i <= (mult_i + (1 << 14)) >>> 15;
                    fft_input_q <= (mult_q + (1 << 14)) >>> 15;
                    mult_i <= mult_i_raw;
                    mult_q <= mult_q_raw;

                    if (fft_sample_counter <= CHIRPS_PER_SUBFRAME - 1) begin
                        mult_i_raw <= $signed(mem_rdata_i) * window_val_reg;
                        mult_q_raw <= $signed(mem_rdata_q) * window_val_reg;
                        // Window coeff index within sub-frame
                        begin : advance_window
                            reg [4:0] win_idx;
                            win_idx = fft_sample_counter[3:0] + 1;
                            if (win_idx < CHIRPS_PER_SUBFRAME)
                                window_val_reg <= $signed(window_coeff[win_idx]);
                        end
                        // Advance BRAM read
                        begin : advance_bram
                            reg [4:0] chirp_offset;
                            reg [4:0] chirp_base;
                            chirp_offset = fft_sample_counter[3:0] + 2;
                            chirp_base = (current_sub_frame == 0) ? 0 : CHIRPS_PER_SUBFRAME;
                            if (chirp_base + chirp_offset < CHIRPS_PER_FRAME)
                                read_doppler_index <= chirp_base + chirp_offset;
                            else
                                read_doppler_index <= CHIRPS_PER_FRAME - 1;
                        end
                    end

                    if (fft_sample_counter == CHIRPS_PER_SUBFRAME + 1) begin
                        // Reset read index for potential next operation
                        if (current_sub_frame == 0)
                            read_doppler_index <= CHIRPS_PER_SUBFRAME;  // Ready for short sub-frame
                        else
                            read_doppler_index <= 0;
                    end
                end
            end

            S_OUTPUT: begin
                if (current_sub_frame == 0) begin
                    // Transitioning to short PRI sub-frame
                    // Set read_doppler_index to start of short sub-frame
                    read_doppler_index <= CHIRPS_PER_SUBFRAME;
                end else begin
                    // Both sub-frames done
                    if (read_range_bin < RANGE_BINS - 1) begin
                        read_range_bin     <= read_range_bin + 1;
                        read_doppler_index <= 0;  // Next range bin starts with long sub-frame
                    end
                end
            end

            default: begin
                // S_FFT_WAIT: no BRAM-write or address operations needed
            end
        endcase
    end
end

// ==============================================
// FFT Module — 16-point
// ==============================================
xfft_16 fft_inst (
    .aclk(clk),
    .aresetn(reset_n),
    .s_axis_config_tdata(8'h01),
    .s_axis_config_tvalid(fft_start),
    .s_axis_config_tready(fft_ready),
    .s_axis_data_tdata({fft_input_q, fft_input_i}),
    .s_axis_data_tvalid(fft_input_valid),
    .s_axis_data_tlast(fft_input_last),
    .m_axis_data_tdata({fft_output_q, fft_output_i}),
    .m_axis_data_tvalid(fft_output_valid),
    .m_axis_data_tlast(fft_output_last),
    .m_axis_data_tready(1'b1)
);

// ==============================================
// Status Outputs
// ==============================================
assign processing_active = (state != S_IDLE);
assign frame_complete = (state == S_IDLE && frame_buffer_full == 0);

endmodule
