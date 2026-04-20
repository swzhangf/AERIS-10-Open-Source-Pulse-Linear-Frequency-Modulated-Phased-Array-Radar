`timescale 1ns / 1ps

// ============================================================================
// CDC FOR MULTI-BIT DATA (ADVANCED)
// Uses Gray-code encoding with synchronous reset on sync chain to avoid
// latch inference. ASYNC_REG attributes ensure Vivado places synchronizer
// FFs in the same slice for optimal MTBF.
// ============================================================================
module cdc_adc_to_processing #(
    parameter WIDTH = 8,
    parameter STAGES = 3
)(
    input wire src_clk,
    input wire dst_clk,
    input wire src_reset_n,
    input wire dst_reset_n,
    input wire [WIDTH-1:0] src_data,
    input wire src_valid,
    output wire [WIDTH-1:0] dst_data,
    output wire dst_valid
`ifdef FORMAL
    ,output wire [WIDTH-1:0] fv_src_data_reg,
    output wire [1:0]       fv_src_toggle
`endif
);

    // Gray encoding for safe CDC
    function [WIDTH-1:0] binary_to_gray;
        input [WIDTH-1:0] binary;
        binary_to_gray = binary ^ (binary >> 1);
    endfunction
    
    function [WIDTH-1:0] gray_to_binary;
        input [WIDTH-1:0] gray;
        reg [WIDTH-1:0] binary;
        integer i;
    begin
        binary[WIDTH-1] = gray[WIDTH-1];
        for (i = WIDTH-2; i >= 0; i = i - 1) begin
            binary[i] = binary[i+1] ^ gray[i];
        end
        gray_to_binary = binary;
    end
    endfunction
    
    // Source domain registers
    reg [WIDTH-1:0] src_data_reg;
    reg [WIDTH-1:0] src_data_gray;   // Gray-encoded in source domain
    reg [1:0] src_toggle = 2'b00;
    
    // Destination domain synchronizer registers
    // ASYNC_REG on memory arrays applies to all elements
    (* ASYNC_REG = "TRUE" *) reg [WIDTH-1:0] dst_data_gray [0:STAGES-1];
    (* ASYNC_REG = "TRUE" *) reg [1:0] dst_toggle_sync [0:STAGES-1];
    reg [WIDTH-1:0] dst_data_reg;
    reg dst_valid_reg = 0;
    reg [1:0] prev_dst_toggle = 2'b00;
    
    // Source domain: capture data, Gray-encode, and toggle — synchronous reset
    // Gray encoding is registered in src_clk to avoid combinational logic
    // before the first synchronizer FF (fixes CDC-10 violations).
    always @(posedge src_clk) begin
        if (!src_reset_n) begin
            src_data_reg  <= 0;
            src_data_gray <= 0;
            src_toggle    <= 2'b00;
        end else if (src_valid) begin
            src_data_reg  <= src_data;
            src_data_gray <= binary_to_gray(src_data);
            src_toggle    <= src_toggle + 1;
        end
    end
    
    // CDC synchronization chain for data — SYNCHRONOUS RESET
    // Using synchronous reset avoids latch inference in Vivado.
    // For CDC synchronizers, synchronous reset is preferred because
    // the reset value is sampled safely within the clock domain.
    genvar i;
    generate
        for (i = 0; i < STAGES; i = i + 1) begin : data_sync_chain
            always @(posedge dst_clk) begin
                if (!dst_reset_n) begin
                    dst_data_gray[i] <= 0;
                end else begin
                    if (i == 0) begin
                        // Sample registered Gray-code from source domain
                        dst_data_gray[i] <= src_data_gray;
                    end else begin
                        dst_data_gray[i] <= dst_data_gray[i-1];
                    end
                end
            end
        end
        
        for (i = 0; i < STAGES; i = i + 1) begin : toggle_sync_chain
            always @(posedge dst_clk) begin
                if (!dst_reset_n) begin
                    dst_toggle_sync[i] <= 2'b00;
                end else begin
                    if (i == 0) begin
                        dst_toggle_sync[i] <= src_toggle;
                    end else begin
                        dst_toggle_sync[i] <= dst_toggle_sync[i-1];
                    end
                end
            end
        end
    endgenerate
    
    // Detect new data — synchronous reset
    always @(posedge dst_clk) begin
        if (!dst_reset_n) begin
            dst_data_reg <= 0;
            dst_valid_reg <= 0;
            prev_dst_toggle <= 2'b00;
        end else begin
            // Convert from gray code
            dst_data_reg <= gray_to_binary(dst_data_gray[STAGES-1]);
            
            // Check if toggle changed (new data)
            if (dst_toggle_sync[STAGES-1] != prev_dst_toggle) begin
                dst_valid_reg <= 1'b1;
                prev_dst_toggle <= dst_toggle_sync[STAGES-1];
            end else begin
                dst_valid_reg <= 1'b0;
            end
        end
    end
    
    assign dst_data = dst_data_reg;
    assign dst_valid = dst_valid_reg;

`ifdef FORMAL
    assign fv_src_data_reg = src_data_reg;
    assign fv_src_toggle   = src_toggle;
