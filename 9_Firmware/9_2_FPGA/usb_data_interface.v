/**
 * usb_data_interface.v
 *
 * FT601 USB 3.0 SuperSpeed FIFO Interface (32-bit bus, 100 MHz ft601_clk).
 * Used on the 200T premium dev board. Production 50T board uses
 * usb_data_interface_ft2232h.v (FT2232H, 8-bit, 60 MHz) instead.
 *
 * USB disconnect recovery:
 *   A clock-activity watchdog in the clk domain detects when ft601_clk_in
 *   stops (USB cable unplugged). After ~0.65 ms of silence (65536 system
 *   clocks) it asserts ft601_clk_lost, which is OR'd into the FT-domain
 *   reset so FSMs and FIFOs return to a clean state. When ft601_clk_in
 *   resumes, a 2-stage reset synchronizer deasserts the reset cleanly.
 */
module usb_data_interface (
    input wire clk,              // Main clock (100MHz recommended)
    input wire reset_n,
    input wire ft601_reset_n,    // FT601-domain synchronized reset
    
    // Radar data inputs
    input wire [31:0] range_profile,
    input wire range_valid,
    input wire [15:0] doppler_real,
    input wire [15:0] doppler_imag,
    input wire doppler_valid,
    input wire cfar_detection,
    input wire cfar_valid,
    
    // FT601 Interface (Slave FIFO mode)
    // Data bus
    inout wire [31:0] ft601_data,    // 32-bit bidirectional data bus
    output reg [3:0] ft601_be,       // Byte enable (active-HIGH per DS_FT600Q-FT601Q Table 3.2)
    
    // Control signals
    // VESTIGIAL OUTPUTS — kept for 200T board port compatibility.
    // On the 200T, these are constrained to physical pins G21 (TXE) and
    // G22 (RXF) in xc7a200t_fbg484.xdc. Removing them from the RTL would
    // break the 200T build. They are reset to 1 and never driven; the
    // actual FT601 flow-control inputs are ft601_txe and ft601_rxf below.
    output reg ft601_txe_n,          // VESTIGIAL: unused output, always 1
    output reg ft601_rxf_n,          // VESTIGIAL: unused output, always 1
    input wire ft601_txe,             // TXE: Transmit FIFO Not Full (active-low: 0 = space available)
    input wire ft601_rxf,             // RXF: Receive FIFO Not Empty (active-low: 0 = data available)
    output reg ft601_wr_n,            // Write strobe (active low)
    output reg ft601_rd_n,            // Read strobe (active low)
    output reg ft601_oe_n,            // Output enable (active low)
    output reg ft601_siwu_n,          // Send immediate / Wakeup
    
    // FIFO flags
    input wire [1:0] ft601_srb,       // Selected read buffer
    input wire [1:0] ft601_swb,       // Selected write buffer
    
    // Clock
    output wire ft601_clk_out,        // Output clock to FT601 (forwarded via ODDR)
    input wire ft601_clk_in,          // Clock from FT601 (60/100MHz)
    
    // ========== HOST COMMAND OUTPUTS (Gap 4: USB Read Path) ==========
    // These outputs are registered in the ft601_clk domain and must be
    // CDC-synchronized by the consumer (radar_system_top.v) before use
    // in the clk_100m domain.
    //
    // Command word format: {opcode[7:0], addr[7:0], value[15:0]}
    //   0x01 = Set radar mode (value[1:0] -> mode_controller mode)
    //   0x02 = Single chirp trigger (value ignored, pulse cmd_valid)
    //   0x03 = Set CFAR threshold (value[15:0] -> threshold)
    //   0x04 = Set stream control (value[2:0] -> enable range/doppler/cfar)
    //   0x10-0x15 = Chirp timing configuration (Gap 2)
    //   0xFF = Status request (triggers status response packet)
    output reg [31:0] cmd_data,      // Last received command word
    output reg cmd_valid,            // Pulse: new command received (ft601_clk domain)
    output reg [7:0] cmd_opcode,     // Decoded opcode for convenience
    output reg [7:0] cmd_addr,       // Decoded register address
    output reg [15:0] cmd_value,     // Decoded value

    // Gap 2: Stream control input (clk_100m domain, CDC'd internally)
    // Bit 0 = range stream enable
    // Bit 1 = doppler stream enable
    // Bit 2 = cfar/detection stream enable
    input wire [2:0] stream_control,

    // Gap 2: Status readback inputs (clk_100m domain, CDC'd internally)
    // When status_request pulses, the write FSM sends a status response
    // packet containing the current register values.
    input wire status_request,                 // 1-cycle pulse in clk_100m when 0xFF received
    input wire [15:0] status_cfar_threshold,   // Current CFAR threshold
    input wire [2:0]  status_stream_ctrl,      // Current stream control
    input wire [1:0]  status_radar_mode,       // Current radar mode
    input wire [15:0] status_long_chirp,       // Current long chirp cycles
    input wire [15:0] status_long_listen,      // Current long listen cycles
    input wire [15:0] status_guard,            // Current guard cycles
    input wire [15:0] status_short_chirp,      // Current short chirp cycles
    input wire [15:0] status_short_listen,     // Current short listen cycles
    input wire [5:0]  status_chirps_per_elev,  // Current chirps per elevation
    input wire [1:0]  status_range_mode,       // Fix 7: Current range mode (0x20)

    // Self-test status readback (opcode 0x31 / included in 0xFF status packet)
    input wire [4:0]  status_self_test_flags,  // Per-test PASS(1)/FAIL(0) latched
    input wire [7:0]  status_self_test_detail, // Diagnostic detail byte latched
    input wire        status_self_test_busy,   // Self-test FSM still running

    // AGC status readback
    input wire [3:0]  status_agc_current_gain,
    input wire [7:0]  status_agc_peak_magnitude,
    input wire [7:0]  status_agc_saturation_count,
    input wire        status_agc_enable
);

