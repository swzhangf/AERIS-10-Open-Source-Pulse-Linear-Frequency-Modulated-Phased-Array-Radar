#!/usr/bin/env python3
"""
AERIS-10 FMC Anti-Alias Filter — openEMS 3D EM Simulation
==========================================================
5th-order differential Butterworth LC LPF, fc ≈ 195 MHz
All components are 0402 (1.0 x 0.5 mm) on FR4 4-layer stackup.

Filter topology (each half of differential):
  IN → R_series(49.9Ω) → L1(24nH) → C1(27pF)↓GND → L2(82nH) → C2(27pF)↓GND → L3(24nH) → OUT
  Plus R_diff(100Ω) across input and output differential pairs.

PCB stackup:
  L1: F.Cu    (signal + components)  — 35µm copper
  Prepreg: 0.2104 mm
  L2: In1.Cu  (GND plane)           — 35µm copper
  Core: 1.0 mm
  L3: In2.Cu  (Power plane)         — 35µm copper
  Prepreg: 0.2104 mm
  L4: B.Cu    (signal)              — 35µm copper

Total board thickness ≈ 1.6 mm

Differential trace: W=0.23mm, S=0.12mm gap → Zdiff≈100Ω
All 0402 pads: 0.5mm x 0.55mm with 0.5mm gap between pads

Simulation extracts 4-port S-parameters (differential in → differential out)
then converts to mixed-mode (Sdd11, Sdd21, Scc21) for analysis.
"""

import os
import sys
import numpy as np

sys.path.insert(0, '/Users/ganeshpanth/openEMS-Project/CSXCAD/python')
sys.path.insert(0, '/Users/ganeshpanth/openEMS-Project/openEMS/python')
os.environ['PATH'] = '/Users/ganeshpanth/opt/openEMS/bin:' + os.environ.get('PATH', '')

from CSXCAD import ContinuousStructure
from openEMS import openEMS
from openEMS.physical_constants import C0, EPS0

unit = 1e-3

f_start = 1e6
f_stop = 1e9
f_center = 150e6
f_IF_low = 120e6
f_IF_high = 180e6

max_res = C0 / f_stop / unit / 20

copper_t = 0.035
prepreg_t = 0.2104
core_t = 1.0
sub_er = 4.3
sub_tand = 0.02
cu_cond = 5.8e7

z_L4_bot = 0.0
z_L4_top = z_L4_bot + copper_t
z_pre2_top = z_L4_top + prepreg_t
z_L3_top = z_pre2_top + copper_t
z_core_top = z_L3_top + core_t
z_L2_top = z_core_top + copper_t
z_pre1_top = z_L2_top + prepreg_t
z_L1_bot = z_pre1_top
z_L1_top = z_L1_bot + copper_t

pad_w = 0.50
pad_l = 0.55
pad_gap = 0.50
comp_pitch = 1.5

trace_w = 0.23
trace_s = 0.12
pair_pitch = trace_w + trace_s

R_series = 49.9
R_diff_in = 100.0
R_diff_out = 100.0

L1_val = 24e-9
L2_val = 82e-9
L3_val = 24e-9

C1_val = 27e-12
C2_val = 27e-12

FDTD = openEMS(NrTS=50000, EndCriteria=1e-5)
FDTD.SetGaussExcite(0.5 * (f_start + f_stop), 0.5 * (f_stop - f_start))
FDTD.SetBoundaryCond(['PML_8'] * 6)

CSX = ContinuousStructure()
FDTD.SetCSX(CSX)

copper = CSX.AddMetal('copper')
gnd_metal = CSX.AddMetal('gnd_plane')
fr4_pre1 = CSX.AddMaterial(
    'prepreg1', epsilon=sub_er, kappa=sub_tand * 2 * np.pi * f_center * EPS0 * sub_er
)
fr4_core = CSX.AddMaterial(
    'core', epsilon=sub_er, kappa=sub_tand * 2 * np.pi * f_center * EPS0 * sub_er
)
fr4_pre2 = CSX.AddMaterial(
    'prepreg2', epsilon=sub_er, kappa=sub_tand * 2 * np.pi * f_center * EPS0 * sub_er
)

y_P = +pair_pitch / 2
y_N = -pair_pitch / 2