`endif
    
endmodule

// ============================================================================
// CDC FOR SINGLE BIT SIGNALS
// Uses synchronous reset on sync chain to avoid metastability on reset
// deassertion. Matches cdc_adc_to_processing best practice.
// ============================================================================
module cdc_single_bit #(
    parameter STAGES = 3
)(
    input wire src_clk,
    input wire dst_clk,
    input wire reset_n,
    input wire src_signal,
    output wire dst_signal
);

    (* ASYNC_REG = "TRUE" *) reg [STAGES-1:0] sync_chain;
    
    always @(posedge dst_clk) begin
        if (!reset_n) begin
            sync_chain <= 0;
        end else begin
            sync_chain <= {sync_chain[STAGES-2:0], src_signal};
        end
    end
    
    assign dst_signal = sync_chain[STAGES-1];
    
endmodule

// ============================================================================
// CDC FOR MULTI-BIT WITH HANDSHAKE
// Uses synchronous reset to avoid metastability on reset deassertion.
// ============================================================================
module cdc_handshake #(
    parameter WIDTH = 32
)(
    input wire src_clk,
    input wire dst_clk,
    input wire reset_n,
    input wire [WIDTH-1:0] src_data,
    input wire src_valid,
    output wire src_ready,
    output wire [WIDTH-1:0] dst_data,
    output wire dst_valid,
    input wire dst_ready
`ifdef FORMAL
    ,output wire              fv_src_busy,
    output wire              fv_dst_ack,
    output wire              fv_dst_req_sync,
    output wire [1:0]        fv_src_ack_sync_chain,
    output wire [1:0]        fv_dst_req_sync_chain,
    output wire [WIDTH-1:0]  fv_src_data_reg_hs
`endif
);

    // Source domain
    reg [WIDTH-1:0] src_data_reg;
    reg src_busy = 0;
    reg src_ack_sync = 0;
    (* ASYNC_REG = "TRUE" *) reg [1:0] src_ack_sync_chain = 2'b00;
    
    // Destination domain
    reg [WIDTH-1:0] dst_data_reg;
    reg dst_valid_reg = 0;
    reg dst_req_sync = 0;
    (* ASYNC_REG = "TRUE" *) reg [1:0] dst_req_sync_chain = 2'b00;
    reg dst_ack = 0;

`ifdef FORMAL
    assign fv_src_busy           = src_busy;
    assign fv_dst_ack            = dst_ack;
    assign fv_dst_req_sync       = dst_req_sync;
    assign fv_src_ack_sync_chain = src_ack_sync_chain;
    assign fv_dst_req_sync_chain = dst_req_sync_chain;
    assign fv_src_data_reg_hs    = src_data_reg;
`endif
    
    // Source clock domain — synchronous reset
    always @(posedge src_clk) begin
        if (!reset_n) begin
            src_data_reg <= 0;
            src_busy <= 0;
            src_ack_sync <= 0;
            src_ack_sync_chain <= 2'b00;
        end else begin
            // Sync acknowledge from destination
            src_ack_sync_chain <= {src_ack_sync_chain[0], dst_ack};
            src_ack_sync <= src_ack_sync_chain[1];
            
            if (!src_busy && src_valid) begin
                src_data_reg <= src_data;
                src_busy <= 1'b1;
            end else if (src_busy && src_ack_sync) begin
                src_busy <= 1'b0;
            end
        end
    end
    
    // Destination clock domain — synchronous reset
    always @(posedge dst_clk) begin
        if (!reset_n) begin
            dst_data_reg <= 0;
            dst_valid_reg <= 0;
            dst_req_sync <= 0;
            dst_req_sync_chain <= 2'b00;
            dst_ack <= 0;
        end else begin
            // Sync request from source
            dst_req_sync_chain <= {dst_req_sync_chain[0], src_busy};
            dst_req_sync <= dst_req_sync_chain[1];
            
            // Capture data when request arrives
            if (dst_req_sync && !dst_valid_reg) begin
                dst_data_reg <= src_data_reg;
                dst_valid_reg <= 1'b1;
                dst_ack <= 1'b1;
            end else if (dst_valid_reg && dst_ready) begin
                dst_valid_reg <= 1'b0;
            end
            
            // Clear acknowledge after source sees it
            if (dst_ack && !dst_req_sync) begin
                dst_ack <= 1'b0;
            end
        end
    end
    
    assign src_ready = !src_busy;
    assign dst_data = dst_data_reg;
    assign dst_valid = dst_valid_reg;
    
endmodule