// USB packet structure (same as before)
localparam HEADER = 8'hAA;
localparam FOOTER = 8'h55;

// FT601 configuration
localparam FT601_DATA_WIDTH = 32;
localparam FT601_BURST_SIZE = 512;    // Max burst size in bytes

// ============================================================================
// WRITE FSM State definitions (Verilog-2001 compatible)
// ============================================================================
// Rewritten: data packet is now 3 x 32-bit writes (11 payload bytes + 1 pad).
// Word 0: {HEADER, range[31:24], range[23:16], range[15:8]}  BE=1111
// Word 1: {range[7:0], doppler_real[15:8], doppler_real[7:0], doppler_imag[15:8]} BE=1111
// Word 2: {doppler_imag[7:0], detection, FOOTER, 8'h00}      BE=1110
localparam [3:0] IDLE                = 4'd0,
                 SEND_DATA_WORD      = 4'd1,
                 SEND_STATUS         = 4'd2,
                 WAIT_ACK            = 4'd3;

reg [3:0] current_state;
reg [1:0] data_word_idx;     // 0..2 for 3-word data packet
reg [31:0] ft601_data_out;
reg ft601_data_oe;  // Output enable for bidirectional data bus

// Pre-packed data words (registered snapshot of CDC'd data)
reg [31:0] data_pkt_word0;
reg [31:0] data_pkt_word1;
reg [31:0] data_pkt_word2;
reg [3:0]  data_pkt_be2;     // BE for last word (BE=1110 since byte 3 is pad)

