`timescale 1ns / 1ps

/**
 * fft_engine.v
 *
 * Synthesizable parameterized radix-2 DIT FFT/IFFT engine.
 * Iterative single-butterfly architecture with quarter-wave twiddle ROM.
 *
 * Architecture:
 *   - LOAD:    Accept N input samples, store bit-reversed in BRAM
 *   - COMPUTE: LOG2N stages x N/2 butterflies, 4-cycle pipeline:
 *              BF_READ:  Present BRAM addresses; register twiddle index
 *              BF_TW:    BRAM data valid → capture; twiddle ROM lookup from
 *                        registered index → capture cos/sin
 *              BF_MULT2: DSP multiply from registered data + twiddle → PREG
 *              BF_WRITE: Shift (bit-select from PREG, pure wiring) +
 *                        add/subtract + BRAM writeback
 *   - OUTPUT:  Stream N results (1/N scaling for IFFT)
 *
 * Twiddle index computed via barrel shift (idx << (LOG2N-1-stage)) instead
 * of general multiply, since the stride is always a power of 2.
 *
 * Data memory uses xpm_memory_tdpram (Xilinx Parameterized Macros) for
 * guaranteed BRAM mapping in synthesis.  Under `ifdef SIMULATION, a
 * behavioral Verilog-2001 model replaces the XPM so the design compiles
 * with Icarus Verilog or any non-Xilinx simulator.
 *
 * Clock domain: single clock (clk), active-low async reset (reset_n).
 */

module fft_engine #(
    parameter N            = 1024,
    parameter LOG2N        = 10,
    parameter DATA_W       = 16,
    parameter INTERNAL_W   = 32,
    parameter TWIDDLE_W    = 16,
    parameter TWIDDLE_FILE = "fft_twiddle_1024.mem"
)(
    input wire clk,
    input wire reset_n,

    // Control
    input wire start,
    input wire inverse,

    // Data input
    input wire signed [DATA_W-1:0] din_re,
    input wire signed [DATA_W-1:0] din_im,
    input wire din_valid,

    // Data output
    output reg signed [DATA_W-1:0] dout_re,
    output reg signed [DATA_W-1:0] dout_im,
    output reg dout_valid,

    // Status
    output wire busy,
    output reg  done
);

// ============================================================================
// SAFE WIDTH CONSTANTS
// ============================================================================
localparam [LOG2N:0] FFT_N         = N;
localparam [LOG2N:0] FFT_N_HALF    = N / 2;
localparam [LOG2N:0] FFT_N_QTR     = N / 4;
localparam [LOG2N:0] FFT_N_HALF_M1 = N / 2 - 1;
localparam [LOG2N:0] FFT_N_M1      = N - 1;

// ============================================================================
// STATES
// ============================================================================
// Butterfly pipeline: READ → TW → MULT2 → WRITE (4 cycles)
//   READ:  Present BRAM addresses; register twiddle index (bf_tw_idx)
//   TW:    BRAM data valid → capture rd_a/rd_b; twiddle ROM lookup from
//          registered index → capture cos/sin
//   MULT2: DSP multiply from registered data + twiddle → products in PREG
//   WRITE: Shift (bit-select from PREG, pure wiring) + add/sub + BRAM writeback
localparam [3:0] ST_IDLE     = 4'd0,
                 ST_LOAD     = 4'd1,
                 ST_BF_READ  = 4'd2,
                 ST_BF_TW    = 4'd3,
                 ST_BF_MULT2 = 4'd4,
                 ST_BF_WRITE = 4'd5,
                 ST_OUTPUT   = 4'd6,
                 ST_DONE     = 4'd7;

reg [3:0] state;
assign busy = (state != ST_IDLE);

// ============================================================================
// DATA MEMORY DECLARATIONS
// ============================================================================

// BRAM read data (registered outputs from port blocks)
reg signed [INTERNAL_W-1:0] mem_rdata_a_re, mem_rdata_a_im;
reg signed [INTERNAL_W-1:0] mem_rdata_b_re, mem_rdata_b_im;

// ============================================================================
// TWIDDLE ROM
// ============================================================================
localparam TW_QUARTER = N / 4;
localparam TW_ADDR_W  = LOG2N - 2;