x_port_in = -1.0
x_R_series = 0.0
x_L1 = x_R_series + comp_pitch
x_C1 = x_L1 + comp_pitch
x_L2 = x_C1 + comp_pitch
x_C2 = x_L2 + comp_pitch
x_L3 = x_C2 + comp_pitch
x_port_out = x_L3 + comp_pitch + 1.0

x_Rdiff_in = x_port_in - 0.5
x_Rdiff_out = x_port_out + 0.5

margin = 3.0
x_min = x_Rdiff_in - margin
x_max = x_Rdiff_out + margin
y_min = y_N - margin
y_max = y_P + margin
z_min = z_L4_bot - margin
z_max = z_L1_top + margin

fr4_pre1.AddBox([x_min, y_min, z_L2_top], [x_max, y_max, z_L1_bot], priority=1)
fr4_core.AddBox([x_min, y_min, z_L3_top], [x_max, y_max, z_core_top], priority=1)
fr4_pre2.AddBox([x_min, y_min, z_L4_top], [x_max, y_max, z_pre2_top], priority=1)

gnd_metal.AddBox(
    [x_min + 0.5, y_min + 0.5, z_core_top], [x_max - 0.5, y_max - 0.5, z_L2_top], priority=10
)


def add_trace_segment(x_start, x_end, y_center, z_bot, z_top, w, metal, priority=20):
    metal.AddBox(
        [x_start, y_center - w / 2, z_bot], [x_end, y_center + w / 2, z_top], priority=priority
    )


def add_0402_pads(x_center, y_center, z_bot, z_top, metal, priority=20):
    x_left = x_center - pad_gap / 2 - pad_w / 2
    metal.AddBox(
        [x_left - pad_w / 2, y_center - pad_l / 2, z_bot],
        [x_left + pad_w / 2, y_center + pad_l / 2, z_top],
        priority=priority,
    )
    x_right = x_center + pad_gap / 2 + pad_w / 2
    metal.AddBox(
        [x_right - pad_w / 2, y_center - pad_l / 2, z_bot],
        [x_right + pad_w / 2, y_center + pad_l / 2, z_top],
        priority=priority,
    )
    return (x_left, x_right)


def add_lumped_element(
    CSX, name, element_type, value, x_center, y_center, z_bot, z_top, direction='x'
):
    x_left = x_center - pad_gap / 2 - pad_w / 2
    x_right = x_center + pad_gap / 2 + pad_w / 2
    if direction == 'x':
        start = [x_left, y_center - pad_l / 4, z_bot]
        stop = [x_right, y_center + pad_l / 4, z_top]
        edir = 'x'
    elif direction == 'y':
        start = [x_center - pad_l / 4, y_center - pad_gap / 2 - pad_w / 2, z_bot]
        stop = [x_center + pad_l / 4, y_center + pad_gap / 2 + pad_w / 2, z_top]
        edir = 'y'
    if element_type == 'R':
        elem = CSX.AddLumpedElement(name, ny=edir, caps=True, R=value)
    elif element_type == 'L':
        elem = CSX.AddLumpedElement(name, ny=edir, caps=True, L=value)
    elif element_type == 'C':
        elem = CSX.AddLumpedElement(name, ny=edir, caps=True, C=value)
    elem.AddBox(start, stop, priority=30)
    return elem


def add_shunt_cap(
    CSX, name, value, x_center, y_trace, _z_top_signal, _z_gnd_top, metal, priority=20,
):
    metal.AddBox(
        [x_center - pad_w / 2, y_trace - pad_l / 2, z_L1_bot],
        [x_center + pad_w / 2, y_trace + pad_l / 2, z_L1_top],
        priority=priority,
    )
    via_drill = 0.15
    cap = CSX.AddLumpedElement(name, ny='z', caps=True, C=value)
    cap.AddBox(
        [x_center - via_drill, y_trace - via_drill, z_L2_top],
        [x_center + via_drill, y_trace + via_drill, z_L1_bot],
        priority=30,
    )
    via_metal = CSX.AddMetal(name + '_via')
    via_metal.AddBox(
        [x_center - via_drill, y_trace - via_drill, z_L2_top],
        [x_center + via_drill, y_trace + via_drill, z_L1_bot],
        priority=25,
    )


