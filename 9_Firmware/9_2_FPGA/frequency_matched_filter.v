`timescale 1ns / 1ps

// frequency_matched_filter_conjugate.v
module frequency_matched_filter (
    input wire clk,
    input wire reset_n,
    
    // Input from Forward FFT (16-bit Q15)
    input wire signed [15:0] fft_real_in,
    input wire signed [15:0] fft_imag_in,
    input wire fft_valid_in,
    
    // Reference Chirp (16-bit Q15) - assumed to be FFT of transmitted chirp

    input wire signed [15:0] ref_chirp_real,
    input wire signed [15:0] ref_chirp_imag,
    
    // Output (16-bit Q15) - FFT(input) ? conj(FFT(reference))
    output wire signed [15:0] filtered_real,
    output wire signed [15:0] filtered_imag,
    output wire filtered_valid,
    
    output wire [1:0] state
);

// Complex multiplication: (a + jb) ? (c - jd) = (ac + bd) + j(bc - ad)
// Note: We use CONJUGATE of reference for matched filter

// Pipeline registers
reg signed [15:0] a_reg, b_reg, c_reg, d_reg;
reg valid_p1;
reg signed [31:0] ac_reg, bd_reg, bc_reg, ad_reg;
reg valid_p2;
reg signed [31:0] real_sum, imag_sum;
reg valid_p3;
reg signed [15:0] real_out, imag_out;
reg valid_out;

// Address counter
reg [9:0] addr_counter;


// ========== PIPELINE STAGE 1: REGISTER INPUTS ==========
// Sync reset: enables DSP48E1 absorption (fixes DPOR-1/DPIP-1 DRC)
always @(posedge clk) begin
    if (!reset_n) begin
        a_reg <= 16'd0; b_reg <= 16'd0;
        c_reg <= 16'd0; d_reg <= 16'd0;
        valid_p1 <= 1'b0;
    end else begin
        if (fft_valid_in) begin
            a_reg <= fft_real_in;      // a
            b_reg <= fft_imag_in;      // b
            c_reg <= ref_chirp_real;   // c
            d_reg <= ref_chirp_imag;   // d
        end
        valid_p1 <= fft_valid_in;
    end
end

// ========== PIPELINE STAGE 2: MULTIPLICATIONS ==========
// Sync reset: enables DSP48E1 absorption (fixes DPOR-1/DPIP-1 DRC)
always @(posedge clk) begin
    if (!reset_n) begin
        ac_reg <= 32'd0; bd_reg <= 32'd0;
        bc_reg <= 32'd0; ad_reg <= 32'd0;
        valid_p2 <= 1'b0;
    end else begin
        // Q15 ? Q15 = Q30
        ac_reg <= a_reg * c_reg;  // ac
        bd_reg <= b_reg * d_reg;  // bd
        bc_reg <= b_reg * c_reg;  // bc
        ad_reg <= a_reg * d_reg;  // ad
        
        valid_p2 <= valid_p1;
    end
end

// ========== PIPELINE STAGE 3: ADDITIONS ==========
// For conjugate multiplication: (ac + bd) + j(bc - ad)
// Sync reset: enables DSP48E1 absorption (fixes DPOR-1/DPIP-1 DRC)
always @(posedge clk) begin
    if (!reset_n) begin
        real_sum <= 32'd0;
        imag_sum <= 32'd0;
        valid_p3 <= 1'b0;
    end else begin
        real_sum <= ac_reg + bd_reg;  // ac + bd
        imag_sum <= bc_reg - ad_reg;  // bc - ad
        
        valid_p3 <= valid_p2;
    end
end

// ========== PIPELINE STAGE 4: SATURATION ==========
function automatic signed [15:0] saturate_and_scale;
    input signed [31:0] q30_value;
    reg signed [15:0] result;
    reg signed [31:0] rounded;
    begin
        // Round to nearest: add 0.5 LSB (bit 14)
        rounded = q30_value + (1 << 14);
        
        // Check for overflow
        if (rounded > 32'sh3FFF8000) begin  // > 32767.5 in Q30
            result = 16'h7FFF;
        end else if (rounded < 32'shC0008000) begin  // < -32768.5 in Q30
            result = 16'h8000;
        end else begin
            // Take bits [30:15] for Q15
            result = rounded[30:15];
        end
        
        saturate_and_scale = result;
    end
endfunction

// Sync reset: enables DSP48E1 absorption (fixes DPOR-1/DPIP-1 DRC)
always @(posedge clk) begin
    if (!reset_n) begin
        real_out <= 16'd0;
        imag_out <= 16'd0;
        valid_out <= 1'b0;
    end else begin
        if (valid_p3) begin
            real_out <= saturate_and_scale(real_sum);
            imag_out <= saturate_and_scale(imag_sum);
        end
        valid_out <= valid_p3;
    end
end

// ========== OUTPUT ASSIGNMENTS ==========
assign filtered_real = real_out;
assign filtered_imag = imag_out;
assign filtered_valid = valid_out;

// Simple state output
assign state = {valid_out, valid_p3};

endmodule