(* rom_style = "block" *) reg signed [TWIDDLE_W-1:0] cos_rom [0:TW_QUARTER-1];

initial begin
    $readmemh(TWIDDLE_FILE, cos_rom);
end

// ============================================================================
// BIT-REVERSE
// ============================================================================
function [LOG2N-1:0] bit_reverse;
    input [LOG2N-1:0] val;
    integer b;
    begin
        bit_reverse = 0;
        for (b = 0; b < LOG2N; b = b + 1)
            bit_reverse[LOG2N-1-b] = val[b];
    end
endfunction

// ============================================================================
// COUNTERS AND PIPELINE REGISTERS
// ============================================================================
reg [LOG2N-1:0] load_count;
reg [LOG2N:0]   out_count;
reg [LOG2N-1:0] bfly_count;
reg [3:0]       stage;

// Registered values (captured in BF_READ, used in BF_TW and later)
reg signed [TWIDDLE_W-1:0]  rd_tw_cos, rd_tw_sin;
reg [LOG2N-1:0] rd_addr_even, rd_addr_odd;
reg rd_inverse;
reg [LOG2N-1:0] rd_tw_idx;  // registered twiddle index (breaks addr→ROM path)

// Half register (twiddle stride replaced by barrel shift — see bf_addr_calc)
reg [LOG2N-1:0] half_reg;

// ============================================================================
// BUTTERFLY ADDRESS COMPUTATION (combinational)
// ============================================================================
reg [LOG2N-1:0] bf_addr_even;
reg [LOG2N-1:0] bf_addr_odd;
reg [LOG2N-1:0] bf_tw_idx;

always @(*) begin : bf_addr_calc
    reg [LOG2N-1:0] half_val;
    reg [LOG2N-1:0] idx_val;
    reg [LOG2N-1:0] grp_val;

    half_val  = half_reg;
    idx_val   = bfly_count & (half_val - 1);
    grp_val   = (bfly_count - idx_val);

    bf_addr_even = (grp_val << 1) | idx_val;
    bf_addr_odd  = bf_addr_even + half_val;

    bf_tw_idx = idx_val << (LOG2N - 1 - stage);
end

// ============================================================================
// TWIDDLE LOOKUP (combinational)
// ============================================================================
reg signed [TWIDDLE_W-1:0] tw_cos_lookup;
reg signed [TWIDDLE_W-1:0] tw_sin_lookup;

