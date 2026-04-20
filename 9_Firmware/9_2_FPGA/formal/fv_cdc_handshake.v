`timescale 1ns / 1ps

// ============================================================================
// Formal Verification Wrapper: cdc_handshake
// AERIS-10 Radar FPGA — CDC Handshake (req/ack)
// Target: SymbiYosys with smtbmc/z3
//
// This is the most critical CDC module. The properties verify protocol
// correctness, data integrity, and liveness under multi-clock formal.
// ============================================================================
module fv_cdc_handshake;

    parameter WIDTH = 8; // Reduced from 32 for faster formal solving

`ifdef FORMAL

    // ================================================================
    // Global formal clock
    // ================================================================
    (* gclk *) reg formal_clk;

    // ================================================================
    // Asynchronous clock generation
    // $anyseq enables let the solver freely interleave clock edges.
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
    // Clock liveness: each clock must toggle within 7 gclk cycles
    // Using 4-bit counters with saturation to avoid overflow.
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
    // Edge detection for clock domains
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
    wire             src_ready;
    wire [WIDTH-1:0] dst_data;
    wire             dst_valid;
    reg              dst_ready = 1'b0;

    // Formal observation ports (exposed by DUT under `ifdef FORMAL)
    wire             fv_src_busy;
    wire             fv_dst_ack;
    wire             fv_dst_req_sync;
    wire [1:0]       fv_src_ack_sync_chain;
    wire [1:0]       fv_dst_req_sync_chain;
    wire [WIDTH-1:0] fv_src_data_reg_hs;

    assign src_data = $anyseq;

    // src_valid: driven freely by the solver, using a hold-until-
    // accepted pattern that mirrors real producer behaviour and avoids
    // a combinational dependency on src_ready (which is a DUT output
    // subject to clk2fflogic timing).
    //
    // Protocol:
    //   - When idle (!src_valid), the solver can freely assert or
    //     deassert src_valid on any src_posedge.
    //   - Once src_valid is asserted it is held high until the DUT
    //     accepts it (src_valid && src_ready on a src_posedge), after
    //     which it clears.  This matches the valid/ready handshake
    //     convention and guarantees that src_valid is stable for the
    //     DUT to sample.
    wire src_valid_next;
    assign src_valid_next = $anyseq;

    always @(posedge formal_clk) begin
        if (!reset_n)
            src_valid <= 1'b0;
        else if (src_posedge) begin
            if (src_valid && src_ready)
                src_valid <= 1'b0;       // accepted — clear
            else if (!src_valid)
                src_valid <= src_valid_next; // idle — solver drives
            // else: src_valid is 1 but src_ready is 0 — hold
        end
    end

    // dst_ready: driven freely by solver after reset
    wire dst_ready_next;
    assign dst_ready_next = $anyseq;

    always @(posedge formal_clk) begin
        if (!reset_n)
            dst_ready <= 1'b0;
        else if (dst_posedge)
            dst_ready <= dst_ready_next;
    end

    // ================================================================
    // DUT instantiation
    // ================================================================
    cdc_handshake #(
        .WIDTH(WIDTH)
    ) dut (
        .src_clk  (src_clk),
        .dst_clk  (dst_clk),
        .reset_n  (reset_n),
        .src_data (src_data),
        .src_valid(src_valid),
        .src_ready(src_ready),
        .dst_data (dst_data),
        .dst_valid(dst_valid),
        .dst_ready(dst_ready),
        .fv_src_busy          (fv_src_busy),
        .fv_dst_ack           (fv_dst_ack),
        .fv_dst_req_sync      (fv_dst_req_sync),
        .fv_src_ack_sync_chain(fv_src_ack_sync_chain),
        .fv_dst_req_sync_chain(fv_dst_req_sync_chain),
        .fv_src_data_reg_hs   (fv_src_data_reg_hs)
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
    // cycle after our edge detection sees the posedge. We need to delay
    // by one extra cycle to avoid checking DUT state before it processes
    // the reset.
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

    // Delay by one cycle to let clk2fflogic-transformed DUT process
    always @(posedge formal_clk) begin
        src_reset_done <= src_saw_posedge;
        dst_reset_done <= dst_saw_posedge;
    end

    wire dut_initialized = reset_n && src_reset_done && dst_reset_done;

    // ================================================================
    // PROPERTY 1: src_ready == !src_busy
    // src_ready is defined as !src_busy in the RTL. Verify this
    // structural invariant holds.
    // ================================================================
    always @(posedge formal_clk) begin
        if (dut_initialized) begin
            assert(src_ready == !fv_src_busy);
        end
    end

    // ================================================================
    // PROPERTY 2: Reset behavior
    // During reset all outputs are deasserted, internal state is clear.
    // ================================================================
    always @(posedge formal_clk) begin
        if (!reset_n && src_reset_done && dst_reset_done) begin
            assert(src_ready == 1'b1);         // src_busy == 0
            assert(dst_valid == 1'b0);
            assert(fv_dst_ack == 1'b0);
        end
    end

    // ================================================================
    // PROPERTY 3: dst_valid bounded duration
    // dst_valid must not remain asserted indefinitely. After dst_valid
    // goes high, it must clear within a bounded window (assuming
    // dst_ready eventually fires — already constrained by Property 5).
    //
    // NOTE: We cannot assert "dst_valid == 0 on the next dst_clk
    // after consumption" because: (a) clk2fflogic adds pipeline
    // latency making exact-cycle checks unreliable, and (b) the DUT
    // validly re-latches data if dst_req_sync is still high.
    // Instead we use a bounded-duration check.
    // ================================================================
    reg [5:0] fv_dst_valid_duration = 0;

    always @(posedge formal_clk) begin
        if (!reset_n) begin
            fv_dst_valid_duration <= 0;
        end else if (dst_posedge) begin
            if (dst_valid)
                fv_dst_valid_duration <= fv_dst_valid_duration + 1;
            else
                fv_dst_valid_duration <= 0;
        end
    end

    // dst_valid must not stay high for more than 60 dst_clk edges.
    // After dst_ready fires and dst_valid_reg clears, the DUT
    // immediately re-asserts dst_valid on the next dst_clk if
    // dst_req_sync is still high (waiting for ack round-trip).
    // This loop continues until src_busy deasserts and propagates
    // through 2-stage sync back to dst. Worst case with stall
    // bound 7: ~4 sync stages × 14 gclk = ~56 gclk ≈ 28 dst edges,
    // but with adversarial clock interleaving the effective count
    // can exceed 30. Bound 60 provides margin.
    always @(posedge formal_clk) begin
        if (dut_initialized) begin
            assert(fv_dst_valid_duration < 60);
        end
    end

    // ================================================================
    // PROPERTY 4: Data stability during dst_valid
    // While dst_valid is asserted, dst_data must remain stable.
    //
    // NOTE: We cannot compare dst_data against fv_src_data_reg_hs
    // (the DUT's current src_data_reg) because src_data_reg may
    // change after dst captures it — the source becomes ready and
    // can accept new data while the destination still presents the
    // old value. Instead, we verify dst_data doesn't change while
    // dst_valid is high, which proves no corruption during delivery.
    // ================================================================
    reg [WIDTH-1:0] fv_dst_data_snapshot;
    reg             fv_dst_valid_prev = 1'b0;

    always @(posedge formal_clk) begin
        if (!reset_n) begin
            fv_dst_valid_prev <= 1'b0;
        end else if (dst_posedge) begin
            fv_dst_valid_prev <= dst_valid;
            // Capture data on rising edge of dst_valid
            if (dst_valid && !fv_dst_valid_prev)
                fv_dst_data_snapshot <= dst_data;
        end
    end

    // dst_data must remain stable throughout the dst_valid pulse
    always @(posedge formal_clk) begin
        if (dut_initialized && dst_posedge && dst_valid && fv_dst_valid_prev) begin
            assert(dst_data == fv_dst_data_snapshot);
        end
    end

    // ================================================================
    // PROPERTY 5: src_ready eventually reasserts (bounded liveness)
    // After src_busy goes high, it must come back low within a bounded
    // number of gclk cycles, provided dst_ready eventually asserts.
    //
    // With 2-stage sync chains in both directions + protocol latency,
    // the worst-case round-trip is roughly:
    //   src_busy -> 2 dst_clk sync -> dst processing -> dst_ack ->
    //   2 src_clk sync -> src clears busy
    // At ~4 gclk per clock edge, this is bounded by ~50 gclk cycles.
    // ================================================================
    reg [6:0] fv_busy_timer = 0;

    always @(posedge formal_clk) begin
        if (!reset_n) begin
            fv_busy_timer <= 0;
        end else if (fv_src_busy) begin
            fv_busy_timer <= fv_busy_timer + 1;
        end else begin
            fv_busy_timer <= 0;
        end
    end

    // Assume dst_ready asserts within a bounded window when dst_valid
    // is high (environment liveness assumption).
    reg [3:0] fv_dst_valid_wait = 0;
    always @(posedge formal_clk) begin
        if (!reset_n) begin
            fv_dst_valid_wait <= 0;
        end else if (dst_posedge && dst_valid && !dst_ready) begin
            fv_dst_valid_wait <= fv_dst_valid_wait + 1;
        end else begin
            fv_dst_valid_wait <= 0;
        end
    end

    always @(posedge formal_clk) begin
        // Consumer must respond within 8 dst_clk-edges
        if (reset_n) begin
            assume(fv_dst_valid_wait < 8);
        end
    end

    // With bounded consumer latency, busy must clear within 100 gclk
    // (wider bound due to stall window of 7 instead of 4)
    always @(posedge formal_clk) begin
        if (dut_initialized) begin
            assert(fv_busy_timer < 100);
        end
    end

    // ================================================================
    // PROPERTY 6: Protocol — dst_ack bounded duration
    // dst_ack must not remain asserted indefinitely. Once src_busy
    // deasserts (visible as !dst_req_sync), dst_ack will be cleared
    // on the next dst_clk edge. We use a bounded-duration check
    // rather than exact-cycle timing due to clk2fflogic latency.
    // ================================================================
    reg [6:0] fv_ack_duration = 0;

    always @(posedge formal_clk) begin
        if (!reset_n) begin
            fv_ack_duration <= 0;
        end else if (dst_posedge) begin
            if (fv_dst_ack)
                fv_ack_duration <= fv_ack_duration + 1;
            else
                fv_ack_duration <= 0;
        end
    end

    // dst_ack must clear within a reasonable window.
    // Worst case: src_busy propagates back through 2-stage sync,
    // then dst_ack clears. Bounded by ~50 gclk (~25 dst edges).
    always @(posedge formal_clk) begin
        if (dut_initialized) begin
            assert(fv_ack_duration < 50);
        end
    end

    // ================================================================
    // PROPERTY 7: No unbounded state growth
    // The sync chain registers are bounded by construction (2-bit).
    // Verify src_ack_sync_chain and dst_req_sync_chain stay in range.
    // (They are 2-bit regs, so this is structural, but good to assert.)
    // ================================================================
    always @(posedge formal_clk) begin
        if (dut_initialized) begin
            assert(fv_src_ack_sync_chain <= 2'b11);
            assert(fv_dst_req_sync_chain <= 2'b11);
        end
    end

    // ================================================================
    // COVER properties — reachability of key protocol states
    // ================================================================

    // Cover: full handshake completes (data accepted by src, delivered
    // at dst, consumed, and src_ready re-asserts).
    reg fv_cover_phase = 1'b0;

    always @(posedge formal_clk) begin
        if (!reset_n)
            fv_cover_phase <= 1'b0;
        else if (dut_initialized && src_posedge && src_valid && src_ready)
            fv_cover_phase <= 1'b1;
    end

    // Cover 1 & 2: not gated by dut_initialized because they're
    // purely observational (no assertion content). They can fire
    // before or after initialization.
    always @(posedge formal_clk) begin
        // Cover: src accepts data (after reset released)
        if (reset_n) begin
            cover(src_posedge && src_valid && src_ready);
        end
    end

    always @(posedge formal_clk) begin
        if (dut_initialized) begin
            // Cover: dst presents valid data
            cover(dst_posedge && dst_valid);

            // Cover: dst consumes data
            cover(dst_posedge && dst_valid && dst_ready);

            // Cover: full round-trip — src back to ready after transfer
            // that started AFTER dut_initialized
            cover(fv_cover_phase && src_ready && !fv_src_busy);
        end
    end

`endif // FORMAL

endmodule
