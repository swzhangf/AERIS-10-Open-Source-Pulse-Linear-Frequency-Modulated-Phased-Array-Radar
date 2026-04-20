`timescale 1ns / 1ps
// ============================================================================
// adc_clk_mmcm.v — MMCME2 Jitter-Cleaning Wrapper for AD9484 400 MHz DCO
//
// PURPOSE:
//   Replaces the direct BUFG on the ADC data clock output (adc_dco) with an
//   MMCME2_ADV configured for 1:1 frequency (400 MHz in → 400 MHz out) with
//   jitter attenuation via the PLL feedback loop.
//
// CURRENT ARCHITECTURE (ad9484_interface_400m.v):
//   adc_dco_p/n → IBUFDS → BUFIO (drives IDDR only, near-zero delay)
//                         → BUFG  (drives all fabric 400 MHz logic)
//
// NEW ARCHITECTURE (this module replaces the BUFG path):
//   adc_dco_p/n → IBUFDS → BUFIO (unchanged — drives IDDR only)
//                         → MMCME2 CLKIN1 → CLKOUT0 → BUFG (fabric 400 MHz)
//
// BENEFITS:
//   1. Jitter attenuation: MMCM PLL loop filters input jitter from ~50 ps
//      to ~20-30 ps output jitter, reducing clock uncertainty by ~20 ps.
//   2. Phase control: CLKOUT0_PHASE can fine-tune phase offset if needed.
//   3. Locked indicator: mmcm_locked output enables proper reset sequencing.
//   4. Expected WNS improvement: +20-40 ps on the 400 MHz CIC critical path.
//
// MMCM CONFIGURATION (Artix-7 XC7A200T-2):
//   CLKIN1 = 400 MHz (from IBUFDS output)
//   DIVCLK_DIVIDE = 1
//   CLKFBOUT_MULT_F = 2.0   → VCO = 400 * 2 = 800 MHz (range: 600-1200 MHz)
//   CLKOUT0_DIVIDE_F = 2.0  → CLKOUT0 = 800 / 2 = 400 MHz
//   CLKFBOUT → BUFG → CLKFBIN (internal feedback for best jitter performance)
//
// INTEGRATION:
//   This module is a DROP-IN replacement for the BUFG in ad9484_interface_400m.v.
//   See adc_clk_mmcm_integration.md for step-by-step instructions.
//
// SIMULATION:
//   Under `ifdef SIMULATION, this module passes the clock through a simple
//   BUFG (no MMCM primitive), matching the current behavior for iverilog.
//
// TARGET: XC7A200T-2FBG484I (Artix-7, speed grade -2, industrial temp)
// ============================================================================

module adc_clk_mmcm (
    // Input: single-ended clock from IBUFDS output
    input  wire clk_in,         // 400 MHz from IBUFDS (adc_dco after IBUFDS)

    // System reset (active-low, from 100 MHz domain)
    input  wire reset_n,

    // Outputs
    output wire clk_400m_out,   // Jitter-cleaned 400 MHz on BUFG (fabric logic)
    output wire mmcm_locked     // 1 = MMCM PLL is locked and clock is stable
);

`ifdef SIMULATION
// ============================================================================
// SIMULATION PATH — simple passthrough (no Xilinx primitives)
// ============================================================================
// iverilog and other simulators don't have MMCME2_ADV. Pass clock through
// with a locked signal that asserts after a brief delay matching real MMCM
// lock time (~10 us at 400 MHz = ~4000 cycles).

reg locked_sim;
reg [12:0] lock_counter;

initial begin
    locked_sim = 1'b0;
    lock_counter = 13'd0;
end

always @(posedge clk_in or negedge reset_n) begin
    if (!reset_n) begin
        locked_sim <= 1'b0;
        lock_counter <= 13'd0;
    end else begin
        if (lock_counter < 13'd4096) begin
            lock_counter <= lock_counter + 1;
        end else begin
            locked_sim <= 1'b1;
        end
    end
end

`ifdef SIMULATION_HAS_BUFG
// If the simulator supports BUFG (e.g., Vivado xsim)
BUFG bufg_sim (
    .I(clk_in),
    .O(clk_400m_out)
);
`else
// Pure behavioral — iverilog
assign clk_400m_out = clk_in;
`endif

assign mmcm_locked = locked_sim;

