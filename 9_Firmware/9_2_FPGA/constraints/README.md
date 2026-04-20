# AERIS-10 FPGA Constraint Files

## Four Targets

| File | Device | Package | Purpose |
|------|--------|---------|---------|
| `xc7a50t_ftg256.xdc` | XC7A50T-2FTG256I | FTG256 (256-ball BGA) | 50T production board |
| `xc7a200t_fbg484.xdc` | XC7A200T-2FBG484I | FBG484 (484-ball BGA) | 200T premium dev board |
| `te0712_te0701_minimal.xdc` | XC7A200T-2FBG484I | FBG484 (484-ball BGA) | Trenz dev split target (minimal clock/reset + LEDs/status) |
| `te0713_te0701_minimal.xdc` | XC7A200T-2FBG484C | FBG484 (484-ball BGA) | Trenz alternate SoM target (minimal clock + FMC status outputs) |

## Why Four Files

The 50T production board uses an XC7A50T in an FTG256 package. The 200T premium
dev board uses an XC7A200T for more logic, BRAM, and DSP resources. The two
devices have completely different packages and pin names, so each needs its own
constraint file.

The Trenz TE0712/TE0701 path uses the same FPGA part as the 200T but different board
pinout and peripherals. The dev target is split into its own top wrapper
(`radar_system_top_te0712_dev.v`) and minimal constraints file to avoid accidental mixing
of production pin assignments during bring-up.

The Trenz TE0713/TE0701 path supports situations where TE0712 lead time is prohibitive.
TE0713 uses XC7A200T-2FBG484C (commercial temp grade) and requires separate clock mapping,
so it has its own dev top and XDC.

## USB Interface Architecture (USB_MODE)

The radar system supports two USB data interfaces, selected at **compile time** via
the `USB_MODE` parameter in `radar_system_top.v`:

| USB_MODE | Interface | Bus Width | Speed | Board Target |
|----------|-----------|-----------|-------|--------------|
| 0 | FT601 (USB 3.0) | 32-bit | 100 MHz | 200T premium dev board |
| 1 (default) | FT2232H (USB 2.0) | 8-bit | 60 MHz | 50T production board |

### How USB_MODE Works

`radar_system_top.v` contains a Verilog `generate` block that instantiates exactly
one USB interface module based on the `USB_MODE` parameter:

```
generate
if (USB_MODE == 0) begin : gen_ft601
    usb_data_interface usb_inst (...)          // FT601, 32-bit
    // FT2232H ports tied off to inactive
end else begin : gen_ft2232h
    usb_data_interface_ft2232h usb_inst (...)  // FT2232H, 8-bit
    // FT601 ports tied off to inactive
end
endgenerate
```

Both interfaces share the same internal radar data bus and host command interface.
The unused interface's I/O pins are tied to safe inactive states (active-low
signals high, active-high signals low, bidirectional buses high-Z).

### How USB_MODE Is Passed Per Board Target

The parameter is set via a **wrapper module** that overrides the default:

- **50T production**: `radar_system_top_50t.v` instantiates the core with
  `.USB_MODE(1)` and maps the FT2232H's 60 MHz `CLKOUT` to the shared
  `ft601_clk_in` port. FT601 inputs are tied inactive; outputs go to `_nc` wires.

  ```verilog
  // In radar_system_top_50t.v:
  radar_system_top #(
      .USB_MODE(1)
  ) u_core ( ... );
  ```

- **200T dev board**: `radar_system_top` is used directly as the top module.
  `USB_MODE` defaults to `1` (FT2232H) since production is the primary target.
  Override with `.USB_MODE(0)` for FT601 builds.

### RTL Files by USB Interface

| File | Purpose |
|------|---------|
| `usb_data_interface.v` | FT601 USB 3.0 module (32-bit, USB_MODE=0) |
| `usb_data_interface_ft2232h.v` | FT2232H USB 2.0 module (8-bit, USB_MODE=1) |
| `radar_system_top.v` | Core module with USB_MODE generate block |
| `radar_system_top_50t.v` | 50T wrapper: sets USB_MODE=1, ties off FT601 |

### FT2232H Pin Map (50T, Bank 35, VCCO=3.3V)

All connections are direct between U6 (FT2232HQ) and U42 (XC7A50T). Only
Channel A is used (245 Synchronous FIFO mode). Channel B is unconnected.

