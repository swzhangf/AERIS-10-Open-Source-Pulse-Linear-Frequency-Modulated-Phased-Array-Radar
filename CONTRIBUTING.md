# Contributing to PLFM_RADAR (AERIS-10)

Thanks for your interest in the project! This guide covers the basics
for getting a change reviewed and merged.

## Getting started

1. Fork the repository and create a topic branch from `develop`. The `main` branch is for production releases only.
2. Keep generated outputs (Vivado projects, bitstreams, build logs) out of version control.

### Security Mandate: Package Installation
Due to supply chain attack risks, **ALL package installations MUST use the `sfw` (secure firewall) prefix**.
- Python: `sfw uv pip install <package>` (Do not use raw pip)
- Node/JS: `sfw npm install <package>`
- Rust/Cargo: `sfw cargo <command>`

Never run bare package installation commands without the `sfw` prefix.

## Repository layout

| Path | Contents |
|------|----------|
| `4_Schematics and Boards Layout/` | KiCad schematics, Gerbers, BOM/CPL |
| `9_Firmware/9_1_Microcontroller/` | STM32 MCU C/C++ firmware and unit tests |
| `9_Firmware/9_2_FPGA/` | Verilog RTL, constraints, testbenches, build scripts |
| `9_Firmware/9_3_GUI/` | Python radar dashboard (Tkinter/PyQt6) and CLI tools |
| `9_Firmware/tests/cross_layer/` | Python-based system invariant/contract tests |
| `docs/` | GitHub Pages documentation site |

## Code Standards & Tooling

- **Python (GUI, Scripts, Tests)**:
  - We use `uv` for dependency management.
  - We strictly enforce linting with `ruff`. Run `uv run ruff check .` before committing.
  - Test with `pytest`.
- **Verilog (FPGA)**:
  - The RTL (`radar_system_top.v`) is the single source of truth for opcode values, bit widths, reset defaults, and valid ranges.
  - Testbenches must include **adversarial validation**: actively test boundary conditions, race conditions, unexpected input sequences, and reset mid-operation.
  - Use `iverilog` for simulation.
- **C/C++ (MCU)**:
  - Use `make test` for host-side unit testing (cpputest).
- **System-Level Invariants**:
  - Whenever adding code, verify that system-level invariants (across module, process, and chip boundaries) hold true.

## AI Usage Policy

The use of AI is permitted but we have to make sure that the quality and control of the codebase doesn't depend on the agents but the maintainer pushing the changes, meaning they are fully responsible for the code they commit.

1. **Human Accountability** — The committing engineer is fully responsible for AI-generated code as if they wrote it. Every PR must be understood and defensible by a human.
2. **Mandatory Review** — No raw AI output may be committed unread. AI code must pass the same review bar as hand-written code.
3. **Full CI Before Commit** — All AI-assisted changes must pass the complete CI suite locally (lint, unit, regression, cross-layer) before commit.

## Running the Test Suites

We use GitHub Actions for CI, which runs four main jobs on every PR. Run these locally before pushing.

### 1. Python & Linting
```bash
uv run ruff check .
cd 9_Firmware/9_3_GUI
uv run pytest test_GUI_V65_Tk.py test_v7.py -v
```

### 2. FPGA Regression
```bash
cd 9_Firmware/9_2_FPGA
bash run_regression.sh
```
This runs five phases (Lint, Changed Modules, Integration, Signal Processing, Infrastructure, and **P0 Adversarial Tests**). All must pass.

### 3. MCU Unit Tests
```bash
cd 9_Firmware/9_1_Microcontroller/tests
make clean && make
```

### 4. Cross-Layer Contract Tests
```bash
uv run pytest 9_Firmware/tests/cross_layer/test_cross_layer_contract.py -v
```

## Before merging: CI checklist

All PRs must pass CI:

| Job | What it checks |
|----|---------------|
| `python-tests` | ruff clean + pytest green |
| `mcu-tests` | make all exits 0 |
| `fpga-regression` | run_regression.sh exits 0 |
| `cross-layer-tests` | pytest exits 0 |

## Important Notes

- **NO LEGACY COMPATIBILITY** unless explicitly requested by the maintainer.
- **The FPGA RTL (`radar_system_top.v`) is the single source of truth** for opcode values, bit widths, reset defaults, and valid ranges. All other layers must align to it.
- **Adversarial testing is mandatory**: Every test must actively try to break the code.
- **Testbench timing**: Always add a `#1` delay after `@(posedge clk)` before driving DUT inputs with blocking assignments.
- **Pre-fetch FIFO**: Remember `wr_full` is asserted after DEPTH+1 writes, not just DEPTH.

## Checklist Before Push

- [ ] `uv run ruff check .` — no lint errors
- [ ] `uv run pytest test_GUI_V65_Tk.py test_v7.py -v` — all pass
- [ ] `cd 9_Firmware/9_2_FPGA && bash run_regression.sh` — all 5 phases pass
- [ ] `cd 9_Firmware/9_1_Microcontroller/tests && make clean && make` — pass
- [ ] `uv run pytest 9_Firmware/tests/cross_layer/test_cross_layer_contract.py` — pass
- [ ] `git diff --check` — no whitespace issues
- [ ] PR targets `develop` branch

## Questions?

Open a GitHub issue — discussion is visible to everyone.