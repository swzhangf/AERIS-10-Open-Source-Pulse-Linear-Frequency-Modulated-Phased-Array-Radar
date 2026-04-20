`timescale 1ns / 1ps

// ============================================================================
// Formal Verification Wrapper: cdc_adc_to_processing
// AERIS-10 Radar FPGA — Multi-bit CDC with Gray Code
// Target: SymbiYosys with smtbmc/z3
// ============================================================================
module fv_cdc_adc;

    parameter WIDTH  = 8;
    parameter STAGES = 3;

`ifdef FORMAL

    // ================================================================
    // Global formal clock
    // ================================================================
    (* gclk *) reg formal_clk;

    // ================================================================
    // Asynchronous clock generation via $anyseq
    // ================================================================
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

    // ================================================================
    // Clock liveness — each clock must toggle within 7 gclk cycles
    // 4-bit counters with saturation.
    // ================================================================
    reg [3:0] src_stall_cnt = 0;
    reg [3:0] dst_stall_cnt = 0;

    always @(posedge formal_clk) begin
        if (!reset_n) begin
            src_stall_cnt <= 0;
            dst_stall_cnt <= 0;
        end else begin
            if (src_clk_en)
                src_stall_cnt <= 0;
            else if (src_stall_cnt < 4'd15)
                src_stall_cnt <= src_stall_cnt + 1;

            if (dst_clk_en)
                dst_stall_cnt <= 0;
            else if (dst_stall_cnt < 4'd15)
                dst_stall_cnt <= dst_stall_cnt + 1;
        end
    end

    always @(posedge formal_clk) begin
        if (reset_n) begin
            assume(src_stall_cnt < 4'd7);
            assume(dst_stall_cnt < 4'd7);
        end
    end

    // ================================================================
    // Edge detection
    // ================================================================
    reg src_clk_prev = 1'b0;
    reg dst_clk_prev = 1'b0;

    always @(posedge formal_clk) begin
        src_clk_prev <= src_clk;
        dst_clk_prev <= dst_clk;
    end

    wire src_posedge = src_clk && !src_clk_prev;
    wire dst_posedge = dst_clk && !dst_clk_prev;

    // ================================================================
    // Reset generation — hold reset long enough for both clocks to
    // see at least one posedge during reset (stall bound 7).
    // ================================================================
    reg reset_n = 1'b0;
    reg [4:0] reset_cnt = 0;

    always @(posedge formal_clk) begin
        if (reset_cnt < 5'd20)
            reset_cnt <= reset_cnt + 1;
    end

    always @(*) begin
        reset_n = (reset_cnt >= 5'd20);
    end

    // ================================================================
    // DUT signals
    // ================================================================
    wire [WIDTH-1:0] src_data;
    reg              src_valid = 1'b0;
    wire [WIDTH-1:0] dst_data;
    wire             dst_valid;

    assign src_data = $anyseq;

    // src_valid: driven freely by solver, but pulsed (single-cycle)
    wire src_valid_next;
    assign src_valid_next = $anyseq;

    always @(posedge formal_clk) begin
        if (!reset_n)
            src_valid <= 1'b0;
        else if (src_posedge)
            src_valid <= src_valid_next;
    end

    // ================================================================
    // DUT instantiation
    // ================================================================
    wire [WIDTH-1:0] fv_src_data_reg;
    wire [1:0]       fv_src_toggle;

    cdc_adc_to_processing #(
        .WIDTH (WIDTH),
        .STAGES(STAGES)
    ) dut (
        .src_clk  (src_clk),
        .dst_clk  (dst_clk),
        .src_reset_n(reset_n),
        .dst_reset_n(reset_n),
        .src_data (src_data),
        .src_valid(src_valid),
        .dst_data (dst_data),
        .dst_valid(dst_valid),
        .fv_src_data_reg(fv_src_data_reg),
        .fv_src_toggle  (fv_src_toggle)
    );

    // ================================================================
    // Past-valid tracker
    // ================================================================
    reg fv_past_valid = 1'b0;
    always @(posedge formal_clk) begin
        fv_past_valid <= 1'b1;
    end

    // ================================================================
    // DUT initialized tracking
    // The DUT uses synchronous reset — registers in each clock domain
    // are undefined until at least one posedge of that domain's clock
    // occurs during reset. Track both domains independently.
    //
    // With clk2fflogic, the DUT's registers are updated one formal_clk
    // cycle after our edge detection sees the posedge. Add a pipeline delay.
    // ================================================================
    reg src_saw_posedge = 1'b0;
    reg dst_saw_posedge = 1'b0;
    reg src_reset_done = 1'b0;
    reg dst_reset_done = 1'b0;

    always @(posedge formal_clk) begin
        if (!reset_n && src_posedge)
            src_saw_posedge <= 1'b1;
    end

    always @(posedge formal_clk) begin
        if (!reset_n && dst_posedge)
            dst_saw_posedge <= 1'b1;
    end

    always @(posedge formal_clk) begin
        src_reset_done <= src_saw_posedge;
        dst_reset_done <= dst_saw_posedge;
    end

    wire dut_initialized = reset_n && src_reset_done && dst_reset_done;

    // ================================================================
    // PROPERTY 1: Gray code round-trip identity
    //   binary_to_gray(gray_to_binary(x)) == x for all x
    //   gray_to_binary(binary_to_gray(x)) == x for all x
    //
    // These are purely combinational checks on a free input.
    // ================================================================
    wire [WIDTH-1:0] fv_test_val;
    assign fv_test_val = $anyconst;

    // Reimplement the functions locally for the wrapper so we can
    // call them on arbitrary values.
    function [WIDTH-1:0] fv_b2g;
        input [WIDTH-1:0] b;
        fv_b2g = b ^ (b >> 1);
    endfunction

    function [WIDTH-1:0] fv_g2b;
        input [WIDTH-1:0] g;
        reg [WIDTH-1:0] b;
        integer k;
    begin
        b[WIDTH-1] = g[WIDTH-1];
        for (k = WIDTH-2; k >= 0; k = k - 1) begin
            b[k] = b[k+1] ^ g[k];
        end
        fv_g2b = b;
    end
    endfunction

    // Combinational assertions (checked every formal tick)
    always @(*) begin
        assert(fv_g2b(fv_b2g(fv_test_val)) == fv_test_val);
        assert(fv_b2g(fv_g2b(fv_test_val)) == fv_test_val);
    end

    // ================================================================
    // PROPERTY 2: Reset behavior
    // During reset, all output registers are 0.
    // ================================================================
    always @(posedge formal_clk) begin
        if (!reset_n && src_reset_done && dst_reset_done) begin
            assert(dst_valid == 1'b0);
            assert(dst_data == {WIDTH{1'b0}});
        end
    end

    // ================================================================
    // PROPERTY 3: No spurious dst_valid without preceding src_valid
    //
    // Track whether any src_valid has ever been asserted after reset.
    // Before the first src_valid, dst_valid must remain 0.
    // ================================================================
    reg fv_any_src_valid = 1'b0;

    always @(posedge formal_clk) begin
        if (!reset_n)
            fv_any_src_valid <= 1'b0;
        else if (src_posedge && src_valid)
            fv_any_src_valid <= 1'b1;
    end

    always @(posedge formal_clk) begin
        if (dut_initialized && !fv_any_src_valid) begin
            assert(dst_valid == 1'b0);
        end
    end

    // ================================================================
    // PROPERTY 4: Data integrity
    // When dst_valid asserts, dst_data must match the DUT's latched
    // src_data_reg (exposed via formal port fv_src_data_reg).
    //
    // Instead of shadowing src_data in the wrapper (which has
    // clk2fflogic timing issues with $anyseq inputs), we directly
    // compare dst_data against fv_src_data_reg. This verifies that
    // the gray-code CDC path correctly transfers the latched value.
    //
    // Spacing assumption: src_valid pulses must be spaced far enough
    // apart for the previous transfer to propagate (STAGES+2 dst_clk
    // cycles). We enforce this with a cooldown counter.
    // ================================================================
    reg [6:0] fv_src_cooldown = 0;

    always @(posedge formal_clk) begin
        if (!reset_n) begin
            fv_src_cooldown <= 0;
        end else if (src_posedge && src_valid) begin
            fv_src_cooldown <= 7'd70; // enough gclk cycles for propagation
        end else if (fv_src_cooldown > 0) begin
            fv_src_cooldown <= fv_src_cooldown - 1;
        end
    end

    // Assume sufficient spacing between src_valid pulses
    always @(posedge formal_clk) begin
        if (reset_n && src_posedge && src_valid) begin
            assume(fv_src_cooldown == 0);
        end
    end

    // Track in-flight transfers for cover properties
    reg fv_inflight = 1'b0;
    reg [1:0] fv_transfer_count = 0;

    always @(posedge formal_clk) begin
        if (!reset_n) begin
            fv_inflight <= 1'b0;
            fv_transfer_count <= 0;
        end else if (src_posedge && src_valid) begin
            fv_inflight <= 1'b1;
        end else if (dst_posedge && dst_valid) begin
            fv_inflight <= 1'b0;
            if (fv_transfer_count < 2'd3)
                fv_transfer_count <= fv_transfer_count + 1;
        end
    end

    // When dst_valid fires, dst_data must match fv_src_data_reg
    // (the value the DUT's source domain actually captured).
    always @(posedge formal_clk) begin
        if (dut_initialized && dst_posedge && dst_valid) begin
            assert(dst_data == fv_src_data_reg);
        end
    end

    // ================================================================
    // PROPERTY 5: Toggle detection — src_valid eventually produces
    // dst_valid (bounded liveness).
    //
    // After src_valid fires, dst_valid must assert within a bounded
    // number of gclk cycles (STAGES sync + output register).
    // ================================================================
    reg [6:0] fv_propagation_timer = 0;

    always @(posedge formal_clk) begin
        if (!reset_n) begin
            fv_propagation_timer <= 0;
        end else if (src_posedge && src_valid && !fv_inflight) begin
            fv_propagation_timer <= 1;
        end else if (fv_propagation_timer > 0 && !(dst_posedge && dst_valid)) begin
            fv_propagation_timer <= fv_propagation_timer + 1;
        end else if (dst_posedge && dst_valid) begin
            fv_propagation_timer <= 0;
        end
    end

    // With STAGES=3, worst case: ~(STAGES+1)*14 gclk cycles
    // (each dst_clk edge takes up to ~14 gclk ticks at worst with
    // our clock stall bound of 7)
    always @(posedge formal_clk) begin
        if (dut_initialized && fv_propagation_timer > 0) begin
            assert(fv_propagation_timer < 80);
        end
    end

    // ================================================================
    // COVER properties
    // ================================================================
    always @(posedge formal_clk) begin
        if (dut_initialized) begin
            // Cover: src captures data
            cover(src_posedge && src_valid);

            // Cover: dst presents valid data
            cover(dst_posedge && dst_valid);

            // Cover: dst_valid seen after src_valid was asserted
            cover(dst_posedge && dst_valid && fv_past_valid);

            // Cover: two successive transfers complete
            cover(dst_posedge && dst_valid && fv_transfer_count >= 1);
        end
    end

`endif // FORMAL

endmodule
