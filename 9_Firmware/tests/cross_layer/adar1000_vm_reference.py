"""ADAR1000 vector-modulator ground-truth table and firmware parser.

This module is a pure data + helpers library imported by the cross-layer
test suite (`9_Firmware/tests/cross_layer/test_cross_layer_contract.py`,
class `TestTier2Adar1000VmTableGroundTruth`). It has no CLI entry point
and no side effects on import beyond the structural assertion on the
table length.

Ground-truth source
-------------------
The 128-entry `(I, Q)` byte pairs below are transcribed from the ADAR1000
datasheet Rev. B, Tables 13-16, page 34 ("Phase Shifter Programming"),
which is the primary normative reference. The same values appear in the
Analog Devices Linux beamformer driver
(`drivers/iio/beamformer/adar1000.c`, `adar1000_phase_values[]`) and were
cross-checked against that driver as a secondary, independent
transcription. The byte values are factual data (5-bit unsigned magnitude
in bits[4:0], polarity bit at bit[5], bits[7:6] reserved zero); no
copyrightable creative expression. Only the datasheet is the
licensing-relevant source.

PLFM_RADAR firmware indexing convention
---------------------------------------
`adarSetRxPhase` / `adarSetTxPhase` in
`9_Firmware/9_1_Microcontroller/9_1_1_C_Cpp_Libraries/ADAR1000_Manager.cpp`
write `VM_I[phase % 128]` and `VM_Q[phase % 128]` to the chip. Each index
N corresponds to commanded beam phase `N * 360/128 = N * 2.8125 deg`. The
ADI table is also on a uniform 2.8125 deg grid (verified by
`check_uniform_2p8125_deg_step` below), so a 1:1 mapping is correct:
PLFM index N == ADI table row N.
"""

from __future__ import annotations

import re

