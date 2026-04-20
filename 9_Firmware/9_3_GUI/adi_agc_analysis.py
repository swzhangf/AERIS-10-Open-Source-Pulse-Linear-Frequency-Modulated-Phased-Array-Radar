# ruff: noqa: T201
#!/usr/bin/env python3
"""
One-off AGC saturation analysis for ADI CN0566 raw IQ captures.

Bit-accurate simulation of rx_gain_control.v AGC inner loop applied
to real captured IQ data.  Three scenarios per dataset:

  Row 1 — AGC OFF:  Fixed gain_shift=0 (pass-through).  Shows raw clipping.
  Row 2 — AGC ON:   Auto-adjusts from gain_shift=0.  Clipping clears.
  Row 3 — AGC delayed: OFF for first half, ON at midpoint.
           Shows the transition: clipping → AGC activates → clears.

Key RTL details modelled exactly:
  - gain_shift[3]=direction (0=amplify/left, 1=attenuate/right), [2:0]=amount
  - Internal agc_gain is signed -7..+7
  - Peak is measured PRE-gain (raw input |sample|, upper 8 of 15 bits)
  - Saturation is measured POST-gain (overflow from shift)
  - Attack: gain -= agc_attack when any sample clips (immediate)
  - Decay: gain += agc_decay when peak < target AND holdoff expired
  - Hold: when peak >= target AND no saturation, hold gain, reset holdoff

Usage:
  python adi_agc_analysis.py
  python adi_agc_analysis.py --data /path/to/file.npy --label "my capture"
"""

import argparse
import sys
from pathlib import Path

import matplotlib.pyplot as plt
import numpy as np

from v7.agc_sim import (
    encoding_to_signed,
    apply_gain_shift,
    quantize_iq,
    AGCConfig,
    AGCState,
    process_agc_frame,
)

# ---------------------------------------------------------------------------
# FPGA AGC parameters (rx_gain_control.v reset defaults)
# ---------------------------------------------------------------------------
AGC_TARGET = 200       # host_agc_target (8-bit, default 200)
ADC_RAIL = 4095        # 12-bit ADC max absolute value


# ---------------------------------------------------------------------------
# Per-frame AGC simulation using v7.agc_sim (bit-accurate to RTL)
# ---------------------------------------------------------------------------

def simulate_agc(frames: np.ndarray, agc_enabled: bool = True,
                 enable_at_frame: int = 0,
                 initial_gain_enc: int = 0x00) -> dict:
    """Simulate FPGA inner-loop AGC across all frames.

    Parameters
    ----------
    frames : (N, chirps, samples) complex — raw ADC captures (12-bit range)
    agc_enabled : if False, gain stays fixed
    enable_at_frame : frame index where AGC activates
    initial_gain_enc : gain_shift[3:0] encoding when AGC enables (default 0x00 = pass-through)
    """
    n_frames = frames.shape[0]

    # Output arrays
    out_gain_enc = np.zeros(n_frames, dtype=int)
    out_gain_signed = np.zeros(n_frames, dtype=int)
    out_peak_mag = np.zeros(n_frames, dtype=int)
    out_sat_count = np.zeros(n_frames, dtype=int)
    out_sat_rate = np.zeros(n_frames, dtype=float)
    out_rms_post = np.zeros(n_frames, dtype=float)

    # AGC state — managed by process_agc_frame()
    state = AGCState(
        gain=encoding_to_signed(initial_gain_enc),
        holdoff_counter=0,
        was_enabled=False,
    )

    for i in range(n_frames):
        frame_i, frame_q = quantize_iq(frames[i])

        agc_active = agc_enabled and (i >= enable_at_frame)

        # Build per-frame config (enable toggles at enable_at_frame)
        config = AGCConfig(enabled=agc_active)

        result = process_agc_frame(frame_i, frame_q, config, state)

        # RMS of shifted signal
        rms = float(np.sqrt(np.mean(
            result.shifted_i.astype(np.float64)**2
            + result.shifted_q.astype(np.float64)**2)))

        total_samples = frame_i.size + frame_q.size
        sat_rate = result.overflow_raw / total_samples if total_samples > 0 else 0.0

        # Record outputs
        out_gain_enc[i] = result.gain_enc
        out_gain_signed[i] = result.gain_signed
        out_peak_mag[i] = result.peak_mag_8bit
        out_sat_count[i] = result.saturation_count
        out_sat_rate[i] = sat_rate
        out_rms_post[i] = rms

    return {
        "gain_enc": out_gain_enc,
        "gain_signed": out_gain_signed,
        "peak_mag": out_peak_mag,
        "sat_count": out_sat_count,
        "sat_rate": out_sat_rate,
        "rms_post": out_rms_post,
    }


# ---------------------------------------------------------------------------
# Range-Doppler processing for heatmap display
# ---------------------------------------------------------------------------