// ============================================================================
// READ FSM State definitions (Gap 4: USB Read Path)
// ============================================================================
// FT601 245 synchronous FIFO read protocol:
//   1. Host has data available: RXF_N = 0 (active low)
//   2. FPGA asserts OE_N = 0 (bus turnaround: FT601 starts driving data bus)
//   3. Wait 1 cycle for bus turnaround settling
//   4. FPGA asserts RD_N = 0 (start reading: data valid on each posedge)
//   5. Sample ft601_data[31:0] while RD_N = 0 and RXF_N = 0
//   6. Deassert RD_N = 1, then OE_N = 1
//
// The read FSM only activates when the write FSM is IDLE and RXF indicates
// data is available. This prevents bus contention between TX and RX.
localparam [2:0] RD_IDLE      = 3'd0,  // Waiting for RXF
                 RD_OE_ASSERT = 3'd1,  // Assert OE_N=0, wait turnaround
                 RD_READING   = 3'd2,  // Assert RD_N=0, sample data
                 RD_DEASSERT  = 3'd3,  // Deassert RD_N, then OE_N
                 RD_PROCESS   = 3'd4;  // Process received command word

reg [2:0] read_state;
reg [31:0] rx_data_captured;  // Data word read from host

// ========== CDC INPUT SYNCHRONIZERS (clk domain -> ft601_clk_in domain) ==========
// The valid signals arrive from clk_100m but the state machine runs on ft601_clk_in.
// Even though both are 100 MHz, they are asynchronous clocks and need synchronization.

// 2-stage synchronizers for valid signals
(* ASYNC_REG = "TRUE" *) reg [1:0] range_valid_sync;
(* ASYNC_REG = "TRUE" *) reg [1:0] doppler_valid_sync;
(* ASYNC_REG = "TRUE" *) reg [1:0] cfar_valid_sync;

// Delayed versions of sync[1] for proper edge detection
reg range_valid_sync_d;
reg doppler_valid_sync_d;
reg cfar_valid_sync_d;

// Holding registers: data captured in SOURCE domain (clk_100m) when valid
// asserts, then read by ft601 domain after synchronized valid edge.
// This is safe because the data is stable for the entire time the valid
// pulse is being synchronized (2+ ft601_clk cycles).
reg [31:0] range_profile_hold;
reg [15:0] doppler_real_hold;
reg [15:0] doppler_imag_hold;
reg cfar_detection_hold;

// Gap 2: Status request toggle register (clk_100m domain).
// Declared here (before the always block) to satisfy iverilog forward-ref rules.
reg status_req_toggle_100m;

// Source-domain holding registers (clk domain)
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        range_profile_hold <= 32'd0;
        doppler_real_hold  <= 16'd0;
        doppler_imag_hold  <= 16'd0;
        cfar_detection_hold <= 1'b0;
        status_req_toggle_100m <= 1'b0;
    end else begin
        if (range_valid)
            range_profile_hold <= range_profile;
        if (doppler_valid) begin
            doppler_real_hold <= doppler_real;
            doppler_imag_hold <= doppler_imag;
        end
        if (cfar_valid)
            cfar_detection_hold <= cfar_detection;
        // Gap 2: Toggle on status request pulse (CDC to ft601_clk)
        if (status_request)
            status_req_toggle_100m <= ~status_req_toggle_100m;
    end
end

// ============================================================================
// CLOCK-ACTIVITY WATCHDOG (clk domain)
// ============================================================================
// Detects when ft601_clk_in stops (USB cable unplugged). A toggle register
// in the ft601_clk domain flips every edge. The clk domain synchronizes it
// and checks for transitions. If no transition is seen for 2^16 = 65536
// clk cycles (~0.65 ms at 100 MHz), ft601_clk_lost asserts.

// Toggle register: flips every ft601_clk edge (ft601_clk domain)
reg ft601_heartbeat;
always @(posedge ft601_clk_in or negedge ft601_reset_n) begin
    if (!ft601_reset_n)
        ft601_heartbeat <= 1'b0;
    else
        ft601_heartbeat <= ~ft601_heartbeat;
end