# ----------------------------------------------------------------------------
# Ground truth: ADAR1000 datasheet Rev. B Tables 13-16 p.34
# Each entry: (angle_int_deg, angle_frac_x10000, vm_byte_I, vm_byte_Q)
# ----------------------------------------------------------------------------
GROUND_TRUTH: list[tuple[int, int, int, int]] = [
    (0, 0, 0x3F, 0x20), (2, 8125, 0x3F, 0x21), (5, 6250, 0x3F, 0x23),
    (8, 4375, 0x3F, 0x24), (11, 2500, 0x3F, 0x26), (14, 625, 0x3E, 0x27),
    (16, 8750, 0x3E, 0x28), (19, 6875, 0x3D, 0x2A), (22, 5000, 0x3D, 0x2B),
    (25, 3125, 0x3C, 0x2D), (28, 1250, 0x3C, 0x2E), (30, 9375, 0x3B, 0x2F),
    (33, 7500, 0x3A, 0x30), (36, 5625, 0x39, 0x31), (39, 3750, 0x38, 0x33),
    (42, 1875, 0x37, 0x34), (45, 0, 0x36, 0x35), (47, 8125, 0x35, 0x36),
    (50, 6250, 0x34, 0x37), (53, 4375, 0x33, 0x38), (56, 2500, 0x32, 0x38),
    (59, 625, 0x30, 0x39), (61, 8750, 0x2F, 0x3A), (64, 6875, 0x2E, 0x3A),
    (67, 5000, 0x2C, 0x3B), (70, 3125, 0x2B, 0x3C), (73, 1250, 0x2A, 0x3C),
    (75, 9375, 0x28, 0x3C), (78, 7500, 0x27, 0x3D), (81, 5625, 0x25, 0x3D),
    (84, 3750, 0x24, 0x3D), (87, 1875, 0x22, 0x3D), (90, 0, 0x21, 0x3D),
    (92, 8125, 0x01, 0x3D), (95, 6250, 0x03, 0x3D), (98, 4375, 0x04, 0x3D),
    (101, 2500, 0x06, 0x3D), (104, 625, 0x07, 0x3C), (106, 8750, 0x08, 0x3C),
    (109, 6875, 0x0A, 0x3C), (112, 5000, 0x0B, 0x3B), (115, 3125, 0x0D, 0x3A),
    (118, 1250, 0x0E, 0x3A), (120, 9375, 0x0F, 0x39), (123, 7500, 0x11, 0x38),
    (126, 5625, 0x12, 0x38), (129, 3750, 0x13, 0x37), (132, 1875, 0x14, 0x36),
    (135, 0, 0x16, 0x35), (137, 8125, 0x17, 0x34), (140, 6250, 0x18, 0x33),
    (143, 4375, 0x19, 0x31), (146, 2500, 0x19, 0x30), (149, 625, 0x1A, 0x2F),
    (151, 8750, 0x1B, 0x2E), (154, 6875, 0x1C, 0x2D), (157, 5000, 0x1C, 0x2B),
    (160, 3125, 0x1D, 0x2A), (163, 1250, 0x1E, 0x28), (165, 9375, 0x1E, 0x27),
    (168, 7500, 0x1E, 0x26), (171, 5625, 0x1F, 0x24), (174, 3750, 0x1F, 0x23),
    (177, 1875, 0x1F, 0x21), (180, 0, 0x1F, 0x20), (182, 8125, 0x1F, 0x01),
    (185, 6250, 0x1F, 0x03), (188, 4375, 0x1F, 0x04), (191, 2500, 0x1F, 0x06),
    (194, 625, 0x1E, 0x07), (196, 8750, 0x1E, 0x08), (199, 6875, 0x1D, 0x0A),
    (202, 5000, 0x1D, 0x0B), (205, 3125, 0x1C, 0x0D), (208, 1250, 0x1C, 0x0E),
    (210, 9375, 0x1B, 0x0F), (213, 7500, 0x1A, 0x10), (216, 5625, 0x19, 0x11),
    (219, 3750, 0x18, 0x13), (222, 1875, 0x17, 0x14), (225, 0, 0x16, 0x15),
    (227, 8125, 0x15, 0x16), (230, 6250, 0x14, 0x17), (233, 4375, 0x13, 0x18),
    (236, 2500, 0x12, 0x18), (239, 625, 0x10, 0x19), (241, 8750, 0x0F, 0x1A),
    (244, 6875, 0x0E, 0x1A), (247, 5000, 0x0C, 0x1B), (250, 3125, 0x0B, 0x1C),
    (253, 1250, 0x0A, 0x1C), (255, 9375, 0x08, 0x1C), (258, 7500, 0x07, 0x1D),
    (261, 5625, 0x05, 0x1D), (264, 3750, 0x04, 0x1D), (267, 1875, 0x02, 0x1D),
    (270, 0, 0x01, 0x1D), (272, 8125, 0x21, 0x1D), (275, 6250, 0x23, 0x1D),
    (278, 4375, 0x24, 0x1D), (281, 2500, 0x26, 0x1D), (284, 625, 0x27, 0x1C),
    (286, 8750, 0x28, 0x1C), (289, 6875, 0x2A, 0x1C), (292, 5000, 0x2B, 0x1B),
    (295, 3125, 0x2D, 0x1A), (298, 1250, 0x2E, 0x1A), (300, 9375, 0x2F, 0x19),
    (303, 7500, 0x31, 0x18), (306, 5625, 0x32, 0x18), (309, 3750, 0x33, 0x17),
    (312, 1875, 0x34, 0x16), (315, 0, 0x36, 0x15), (317, 8125, 0x37, 0x14),
    (320, 6250, 0x38, 0x13), (323, 4375, 0x39, 0x11), (326, 2500, 0x39, 0x10),
    (329, 625, 0x3A, 0x0F), (331, 8750, 0x3B, 0x0E), (334, 6875, 0x3C, 0x0D),
    (337, 5000, 0x3C, 0x0B), (340, 3125, 0x3D, 0x0A), (343, 1250, 0x3E, 0x08),
    (345, 9375, 0x3E, 0x07), (348, 7500, 0x3E, 0x06), (351, 5625, 0x3F, 0x04),
    (354, 3750, 0x3F, 0x03), (357, 1875, 0x3F, 0x01),
]

assert len(GROUND_TRUTH) == 128, f"GROUND_TRUTH must have 128 entries, has {len(GROUND_TRUTH)}"

VM_I_REF: list[int] = [row[2] for row in GROUND_TRUTH]
VM_Q_REF: list[int] = [row[3] for row in GROUND_TRUTH]


# ----------------------------------------------------------------------------
# Structural-invariant checks on the embedded ground-truth transcription.
# These defend against typos during the copy-paste from the datasheet / ADI
# driver. Each function returns a list of error strings (empty == pass) so
# callers (the pytest class) can assert-on-empty with a useful message.
# ----------------------------------------------------------------------------
def check_byte_format(label: str, table: list[int]) -> list[str]:
    """Each byte must have bits[7:6] == 0 (reserved)."""
    errors = []
    for i, byte in enumerate(table):
        if byte & 0xC0:
            errors.append(f"{label}[{i}]=0x{byte:02X}: reserved bits[7:6] non-zero")
    return errors


def check_uniform_2p8125_deg_step() -> list[str]:
    """Angles must form a uniform 2.8125 deg grid: angle[N] == N * 2.8125."""
    errors = []
    for i, (deg_int, deg_frac, _, _) in enumerate(GROUND_TRUTH):
        # angle in units of 1/10000 degree; 2.8125 deg = 28125/10000 exactly
        angle_e4 = deg_int * 10000 + deg_frac
        expected_e4 = i * 28125
        if angle_e4 != expected_e4:
            errors.append(
                f"GROUND_TRUTH[{i}]: angle {deg_int}.{deg_frac:04d} deg "
                f"(={angle_e4}/10000) != expected {expected_e4}/10000 "
                f"(=i*2.8125)"
            )
    return errors