| Signal | FT2232H Pin | FPGA Ball | Direction |
|--------|-------------|-----------|-----------|
| FT_D[7:0] | ADBUS[7:0] | K1,J3,H3,G4,F2,D1,C3,C1 | Bidirectional |
| FT_RXF# | ACBUS0 | A2 | Input (FIFO not empty) |
| FT_TXE# | ACBUS1 | B2 | Input (FIFO not full) |
| FT_RD# | ACBUS2 | A3 | Output (read strobe) |
| FT_WR# | ACBUS3 | A4 | Output (write strobe) |
| FT_SIWUA | ACBUS4 | A5 | Output (send immediate) |
| FT_CLKOUT | ACBUS5 | C4 (MRCC) | Input (60 MHz clock) |
| FT_OE# | ACBUS6 | B7 | Output (bus direction) |

## Bank Voltage Assignments

### XC7A50T-FTG256 (50T Production)

| Bank | VCCO | Signals |
|------|------|---------|
| 0 | 3.3V | JTAG, flash CS |
| 14 | 3.3V | ADC LVDS (LVDS_33), SPI flash |
| 15 | 3.3V | DAC, clocks, STM32 3.3V SPI, DIG bus |
| 34 | 1.8V | ADAR1000 control, SPI 1.8V side |
| 35 | 3.3V | FT2232H USB 2.0 (8-bit data + control, 15 signals) |

### XC7A200T-FBG484 (200T Premium Dev Board)

| Bank | VCCO | Used/Avail | Signals |
|------|------|------------|---------|
| 13 | 3.3V | 17/35 | Debug overflow (doppler bins, range bins, status) |
| 14 | 2.5V | 19/50 | ADC LVDS_25 + DIFF_TERM, ADC power-down |
| 15 | 3.3V | 27/50 | System clocks (100M, 120M), DAC, RF, STM32 3.3V SPI, DIG bus |
| 16 | 3.3V | 50/50 | FT601 USB 3.0 (32-bit data + byte enable + control) |
| 34 | 1.8V | 19/50 | ADAR1000 beamformer control, SPI 1.8V side |
| 35 | 3.3V | 50/50 | Status outputs (beam position, chirp, doppler data bus) |

## Signal Differences Between Targets

| Signal | 50T Production (FTG256) | 200T Dev (FBG484) |
|--------|-------------------------|-------------------|
| USB interface | FT2232H USB 2.0 (8-bit, Bank 35) | FT601 USB 3.0 (32-bit, Bank 16) |
| USB_MODE | 1 (via `radar_system_top_50t` wrapper) | 0 (default in `radar_system_top`) |
| USB clock | 60 MHz from FT2232H CLKOUT | 100 MHz from FT601 |
| `dac_clk` | Not connected (DAC clocked by AD9523 directly) | Routed, FPGA drives DAC |
| `ft601_be` width | N/A (FT601 unused, tied off) | `[3:0]` (RTL updated) |
| ADC LVDS standard | LVDS_33 (3.3V bank) | LVDS_25 (2.5V bank, better quality) |
| Status/debug outputs | No physical pins (commented out) | All routed to Banks 35 + 13 |

## How to Build

### Quick Reference

```bash
# From the FPGA source directory (9_Firmware/9_2_FPGA):

# 50T production build (FT2232H, USB_MODE=1):
vivado -mode batch -source scripts/50t/build_50t.tcl 2>&1 | tee build_50t/vivado.log

# 200T dev build (FT601, USB_MODE=0):
vivado -mode batch -source scripts/200t/build_200t.tcl \
  -log build/build.log -journal build/build.jou
```

The build scripts automatically select the correct top module and constraints:

| Build Script | Top Module | Constraints | USB_MODE |
|--------------|------------|-------------|----------|
| `scripts/50t/build_50t.tcl` | `radar_system_top_50t` | `xc7a50t_ftg256.xdc` | 1 (FT2232H) |
| `scripts/200t/build_200t.tcl` | `radar_system_top` | `xc7a200t_fbg484.xdc` | 0 (FT601) |

You do NOT need to set `USB_MODE` manually. The top module selection handles it:
- `radar_system_top_50t` forces `USB_MODE=1` internally
- `radar_system_top` defaults to `USB_MODE=1` (FT2232H, production default)

## How to Select Constraints in Vivado

In the Vivado project, only one target XDC should be active at a time:

1. Add both files to the project: `File > Add Sources > Add Constraints`
2. In the Sources panel, right-click the XDC you do NOT want and select
   `Set File Properties > Enabled = false` (or remove it from the active
   constraint set)
3. Alternatively, use two separate constraint sets and switch between them