`else
// ============================================================================
// SYNTHESIS PATH — MMCME2_ADV with jitter-cleaning feedback loop
// ============================================================================

wire clk_mmcm_out0;    // MMCM CLKOUT0 (unbuffered)
wire clk_mmcm_fb_out;  // MMCM CLKFBOUT (unbuffered)
wire clk_mmcm_fb_bufg; // CLKFBOUT after BUFG (feedback)
wire mmcm_locked_int;

// ---- MMCME2_ADV Instance ----
// Configuration for 400 MHz 1:1 with jitter cleaning:
//   VCO = CLKIN1 * CLKFBOUT_MULT_F / DIVCLK_DIVIDE = 400 * 2.0 / 1 = 800 MHz
//   CLKOUT0 = VCO / CLKOUT0_DIVIDE_F = 800 / 2.0 = 400 MHz
//   Bandwidth = "HIGH" for maximum jitter attenuation
MMCME2_ADV #(
    // Input clock
    .CLKIN1_PERIOD      (2.500),    // 400 MHz = 2.500 ns period
    .CLKIN2_PERIOD      (0.000),    // Unused
    .REF_JITTER1        (0.020),    // 20 ps reference jitter (conservative)
    .REF_JITTER2        (0.000),    // Unused

    // VCO configuration
    .DIVCLK_DIVIDE      (1),        // Input divider = 1 (no division)
    .CLKFBOUT_MULT_F    (2.0),      // Feedback multiplier → VCO = 800 MHz
    .CLKFBOUT_PHASE     (0.0),      // No feedback phase shift

    // Output 0: 400 MHz fabric clock
    .CLKOUT0_DIVIDE_F   (2.0),      // 800 / 2.0 = 400 MHz
    .CLKOUT0_PHASE      (0.0),      // Phase-aligned with input
    .CLKOUT0_DUTY_CYCLE (0.5),      // 50% duty cycle

    // Unused outputs — disabled
    .CLKOUT1_DIVIDE     (1),
    .CLKOUT1_PHASE      (0.0),
    .CLKOUT1_DUTY_CYCLE (0.5),
    .CLKOUT2_DIVIDE     (1),
    .CLKOUT2_PHASE      (0.0),
    .CLKOUT2_DUTY_CYCLE (0.5),
    .CLKOUT3_DIVIDE     (1),
    .CLKOUT3_PHASE      (0.0),
    .CLKOUT3_DUTY_CYCLE (0.5),
    .CLKOUT4_DIVIDE     (1),
    .CLKOUT4_PHASE      (0.0),
    .CLKOUT4_DUTY_CYCLE (0.5),
    .CLKOUT5_DIVIDE     (1),
    .CLKOUT5_PHASE      (0.0),
    .CLKOUT5_DUTY_CYCLE (0.5),
    .CLKOUT6_DIVIDE     (1),
    .CLKOUT6_PHASE      (0.0),
    .CLKOUT6_DUTY_CYCLE (0.5),

    // PLL filter bandwidth — HIGH for maximum jitter attenuation
    .BANDWIDTH          ("HIGH"),

    // Compensation mode — BUFG on feedback path
    .COMPENSATION       ("BUF_IN"),

    // Startup wait for configuration clock
    .STARTUP_WAIT       ("FALSE")
) mmcm_adc_400m (
    // Clock inputs
    .CLKIN1             (clk_in),           // 400 MHz from IBUFDS
    .CLKIN2             (1'b0),             // Unused second input
    .CLKINSEL           (1'b1),             // Select CLKIN1

    // Feedback
    .CLKFBOUT           (clk_mmcm_fb_out),  // Feedback output (unbuffered)
    .CLKFBIN            (clk_mmcm_fb_bufg), // Feedback input (from BUFG)

    // Clock outputs
    .CLKOUT0            (clk_mmcm_out0),    // 400 MHz output (unbuffered)
    .CLKOUT0B           (),                 // Unused inverted
    .CLKOUT1            (),
    .CLKOUT1B           (),
    .CLKOUT2            (),
    .CLKOUT2B           (),
    .CLKOUT3            (),
    .CLKOUT3B           (),
    .CLKOUT4            (),
    .CLKOUT5            (),
    .CLKOUT6            (),
    .CLKFBOUTB          (),                 // Unused inverted feedback

    // Control
    .RST                (~reset_n),         // Active-high reset
    .PWRDWN             (1'b0),             // Never power down

    // Status
    .LOCKED             (mmcm_locked_int),

    // Dynamic reconfiguration (unused — tie off)
    .DADDR              (7'd0),
    .DCLK               (1'b0),
    .DEN                (1'b0),
    .DI                 (16'd0),
    .DWE                (1'b0),
    .DO                 (),
    .DRDY               (),

    // Phase shift (unused — tie off)
    .PSCLK              (1'b0),
    .PSEN               (1'b0),
    .PSINCDEC           (1'b0),
    .PSDONE             ()
);

// ---- Feedback BUFG ----
// Routes CLKFBOUT through a BUFG back to CLKFBIN.
// This is the standard "internal feedback" topology for best jitter performance.
// Vivado's clock network insertion delay is compensated by the MMCM feedback loop.
BUFG bufg_feedback (
    .I(clk_mmcm_fb_out),
    .O(clk_mmcm_fb_bufg)
);

// ---- Output BUFG ----
// Routes the jitter-cleaned 400 MHz CLKOUT0 onto a global clock network.
// DONT_TOUCH prevents phys_opt_design AggressiveExplore from replicating this
// BUFG into a cascaded chain (4 BUFGs in series observed in Build 26), which
// added ~243ps of clock insertion delay and caused -187ps clock skew on the
// NCO→DSP mixer critical path.
(* DONT_TOUCH = "TRUE" *)
BUFG bufg_clk400m (
    .I(clk_mmcm_out0),
    .O(clk_400m_out)
);

assign mmcm_locked = mmcm_locked_int;

`endif

endmodule