// Synchronize heartbeat into clk domain (2-stage)
(* ASYNC_REG = "TRUE" *) reg [1:0] ft601_hb_sync;
reg ft601_hb_prev;
reg [15:0] ft601_clk_timeout;
reg ft601_clk_lost;

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        ft601_hb_sync    <= 2'b00;
        ft601_hb_prev    <= 1'b0;
        ft601_clk_timeout <= 16'd0;
        ft601_clk_lost   <= 1'b0;
    end else begin
        ft601_hb_sync <= {ft601_hb_sync[0], ft601_heartbeat};
        ft601_hb_prev <= ft601_hb_sync[1];

        if (ft601_hb_sync[1] != ft601_hb_prev) begin
            // ft601_clk is alive — reset counter, clear lost flag
            ft601_clk_timeout <= 16'd0;
            ft601_clk_lost    <= 1'b0;
        end else if (!ft601_clk_lost) begin
            if (ft601_clk_timeout == 16'hFFFF)
                ft601_clk_lost <= 1'b1;
            else
                ft601_clk_timeout <= ft601_clk_timeout + 16'd1;
        end
    end
end

// Effective FT601-domain reset: asserted by global reset OR clock loss.
// Deassertion synchronized to ft601_clk via 2-stage sync to avoid
// metastability on the recovery edge.
(* ASYNC_REG = "TRUE" *) reg [1:0] ft601_reset_sync;
wire ft601_reset_raw_n = ft601_reset_n & ~ft601_clk_lost;

always @(posedge ft601_clk_in or negedge ft601_reset_raw_n) begin
    if (!ft601_reset_raw_n)
        ft601_reset_sync <= 2'b00;
    else
        ft601_reset_sync <= {ft601_reset_sync[0], 1'b1};
end

wire ft601_effective_reset_n = ft601_reset_sync[1];

// FT601-domain captured data (sampled from holding regs on sync'd edge)
reg [31:0] range_profile_cap;
reg [15:0] doppler_real_cap;
reg [15:0] doppler_imag_cap;
reg cfar_detection_cap;

// Data-pending flags (ft601_clk domain).
// Set when a valid edge is detected, cleared when the write FSM consumes
// or skips the data. Prevents the write FSM from blocking forever when
// a stream's valid hasn't fired yet (e.g., Doppler needs 32 chirps).
reg doppler_data_pending;
reg cfar_data_pending;

// 1-cycle delayed range trigger.  range_valid_ft fires on the same clock
// edge that range_profile_cap is captured (non-blocking).  If the FSM
// reads range_profile_cap on that same edge it sees the STALE value.
// Delaying the trigger by one cycle guarantees the capture register has
// settled before the FSM packs the data words.
reg range_data_ready;

// Frame sync: sample counter (ft601_clk domain, wraps at NUM_CELLS)
// Bit 7 of detection byte is set when sample_counter == 0 (frame start).
localparam [11:0] NUM_CELLS = 12'd2048;  // 64 range x 32 doppler
reg [11:0] sample_counter;

// Gap 2: CDC for stream_control (clk_100m -> ft601_clk_in)
// stream_control changes infrequently (only on host USB command), so
// per-bit 2-stage synchronizers are sufficient. No Gray coding needed
// because the bits are independent enables.
// Fix #5: Default to range-only (3'b001) on reset to prevent write FSM
// deadlock before host configures streams. With all streams enabled on
// reset, the first range_valid triggers the write FSM which then blocks
// forever on SEND_DOPPLER_DATA (Doppler hasn't produced data yet).
(* ASYNC_REG = "TRUE" *) reg [2:0] stream_ctrl_sync_0;
(* ASYNC_REG = "TRUE" *) reg [2:0] stream_ctrl_sync_1;
wire stream_range_en   = stream_ctrl_sync_1[0];
wire stream_doppler_en = stream_ctrl_sync_1[1];
wire stream_cfar_en    = stream_ctrl_sync_1[2];

// Gap 2: Status request CDC (toggle CDC, same pattern as cmd_valid)
// status_request is a 1-cycle pulse in clk_100m. Toggle→sync→edge-detect.
// NOTE: status_req_toggle_100m declared above (before source-domain always block)
(* ASYNC_REG = "TRUE" *) reg [1:0] status_req_sync;
reg status_req_sync_prev;
wire status_req_ft601 = status_req_sync[1] ^ status_req_sync_prev;

// Status snapshot: captured in ft601_clk domain when status request arrives.
// The clk_100m-domain status inputs are stable for many cycles after the
// command decode, so sampling them a few ft601_clk cycles later is safe.
reg [31:0] status_words [0:5];  // 6 status words (word 5 = self-test)
reg [2:0] status_word_idx;

wire range_valid_ft;
wire doppler_valid_ft;
wire cfar_valid_ft;

always @(posedge ft601_clk_in or negedge ft601_effective_reset_n) begin
    if (!ft601_effective_reset_n) begin
        range_valid_sync   <= 2'b00;
        doppler_valid_sync <= 2'b00;
        cfar_valid_sync    <= 2'b00;
        range_valid_sync_d   <= 1'b0;
        doppler_valid_sync_d <= 1'b0;
        cfar_valid_sync_d    <= 1'b0;
        range_profile_cap  <= 32'd0;
        doppler_real_cap   <= 16'd0;
        doppler_imag_cap   <= 16'd0;
        cfar_detection_cap <= 1'b0;
        range_data_ready   <= 1'b0;
        // Fix #5: Default to range-only on reset (prevents write FSM deadlock)
        stream_ctrl_sync_0 <= 3'b001;
        stream_ctrl_sync_1 <= 3'b001;
        // Gap 2: status request CDC reset
        status_req_sync <= 2'b00;
        status_req_sync_prev <= 1'b0;
        status_word_idx <= 3'd0;
    end else begin
        // Synchronize valid strobes (2-stage sync chain)
        range_valid_sync   <= {range_valid_sync[0],   range_valid};
        doppler_valid_sync <= {doppler_valid_sync[0], doppler_valid};
        cfar_valid_sync    <= {cfar_valid_sync[0],    cfar_valid};

        // Gap 2: stream control CDC (2-stage)
        stream_ctrl_sync_0 <= stream_control;
        stream_ctrl_sync_1 <= stream_ctrl_sync_0;

        // Gap 2: status request CDC (toggle sync + edge detect)
        status_req_sync <= {status_req_sync[0], status_req_toggle_100m};
        status_req_sync_prev <= status_req_sync[1];

        // Gap 2: Capture status snapshot when request arrives in ft601 domain
        if (status_req_ft601) begin
            // Pack register values into 5x 32-bit status words
            // Word 0: {0xFF[31:24], mode[23:22], stream[21:19], 3'b000[18:16], threshold[15:0]}
            status_words[0] <= {8'hFF, status_radar_mode, status_stream_ctrl,
                                3'b000, status_cfar_threshold};
            // Word 1: {long_chirp_cycles[15:0], long_listen_cycles[15:0]}
            status_words[1] <= {status_long_chirp, status_long_listen};
            // Word 2: {guard_cycles[15:0], short_chirp_cycles[15:0]}
            status_words[2] <= {status_guard, status_short_chirp};
            // Word 3: {short_listen_cycles[15:0], chirps_per_elev[5:0], 10'b0}
            status_words[3] <= {status_short_listen, 10'd0, status_chirps_per_elev};
            // Word 4: AGC metrics + range_mode
            status_words[4] <= {status_agc_current_gain,        // [31:28]
                                status_agc_peak_magnitude,      // [27:20]
                                status_agc_saturation_count,    // [19:12] 8-bit saturation count
                                status_agc_enable,              // [11]
                                9'd0,                           // [10:2] reserved
                                status_range_mode};             // [1:0]
            // Word 5: Self-test results {reserved[6:0], busy, reserved[7:0], detail[7:0], reserved[2:0], flags[4:0]}
            status_words[5] <= {7'd0, status_self_test_busy,
                                8'd0, status_self_test_detail,
                                3'd0, status_self_test_flags};
        end

        // Delayed version of sync[1] for edge detection
        range_valid_sync_d   <= range_valid_sync[1];
        doppler_valid_sync_d <= doppler_valid_sync[1];
        cfar_valid_sync_d    <= cfar_valid_sync[1];

        // Capture data on rising edge of FULLY SYNCHRONIZED valid (sync[1])
        // Data in holding regs is stable by the time sync[1] rises (2+ cycles)
        if (range_valid_sync[1] && !range_valid_sync_d)
            range_profile_cap <= range_profile_hold;
        if (doppler_valid_sync[1] && !doppler_valid_sync_d) begin
            doppler_real_cap <= doppler_real_hold;
            doppler_imag_cap <= doppler_imag_hold;
        end
        if (cfar_valid_sync[1] && !cfar_valid_sync_d) begin
            cfar_detection_cap <= cfar_detection_hold;
        end

        // 1-cycle delayed trigger: ensures range_profile_cap has settled
        // before the FSM reads it for word packing.
        range_data_ready <= range_valid_ft;
    end
end

// Rising-edge detect on FULLY SYNCHRONIZED valid (sync[1], not sync[0])
// This provides full 2-stage metastability protection before use.
assign range_valid_ft   = range_valid_sync[1]   && !range_valid_sync_d;
assign doppler_valid_ft = doppler_valid_sync[1]  && !doppler_valid_sync_d;
assign cfar_valid_ft    = cfar_valid_sync[1]     && !cfar_valid_sync_d;

// FT601 data bus direction control
assign ft601_data = ft601_data_oe ? ft601_data_out : 32'hzzzz_zzzz;

always @(posedge ft601_clk_in or negedge ft601_effective_reset_n) begin
    if (!ft601_effective_reset_n) begin
        current_state <= IDLE;
        read_state <= RD_IDLE;
        data_word_idx <= 2'd0;
        ft601_data_out <= 0;
        ft601_data_oe <= 0;
        ft601_be <= 4'b1111;  // All bytes enabled for 32-bit mode
        ft601_txe_n <= 1;
        ft601_rxf_n <= 1;
        ft601_wr_n <= 1;
        ft601_rd_n <= 1;
        ft601_oe_n <= 1;
        ft601_siwu_n <= 1;
        rx_data_captured <= 32'd0;
        cmd_data <= 32'd0;
        cmd_valid <= 1'b0;
        cmd_opcode <= 8'd0;
        cmd_addr <= 8'd0;
        cmd_value <= 16'd0;
        doppler_data_pending <= 1'b0;
        cfar_data_pending <= 1'b0;
        data_pkt_word0 <= 32'd0;
        data_pkt_word1 <= 32'd0;
        data_pkt_word2 <= 32'd0;
        data_pkt_be2   <= 4'b1110;
        sample_counter <= 12'd0;
        // NOTE: ft601_clk_out is driven by the clk-domain always block below.
        // Do NOT assign it here (ft601_clk_in domain) — causes multi-driven net.
    end else begin
        // Default: clear one-shot signals
        cmd_valid <= 1'b0;

        // Data-pending flag management: set on valid edge, cleared when
        // consumed or skipped by write FSM. Must be in this always block
        // (not the CDC sync block) to avoid Vivado multiple-driver DRC error.
        if (doppler_valid_ft)
            doppler_data_pending <= 1'b1;
        if (cfar_valid_ft)
            cfar_data_pending <= 1'b1;

        // ================================================================
        // READ FSM — host-to-FPGA command path (Gap 4)
        //
        // The read FSM takes priority over write when both could activate.
        // It only starts when the write FSM is IDLE and ft601_rxf
        // indicates data from host is available.
        // ================================================================
        case (read_state)
            RD_IDLE: begin
                // Only start reading if write FSM is idle and host has data.
                // ft601_rxf active-low: 0 means data available from host.
                if (current_state == IDLE && !ft601_rxf) begin
                    ft601_oe_n <= 1'b0;     // Assert OE: tell FT601 to drive bus
                    ft601_data_oe <= 1'b0;  // FPGA releases bus (FT601 drives)
                    read_state <= RD_OE_ASSERT;
                end
            end

            RD_OE_ASSERT: begin
                // 1-cycle turnaround: OE_N asserted, bus settling.
                // FT601 spec requires 1 clock of OE_N before RD_N assertion.
                if (!ft601_rxf) begin
                    ft601_rd_n <= 1'b0;     // Assert RD: start reading
                    read_state <= RD_READING;
                end else begin
                    // Host withdrew data — abort
                    ft601_oe_n <= 1'b1;
                    read_state <= RD_IDLE;
                end
            end

            RD_READING: begin
                // Data is valid on ft601_data. Sample it.
                // For now we read a single 32-bit command word per transaction.
                rx_data_captured <= ft601_data;
                ft601_rd_n <= 1'b1;         // Deassert RD
                read_state <= RD_DEASSERT;
            end

            RD_DEASSERT: begin
                // Deassert OE_N (1 cycle after RD_N deasserted)
                ft601_oe_n <= 1'b1;
                read_state <= RD_PROCESS;
            end

            RD_PROCESS: begin
                // Decode the received command word and pulse cmd_valid.
                // Format: {opcode[31:24], addr[23:16], value[15:0]}
                cmd_data   <= rx_data_captured;
                cmd_opcode <= rx_data_captured[31:24];
                cmd_addr   <= rx_data_captured[23:16];
                cmd_value  <= rx_data_captured[15:0];
                cmd_valid  <= 1'b1;
                read_state <= RD_IDLE;
            end

            default: read_state <= RD_IDLE;
        endcase

        // ================================================================
        // WRITE FSM — FPGA-to-host data streaming (existing)
        //
        // Only operates when read FSM is idle (no bus contention).
        // ================================================================
        if (read_state == RD_IDLE) begin
            case (current_state)
                IDLE: begin
                    ft601_wr_n <= 1;
                    ft601_data_oe <= 0;  // Release data bus
                    // Gap 2: Status readback takes priority
                    if (status_req_ft601 && ft601_rxf) begin
                        current_state <= SEND_STATUS;
                        status_word_idx <= 3'd0;
                    end
                    // Trigger on range_data_ready (1 cycle after range_valid_ft)
                    // so that range_profile_cap has settled from the CDC block.
                    // Gate on pending flags: only send when all enabled
                    // streams have fresh data (avoids stale doppler/CFAR)
                    else if (range_data_ready && stream_range_en
                             && (!stream_doppler_en || doppler_data_pending)
                             && (!stream_cfar_en    || cfar_data_pending)) begin
                        // Don't start write if a read is about to begin
                        if (ft601_rxf) begin  // rxf=1 means no host data pending
                            // Pack 11-byte data packet into 3 x 32-bit words
                            // Doppler fields zeroed when stream disabled
                            // CFAR field zeroed when stream disabled
                            data_pkt_word0 <= {HEADER,
                                               range_profile_cap[31:24],
                                               range_profile_cap[23:16],
                                               range_profile_cap[15:8]};
                            data_pkt_word1 <= {range_profile_cap[7:0],
                                               stream_doppler_en ? doppler_real_cap[15:8] : 8'd0,
                                               stream_doppler_en ? doppler_real_cap[7:0]  : 8'd0,
                                               stream_doppler_en ? doppler_imag_cap[15:8] : 8'd0};
                            data_pkt_word2 <= {stream_doppler_en ? doppler_imag_cap[7:0]  : 8'd0,
                                               stream_cfar_en
                                                    ? {(sample_counter == 12'd0), 6'b0, cfar_detection_cap}
                                                    : {(sample_counter == 12'd0), 7'd0},
                                               FOOTER,
                                               8'h00};  // pad byte
                            data_pkt_be2   <= 4'b1110;   // 3 valid bytes + 1 pad
                            data_word_idx  <= 2'd0;
                            current_state  <= SEND_DATA_WORD;
                        end
                    end
                end

                SEND_DATA_WORD: begin
                    if (!ft601_txe) begin
                        ft601_data_oe <= 1;
                        ft601_wr_n <= 0;
                        case (data_word_idx)
                            2'd0: begin
                                ft601_data_out <= data_pkt_word0;
                                ft601_be <= 4'b1111;
                            end
                            2'd1: begin
                                ft601_data_out <= data_pkt_word1;
                                ft601_be <= 4'b1111;
                            end
                            2'd2: begin
                                ft601_data_out <= data_pkt_word2;
                                ft601_be <= data_pkt_be2;
                            end
                            default: ;
                        endcase
                        if (data_word_idx == 2'd2) begin
                            data_word_idx <= 2'd0;
                            current_state <= WAIT_ACK;
                        end else begin
                            data_word_idx <= data_word_idx + 2'd1;
                        end
                    end
                end

                // Gap 2: Status readback — send 6 x 32-bit status words
                // Format: HEADER, status_words[0..5], FOOTER
                SEND_STATUS: begin
                    if (!ft601_txe) begin
                        ft601_data_oe <= 1;
                        ft601_be <= 4'b1111;
                        case (status_word_idx)
                            3'd0: begin
                                // Send status header marker (0xBB = status response)
                                ft601_data_out <= {24'b0, 8'hBB};
                                ft601_be <= 4'b0001;
                            end
                            3'd1: ft601_data_out <= status_words[0];
                            3'd2: ft601_data_out <= status_words[1];
                            3'd3: ft601_data_out <= status_words[2];
                            3'd4: ft601_data_out <= status_words[3];
                            3'd5: ft601_data_out <= status_words[4];
                            3'd6: ft601_data_out <= status_words[5];
                            3'd7: begin
                                // Send status footer
                                ft601_data_out <= {24'b0, FOOTER};
                                ft601_be <= 4'b0001;
                            end
                            default: ;
                        endcase
                        ft601_wr_n <= 0;
                        if (status_word_idx == 3'd7) begin
                            status_word_idx <= 3'd0;
                            current_state <= WAIT_ACK;
                        end else begin
                            status_word_idx <= status_word_idx + 1;
                        end
                    end
                end
                
                WAIT_ACK: begin
                    ft601_wr_n <= 1;
                    ft601_data_oe <= 0;  // Release data bus
                    // Clear pending flags — data consumed
                    doppler_data_pending <= 1'b0;
                    cfar_data_pending    <= 1'b0;
                    // Advance frame sync counter
                    if (sample_counter == NUM_CELLS - 12'd1)
                        sample_counter <= 12'd0;
                    else
                        sample_counter <= sample_counter + 12'd1;
                    current_state <= IDLE;
                end
            endcase
        end
    end
end

// ============================================================================
// FT601 clock output forwarding
// ============================================================================
// Forward ft601_clk_in back out via ODDR so that the forwarded clock at the
// pin has the same insertion delay as the data outputs (both go through the
// same BUFG). This makes the output delay analysis relative to the generated
// clock at the pin, where insertion delays cancel.

`ifndef SIMULATION
ODDR #(
    .DDR_CLK_EDGE("OPPOSITE_EDGE"),
    .INIT(1'b0),
    .SRTYPE("SYNC")
) oddr_ft601_clk (
    .Q(ft601_clk_out),
    .C(ft601_clk_in),
    .CE(1'b1),
    .D1(1'b1),
    .D2(1'b0),
    .R(1'b0),
    .S(1'b0)
);
`else
// Simulation: behavioral clock forwarding
reg ft601_clk_out_sim;
always @(posedge ft601_clk_in or negedge ft601_effective_reset_n) begin
    if (!ft601_effective_reset_n)
        ft601_clk_out_sim <= 1'b0;
    else
        ft601_clk_out_sim <= 1'b1;
end
// In simulation, just pass the clock through
assign ft601_clk_out = ft601_clk_in;
`endif

endmodule