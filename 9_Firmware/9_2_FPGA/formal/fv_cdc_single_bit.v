`timescale 1ns / 1ps

// ============================================================================
// Formal Verification Wrapper: cdc_single_bit
// AERIS-10 Radar FPGA — CDC Single-Bit Synchronizer
// Target: SymbiYosys with smtbmc/z3
// ============================================================================
module fv_cdc_single_bit;

    parameter STAGES = 3;

`ifdef FORMAL

    // ----------------------------------------------------------------
    // Global formal clock — Yosys gclk drives all formal evaluation
    // ----------------------------------------------------------------
    (* gclk *) reg formal_clk;

    // ----------------------------------------------------------------
    // Asynchronous clock generation
    // Use $anyseq to let the solver freely schedule clock edges,
    // modeling truly asynchronous clock domains.
    // ----------------------------------------------------------------
    reg src_clk_r = 1'b0;
    reg dst_clk_r = 1'b0;

    wire src_clk_en;
    wire dst_clk_en;
    assign src_clk_en = $anyseq;
    assign dst_clk_en = $anyseq;

    always @(posedge formal_clk) begin
        if (src_clk_en) src_clk_r <= !src_clk_r;
        if (dst_clk_en) dst_clk_r <= !dst_clk_r;
    end

    wire src_clk = src_clk_r;
    wire dst_clk = dst_clk_r;

    // ----------------------------------------------------------------
    // Liveness: clocks must toggle eventually (fairness constraints)
    // Without this the solver could hold clocks static forever.
    // ----------------------------------------------------------------
    // Each clock must toggle within 7 gclk cycles. Using 4-bit
    // counters with saturation to avoid overflow.
    reg [3:0] src_no_toggle_cnt = 0;
    reg [3:0] dst_no_toggle_cnt = 0;

    always @(posedge formal_clk) begin
        if (!reset_n) begin
            src_no_toggle_cnt <= 0;
            dst_no_toggle_cnt <= 0;
        end else begin
            if (src_clk_en)
                src_no_toggle_cnt <= 0;
            else if (src_no_toggle_cnt < 4'd15)
                src_no_toggle_cnt <= src_no_toggle_cnt + 1;

            if (dst_clk_en)
                dst_no_toggle_cnt <= 0;
            else if (dst_no_toggle_cnt < 4'd15)
                dst_no_toggle_cnt <= dst_no_toggle_cnt + 1;
        end
    end

    always @(posedge formal_clk) begin
        if (reset_n) begin
            assume(src_no_toggle_cnt < 4'd7);
            assume(dst_no_toggle_cnt < 4'd7);
        end
    end

    // ----------------------------------------------------------------
    // DUT signals
    // ----------------------------------------------------------------
    reg reset_n = 1'b0;
    wire src_signal;
    wire dst_signal;

    assign src_signal = $anyseq;

    // ----------------------------------------------------------------
    // Reset generation: hold reset for enough cycles to guarantee
    // both clocks see at least one posedge during reset (with stall
    // bound of 7, worst case is ~14 gclk cycles for one full period).
    // ----------------------------------------------------------------
    reg [4:0] reset_cnt = 0;

    always @(posedge formal_clk) begin
        if (reset_cnt < 5'd20)
            reset_cnt <= reset_cnt + 1;
    end

    always @(*) begin
        reset_n = (reset_cnt >= 5'd20);
    end

    // ----------------------------------------------------------------
    // DUT instantiation
    // ----------------------------------------------------------------
    cdc_single_bit #(
        .STAGES(STAGES)
    ) dut (
        .src_clk   (src_clk),
        .dst_clk   (dst_clk),
        .reset_n   (reset_n),
        .src_signal(src_signal),
        .dst_signal(dst_signal)
    );

    // ----------------------------------------------------------------
    // Track dst_clk edges for property evaluation
    // ----------------------------------------------------------------
    reg dst_clk_prev = 1'b0;
    wire dst_posedge;

    always @(posedge formal_clk) begin
        dst_clk_prev <= dst_clk;
    end

    assign dst_posedge = dst_clk && !dst_clk_prev;

    // ----------------------------------------------------------------
    // Property: Output is 0 during reset
    // With synchronous reset, the sync_chain is only cleared on a
    // dst_clk posedge while !reset_n. We must track whether at least
    // one dst_clk posedge has occurred during reset before asserting.
    // ----------------------------------------------------------------
    reg dst_posedge_during_reset = 1'b0;

    always @(posedge formal_clk) begin
        if (reset_n)
            dst_posedge_during_reset <= 1'b0;
        else if (dst_posedge)
            dst_posedge_during_reset <= 1'b1;
    end

    // ----------------------------------------------------------------
    // DUT initialized flag
    // The DUT uses synchronous reset, so registers are undefined until
    // at least one dst_clk posedge occurs during reset. Properties
    // should only fire after reset has been applied AND released.
    //
    // With clk2fflogic, the DUT's register updates are delayed one
    // formal_clk cycle vs our edge detection. Add a pipeline delay.
    // ----------------------------------------------------------------
    reg dst_saw_posedge = 1'b0;
    reg dst_reset_done = 1'b0;

    always @(posedge formal_clk) begin
        if (!reset_n && dst_posedge)
            dst_saw_posedge <= 1'b1;
    end

    always @(posedge formal_clk) begin
        dst_reset_done <= dst_saw_posedge;
    end

    wire dut_initialized = reset_n && dst_reset_done;

    always @(posedge formal_clk) begin
        if (!reset_n && dst_posedge_during_reset) begin
            assert(dst_signal == 1'b0);
        end
    end

    // ----------------------------------------------------------------
    // Property: Output only changes on dst_clk posedge
    // If there was no dst_clk posedge, dst_signal must be stable.
    // ----------------------------------------------------------------
    reg dst_signal_prev = 1'b0;
    reg past_valid = 1'b0;

    always @(posedge formal_clk) begin
        past_valid <= 1'b1;
        dst_signal_prev <= dst_signal;
    end

    always @(posedge formal_clk) begin
        if (dut_initialized && past_valid && !dst_posedge) begin
            assert(dst_signal == dst_signal_prev);
        end
    end

    // ----------------------------------------------------------------
    // Cover: dst_signal transitions 0->1 after reset
    // ----------------------------------------------------------------
    reg seen_dst_low_after_reset = 1'b0;

    always @(posedge formal_clk) begin
        if (!reset_n)
            seen_dst_low_after_reset <= 1'b0;
        else if (dst_posedge && dst_signal == 1'b0)
            seen_dst_low_after_reset <= 1'b1;
    end

    always @(posedge formal_clk) begin
        if (dut_initialized) begin
            // Cover a 0->1 transition
            cover(past_valid && dst_posedge && dst_signal == 1'b1 && dst_signal_prev == 1'b0);
            // Cover a 1->0 transition
            cover(past_valid && dst_posedge && dst_signal == 1'b0 && dst_signal_prev == 1'b1);
        end
    end

    // ----------------------------------------------------------------
    // Cover: basic reachability — output can be 1 after reset
    // ----------------------------------------------------------------
    always @(posedge formal_clk) begin
        if (dut_initialized) begin
            cover(dst_signal == 1'b1);
        end
    end

`endif // FORMAL

endmodule