add_trace_segment(
    x_port_in, x_R_series - pad_gap / 2 - pad_w, y_P, z_L1_bot, z_L1_top, trace_w, copper
)
add_0402_pads(x_R_series, y_P, z_L1_bot, z_L1_top, copper)
add_lumped_element(CSX, 'R10', 'R', R_series, x_R_series, y_P, z_L1_bot, z_L1_top)
add_trace_segment(
    x_R_series + pad_gap / 2 + pad_w,
    x_L1 - pad_gap / 2 - pad_w,
    y_P,
    z_L1_bot,
    z_L1_top,
    trace_w,
    copper,
)
add_0402_pads(x_L1, y_P, z_L1_bot, z_L1_top, copper)
add_lumped_element(CSX, 'L5', 'L', L1_val, x_L1, y_P, z_L1_bot, z_L1_top)
add_trace_segment(x_L1 + pad_gap / 2 + pad_w, x_C1, y_P, z_L1_bot, z_L1_top, trace_w, copper)
add_shunt_cap(CSX, 'C53', C1_val, x_C1, y_P, z_L1_top, z_L2_top, copper)
add_trace_segment(x_C1, x_L2 - pad_gap / 2 - pad_w, y_P, z_L1_bot, z_L1_top, trace_w, copper)
add_0402_pads(x_L2, y_P, z_L1_bot, z_L1_top, copper)
add_lumped_element(CSX, 'L8', 'L', L2_val, x_L2, y_P, z_L1_bot, z_L1_top)
add_trace_segment(x_L2 + pad_gap / 2 + pad_w, x_C2, y_P, z_L1_bot, z_L1_top, trace_w, copper)
add_shunt_cap(CSX, 'C55', C2_val, x_C2, y_P, z_L1_top, z_L2_top, copper)
add_trace_segment(x_C2, x_L3 - pad_gap / 2 - pad_w, y_P, z_L1_bot, z_L1_top, trace_w, copper)
add_0402_pads(x_L3, y_P, z_L1_bot, z_L1_top, copper)
add_lumped_element(CSX, 'L10', 'L', L3_val, x_L3, y_P, z_L1_bot, z_L1_top)
add_trace_segment(x_L3 + pad_gap / 2 + pad_w, x_port_out, y_P, z_L1_bot, z_L1_top, trace_w, copper)

add_trace_segment(
    x_port_in, x_R_series - pad_gap / 2 - pad_w, y_N, z_L1_bot, z_L1_top, trace_w, copper
)
add_0402_pads(x_R_series, y_N, z_L1_bot, z_L1_top, copper)
add_lumped_element(CSX, 'R11', 'R', R_series, x_R_series, y_N, z_L1_bot, z_L1_top)
add_trace_segment(
    x_R_series + pad_gap / 2 + pad_w,
    x_L1 - pad_gap / 2 - pad_w,
    y_N,
    z_L1_bot,
    z_L1_top,
    trace_w,
    copper,
)
add_0402_pads(x_L1, y_N, z_L1_bot, z_L1_top, copper)
add_lumped_element(CSX, 'L6', 'L', L1_val, x_L1, y_N, z_L1_bot, z_L1_top)
add_trace_segment(x_L1 + pad_gap / 2 + pad_w, x_C1, y_N, z_L1_bot, z_L1_top, trace_w, copper)
add_shunt_cap(CSX, 'C54', C1_val, x_C1, y_N, z_L1_top, z_L2_top, copper)
add_trace_segment(x_C1, x_L2 - pad_gap / 2 - pad_w, y_N, z_L1_bot, z_L1_top, trace_w, copper)
add_0402_pads(x_L2, y_N, z_L1_bot, z_L1_top, copper)
add_lumped_element(CSX, 'L7', 'L', L2_val, x_L2, y_N, z_L1_bot, z_L1_top)
add_trace_segment(x_L2 + pad_gap / 2 + pad_w, x_C2, y_N, z_L1_bot, z_L1_top, trace_w, copper)
add_shunt_cap(CSX, 'C56', C2_val, x_C2, y_N, z_L1_top, z_L2_top, copper)
add_trace_segment(x_C2, x_L3 - pad_gap / 2 - pad_w, y_N, z_L1_bot, z_L1_top, trace_w, copper)
add_0402_pads(x_L3, y_N, z_L1_bot, z_L1_top, copper)
add_lumped_element(CSX, 'L9', 'L', L3_val, x_L3, y_N, z_L1_bot, z_L1_top)
add_trace_segment(x_L3 + pad_gap / 2 + pad_w, x_port_out, y_N, z_L1_bot, z_L1_top, trace_w, copper)

