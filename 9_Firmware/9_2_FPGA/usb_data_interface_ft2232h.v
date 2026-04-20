`timescale 1ns / 1ps

/**
 * usb_data_interface_ft2232h.v
 *
 * FT2232H USB 2.0 Hi-Speed FIFO Interface (245 Synchronous FIFO Mode)
 * Channel A only — 8-bit data bus, 60 MHz CLKOUT from FT2232H.
 *
 * This module is the 50T production board equivalent of usb_data_interface.v
 * (FT601, 32-bit, USB 3.0). Both share the same internal interface signals
 * so they can be swapped via a generate block in radar_system_top.v.
 *
 * Data packet (FPGA→Host): 11 bytes
 *   Byte 0:    0xAA (header)
 *   Bytes 1-4: range_profile[31:0] = {range_q[15:0], range_i[15:0]} MSB first
 *   Bytes 5-6: doppler_real[15:0] MSB first
 *   Bytes 7-8: doppler_imag[15:0] MSB first
 *   Byte 9:    {7'b0, cfar_detection}
 *   Byte 10:   0x55 (footer)
 *
 * Status packet (FPGA→Host): 26 bytes
 *   Byte 0:     0xBB (status header)
 *   Bytes 1-24: 6 × 32-bit status words, MSB first
 *   Byte 25:    0x55 (footer)
 *
 * Command (Host→FPGA): 4 bytes received sequentially
 *   Byte 0: opcode[7:0]
 *   Byte 1: addr[7:0]
 *   Byte 2: value[15:8]
 *   Byte 3: value[7:0]
 *
 * CDC: Toggle CDC (not level sync) for all valid pulse crossings from
 * 100 MHz → 60 MHz. Toggle CDC is guaranteed to work regardless of
 * clock frequency ratio.
 *
 * Clock domains:
 *   clk       = 100 MHz system clock (radar data domain)
 *   ft_clk    = 60 MHz from FT2232H CLKOUT (USB FIFO domain)
 *
 * USB disconnect recovery:
 *   A clock-activity watchdog in the clk domain detects when ft_clk stops
 *   (USB cable unplugged). After ~0.65 ms of silence (65536 system clocks)
 *   it asserts ft_clk_lost, which is OR'd into the FT-domain reset so
 *   FSMs and FIFOs return to a clean state. When ft_clk resumes, a 2-stage
 *   reset synchronizer deasserts the reset cleanly in the ft_clk domain.
 */

module usb_data_interface_ft2232h (
    input wire clk,              // Main clock (100 MHz)
    input wire reset_n,          // System reset (clk domain)
    input wire ft_reset_n,       // FT2232H-domain synchronized reset

    // Radar data inputs (clk domain)
    input wire [31:0] range_profile,
    input wire range_valid,
    input wire [15:0] doppler_real,
    input wire [15:0] doppler_imag,
    input wire doppler_valid,
    input wire cfar_detection,
    input wire cfar_valid,

    // FT2232H Physical Interface (245 Synchronous FIFO mode)
    inout wire [7:0] ft_data,       // 8-bit bidirectional data bus
    input wire ft_rxf_n,            // Receive FIFO not empty (active low)
    input wire ft_txe_n,            // Transmit FIFO not full (active low)
    output reg ft_rd_n,             // Read strobe (active low)
    output reg ft_wr_n,             // Write strobe (active low)
    output reg ft_oe_n,             // Output enable (active low) — bus direction
    output reg ft_siwu,             // Send Immediate / WakeUp — UNUSED: held low.
                                    // SIWU could flush the TX FIFO for lower latency
                                    // but is not needed at current data rates. Deferred.

    // Clock from FT2232H (directly used — no ODDR forwarding needed)
    input wire ft_clk,              // 60 MHz from FT2232H CLKOUT

    // Host command outputs (ft_clk domain — CDC'd by consumer)
    output reg [31:0] cmd_data,
    output reg cmd_valid,
    output reg [7:0] cmd_opcode,
    output reg [7:0] cmd_addr,
    output reg [15:0] cmd_value,

    // Stream control input (clk domain, CDC'd internally)
    input wire [2:0] stream_control,

    // Status readback inputs (clk domain, CDC'd internally)
    input wire status_request,
    input wire [15:0] status_cfar_threshold,
    input wire [2:0]  status_stream_ctrl,
    input wire [1:0]  status_radar_mode,
    input wire [15:0] status_long_chirp,
    input wire [15:0] status_long_listen,
    input wire [15:0] status_guard,
    input wire [15:0] status_short_chirp,
    input wire [15:0] status_short_listen,
    input wire [5:0]  status_chirps_per_elev,
    input wire [1:0]  status_range_mode,

    // Self-test status readback
    input wire [4:0]  status_self_test_flags,
    input wire [7:0]  status_self_test_detail,
    input wire        status_self_test_busy,

    // AGC status readback
    input wire [3:0]  status_agc_current_gain,
    input wire [7:0]  status_agc_peak_magnitude,
    input wire [7:0]  status_agc_saturation_count,
    input wire        status_agc_enable
);

// ============================================================================
// PACKET FORMAT CONSTANTS
// ============================================================================
localparam HEADER        = 8'hAA;
localparam FOOTER        = 8'h55;
localparam STATUS_HEADER = 8'hBB;

// Data packet: 11 bytes total
localparam DATA_PKT_LEN    = 5'd11;
// Status packet: 26 bytes total (1 header + 24 data + 1 footer)
localparam STATUS_PKT_LEN  = 5'd26;

// ============================================================================
// WRITE FSM STATES (FPGA → Host)
// ============================================================================
localparam [2:0] WR_IDLE          = 3'd0,
                 WR_DATA_SEND     = 3'd1,
                 WR_STATUS_SEND   = 3'd2,
                 WR_DONE          = 3'd3;

reg [2:0] wr_state;
reg [4:0] wr_byte_idx;   // Byte counter within packet (0..10 data, 0..25 status)

// ============================================================================
// READ FSM STATES (Host → FPGA)
// ============================================================================
localparam [2:0] RD_IDLE       = 3'd0,
                 RD_OE_ASSERT  = 3'd1,
                 RD_READING    = 3'd2,
                 RD_DEASSERT   = 3'd3,
                 RD_PROCESS    = 3'd4;

reg [2:0] rd_state;
reg [1:0] rd_byte_cnt;   // 0..3 for 4-byte command word
reg [31:0] rd_shift_reg;  // Shift register to assemble 4-byte command
reg rd_cmd_complete;      // Set when all 4 bytes received (distinguishes from abort)

// ============================================================================
// DATA BUS DIRECTION CONTROL
// ============================================================================
reg [7:0] ft_data_out;
reg ft_data_oe;  // 1 = FPGA drives bus, 0 = FT2232H drives bus

assign ft_data = ft_data_oe ? ft_data_out : 8'hZZ;

// ============================================================================
// TOGGLE CDC: clk (100 MHz) → ft_clk (60 MHz)
// ============================================================================
// Toggle CDC is used instead of level synchronizers because a 10 ns pulse
// on clk_100m could be missed by the 16.67 ns ft_clk period. Toggle CDC
// converts pulses to level transitions, which are always captured.

// --- Toggle registers (clk domain) ---
reg range_valid_toggle;
reg doppler_valid_toggle;
reg cfar_valid_toggle;
reg status_req_toggle;

// --- Holding registers (clk domain) ---
// Data captured on valid pulse, held stable for ft_clk domain to read
reg [31:0] range_profile_hold;
reg [15:0] doppler_real_hold;
reg [15:0] doppler_imag_hold;
reg cfar_detection_hold;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        range_valid_toggle   <= 1'b0;
        doppler_valid_toggle <= 1'b0;
        cfar_valid_toggle    <= 1'b0;
        status_req_toggle    <= 1'b0;
        range_profile_hold   <= 32'd0;
        doppler_real_hold    <= 16'd0;
        doppler_imag_hold    <= 16'd0;
        cfar_detection_hold  <= 1'b0;
    end else begin
        if (range_valid) begin
            range_valid_toggle  <= ~range_valid_toggle;
            range_profile_hold  <= range_profile;
        end
        if (doppler_valid) begin
            doppler_valid_toggle <= ~doppler_valid_toggle;
            doppler_real_hold    <= doppler_real;
            doppler_imag_hold    <= doppler_imag;
        end
        if (cfar_valid) begin
            cfar_valid_toggle   <= ~cfar_valid_toggle;
            cfar_detection_hold <= cfar_detection;
        end
        if (status_request)
            status_req_toggle <= ~status_req_toggle;
    end
end

// ============================================================================
// CLOCK-ACTIVITY WATCHDOG (clk domain)
// ============================================================================
// Detects when ft_clk stops (USB cable unplugged). A toggle register in the
// ft_clk domain flips every ft_clk edge. The clk domain synchronizes it and
// checks for transitions. If no transition is seen for 2^16 = 65536 clk
// cycles (~0.65 ms at 100 MHz), ft_clk_lost asserts.
//
// ft_clk_lost feeds into the effective reset for the ft_clk domain so that
// FSMs and capture registers return to a clean state automatically.

// Toggle register: flips every ft_clk edge (ft_clk domain)
reg ft_heartbeat;
always @(posedge ft_clk or negedge ft_reset_n) begin
    if (!ft_reset_n)
        ft_heartbeat <= 1'b0;
    else
        ft_heartbeat <= ~ft_heartbeat;
end

// Synchronize heartbeat into clk domain (2-stage)
(* ASYNC_REG = "TRUE" *) reg [1:0] ft_hb_sync;
reg ft_hb_prev;
reg [15:0] ft_clk_timeout;
reg ft_clk_lost;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        ft_hb_sync    <= 2'b00;
        ft_hb_prev    <= 1'b0;
        ft_clk_timeout <= 16'd0;
        ft_clk_lost   <= 1'b0;
    end else begin
        ft_hb_sync <= {ft_hb_sync[0], ft_heartbeat};
        ft_hb_prev <= ft_hb_sync[1];

        if (ft_hb_sync[1] != ft_hb_prev) begin
            // ft_clk is alive — reset counter, clear lost flag
            ft_clk_timeout <= 16'd0;
            ft_clk_lost    <= 1'b0;
        end else if (!ft_clk_lost) begin
            if (ft_clk_timeout == 16'hFFFF)
                ft_clk_lost <= 1'b1;
            else
                ft_clk_timeout <= ft_clk_timeout + 16'd1;
        end
    end
end

// Effective FT-domain reset: asserted by global reset OR clock loss.
// Deassertion synchronized to ft_clk via 2-stage sync to avoid
// metastability on the recovery edge.
(* ASYNC_REG = "TRUE" *) reg [1:0] ft_reset_sync;
wire ft_reset_raw_n = ft_reset_n & ~ft_clk_lost;

always @(posedge ft_clk or negedge ft_reset_raw_n) begin
    if (!ft_reset_raw_n)
        ft_reset_sync <= 2'b00;
    else
        ft_reset_sync <= {ft_reset_sync[0], 1'b1};
end

wire ft_effective_reset_n = ft_reset_sync[1];

// --- 3-stage synchronizers (ft_clk domain) ---
// 3 stages for better MTBF at 60 MHz

(* ASYNC_REG = "TRUE" *) reg [2:0] range_toggle_sync;
(* ASYNC_REG = "TRUE" *) reg [2:0] doppler_toggle_sync;
(* ASYNC_REG = "TRUE" *) reg [2:0] cfar_toggle_sync;
(* ASYNC_REG = "TRUE" *) reg [2:0] status_toggle_sync;

reg range_toggle_prev;
reg doppler_toggle_prev;
reg cfar_toggle_prev;
reg status_toggle_prev;

// Edge-detected pulses in ft_clk domain
wire range_valid_ft   = range_toggle_sync[2]   ^ range_toggle_prev;
wire doppler_valid_ft = doppler_toggle_sync[2]  ^ doppler_toggle_prev;
wire cfar_valid_ft    = cfar_toggle_sync[2]     ^ cfar_toggle_prev;
wire status_req_ft    = status_toggle_sync[2]   ^ status_toggle_prev;

// --- Stream control CDC (per-bit 2-stage, changes infrequently) ---
(* ASYNC_REG = "TRUE" *) reg [2:0] stream_ctrl_sync_0;
(* ASYNC_REG = "TRUE" *) reg [2:0] stream_ctrl_sync_1;
wire stream_range_en   = stream_ctrl_sync_1[0];
wire stream_doppler_en = stream_ctrl_sync_1[1];
wire stream_cfar_en    = stream_ctrl_sync_1[2];

// --- Captured data in ft_clk domain ---
reg [31:0] range_profile_cap;
reg [15:0] doppler_real_cap;
reg [15:0] doppler_imag_cap;
reg cfar_detection_cap;

// Data-pending flags (ft_clk domain)
reg doppler_data_pending;
reg cfar_data_pending;

// 1-cycle delayed range trigger.  range_valid_ft fires on the same clock
// edge that range_profile_cap is captured (non-blocking).  If the FSM
// reads range_profile_cap on that same edge it sees the STALE value.
// Delaying the trigger by one cycle guarantees the capture register has
// settled before the byte mux reads it.
reg range_data_ready;

// Frame sync: sample counter (ft_clk domain, wraps at NUM_CELLS)
// Bit 7 of detection byte is set when sample_counter == 0 (frame start).
// This allows the Python host to resynchronize without a protocol change.
localparam [11:0] NUM_CELLS = 12'd2048;  // 64 range x 32 doppler
reg [11:0] sample_counter;

// Status snapshot (ft_clk domain)
reg [31:0] status_words [0:5];

integer si;  // status_words loop index
always @(posedge ft_clk or negedge ft_effective_reset_n) begin
    if (!ft_effective_reset_n) begin
        range_toggle_sync   <= 3'b000;
        doppler_toggle_sync <= 3'b000;
        cfar_toggle_sync    <= 3'b000;
        status_toggle_sync  <= 3'b000;
        range_toggle_prev   <= 1'b0;
        doppler_toggle_prev <= 1'b0;
        cfar_toggle_prev    <= 1'b0;
        status_toggle_prev  <= 1'b0;
        range_profile_cap   <= 32'd0;
        doppler_real_cap    <= 16'd0;
        doppler_imag_cap    <= 16'd0;
        cfar_detection_cap  <= 1'b0;
        range_data_ready    <= 1'b0;
        // Default to range-only on reset (prevents write FSM deadlock)
        stream_ctrl_sync_0  <= 3'b001;
        stream_ctrl_sync_1  <= 3'b001;
        // Explicit reset for status_words to avoid Synth 8-7137
        for (si = 0; si < 6; si = si + 1)
            status_words[si] <= 32'd0;
    end else begin
        // 3-stage toggle synchronizers
        range_toggle_sync   <= {range_toggle_sync[1:0],   range_valid_toggle};
        doppler_toggle_sync <= {doppler_toggle_sync[1:0], doppler_valid_toggle};
        cfar_toggle_sync    <= {cfar_toggle_sync[1:0],    cfar_valid_toggle};
        status_toggle_sync  <= {status_toggle_sync[1:0],  status_req_toggle};

        // Previous toggle value for edge detection
        range_toggle_prev   <= range_toggle_sync[2];
        doppler_toggle_prev <= doppler_toggle_sync[2];
        cfar_toggle_prev    <= cfar_toggle_sync[2];
        status_toggle_prev  <= status_toggle_sync[2];

        // Stream control CDC (2-stage)
        stream_ctrl_sync_0 <= stream_control;
        stream_ctrl_sync_1 <= stream_ctrl_sync_0;

        // Capture data on toggle edge
        if (range_valid_ft)
            range_profile_cap <= range_profile_hold;
        if (doppler_valid_ft) begin
            doppler_real_cap <= doppler_real_hold;
            doppler_imag_cap <= doppler_imag_hold;
        end
        if (cfar_valid_ft)
            cfar_detection_cap <= cfar_detection_hold;

        // 1-cycle delayed trigger: ensures range_profile_cap has settled
        // before the FSM reads it via the byte mux.
        range_data_ready <= range_valid_ft;

        // Status snapshot on request
        if (status_req_ft) begin
            // Word 0: {0xFF[31:24], mode[23:22], stream[21:19], 3'b000[18:16], threshold[15:0]}
            status_words[0] <= {8'hFF, status_radar_mode, status_stream_ctrl,
                                3'b000, status_cfar_threshold};
            status_words[1] <= {status_long_chirp, status_long_listen};
            status_words[2] <= {status_guard, status_short_chirp};
            status_words[3] <= {status_short_listen, 10'd0, status_chirps_per_elev};
            status_words[4] <= {status_agc_current_gain,        // [31:28]
                                status_agc_peak_magnitude,      // [27:20]
                                status_agc_saturation_count,    // [19:12]
                                status_agc_enable,              // [11]
                                9'd0,                           // [10:2] reserved
                                status_range_mode};             // [1:0]
            status_words[5] <= {7'd0, status_self_test_busy,
                                8'd0, status_self_test_detail,
                                3'd0, status_self_test_flags};
        end
    end
end

// ============================================================================
// WRITE DATA MUX — byte selection for data packet (11 bytes)
// ============================================================================
// Mux-based byte selection is simpler than a shift register and gives
// explicit byte ordering for synthesis.

reg [7:0] data_pkt_byte;

always @(*) begin
    case (wr_byte_idx)
        5'd0:  data_pkt_byte = HEADER;
        5'd1:  data_pkt_byte = range_profile_cap[31:24];   // range MSB
        5'd2:  data_pkt_byte = range_profile_cap[23:16];
        5'd3:  data_pkt_byte = range_profile_cap[15:8];
        5'd4:  data_pkt_byte = range_profile_cap[7:0];     // range LSB
        // Doppler fields: zero when stream_doppler_en is off
        5'd5:  data_pkt_byte = stream_doppler_en ? doppler_real_cap[15:8]  : 8'd0;
        5'd6:  data_pkt_byte = stream_doppler_en ? doppler_real_cap[7:0]   : 8'd0;
        5'd7:  data_pkt_byte = stream_doppler_en ? doppler_imag_cap[15:8]  : 8'd0;
        5'd8:  data_pkt_byte = stream_doppler_en ? doppler_imag_cap[7:0]   : 8'd0;
        // Detection field: zero when stream_cfar_en is off
        // Bit 7 = frame_start flag (sample_counter == 0), bit 0 = cfar_detection
        5'd9:  data_pkt_byte = stream_cfar_en
                   ? {(sample_counter == 12'd0), 6'b0, cfar_detection_cap}
                   : {(sample_counter == 12'd0), 7'd0};
        5'd10: data_pkt_byte = FOOTER;
        default: data_pkt_byte = 8'h00;
    endcase
end

// ============================================================================
// WRITE DATA MUX — byte selection for status packet (26 bytes)
// ============================================================================

reg [7:0] status_pkt_byte;

always @(*) begin
    case (wr_byte_idx)
        5'd0:  status_pkt_byte = STATUS_HEADER;
        // Word 0 (bytes 1-4)
        5'd1:  status_pkt_byte = status_words[0][31:24];
        5'd2:  status_pkt_byte = status_words[0][23:16];
        5'd3:  status_pkt_byte = status_words[0][15:8];
        5'd4:  status_pkt_byte = status_words[0][7:0];
        // Word 1 (bytes 5-8)
        5'd5:  status_pkt_byte = status_words[1][31:24];
        5'd6:  status_pkt_byte = status_words[1][23:16];
        5'd7:  status_pkt_byte = status_words[1][15:8];
        5'd8:  status_pkt_byte = status_words[1][7:0];
        // Word 2 (bytes 9-12)
        5'd9:  status_pkt_byte = status_words[2][31:24];
        5'd10: status_pkt_byte = status_words[2][23:16];
        5'd11: status_pkt_byte = status_words[2][15:8];
        5'd12: status_pkt_byte = status_words[2][7:0];
        // Word 3 (bytes 13-16)
        5'd13: status_pkt_byte = status_words[3][31:24];
        5'd14: status_pkt_byte = status_words[3][23:16];
        5'd15: status_pkt_byte = status_words[3][15:8];
        5'd16: status_pkt_byte = status_words[3][7:0];
        // Word 4 (bytes 17-20)
        5'd17: status_pkt_byte = status_words[4][31:24];
        5'd18: status_pkt_byte = status_words[4][23:16];
        5'd19: status_pkt_byte = status_words[4][15:8];
        5'd20: status_pkt_byte = status_words[4][7:0];
        // Word 5 (bytes 21-24)
        5'd21: status_pkt_byte = status_words[5][31:24];
        5'd22: status_pkt_byte = status_words[5][23:16];
        5'd23: status_pkt_byte = status_words[5][15:8];
        5'd24: status_pkt_byte = status_words[5][7:0];
        // Footer (byte 25)
        5'd25: status_pkt_byte = FOOTER;
        default: status_pkt_byte = 8'h00;
    endcase
end

// ============================================================================
// MAIN FSM (ft_clk domain)
// ============================================================================
// Write FSM and Read FSM share the bus. Write FSM operates when Read FSM
// is idle. Read FSM takes priority when host has data available.

always @(posedge ft_clk or negedge ft_effective_reset_n) begin
    if (!ft_effective_reset_n) begin
        wr_state       <= WR_IDLE;
        wr_byte_idx    <= 5'd0;
        rd_state       <= RD_IDLE;
        rd_byte_cnt    <= 2'd0;
        rd_cmd_complete <= 1'b0;
        rd_shift_reg   <= 32'd0;
        ft_data_out    <= 8'd0;
        ft_data_oe     <= 1'b0;
        ft_rd_n        <= 1'b1;
        ft_wr_n        <= 1'b1;
        ft_oe_n        <= 1'b1;
        ft_siwu        <= 1'b0;
        cmd_data       <= 32'd0;
        cmd_valid      <= 1'b0;
        cmd_opcode     <= 8'd0;
        cmd_addr       <= 8'd0;
        cmd_value      <= 16'd0;
        doppler_data_pending <= 1'b0;
        cfar_data_pending    <= 1'b0;
        sample_counter       <= 12'd0;
    end else begin
        // Default: clear one-shot signals
        cmd_valid <= 1'b0;

        // Data-pending flag management
        if (doppler_valid_ft)
            doppler_data_pending <= 1'b1;
        if (cfar_valid_ft)
            cfar_data_pending <= 1'b1;

        // ================================================================
        // READ FSM — Host → FPGA command path (4-byte sequential read)
        // ================================================================
        case (rd_state)
            RD_IDLE: begin
                // Only start reading if write FSM is idle and host has data
                if (wr_state == WR_IDLE && !ft_rxf_n) begin
                    ft_oe_n    <= 1'b0;      // Assert OE: FT2232H drives bus
                    ft_data_oe <= 1'b0;      // FPGA releases bus
                    rd_state   <= RD_OE_ASSERT;
                end
            end

            RD_OE_ASSERT: begin
                // 1-cycle turnaround: OE asserted, bus settling
                if (!ft_rxf_n) begin
                    ft_rd_n  <= 1'b0;        // Assert RD: start reading
                    rd_state <= RD_READING;
                end else begin
                    // Host withdrew data — abort
                    ft_oe_n  <= 1'b1;
                    rd_state <= RD_IDLE;
                end
            end

            RD_READING: begin
                // Sample byte and shift into command register
                // Byte order: opcode, addr, value_hi, value_lo
                rd_shift_reg <= {rd_shift_reg[23:0], ft_data};
                if (rd_byte_cnt == 2'd3) begin
                    // All 4 bytes received
                    ft_rd_n         <= 1'b1;
                    rd_byte_cnt     <= 2'd0;
                    rd_cmd_complete <= 1'b1;
                    rd_state        <= RD_DEASSERT;
                end else begin
                    rd_byte_cnt <= rd_byte_cnt + 2'd1;
                    // Keep reading if more data available
                    if (ft_rxf_n) begin
                        // Host ran out of data mid-command — abort
                        ft_rd_n         <= 1'b1;
                        rd_byte_cnt     <= 2'd0;
                        rd_cmd_complete <= 1'b0;
                        rd_state        <= RD_DEASSERT;
                    end
                end
            end

            RD_DEASSERT: begin
                // Deassert OE (1 cycle after RD deasserted)
                ft_oe_n  <= 1'b1;
                // Only process if we received a full 4-byte command
                if (rd_cmd_complete) begin
                    rd_cmd_complete <= 1'b0;
                    rd_state <= RD_PROCESS;
                end else begin
                    // Incomplete command — discard
                    rd_state <= RD_IDLE;
                end
            end

            RD_PROCESS: begin
                // Decode the assembled command word
                cmd_data   <= rd_shift_reg;
                cmd_opcode <= rd_shift_reg[31:24];
                cmd_addr   <= rd_shift_reg[23:16];
                cmd_value  <= rd_shift_reg[15:0];
                cmd_valid  <= 1'b1;
                rd_state   <= RD_IDLE;
            end

            default: rd_state <= RD_IDLE;
        endcase

        // ================================================================
        // WRITE FSM — FPGA → Host data streaming (byte-sequential)
        // ================================================================
        if (rd_state == RD_IDLE) begin
            case (wr_state)
                WR_IDLE: begin
                    ft_wr_n    <= 1'b1;
                    ft_data_oe <= 1'b0;   // Release data bus

                    // Status readback takes priority
                    if (status_req_ft && ft_rxf_n) begin
                        wr_state    <= WR_STATUS_SEND;
                        wr_byte_idx <= 5'd0;
                    end
                    // Trigger on range_data_ready (1 cycle after range_valid_ft)
                    // so that range_profile_cap has settled from the CDC block.
                    // Gate on pending flags: only send when all enabled
                    // streams have fresh data (avoids stale doppler/CFAR)
                    else if (range_data_ready && stream_range_en
                             && (!stream_doppler_en || doppler_data_pending)
                             && (!stream_cfar_en    || cfar_data_pending)) begin
                        if (ft_rxf_n) begin  // No host read pending
                            wr_state    <= WR_DATA_SEND;
                            wr_byte_idx <= 5'd0;
                        end
                    end
                end

                WR_DATA_SEND: begin
                    if (!ft_txe_n) begin
                        // TXE# low = TX FIFO has room
                        ft_data_oe  <= 1'b1;
                        ft_data_out <= data_pkt_byte;
                        ft_wr_n     <= 1'b0;   // Assert write strobe

                        if (wr_byte_idx == DATA_PKT_LEN - 5'd1) begin
                            // Last byte of data packet
                            wr_state    <= WR_DONE;
                            wr_byte_idx <= 5'd0;
                        end else begin
                            wr_byte_idx <= wr_byte_idx + 5'd1;
                        end
                    end
                end

                WR_STATUS_SEND: begin
                    if (!ft_txe_n) begin
                        ft_data_oe  <= 1'b1;
                        ft_data_out <= status_pkt_byte;
                        ft_wr_n     <= 1'b0;

                        if (wr_byte_idx == STATUS_PKT_LEN - 5'd1) begin
                            wr_state    <= WR_DONE;
                            wr_byte_idx <= 5'd0;
                        end else begin
                            wr_byte_idx <= wr_byte_idx + 5'd1;
                        end
                    end
                end

                WR_DONE: begin
                    ft_wr_n    <= 1'b1;
                    ft_data_oe <= 1'b0;   // Release data bus
                    // Clear pending flags — data consumed
                    doppler_data_pending <= 1'b0;
                    cfar_data_pending    <= 1'b0;
                    // Advance frame sync counter
                    if (sample_counter == NUM_CELLS - 12'd1)
                        sample_counter <= 12'd0;
                    else
                        sample_counter <= sample_counter + 12'd1;
                    wr_state   <= WR_IDLE;
                end

                default: wr_state <= WR_IDLE;
            endcase
        end
    end
end

endmodule