def process_frame_rd(frame: np.ndarray, gain_enc: int,
                     n_range: int = 64,
                     n_doppler: int = 32) -> np.ndarray:
    """Range-Doppler magnitude for one frame with gain applied."""
    frame_i, frame_q = quantize_iq(frame)
    si, sq, _ = apply_gain_shift(frame_i, frame_q, gain_enc)

    iq = si.astype(np.float64) + 1j * sq.astype(np.float64)
    n_chirps, _ = iq.shape

    range_fft = np.fft.fft(iq, axis=1)[:, :n_range]
    doppler_fft = np.fft.fftshift(np.fft.fft(range_fft, axis=0), axes=0)
    center = n_chirps // 2
    half_d = n_doppler // 2
    doppler_fft = doppler_fft[center - half_d:center + half_d, :]

    rd_mag = np.abs(doppler_fft.real) + np.abs(doppler_fft.imag)
    return rd_mag.T  # (n_range, n_doppler)


# ---------------------------------------------------------------------------
# Plotting
# ---------------------------------------------------------------------------

def plot_scenario(axes, data: np.ndarray, agc: dict, title: str,
                  enable_frame: int = 0):
    """Plot one AGC scenario across 5 axes."""
    n = data.shape[0]
    xs = np.arange(n)

    # Range-Doppler heatmap
    if enable_frame > 0 and enable_frame < n:
        f_before = max(0, enable_frame - 1)
        f_after = min(n - 1, n - 2)
        rd_before = process_frame_rd(data[f_before], int(agc["gain_enc"][f_before]))
        rd_after = process_frame_rd(data[f_after], int(agc["gain_enc"][f_after]))
        combined = np.hstack([rd_before, rd_after])
        im = axes[0].imshow(
            20 * np.log10(combined + 1), aspect="auto", origin="lower",
            cmap="inferno", interpolation="nearest")
        axes[0].axvline(x=rd_before.shape[1] - 0.5, color="cyan",
                        linewidth=2, linestyle="--")
        axes[0].set_title(f"{title}\nL: f{f_before} (pre) | R: f{f_after} (post)")
    else:
        worst = int(np.argmax(agc["sat_count"]))
        best = int(np.argmin(agc["sat_count"]))
        f_show = worst if agc["sat_count"][worst] > 0 else best
        rd = process_frame_rd(data[f_show], int(agc["gain_enc"][f_show]))
        im = axes[0].imshow(
            20 * np.log10(rd + 1), aspect="auto", origin="lower",
            cmap="inferno", interpolation="nearest")
        axes[0].set_title(f"{title}\nFrame {f_show}")

    axes[0].set_xlabel("Doppler bin")
    axes[0].set_ylabel("Range bin")
    plt.colorbar(im, ax=axes[0], label="dB", shrink=0.8)

    # Signed gain history (the real AGC state)
    axes[1].plot(xs, agc["gain_signed"], color="#00ff88", linewidth=1.5)
    axes[1].axhline(y=0, color="gray", linestyle=":", alpha=0.5,
                    label="Pass-through")
    if enable_frame > 0:
        axes[1].axvline(x=enable_frame, color="yellow", linewidth=2,
                        linestyle="--", label="AGC ON")
    axes[1].set_ylim(-8, 8)
    axes[1].set_ylabel("Gain (signed)")
    axes[1].set_title("AGC Internal Gain (-7=max atten, +7=max amp)")
    axes[1].legend(fontsize=7, loc="upper right")
    axes[1].grid(True, alpha=0.3)

    # Peak magnitude (PRE-gain, 8-bit)
    axes[2].plot(xs, agc["peak_mag"], color="#ffaa00", linewidth=1.0)
    axes[2].axhline(y=AGC_TARGET, color="cyan", linestyle="--",
                    alpha=0.7, label=f"Target ({AGC_TARGET})")
    axes[2].axhspan(240, 255, color="red", alpha=0.15, label="Clip zone")
    if enable_frame > 0:
        axes[2].axvline(x=enable_frame, color="yellow", linewidth=2,
                        linestyle="--", alpha=0.8)
    axes[2].set_ylim(0, 260)
    axes[2].set_ylabel("Peak (8-bit)")
    axes[2].set_title("Peak Magnitude (pre-gain, raw input)")
    axes[2].legend(fontsize=7, loc="upper right")
    axes[2].grid(True, alpha=0.3)

    # Saturation count (POST-gain overflow)
    axes[3].fill_between(xs, agc["sat_count"], color="red", alpha=0.4)
    axes[3].plot(xs, agc["sat_count"], color="red", linewidth=0.8)
    if enable_frame > 0:
        axes[3].axvline(x=enable_frame, color="yellow", linewidth=2,
                        linestyle="--", alpha=0.8)
    axes[3].set_ylabel("Overflow Count")
    total = int(agc["sat_count"].sum())
    axes[3].set_title(f"Post-Gain Overflow (total={total})")
    axes[3].grid(True, alpha=0.3)

    # RMS signal level (post-gain)
    axes[4].plot(xs, agc["rms_post"], color="#44aaff", linewidth=1.0)
    if enable_frame > 0:
        axes[4].axvline(x=enable_frame, color="yellow", linewidth=2,
                        linestyle="--", alpha=0.8)
    axes[4].set_ylabel("RMS")
    axes[4].set_xlabel("Frame")
    axes[4].set_title("Post-Gain RMS Level")
    axes[4].grid(True, alpha=0.3)


