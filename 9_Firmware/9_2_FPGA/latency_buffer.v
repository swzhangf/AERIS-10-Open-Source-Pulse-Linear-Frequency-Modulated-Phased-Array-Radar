`timescale 1ns / 1ps

// latency_buffer.v — Parameterized BRAM-based latency/delay buffer
// Renamed from latency_buffer_2159 to latency_buffer (module name was
// inconsistent with the actual LATENCY=3187 parameter).
module latency_buffer #(
    parameter DATA_WIDTH = 32,
    parameter LATENCY = 3187
) (
    input wire clk,
    input wire reset_n,
    input wire [DATA_WIDTH-1:0] data_in,
    input wire valid_in,
    output wire [DATA_WIDTH-1:0] data_out,
    output wire valid_out
);

// ========== FIXED PARAMETERS ==========
localparam ADDR_WIDTH = 12;  // Enough for 4096 entries (>2159)

// ========== FIXED LOGIC ==========
(* ram_style = "block" *) reg [DATA_WIDTH-1:0] bram [0:4095];
reg [ADDR_WIDTH-1:0] write_ptr;
reg [ADDR_WIDTH-1:0] read_ptr;
reg valid_out_reg;

// Delay counter to track when LATENCY cycles have passed
reg [ADDR_WIDTH-1:0] delay_counter;
reg buffer_has_data;  // Flag when buffer has accumulated LATENCY samples

// ========== FIXED INITIALIZATION ==========
integer k;
initial begin
    for (k = 0; k < 4096; k = k + 1) begin
        bram[k] = {DATA_WIDTH{1'b0}};
    end
    write_ptr = 0;
    read_ptr = 0;
    valid_out_reg = 0;
    delay_counter = 0;
    buffer_has_data = 0;
end

// ========== BRAM WRITE (synchronous only, no async reset) ==========
// Xilinx Block RAMs do not support asynchronous resets.
// Separating the BRAM write into its own always block avoids Synth 8-3391.
// The initial block above handles power-on initialization for FPGA.
always @(posedge clk) begin
    if (valid_in) begin
        bram[write_ptr] <= data_in;
    end
end

// ========== CONTROL LOGIC (with async reset) ==========
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        write_ptr <= 0;
        read_ptr <= 0;
        valid_out_reg <= 0;
        delay_counter <= 0;
        buffer_has_data <= 0;
    end else begin
        // Default: no valid output
        valid_out_reg <= 0;
        
        // ===== WRITE SIDE =====
        if (valid_in) begin
            // Increment write pointer (wrap at 4095)
            if (write_ptr == 4095) begin
                write_ptr <= 0;
            end else begin
                write_ptr <= write_ptr + 1;
            end
            
            // Count how many samples we've written
            if (delay_counter < LATENCY) begin
                delay_counter <= delay_counter + 1;
                
                // When we've written LATENCY samples, buffer is "primed"
                if (delay_counter == LATENCY - 1) begin
                    buffer_has_data <= 1'b1;
                end
            end
        end
        
        // ===== READ SIDE =====
        // Only start reading after we have LATENCY samples in buffer
        if (buffer_has_data && valid_in) begin
            // Read pointer follows write pointer with LATENCY delay
            // Calculate: read_ptr = (write_ptr - LATENCY) mod 4096
            
            // Handle wrap-around correctly
            if (write_ptr >= LATENCY) begin
                read_ptr <= write_ptr - LATENCY;
            end else begin
                // Wrap around: 4096 + write_ptr - LATENCY
                read_ptr <= 4096 + write_ptr - LATENCY;
            end
            
            // Output is valid
            valid_out_reg <= 1'b1;
        end
    end
end

// ========== BRAM READ (synchronous — required for Block RAM inference) ==========
// Xilinx Block RAMs physically register the read output. An async read
// (assign data_out = bram[addr]) forces Vivado to use distributed LUTRAM
// instead, wasting ~704 LUTs. Registering the read adds 1 cycle of latency,
// compensated by the valid pipeline stage below.
reg [DATA_WIDTH-1:0] data_out_reg;

always @(posedge clk) begin
    data_out_reg <= bram[read_ptr];
end

// Pipeline valid_out_reg by 1 cycle to align with registered BRAM read
reg valid_out_pipe;
always @(posedge clk or negedge reset_n) begin
    if (!reset_n)
        valid_out_pipe <= 1'b0;
    else
        valid_out_pipe <= valid_out_reg;
end

assign data_out = data_out_reg;
assign valid_out = valid_out_pipe;



endmodule