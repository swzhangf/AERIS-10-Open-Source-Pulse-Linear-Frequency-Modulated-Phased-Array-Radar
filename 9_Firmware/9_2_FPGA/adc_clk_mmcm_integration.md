# ADC Clock MMCM Integration Guide

## Overview

`adc_clk_mmcm.v` is a drop-in MMCME2_ADV wrapper that replaces the direct BUFG
on the 400 MHz ADC data clock output with a jitter-cleaning PLL loop.

### Current clock path (Build 18)
```
adc_dco_p/n → IBUFDS → BUFIO  (drives IDDR only — near-zero delay)
                      → BUFG   (drives all fabric 400 MHz logic)
```

### New clock path (with MMCM)
```
adc_dco_p/n → IBUFDS → BUFIO  (unchanged — drives IDDR only)
                      → MMCME2 CLKIN1 → CLKOUT0 → BUFG  (fabric 400 MHz)
                                      → CLKFBOUT → BUFG → CLKFBIN (feedback)
```

## Expected Timing Improvement

| Parameter | Before (Build 18) | After (estimated) |
|-----------|-------------------|-------------------|
| Input jitter | 50 ps | 50 ps (unchanged) |
| Output jitter (MMCM) | N/A | ~20-30 ps |
| Clock uncertainty | 43 ps | ~25 ps |
| WNS (setup, 400 MHz) | +0.062 ns | ~+0.08 to +0.10 ns |
| WHS (hold, 100 MHz) | +0.059 ns | unchanged |

The improvement comes from reduced clock uncertainty in the Vivado timing
analysis. The MMCM's PLL loop attenuates the input jitter, so Vivado deducts
less uncertainty from the timing budget.

## MMCM Configuration

```
CLKIN1         = 400 MHz (2.500 ns)
DIVCLK_DIVIDE  = 1
CLKFBOUT_MULT_F = 2.0   → VCO = 800 MHz
CLKOUT0_DIVIDE_F = 2.0  → Output = 400 MHz
BANDWIDTH      = HIGH    (maximum jitter filtering)
```

VCO at 800 MHz is well within the Artix-7 -2 speed grade range (600–1200 MHz).

## Resource Cost

| Resource | Count | Notes |
|----------|-------|-------|
| MMCME2_ADV | 1 | Was 0/10, now 1/10 |
| BUFG | +1 (feedback) | Was 4/32, now 5/32 |
| FFs | 0 | No additional fabric registers |

## Integration Steps

### Step 1: Modify `ad9484_interface_400m.v`

Replace the BUFG instantiation with `adc_clk_mmcm`:

```verilog
// REMOVE these lines (65-69):
//   BUFG bufg_dco (
//       .I(adc_dco),
//       .O(adc_dco_buffered)
//   );
//   assign adc_dco_bufg = adc_dco_buffered;

// ADD this instead:
wire mmcm_locked;
wire adc_dco_mmcm;

adc_clk_mmcm mmcm_inst (
    .clk_in       (adc_dco),          // From IBUFDS output
    .reset_n      (reset_n),
    .clk_400m_out (adc_dco_mmcm),     // Jitter-cleaned 400 MHz
    .mmcm_locked  (mmcm_locked)
);

// Use MMCM output for all fabric logic
wire adc_dco_buffered = adc_dco_mmcm;
assign adc_dco_bufg = adc_dco_buffered;
```

### Step 2: Gate reset on MMCM lock (recommended)

In `ad9484_interface_400m.v`, modify the reset synchronizer to require MMCM lock:

```verilog
// Change the reset synchronizer input from:
//   always @(posedge adc_dco_buffered or negedge reset_n) begin
//       if (!reset_n)
//           reset_sync_400m <= 2'b00;
//       else
//           reset_sync_400m <= {reset_sync_400m[0], 1'b1};
//   end

// To:
wire reset_n_gated = reset_n & mmcm_locked;

always @(posedge adc_dco_buffered or negedge reset_n_gated) begin
    if (!reset_n_gated)
        reset_sync_400m <= 2'b00;
    else
        reset_sync_400m <= {reset_sync_400m[0], 1'b1};
end
```

This ensures the 400 MHz domain stays in reset until the MMCM has locked and
the clock is stable. Without this, the first ~10 µs after power-up (before
MMCM lock) could produce glitchy clock edges.

### Step 3: Add constraint file

Add `constraints/adc_clk_mmcm.xdc` to the Vivado project. Uncomment the
constraints and adjust hierarchy paths based on your actual instantiation.

Key constraints to uncomment:
1. `create_generated_clock` (or verify Vivado auto-creates it)
2. `set_max_delay` between `adc_dco_p` and `clk_400m_mmcm`
3. `set_false_path` between `clk_400m_mmcm` and other clock domains
4. `set_false_path` on `LOCKED` output

### Step 4: Add to build script

In the Tcl build script, add the new source file:

```tcl
read_verilog adc_clk_mmcm.v
read_xdc constraints/adc_clk_mmcm.xdc
```

### Step 5: Verify

After building:
1. Check `report_clocks` — should show the new MMCM-derived clock
2. Check `report_clock_interaction` — verify no unexpected crossings
3. Check WNS on the `adc_dco_p` / MMCM clock group — should improve
4. Check MMCM locked in ILA during bring-up

## BUFIO Compatibility Note

The BUFIO path for IDDR capture is **not affected** by this change. BUFIO
drives only IOB primitives (IDDR) and cannot go through an MMCM. The BUFIO
continues to use the raw IBUFDS output with near-zero insertion delay, which
is correct for source-synchronous DDR capture.

The re-registration from BUFIO domain to BUFG domain (lines 105-108 of
`ad9484_interface_400m.v`) now crosses from the raw `adc_dco_p` clock to the
MMCM-derived clock. Since both are frequency-matched and the MMCM is locked
to the input, this is a safe single-register transfer. The `set_max_delay`
constraint in the XDC ensures Vivado verifies this.

## Simulation

Under `SIMULATION` define (iverilog), the module passes the clock straight
through with a simulated lock delay of ~4096 cycles. This matches the
current testbench behavior — no changes to any testbenches needed.

## Rollback

To revert: simply restore the original BUFG in `ad9484_interface_400m.v` and
remove `adc_clk_mmcm.v` + `constraints/adc_clk_mmcm.xdc` from the project.
No other files are affected.