def check_quadrant_symmetry() -> list[str]:
    """Angle and angle+180 deg must have inverted polarity bits but identical
    magnitudes. Index offset 64 corresponds to 180 deg on the 128-step grid.

    Exemption: when magnitude is zero the polarity bit is physically
    meaningless (sign of zero is undefined for the IQ phasor projection).
    The datasheet uses POL=1 for both 0 and 180 deg Q components (both
    encode Q=0). Skip the polarity assertion for zero-magnitude entries.
    """
    errors = []
    POL = 0x20
    MAG = 0x1F
    for i in range(64):
        j = i + 64
        mag_i_a, mag_i_b = VM_I_REF[i] & MAG, VM_I_REF[j] & MAG
        if mag_i_a != mag_i_b:
            errors.append(
                f"VM_I[{i}]=0x{VM_I_REF[i]:02X} vs VM_I[{j}]=0x{VM_I_REF[j]:02X}: "
                f"180 deg pair has different magnitude"
            )
        if mag_i_a != 0 and (VM_I_REF[i] & POL) == (VM_I_REF[j] & POL):
            errors.append(
                f"VM_I[{i}]=0x{VM_I_REF[i]:02X} vs VM_I[{j}]=0x{VM_I_REF[j]:02X}: "
                f"180 deg pair has same polarity (should be inverted, mag={mag_i_a})"
            )
        mag_q_a, mag_q_b = VM_Q_REF[i] & MAG, VM_Q_REF[j] & MAG
        if mag_q_a != mag_q_b:
            errors.append(
                f"VM_Q[{i}]=0x{VM_Q_REF[i]:02X} vs VM_Q[{j}]=0x{VM_Q_REF[j]:02X}: "
                f"180 deg pair has different magnitude"
            )
        if mag_q_a != 0 and (VM_Q_REF[i] & POL) == (VM_Q_REF[j] & POL):
            errors.append(
                f"VM_Q[{i}]=0x{VM_Q_REF[i]:02X} vs VM_Q[{j}]=0x{VM_Q_REF[j]:02X}: "
                f"180 deg pair has same polarity (should be inverted, mag={mag_q_a})"
            )
    return errors


def check_cardinal_points() -> list[str]:
    """Spot-check cardinal phase points against datasheet expectations."""
    errors = []
    expectations = [
        (0,  0x3F, 0x20, "0 deg: max +I, ~zero Q"),
        (32, 0x21, 0x3D, "90 deg: ~zero I, max +Q"),
        (64, 0x1F, 0x20, "180 deg: max -I, ~zero Q"),
        (96, 0x01, 0x1D, "270 deg: ~zero I, max -Q"),
    ]
    for idx, exp_i, exp_q, desc in expectations:
        if VM_I_REF[idx] != exp_i or VM_Q_REF[idx] != exp_q:
            errors.append(
                f"index {idx} ({desc}): expected (0x{exp_i:02X}, 0x{exp_q:02X}), "
                f"got (0x{VM_I_REF[idx]:02X}, 0x{VM_Q_REF[idx]:02X})"
            )
    return errors


# ----------------------------------------------------------------------------
# Parse VM_I[] / VM_Q[] from firmware C++ source.
# ----------------------------------------------------------------------------
ARRAY_RE = re.compile(
    r"const\s+uint8_t\s+ADAR1000Manager::(?P<name>VM_I|VM_Q|VM_GAIN)\s*"
    r"\[\s*128\s*\]\s*=\s*\{(?P<body>[^}]*)\}\s*;",
    re.DOTALL,
)
HEX_RE = re.compile(r"0[xX][0-9a-fA-F]{1,2}")


def parse_array(source: str, name: str) -> list[int] | None:
    """Extract a 128-entry uint8_t array from C++ source by name.

    Returns None if the array is not found. Returns a list (possibly shorter
    than 128) of the parsed bytes if found; caller is responsible for length
    validation.

    LIMITATION (intentional, see PR fix/adar1000-vm-tables review finding #2):
    ARRAY_RE uses `[^}]*` for the body, which terminates at the first `}`.
    This is sufficient for the *flat* `const uint8_t NAME[128] = { ... };`
    declarations VM_I/VM_Q use today, but it would mis-parse if the array
    body ever contained nested braces (e.g. designated initialisers, struct
    aggregates, or macro-expansions producing braces). If the firmware ever
    needs such a form for the VM tables, replace ARRAY_RE with a balanced
    brace-counting parser. Until then, the current regex is preferred for
    its simplicity and the round-trip tests will catch any silent breakage.
    """
    for m in ARRAY_RE.finditer(source):
        if m.group("name") != name:
            continue
        body = m.group("body")
        body = re.sub(r"//[^\n]*", "", body)
        body = re.sub(r"/\*.*?\*/", "", body, flags=re.DOTALL)
        return [int(tok, 16) for tok in HEX_RE.findall(body)]
    return None