def analyze_dataset(data: np.ndarray, label: str):
    """Run 3-scenario analysis for one dataset."""
    n_frames = data.shape[0]
    mid = n_frames // 2

    print(f"\n{'='*60}")
    print(f"  {label}  —  shape {data.shape}")
    print(f"{'='*60}")

    # Raw ADC stats
    raw_sat = np.sum((np.abs(data.real) >= ADC_RAIL) |
                     (np.abs(data.imag) >= ADC_RAIL))
    print(f"  Raw ADC saturation: {raw_sat} samples "
          f"({100*raw_sat/(2*data.size):.2f}%)")

    # Scenario 1: AGC OFF — pass-through (gain_shift=0x00)
    print("  [1/3] AGC OFF (gain=0, pass-through) ...")
    agc_off = simulate_agc(data, agc_enabled=False, initial_gain_enc=0x00)
    print(f"        Post-gain overflow: {agc_off['sat_count'].sum()} "
          f"(should be 0 — no amplification)")

    # Scenario 2: AGC ON from frame 0
    print("  [2/3] AGC ON (from start) ...")
    agc_on = simulate_agc(data, agc_enabled=True, enable_at_frame=0,
                          initial_gain_enc=0x00)
    print(f"        Final gain: {agc_on['gain_signed'][-1]} "
          f"(enc=0x{agc_on['gain_enc'][-1]:X})")
    print(f"        Post-gain overflow: {agc_on['sat_count'].sum()}")

    # Scenario 3: AGC delayed
    print(f"  [3/3] AGC delayed (ON at frame {mid}) ...")
    agc_delayed = simulate_agc(data, agc_enabled=True,
                               enable_at_frame=mid,
                               initial_gain_enc=0x00)
    pre_sat = int(agc_delayed["sat_count"][:mid].sum())
    post_sat = int(agc_delayed["sat_count"][mid:].sum())
    print(f"        Pre-AGC overflow: {pre_sat}  "
          f"Post-AGC overflow: {post_sat}")

    # Plot
    fig, axes = plt.subplots(3, 5, figsize=(28, 14))
    fig.suptitle(f"AERIS-10 AGC Analysis — {label}\n"
                 f"({n_frames} frames, {data.shape[1]} chirps, "
                 f"{data.shape[2]} samples/chirp, "
                 f"raw ADC sat={100*raw_sat/(2*data.size):.2f}%)",
                 fontsize=13, fontweight="bold", y=0.99)

    plot_scenario(axes[0], data, agc_off, "AGC OFF (pass-through)")
    plot_scenario(axes[1], data, agc_on, "AGC ON (from start)")
    plot_scenario(axes[2], data, agc_delayed,
                  f"AGC delayed (ON at frame {mid})", enable_frame=mid)

    for ax, lbl in zip(axes[:, 0],
                       ["AGC OFF", "AGC ON", "AGC DELAYED"],
                       strict=True):
        ax.annotate(lbl, xy=(-0.35, 0.5), xycoords="axes fraction",
                    fontsize=13, fontweight="bold", color="white",
                    ha="center", va="center", rotation=90)

    plt.tight_layout(rect=[0.03, 0, 1, 0.95])
    return fig


def main():
    parser = argparse.ArgumentParser(
        description="AGC analysis for ADI raw IQ captures "
                    "(bit-accurate rx_gain_control.v simulation)")
    parser.add_argument("--amp", type=str,
                        default=str(Path.home() / "Downloads/adi_radar_data"
                                    "/amp_radar"
                                    "/phaser_amp_4MSPS_500M_300u_256_m3dB.npy"),
                        help="Path to amplified radar .npy")
    parser.add_argument("--noamp", type=str,
                        default=str(Path.home() / "Downloads/adi_radar_data"
                                    "/no_amp_radar"
                                    "/phaser_NOamp_4MSPS_500M_300u_256.npy"),
                        help="Path to non-amplified radar .npy")
    parser.add_argument("--data", type=str, default=None,
                        help="Single dataset mode")
    parser.add_argument("--label", type=str, default="Custom Data")
    args = parser.parse_args()

    plt.style.use("dark_background")

    if args.data:
        data = np.load(args.data)
        analyze_dataset(data, args.label)
        plt.show()
        return

    figs = []
    for path, label in [(args.amp, "With Amplifier (-3 dB)"),
                        (args.noamp, "No Amplifier")]:
        if not Path(path).exists():
            print(f"WARNING: {path} not found, skipping")
            continue
        data = np.load(path)
        fig = analyze_dataset(data, label)
        figs.append(fig)

    if not figs:
        print("No data found. Use --amp/--noamp or --data.")
        sys.exit(1)

    plt.show()


if __name__ == "__main__":
    main()