For TCL-based flows:
```tcl
# For production target:
read_xdc constraints/xc7a200t_fbg484.xdc

# For upstream target:
read_xdc constraints/xc7a50t_ftg256.xdc

# For Trenz TE0712/TE0701 split target:
read_xdc constraints/te0712_te0701_minimal.xdc

# For Trenz TE0713/TE0701 split target:
read_xdc constraints/te0713_te0701_minimal.xdc
```

## Top Modules by Target

| Target | Top module | USB_MODE | USB Interface | Notes |
|--------|------------|----------|---------------|-------|
| 50T Production (FTG256) | `radar_system_top_50t` | 1 | FT2232H (8-bit) | Wrapper sets USB_MODE=1, ties off FT601 |
| 200T Dev (FBG484) | `radar_system_top` | 0 (override) | FT601 (32-bit) | Build script overrides default USB_MODE=1 |
| Trenz TE0712/TE0701 | `radar_system_top_te0712_dev` | 0 (override) | FT601 (32-bit) | Minimal bring-up wrapper |
| Trenz TE0713/TE0701 | `radar_system_top_te0713_dev` | 0 (override) | FT601 (32-bit) | Alternate SoM wrapper |

## Trenz Split Status

- `constraints/te0712_te0701_minimal.xdc` currently includes verified TE0712 pins:
  - `clk_100m` -> `R4` (TE0712 `CLK1B[0]`, 50 MHz source)
  - `reset_n` -> `T3` (TE0712 reset pin)
- `user_led` and `system_status` are now mapped to TE0701 FMC LA lines through TE0712 B16
  package pins (GPIO export path, not TE0701 onboard LED D1..D8).
- Temporary `NSTD-1`/`UCIO-1` severity downgrades were removed after pin assignment.

### Current GPIO Export Map

| Port | TE0712 package pin | TE0712 net | TE0701 FMC net |
|------|---------------------|------------|----------------|
| `user_led[0]` | `A19` | `B16_L17_N` | `FMC_LA14_N` |
| `user_led[1]` | `A18` | `B16_L17_P` | `FMC_LA14_P` |
| `user_led[2]` | `F20` | `B16_L18_N` | `FMC_LA13_N` |
| `user_led[3]` | `F19` | `B16_L18_P` | `FMC_LA13_P` |
| `system_status[0]` | `F18` | `B16_L15_P` | `FMC_LA5_N` |
| `system_status[1]` | `E18` | `B16_L15_N` | `FMC_LA5_P` |
| `system_status[2]` | `C22` | `B16_L20_P` | `FMC_LA6_N` |
| `system_status[3]` | `B22` | `B16_L20_N` | `FMC_LA6_P` |

Note: FMC direction/N/P labeling must be validated against TE0701 connector orientation
and I/O Planner before final hardware sign-off.

## Trenz Batch Build

Use the dedicated script for the split dev target:

```bash
vivado -mode batch -source scripts/build_te0712_dev.tcl

# TE0713/TE0701 target
vivado -mode batch -source scripts/build_te0713_dev.tcl
```

Outputs:
- Project directory: `vivado_te0712_dev/`
- Reports: `vivado_te0712_dev/reports/`
- Top module: `radar_system_top_te0712_dev`
- Constraint file: `constraints/te0712_te0701_minimal.xdc`

TE0713 outputs:
- Project directory: `vivado_te0713_dev/`
- Reports: `vivado_te0713_dev/reports/`
- Top module: `radar_system_top_te0713_dev`
- Constraint file: `constraints/te0713_te0701_minimal.xdc`

## Notes

- **USB_MODE is compile-time only.** You cannot switch USB interfaces at runtime.
  Each board target has exactly one USB chip physically connected.
- The 50T production build must use `radar_system_top_50t` as top module. Using
  `radar_system_top` directly will default to FT601 (USB_MODE=0), which has no
  physical connection on the 50T board.
- The 200T XDC pin assignments are **recommended** for the new PCB.
  The PCB designer should follow this allocation.
- Bank 16 on the 200T (FT601) is fully utilized at 50/50 pins. No room for expansion
  on that bank.
- Bank 35 on the 200T (status/debug) is also at capacity (50/50). Additional debug
  signals should use Bank 13 spare pins (18 remaining).
- Bank 35 on the 50T is used for FT2232H (15 signals). Remaining pins are available
  for future expansion.
- Clock inputs are placed on MRCC (Multi-Region Clock Capable) pins to
  ensure proper clock tree access. The FT2232H CLKOUT (60 MHz) is on
  pin C4 (`IO_L12N_T1_MRCC_35`).
