`timescale 1ns / 1ps
module chirp_memory_loader_param #(
    parameter LONG_I_FILE_SEG0 = "long_chirp_seg0_i.mem",
    parameter LONG_Q_FILE_SEG0 = "long_chirp_seg0_q.mem",
    parameter LONG_I_FILE_SEG1 = "long_chirp_seg1_i.mem",
    parameter LONG_Q_FILE_SEG1 = "long_chirp_seg1_q.mem",
    parameter LONG_I_FILE_SEG2 = "long_chirp_seg2_i.mem",
    parameter LONG_Q_FILE_SEG2 = "long_chirp_seg2_q.mem",
    parameter LONG_I_FILE_SEG3 = "long_chirp_seg3_i.mem",
    parameter LONG_Q_FILE_SEG3 = "long_chirp_seg3_q.mem",
    parameter SHORT_I_FILE = "short_chirp_i.mem",
    parameter SHORT_Q_FILE = "short_chirp_q.mem",
    parameter DEBUG = 1
)(
    input wire clk,
    input wire reset_n,
    input wire [1:0] segment_select,
    input wire mem_request,
    input wire use_long_chirp,
    input wire [9:0] sample_addr,
    output reg [15:0] ref_i,
    output reg [15:0] ref_q,
    output reg mem_ready
);

// Memory declarations - now 4096 samples for 4 segments
(* ram_style = "block" *) reg [15:0] long_chirp_i [0:4095];
(* ram_style = "block" *) reg [15:0] long_chirp_q [0:4095];
(* ram_style = "block" *) reg [15:0] short_chirp_i [0:1023];
(* ram_style = "block" *) reg [15:0] short_chirp_q [0:1023];

// Initialize memory
integer i;

initial begin
    `ifdef SIMULATION
    if (DEBUG) begin
        $display("[MEM] Starting memory initialization for 4 long chirp segments");
    end
    `endif
    
    // === LOAD LONG CHIRP - 4 SEGMENTS ===
    // Segment 0 (addresses 0-1023)
    $readmemh(LONG_I_FILE_SEG0, long_chirp_i, 0, 1023);
    $readmemh(LONG_Q_FILE_SEG0, long_chirp_q, 0, 1023);
    `ifdef SIMULATION
    if (DEBUG) $display("[MEM] Loaded long chirp segment 0 (0-1023)");
    `endif
    
    // Segment 1 (addresses 1024-2047)
    $readmemh(LONG_I_FILE_SEG1, long_chirp_i, 1024, 2047);
    $readmemh(LONG_Q_FILE_SEG1, long_chirp_q, 1024, 2047);
    `ifdef SIMULATION
    if (DEBUG) $display("[MEM] Loaded long chirp segment 1 (1024-2047)");
    `endif
    
    // Segment 2 (addresses 2048-3071)
    $readmemh(LONG_I_FILE_SEG2, long_chirp_i, 2048, 3071);
    $readmemh(LONG_Q_FILE_SEG2, long_chirp_q, 2048, 3071);
    `ifdef SIMULATION
    if (DEBUG) $display("[MEM] Loaded long chirp segment 2 (2048-3071)");
    `endif
    
    // Segment 3 (addresses 3072-4095)
    $readmemh(LONG_I_FILE_SEG3, long_chirp_i, 3072, 4095);
    $readmemh(LONG_Q_FILE_SEG3, long_chirp_q, 3072, 4095);
    `ifdef SIMULATION
    if (DEBUG) $display("[MEM] Loaded long chirp segment 3 (3072-4095)");
    `endif
    
    // === LOAD SHORT CHIRP ===
    // Load first 50 samples (0-49). Explicit range prevents iverilog warning
    // about insufficient words for the full [0:1023] array.
    $readmemh(SHORT_I_FILE, short_chirp_i, 0, 49);
    $readmemh(SHORT_Q_FILE, short_chirp_q, 0, 49);
    `ifdef SIMULATION
    if (DEBUG) $display("[MEM] Loaded short chirp (0-49)");
    `endif
    
    // Zero pad remaining 974 samples (50-1023)
    for (i = 50; i < 1024; i = i + 1) begin
        short_chirp_i[i] = 16'h0000;
        short_chirp_q[i] = 16'h0000;
    end
    `ifdef SIMULATION
    if (DEBUG) $display("[MEM] Zero-padded short chirp from 50-1023");
    
    // === VERIFICATION ===
    if (DEBUG) begin
        $display("[MEM] Memory loading complete. Verification samples:");
        $display("  Long[0]:     I=%h Q=%h", long_chirp_i[0], long_chirp_q[0]);
        $display("  Long[1023]:  I=%h Q=%h", long_chirp_i[1023], long_chirp_q[1023]);
        $display("  Long[1024]:  I=%h Q=%h", long_chirp_i[1024], long_chirp_q[1024]);
        $display("  Long[2047]:  I=%h Q=%h", long_chirp_i[2047], long_chirp_q[2047]);
        $display("  Long[2048]:  I=%h Q=%h", long_chirp_i[2048], long_chirp_q[2048]);
        $display("  Long[3071]:  I=%h Q=%h", long_chirp_i[3071], long_chirp_q[3071]);
        $display("  Long[3072]:  I=%h Q=%h", long_chirp_i[3072], long_chirp_q[3072]);
        $display("  Long[4095]:  I=%h Q=%h", long_chirp_i[4095], long_chirp_q[4095]);
        $display("  Short[0]:    I=%h Q=%h", short_chirp_i[0], short_chirp_q[0]);
        $display("  Short[49]:   I=%h Q=%h", short_chirp_i[49], short_chirp_q[49]);
        $display("  Short[50]:   I=%h Q=%h (zero-padded)", short_chirp_i[50], short_chirp_q[50]);
    end
    `endif
end

// Memory access logic
// long_addr is combinational — segment_select[1:0] concatenated with sample_addr[9:0]
wire [11:0] long_addr = {segment_select, sample_addr};

// ---- BRAM read block (sync-only, sync reset) ----
// REQP-1839/1840 fix: BRAM output registers cannot have async resets.
// We use a synchronous reset instead, which Vivado maps to the BRAM
// RSTREGB port (supported by 7-series BRAM primitives).
always @(posedge clk) begin
    if (!reset_n) begin
        ref_i <= 16'd0;
        ref_q <= 16'd0;
    end else if (mem_request) begin
        if (use_long_chirp) begin
            ref_i <= long_chirp_i[long_addr];
            ref_q <= long_chirp_q[long_addr];
            
            `ifdef SIMULATION
            if (DEBUG && $time < 100) begin
                $display("[MEM @%0t] Long chirp: seg=%b, addr=%d, I=%h, Q=%h",
                        $time, segment_select, long_addr,
                        long_chirp_i[long_addr], long_chirp_q[long_addr]);
            end
            `endif
        end else begin
            // Short chirp (0-1023)
            ref_i <= short_chirp_i[sample_addr];
            ref_q <= short_chirp_q[sample_addr];
            
            `ifdef SIMULATION
            if (DEBUG && $time < 100) begin
                $display("[MEM @%0t] Short chirp: addr=%d, I=%h, Q=%h",
                        $time, sample_addr, short_chirp_i[sample_addr], short_chirp_q[sample_addr]);
            end
            `endif
        end
    end
end

// ---- Control block (async reset for mem_ready only) ----
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        mem_ready <= 1'b0;
    end else begin
        mem_ready <= mem_request;
    end
end

endmodule