R4_x = x_port_in - 0.3
copper.AddBox(
    [R4_x - pad_l / 2, y_P - pad_w / 2, z_L1_bot],
    [R4_x + pad_l / 2, y_P + pad_w / 2, z_L1_top],
    priority=20,
)
copper.AddBox(
    [R4_x - pad_l / 2, y_N - pad_w / 2, z_L1_bot],
    [R4_x + pad_l / 2, y_N + pad_w / 2, z_L1_top],
    priority=20,
)
R4_elem = CSX.AddLumpedElement('R4', ny='y', caps=True, R=R_diff_in)
R4_elem.AddBox([R4_x - pad_l / 4, y_N, z_L1_bot], [R4_x + pad_l / 4, y_P, z_L1_top], priority=30)

R18_x = x_port_out + 0.3
copper.AddBox(
    [R18_x - pad_l / 2, y_P - pad_w / 2, z_L1_bot],
    [R18_x + pad_l / 2, y_P + pad_w / 2, z_L1_top],
    priority=20,
)
copper.AddBox(
    [R18_x - pad_l / 2, y_N - pad_w / 2, z_L1_bot],
    [R18_x + pad_l / 2, y_N + pad_w / 2, z_L1_top],
    priority=20,
)
R18_elem = CSX.AddLumpedElement('R18', ny='y', caps=True, R=R_diff_out)
R18_elem.AddBox([R18_x - pad_l / 4, y_N, z_L1_bot], [R18_x + pad_l / 4, y_P, z_L1_top], priority=30)

port1 = FDTD.AddLumpedPort(
    1,
    50,
    [x_port_in, y_P - trace_w / 2, z_L2_top],
    [x_port_in, y_P + trace_w / 2, z_L1_bot],
    'z',
    excite=1.0,
)
port2 = FDTD.AddLumpedPort(
    2,
    50,
    [x_port_in, y_N - trace_w / 2, z_L2_top],
    [x_port_in, y_N + trace_w / 2, z_L1_bot],
    'z',
    excite=-1.0,
)
port3 = FDTD.AddLumpedPort(
    3,
    50,
    [x_port_out, y_P - trace_w / 2, z_L2_top],
    [x_port_out, y_P + trace_w / 2, z_L1_bot],
    'z',
    excite=0,
)
port4 = FDTD.AddLumpedPort(
    4,
    50,
    [x_port_out, y_N - trace_w / 2, z_L2_top],
    [x_port_out, y_N + trace_w / 2, z_L1_bot],
    'z',
    excite=0,
)

mesh = CSX.GetGrid()
mesh.SetDeltaUnit(unit)
mesh.AddLine('x', [x_min, x_max])
for x_comp in [x_R_series, x_L1, x_C1, x_L2, x_C2, x_L3]:
    mesh.AddLine('x', np.linspace(x_comp - 1.0, x_comp + 1.0, 15))
mesh.AddLine('x', [x_port_in, x_port_out])
mesh.AddLine('x', [R4_x, R18_x])
mesh.AddLine('y', [y_min, y_max])
for y_trace in [y_P, y_N]:
    mesh.AddLine('y', np.linspace(y_trace - 0.5, y_trace + 0.5, 10))
mesh.AddLine('z', [z_min, z_max])
mesh.AddLine('z', np.linspace(z_L4_bot - 0.1, z_L1_top + 0.1, 25))
mesh.SmoothMeshLines('x', max_res, ratio=1.4)
mesh.SmoothMeshLines('y', max_res, ratio=1.4)
mesh.SmoothMeshLines('z', max_res / 3, ratio=1.3)

sim_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'results')
if not os.path.exists(sim_path):
    os.makedirs(sim_path)

CSX_file = os.path.join(sim_path, 'aaf_filter.xml')
CSX.Write2XML(CSX_file)

FDTD.Run(sim_path, cleanup=True, verbose=3)

freq = np.linspace(f_start, f_stop, 1001)
port1.CalcPort(sim_path, freq)
port2.CalcPort(sim_path, freq)
port3.CalcPort(sim_path, freq)
port4.CalcPort(sim_path, freq)