always @(*) begin : tw_lookup
    reg [LOG2N-1:0] k;
    reg [LOG2N-1:0] rom_idx;

    k = rd_tw_idx;  // use registered index (set in ST_BF_READ)
    tw_cos_lookup = 0;
    tw_sin_lookup = 0;

    if (k == 0) begin
        tw_cos_lookup = cos_rom[0];
        tw_sin_lookup = {TWIDDLE_W{1'b0}};
    end else if (k == FFT_N_QTR[LOG2N-1:0]) begin
        tw_cos_lookup = {TWIDDLE_W{1'b0}};
        tw_sin_lookup = cos_rom[0];
    end else if (k < FFT_N_QTR[LOG2N-1:0]) begin
        tw_cos_lookup = cos_rom[k[TW_ADDR_W-1:0]];
        rom_idx = FFT_N_QTR[LOG2N-1:0] - k;
        tw_sin_lookup = cos_rom[rom_idx[TW_ADDR_W-1:0]];
    end else begin
        rom_idx = k - FFT_N_QTR[LOG2N-1:0];
        tw_sin_lookup = cos_rom[rom_idx[TW_ADDR_W-1:0]];
        rom_idx = FFT_N_HALF[LOG2N-1:0] - k;
        tw_cos_lookup = -cos_rom[rom_idx[TW_ADDR_W-1:0]];
    end
end

// ============================================================================
// SATURATION
// ============================================================================
function signed [DATA_W-1:0] saturate;
    input signed [INTERNAL_W-1:0] val;
    reg signed [INTERNAL_W-1:0] max_pos;
    reg signed [INTERNAL_W-1:0] max_neg;
    begin
        max_pos = (1 << (DATA_W - 1)) - 1;
        max_neg = -(1 << (DATA_W - 1));
        if (val > max_pos)
            saturate = max_pos[DATA_W-1:0];
        else if (val < max_neg)
            saturate = max_neg[DATA_W-1:0];
        else
            saturate = val[DATA_W-1:0];
    end
endfunction

// ============================================================================
// BUTTERFLY PIPELINE REGISTERS
// ============================================================================
// Stage 1 (BF_TW):    Capture BRAM read data into rd_a, rd_b
// Stage 2 (BF_MULT2): DSP multiply + accumulate → raw products (bf_prod_re/im)
// Stage 3 (BF_WRITE): Shift (bit-select, pure wiring) + add/subtract + BRAM writeback
// ============================================================================
reg signed [INTERNAL_W-1:0] rd_a_re, rd_a_im;    // registered BRAM port A data
reg signed [INTERNAL_W-1:0] rd_b_re, rd_b_im;    // registered BRAM port B data (for twiddle multiply)

// Raw DSP products — full precision, registered to break DSP→CARRY4 path
// Width: 32*16 = 48 bits per multiply, sum of two = 49 bits max
localparam PROD_W = INTERNAL_W + TWIDDLE_W;  // 48
reg signed [PROD_W:0] bf_prod_re, bf_prod_im; // 49 bits to hold sum of two products

// Combinational add/subtract from registered values (used in BF_WRITE)
reg signed [INTERNAL_W-1:0] bf_sum_re, bf_sum_im;
reg signed [INTERNAL_W-1:0] bf_dif_re, bf_dif_im;

always @(*) begin : bf_addsub
    // Shift is pure bit-selection from DSP PREG (zero logic levels in HW).
    // Path: PREG → wiring → 32-bit CARRY4 adder → BRAM write (~3 ns total).
    bf_sum_re = rd_a_re + (bf_prod_re >>> (TWIDDLE_W - 1));
    bf_sum_im = rd_a_im + (bf_prod_im >>> (TWIDDLE_W - 1));
    bf_dif_re = rd_a_re - (bf_prod_re >>> (TWIDDLE_W - 1));
    bf_dif_im = rd_a_im - (bf_prod_im >>> (TWIDDLE_W - 1));
end

// ============================================================================
// BRAM PORT ADDRESS / WE / WDATA — combinational mux (registered signals)
// ============================================================================
// Drives port A and port B control signals from FSM state.
// These are registered (via NBA) so they are stable at the next posedge
// when the BRAM template blocks sample them. This avoids any NBA race.
// ============================================================================
reg                          bram_we_a;
reg  [LOG2N-1:0]             bram_addr_a;
reg  signed [INTERNAL_W-1:0] bram_wdata_a_re;
reg  signed [INTERNAL_W-1:0] bram_wdata_a_im;

reg                          bram_we_b;
reg  [LOG2N-1:0]             bram_addr_b;
reg  signed [INTERNAL_W-1:0] bram_wdata_b_re;
reg  signed [INTERNAL_W-1:0] bram_wdata_b_im;

always @(*) begin : bram_port_mux
    // Port A defaults
    bram_we_a       = 1'b0;
    bram_addr_a     = 0;
    bram_wdata_a_re = 0;
    bram_wdata_a_im = 0;

    // Port B defaults
    bram_we_b       = 1'b0;
    bram_addr_b     = 0;
    bram_wdata_b_re = 0;
    bram_wdata_b_im = 0;

    case (state)
    ST_LOAD: begin
        bram_we_a       = din_valid;
        bram_addr_a     = bit_reverse(load_count);
        bram_wdata_a_re = {{(INTERNAL_W-DATA_W){din_re[DATA_W-1]}}, din_re};
        bram_wdata_a_im = {{(INTERNAL_W-DATA_W){din_im[DATA_W-1]}}, din_im};
    end
    ST_BF_READ: begin
        bram_addr_a = bf_addr_even;
        bram_addr_b = bf_addr_odd;
    end
    ST_BF_TW: begin
        // BRAM outputs are being read; addresses were set in BF_READ
        // Data is being captured into pipeline regs (rd_a, rd_b)
    end
    ST_BF_MULT2: begin
        // Twiddle multiply from registered BRAM data (rd_b_re/im)
        // No BRAM access needed this cycle
    end
    ST_BF_WRITE: begin
        bram_we_a       = 1'b1;
        bram_addr_a     = rd_addr_even;
        bram_wdata_a_re = bf_sum_re;
        bram_wdata_a_im = bf_sum_im;

        bram_we_b       = 1'b1;
        bram_addr_b     = rd_addr_odd;
        bram_wdata_b_re = bf_dif_re;
        bram_wdata_b_im = bf_dif_im;
    end
    ST_OUTPUT: begin
        bram_addr_a = out_count[LOG2N-1:0];
    end
    default: begin
        // keep defaults
    end
    endcase
end

// ============================================================================
// DATA MEMORY — True Dual-Port BRAM
// ============================================================================
// For synthesis: xpm_memory_tdpram (Xilinx Parameterized Macros)
// For simulation: behavioral Verilog-2001 model (Icarus-compatible)
// ============================================================================

// XPM read-data wires (directly assigned to rdata regs below)
wire [INTERNAL_W-1:0] xpm_douta_re, xpm_doutb_re;
wire [INTERNAL_W-1:0] xpm_douta_im, xpm_doutb_im;

always @(*) begin
    mem_rdata_a_re = $signed(xpm_douta_re);
    mem_rdata_a_im = $signed(xpm_douta_im);
    mem_rdata_b_re = $signed(xpm_doutb_re);
    mem_rdata_b_im = $signed(xpm_doutb_im);
end

`ifndef FFT_XPM_BRAM
// ----------------------------------------------------------------------------
// Default: behavioral TDP model (works with Icarus Verilog -g2001)
// For Vivado synthesis, define FFT_XPM_BRAM to use xpm_memory_tdpram.
// ----------------------------------------------------------------------------
reg [INTERNAL_W-1:0] sim_mem_re [0:N-1];
reg [INTERNAL_W-1:0] sim_mem_im [0:N-1];

// Port A
reg [INTERNAL_W-1:0] sim_douta_re, sim_douta_im;
always @(posedge clk) begin
    if (bram_we_a) begin
        sim_mem_re[bram_addr_a] <= bram_wdata_a_re;
        sim_mem_im[bram_addr_a] <= bram_wdata_a_im;
    end
    sim_douta_re <= sim_mem_re[bram_addr_a];
    sim_douta_im <= sim_mem_im[bram_addr_a];
end
assign xpm_douta_re = sim_douta_re;
assign xpm_douta_im = sim_douta_im;

// Port B
reg [INTERNAL_W-1:0] sim_doutb_re, sim_doutb_im;
always @(posedge clk) begin
    if (bram_we_b) begin
        sim_mem_re[bram_addr_b] <= bram_wdata_b_re;
        sim_mem_im[bram_addr_b] <= bram_wdata_b_im;
    end
    sim_doutb_re <= sim_mem_re[bram_addr_b];
    sim_doutb_im <= sim_mem_im[bram_addr_b];
end
assign xpm_doutb_re = sim_doutb_re;
assign xpm_doutb_im = sim_doutb_im;

integer init_i;
initial begin
    for (init_i = 0; init_i < N; init_i = init_i + 1) begin
        sim_mem_re[init_i] = 0;
        sim_mem_im[init_i] = 0;
    end
end

`else
// ----------------------------------------------------------------------------
// Synthesis: xpm_memory_tdpram — guaranteed BRAM mapping
// Enabled when FFT_XPM_BRAM is defined (e.g. in Vivado TCL script).
// ----------------------------------------------------------------------------
// Note: Vivado auto-finds XPM library; no `include needed.
// Two instances: one for real, one for imaginary.
// WRITE_MODE = "write_first" matches the behavioral TDP template.
// READ_LATENCY = 1 (registered output).
// ----------------------------------------------------------------------------

xpm_memory_tdpram #(
    .ADDR_WIDTH_A        (LOG2N),
    .ADDR_WIDTH_B        (LOG2N),
    .AUTO_SLEEP_TIME     (0),
    .BYTE_WRITE_WIDTH_A  (INTERNAL_W),
    .BYTE_WRITE_WIDTH_B  (INTERNAL_W),
    .CASCADE_HEIGHT      (0),
    .CLOCKING_MODE       ("common_clock"),
    .ECC_BIT_RANGE       ("7:0"),
    .ECC_MODE            ("no_ecc"),
    .ECC_TYPE            ("none"),
    .IGNORE_INIT_SYNTH   (0),
    .MEMORY_INIT_FILE    ("none"),
    .MEMORY_INIT_PARAM   ("0"),
    .MEMORY_OPTIMIZATION ("true"),
    .MEMORY_PRIMITIVE     ("block"),
    .MEMORY_SIZE         (N * INTERNAL_W),
    .MESSAGE_CONTROL     (0),
    .RAM_DECOMP          ("auto"),
    .READ_DATA_WIDTH_A   (INTERNAL_W),
    .READ_DATA_WIDTH_B   (INTERNAL_W),
    .READ_LATENCY_A      (1),
    .READ_LATENCY_B      (1),
    .READ_RESET_VALUE_A  ("0"),
    .READ_RESET_VALUE_B  ("0"),
    .RST_MODE_A          ("SYNC"),
    .RST_MODE_B          ("SYNC"),
    .SIM_ASSERT_CHK      (0),
    .USE_EMBEDDED_CONSTRAINT (0),
    .USE_MEM_INIT        (1),
    .USE_MEM_INIT_MMI    (0),
    .WAKEUP_TIME         ("disable_sleep"),
    .WRITE_DATA_WIDTH_A  (INTERNAL_W),
    .WRITE_DATA_WIDTH_B  (INTERNAL_W),
    .WRITE_MODE_A        ("read_first"),
    .WRITE_MODE_B        ("read_first"),
    .WRITE_PROTECT       (1)
) u_bram_re (
    .clka            (clk),
    .clkb            (clk),
    .rsta            (1'b0),
    .rstb            (1'b0),
    .ena             (1'b1),
    .enb             (1'b1),
    .regcea          (1'b1),
    .regceb          (1'b1),
    .addra           (bram_addr_a),
    .addrb           (bram_addr_b),
    .dina            (bram_wdata_a_re),
    .dinb            (bram_wdata_b_re),
    .wea             (bram_we_a),
    .web             (bram_we_b),
    .douta           (xpm_douta_re),
    .doutb           (xpm_doutb_re),
    .injectdbiterra  (1'b0),
    .injectdbiterrb  (1'b0),
    .injectsbiterra  (1'b0),
    .injectsbiterrb  (1'b0),
    .sbiterra        (),
    .sbiterrb        (),
    .dbiterra        (),
    .dbiterrb        (),
    .sleep           (1'b0)
);

xpm_memory_tdpram #(
    .ADDR_WIDTH_A        (LOG2N),
    .ADDR_WIDTH_B        (LOG2N),
    .AUTO_SLEEP_TIME     (0),
    .BYTE_WRITE_WIDTH_A  (INTERNAL_W),
    .BYTE_WRITE_WIDTH_B  (INTERNAL_W),
    .CASCADE_HEIGHT      (0),
    .CLOCKING_MODE       ("common_clock"),
    .ECC_BIT_RANGE       ("7:0"),
    .ECC_MODE            ("no_ecc"),
    .ECC_TYPE            ("none"),
    .IGNORE_INIT_SYNTH   (0),
    .MEMORY_INIT_FILE    ("none"),
    .MEMORY_INIT_PARAM   ("0"),
    .MEMORY_OPTIMIZATION ("true"),
    .MEMORY_PRIMITIVE     ("block"),
    .MEMORY_SIZE         (N * INTERNAL_W),
    .MESSAGE_CONTROL     (0),
    .RAM_DECOMP          ("auto"),
    .READ_DATA_WIDTH_A   (INTERNAL_W),
    .READ_DATA_WIDTH_B   (INTERNAL_W),
    .READ_LATENCY_A      (1),
    .READ_LATENCY_B      (1),
    .READ_RESET_VALUE_A  ("0"),
    .READ_RESET_VALUE_B  ("0"),
    .RST_MODE_A          ("SYNC"),
    .RST_MODE_B          ("SYNC"),
    .SIM_ASSERT_CHK      (0),
    .USE_EMBEDDED_CONSTRAINT (0),
    .USE_MEM_INIT        (1),
    .USE_MEM_INIT_MMI    (0),
    .WAKEUP_TIME         ("disable_sleep"),
    .WRITE_DATA_WIDTH_A  (INTERNAL_W),
    .WRITE_DATA_WIDTH_B  (INTERNAL_W),
    .WRITE_MODE_A        ("read_first"),
    .WRITE_MODE_B        ("read_first"),
    .WRITE_PROTECT       (1)
) u_bram_im (
    .clka            (clk),
    .clkb            (clk),
    .rsta            (1'b0),
    .rstb            (1'b0),
    .ena             (1'b1),
    .enb             (1'b1),
    .regcea          (1'b1),
    .regceb          (1'b1),
    .addra           (bram_addr_a),
    .addrb           (bram_addr_b),
    .dina            (bram_wdata_a_im),
    .dinb            (bram_wdata_b_im),
    .wea             (bram_we_a),
    .web             (bram_we_b),
    .douta           (xpm_douta_im),
    .doutb           (xpm_doutb_im),
    .injectdbiterra  (1'b0),
    .injectdbiterrb  (1'b0),
    .injectsbiterra  (1'b0),
    .injectsbiterrb  (1'b0),
    .sbiterra        (),
    .sbiterrb        (),
    .dbiterra        (),
    .dbiterrb        (),
    .sleep           (1'b0)
);

`endif

// ============================================================================
// OUTPUT PIPELINE
// ============================================================================
reg out_pipe_valid;
reg out_pipe_inverse;

// Sync reset: pure internal pipeline — no functional need for async reset.
// Enables downstream register absorption.
always @(posedge clk) begin
    if (!reset_n) begin
        out_pipe_valid   <= 1'b0;
        out_pipe_inverse <= 1'b0;
    end else begin
        out_pipe_valid   <= (state == ST_OUTPUT) && (out_count <= FFT_N_M1[LOG2N-1:0]);
        out_pipe_inverse <= inverse;
    end
end

// ============================================================================
// MAIN FSM — Block 1: Control / FSM / Output Interface (async reset)
// ============================================================================
// Retains async reset for deterministic startup of FSM state and external
// output interface signals (dout_re/im, dout_valid, done).
// ============================================================================
always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        state          <= ST_IDLE;
        load_count     <= 0;
        out_count      <= 0;
        bfly_count     <= 0;
        stage          <= 0;
        half_reg       <= 1;
        dout_re        <= 0;
        dout_im        <= 0;
        dout_valid     <= 0;
        done           <= 0;
    end else begin
        dout_valid <= 1'b0;
        done       <= 1'b0;

        case (state)

        ST_IDLE: begin
            if (start) begin
                state      <= ST_LOAD;
                load_count <= 0;
            end
        end

        ST_LOAD: begin
            if (din_valid) begin
                if (load_count == FFT_N_M1[LOG2N-1:0]) begin
                    state         <= ST_BF_READ;
                    stage         <= 0;
                    bfly_count    <= 0;
                    half_reg      <= 1;
                end else begin
                    load_count <= load_count + 1;
                end
            end
        end

        ST_BF_READ: begin
            state <= ST_BF_TW;
        end

        ST_BF_TW: begin
            state <= ST_BF_MULT2;
        end

        ST_BF_MULT2: begin
            state <= ST_BF_WRITE;
        end

        ST_BF_WRITE: begin
            if (bfly_count == FFT_N_HALF_M1[LOG2N-1:0]) begin
                bfly_count <= 0;
                if (stage == LOG2N - 1) begin
                    state     <= ST_OUTPUT;
                    out_count <= 0;
                end else begin
                    stage         <= stage + 1;
                    half_reg      <= half_reg << 1;
                    state         <= ST_BF_READ;
                end
            end else begin
                bfly_count <= bfly_count + 1;
                state      <= ST_BF_READ;
            end
        end

        ST_OUTPUT: begin
            if (out_count <= FFT_N_M1[LOG2N-1:0]) begin
                out_count <= out_count + 1;
            end

            if (out_pipe_valid) begin
                if (out_pipe_inverse) begin
                    dout_re <= saturate(mem_rdata_a_re >>> LOG2N);
                    dout_im <= saturate(mem_rdata_a_im >>> LOG2N);
                end else begin
                    dout_re <= saturate(mem_rdata_a_re);
                    dout_im <= saturate(mem_rdata_a_im);
                end
                dout_valid <= 1'b1;
            end

            if (out_count > FFT_N_M1[LOG2N-1:0] && !out_pipe_valid) begin
                state <= ST_DONE;
            end
        end

        ST_DONE: begin
            done  <= 1'b1;
            state <= ST_IDLE;
        end

        default: state <= ST_IDLE;
        endcase
    end
end

// ============================================================================
// MAIN FSM — Block 2: DSP/BRAM Datapath Pipeline (sync reset)
// ============================================================================
// Sync reset enables Vivado to absorb these registers into hard blocks:
//   - rd_b_re/im     → DSP48E1 AREG (butterfly multiply A-port input)
//   - rd_tw_cos/sin  → DSP48E1 BREG (butterfly multiply B-port input)
//   - bf_prod_re/im  → DSP48E1 PREG (multiply output register)
//   - rd_a_re/im     → BRAM output register (REGCE)
//   - rd_tw_idx      → pipeline register (twiddle index)
//   - rd_addr_even/odd, rd_inverse — internal pipeline
//
// These registers are only meaningful during COMPUTE states (BF_READ through
// BF_WRITE). Their values are always overwritten before use after every FSM
// transition, so sync reset is functionally equivalent to async reset.
// ============================================================================
always @(posedge clk) begin
    if (!reset_n) begin
        rd_tw_cos      <= 0;
        rd_tw_sin      <= 0;
        rd_addr_even   <= 0;
        rd_addr_odd    <= 0;
        rd_inverse     <= 0;
        rd_tw_idx      <= 0;
        rd_a_re        <= 0;
        rd_a_im        <= 0;
        rd_b_re        <= 0;
        rd_b_im        <= 0;
        bf_prod_re     <= 0;
        bf_prod_im     <= 0;
    end else begin
        case (state)

        ST_BF_READ: begin
            // Register butterfly addresses and twiddle index.
            // BRAM read initiated by bram_port_mux (addresses presented
            // combinationally); data arrives next cycle (ST_BF_TW).
            // Twiddle ROM lookup uses rd_tw_idx next cycle, breaking the
            // address-calc -> ROM -> quarter-wave-mux combinational path.
            rd_addr_even <= bf_addr_even;
            rd_addr_odd  <= bf_addr_odd;
            rd_inverse   <= inverse;
            rd_tw_idx    <= bf_tw_idx;
        end

        ST_BF_TW: begin
            // BRAM data valid this cycle (1-cycle read latency).
            // Capture BRAM data into pipeline regs.
            // Twiddle ROM lookup is combinational from registered rd_tw_idx
            // -- capture the result into rd_tw_cos/sin.
            rd_a_re   <= mem_rdata_a_re;
            rd_a_im   <= mem_rdata_a_im;
            rd_b_re   <= mem_rdata_b_re;
            rd_b_im   <= mem_rdata_b_im;
            rd_tw_cos <= tw_cos_lookup;
            rd_tw_sin <= tw_sin_lookup;
        end

        ST_BF_MULT2: begin
            // Compute raw twiddle products from registered BRAM data.
            // Path: register -> DSP48E1 multiply-accumulate -> PREG
            // The arithmetic shift and add/subtract are handled combinationally
            // in BF_WRITE (shift is pure bit-select, zero logic levels).
            if (!rd_inverse) begin
                bf_prod_re <= rd_b_re * rd_tw_cos + rd_b_im * rd_tw_sin;
                bf_prod_im <= rd_b_im * rd_tw_cos - rd_b_re * rd_tw_sin;
            end else begin
                bf_prod_re <= rd_b_re * rd_tw_cos - rd_b_im * rd_tw_sin;
                bf_prod_im <= rd_b_im * rd_tw_cos + rd_b_re * rd_tw_sin;
            end
        end

        default: begin
            // No datapath update in other states — registers hold values
        end
        endcase
    end
end

endmodule