inc1 = port1.uf_inc
ref1 = port1.uf_ref
inc2 = port2.uf_inc
ref2 = port2.uf_ref
inc3 = port3.uf_inc
ref3 = port3.uf_ref
inc4 = port4.uf_inc
ref4 = port4.uf_ref

a_diff = (inc1 - inc2) / np.sqrt(2)
b_diff_in = (ref1 - ref2) / np.sqrt(2)
b_diff_out = (ref3 - ref4) / np.sqrt(2)

Sdd11 = b_diff_in / a_diff
Sdd21 = b_diff_out / a_diff

b_comm_out = (ref3 + ref4) / np.sqrt(2)
Scd21 = b_comm_out / a_diff

import matplotlib  # noqa: E402
matplotlib.use('Agg')
import matplotlib.pyplot as plt  # noqa: E402

fig, axes = plt.subplots(3, 1, figsize=(12, 14))

ax = axes[0]
Sdd21_dB = 20 * np.log10(np.abs(Sdd21) + 1e-15)
ax.plot(freq / 1e6, Sdd21_dB, 'b-', linewidth=2, label='|Sdd21| (Insertion Loss)')
ax.axvspan(
    f_IF_low / 1e6, f_IF_high / 1e6, alpha=0.15, color='green', label='IF Band (120-180 MHz)'
)
ax.axhline(-3, color='r', linestyle='--', alpha=0.5, label='-3 dB')
ax.set_xlabel('Frequency (MHz)')
ax.set_ylabel('|Sdd21| (dB)')
ax.set_title('Anti-Alias Filter — Differential Insertion Loss')
ax.set_xlim([0, 1000])
ax.set_ylim([-60, 5])
ax.grid(True, alpha=0.3)
ax.legend()

ax = axes[1]
Sdd11_dB = 20 * np.log10(np.abs(Sdd11) + 1e-15)
ax.plot(freq / 1e6, Sdd11_dB, 'r-', linewidth=2, label='|Sdd11| (Return Loss)')
ax.axvspan(f_IF_low / 1e6, f_IF_high / 1e6, alpha=0.15, color='green', label='IF Band')
ax.axhline(-10, color='orange', linestyle='--', alpha=0.5, label='-10 dB')
ax.set_xlabel('Frequency (MHz)')
ax.set_ylabel('|Sdd11| (dB)')
ax.set_title('Anti-Alias Filter — Differential Return Loss')
ax.set_xlim([0, 1000])
ax.set_ylim([-40, 0])
ax.grid(True, alpha=0.3)
ax.legend()

ax = axes[2]
phase_Sdd21 = np.unwrap(np.angle(Sdd21))
group_delay = -np.diff(phase_Sdd21) / np.diff(2 * np.pi * freq) * 1e9
ax.plot(freq[1:] / 1e6, group_delay, 'g-', linewidth=2, label='Group Delay')
ax.axvspan(f_IF_low / 1e6, f_IF_high / 1e6, alpha=0.15, color='green', label='IF Band')
ax.set_xlabel('Frequency (MHz)')
ax.set_ylabel('Group Delay (ns)')
ax.set_title('Anti-Alias Filter — Group Delay')
ax.set_xlim([0, 500])
ax.grid(True, alpha=0.3)
ax.legend()

plt.tight_layout()
plot_file = os.path.join(sim_path, 'aaf_filter_response.png')
plt.savefig(plot_file, dpi=150)

idx_120 = np.argmin(np.abs(freq - f_IF_low))
idx_150 = np.argmin(np.abs(freq - f_center))
idx_180 = np.argmin(np.abs(freq - f_IF_high))
idx_200 = np.argmin(np.abs(freq - 200e6))
idx_400 = np.argmin(np.abs(freq - 400e6))


csv_file = os.path.join(sim_path, 'aaf_sparams.csv')
np.savetxt(
    csv_file,
    np.column_stack([freq / 1e6, Sdd21_dB, Sdd11_dB, 20 * np.log10(np.abs(Scd21) + 1e-15)]),
    header='Freq_MHz, Sdd21_dB, Sdd11_dB, Scd21_dB',
    delimiter=',', fmt='%.6f'
)
