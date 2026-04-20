"""
v7.software_fpga — Bit-accurate software replica of the AERIS-10 FPGA signal chain.

Imports processing functions directly from golden_reference.py (Option A)
to avoid code duplication.  Every stage is toggleable via the same host
register interface the real FPGA exposes, so the dashboard spinboxes can
drive either backend transparently.

Signal chain order (matching RTL):
    quantize → range_fft → decimator → MTI → doppler_fft → dc_notch → CFAR → RadarFrame

Usage:
    fpga = SoftwareFPGA()
    fpga.set_cfar_enable(True)
    frame = fpga.process_chirps(iq_i, iq_q, frame_number=0)
"""

from __future__ import annotations

import logging
import os
import sys
from pathlib import Path

import numpy as np

# ---------------------------------------------------------------------------
# Import golden_reference by adding the cosim path to sys.path
# ---------------------------------------------------------------------------
_GOLDEN_REF_DIR = str(
    Path(__file__).resolve().parents[2]  # 9_Firmware/
    / "9_2_FPGA" / "tb" / "cosim" / "real_data"
)
if _GOLDEN_REF_DIR not in sys.path:
    sys.path.insert(0, _GOLDEN_REF_DIR)

from golden_reference import (  # noqa: E402
    run_range_fft,
    run_range_bin_decimator,
    run_mti_canceller,
    run_doppler_fft,
    run_dc_notch,
    run_cfar_ca,
    run_detection,
    FFT_SIZE,
    DOPPLER_CHIRPS,
)

# RadarFrame lives in radar_protocol (no circular dep — protocol has no GUI)
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from radar_protocol import RadarFrame  # noqa: E402

log = logging.getLogger(__name__)

# ---------------------------------------------------------------------------
# Twiddle factor file paths (relative to FPGA root)
# ---------------------------------------------------------------------------
_FPGA_DIR = Path(__file__).resolve().parents[2] / "9_2_FPGA"
TWIDDLE_1024 = str(_FPGA_DIR / "fft_twiddle_1024.mem")
TWIDDLE_16 = str(_FPGA_DIR / "fft_twiddle_16.mem")

# CFAR mode int→string mapping (FPGA register 0x24: 0=CA, 1=GO, 2=SO)
_CFAR_MODE_MAP = {0: "CA", 1: "GO", 2: "SO", 3: "CA"}


class SoftwareFPGA:
    """Bit-accurate replica of the AERIS-10 FPGA signal processing chain.

    All registers mirror FPGA reset defaults from ``radar_system_top.v``.
    Setters accept the same integer values as the FPGA host commands.
    """

    def __init__(self) -> None:
        # --- FPGA register mirror (reset defaults) ---
        # Detection
        self.detect_threshold: int = 10_000   # 0x03
        self.gain_shift: int = 0              # 0x16

        # CFAR
        self.cfar_enable: bool = False         # 0x25
        self.cfar_guard: int = 2               # 0x21
        self.cfar_train: int = 8               # 0x22
        self.cfar_alpha: int = 0x30            # 0x23  Q4.4
        self.cfar_mode: int = 0                # 0x24  0=CA,1=GO,2=SO

        # MTI
        self.mti_enable: bool = False          # 0x26

        # DC notch
        self.dc_notch_width: int = 0           # 0x27

        # AGC (tracked but not applied in software chain — AGC operates
        # on the analog front-end gain, which doesn't exist in replay)
        self.agc_enable: bool = False          # 0x28
        self.agc_target: int = 200             # 0x29
        self.agc_attack: int = 1               # 0x2A
        self.agc_decay: int = 1                # 0x2B
        self.agc_holdoff: int = 4              # 0x2C

    # ------------------------------------------------------------------
    # Register setters (same interface as UART commands to real FPGA)
    # ------------------------------------------------------------------
    def set_detect_threshold(self, val: int) -> None:
        self.detect_threshold = int(val) & 0xFFFF

    def set_gain_shift(self, val: int) -> None:
        self.gain_shift = int(val) & 0x0F

    def set_cfar_enable(self, val: bool) -> None:
        self.cfar_enable = bool(val)

    def set_cfar_guard(self, val: int) -> None:
        self.cfar_guard = int(val) & 0x0F

    def set_cfar_train(self, val: int) -> None:
        self.cfar_train = max(1, int(val) & 0x1F)

    def set_cfar_alpha(self, val: int) -> None:
        self.cfar_alpha = int(val) & 0xFF

    def set_cfar_mode(self, val: int) -> None:
        self.cfar_mode = int(val) & 0x03

    def set_mti_enable(self, val: bool) -> None:
        self.mti_enable = bool(val)

    def set_dc_notch_width(self, val: int) -> None:
        self.dc_notch_width = int(val) & 0x07

    def set_agc_enable(self, val: bool) -> None:
        self.agc_enable = bool(val)

    def set_agc_params(
        self,
        target: int | None = None,
        attack: int | None = None,
        decay: int | None = None,
        holdoff: int | None = None,
    ) -> None:
        if target is not None:
            self.agc_target = int(target) & 0xFF
        if attack is not None:
            self.agc_attack = int(attack) & 0x0F
        if decay is not None:
            self.agc_decay = int(decay) & 0x0F
        if holdoff is not None:
            self.agc_holdoff = int(holdoff) & 0x0F

    # ------------------------------------------------------------------
    # Core processing: raw IQ chirps → RadarFrame
    # ------------------------------------------------------------------
    def process_chirps(
        self,
        iq_i: np.ndarray,
        iq_q: np.ndarray,
        frame_number: int = 0,
        timestamp: float = 0.0,
    ) -> RadarFrame:
        """Run the full FPGA signal chain on pre-quantized 16-bit I/Q chirps.

        Parameters
        ----------
        iq_i, iq_q : ndarray, shape (n_chirps, n_samples), int16/int64
            Post-DDC I/Q samples.  For ADI phaser data, use
            ``quantize_raw_iq()`` first.
        frame_number : int
            Frame counter for the output RadarFrame.
        timestamp : float
            Timestamp for the output RadarFrame.

        Returns
        -------
        RadarFrame
            Populated frame identical to what the real FPGA would produce.
        """
        n_chirps = iq_i.shape[0]
        n_samples = iq_i.shape[1]

        # --- Stage 1: Range FFT (per chirp) ---
        range_i = np.zeros((n_chirps, n_samples), dtype=np.int64)
        range_q = np.zeros((n_chirps, n_samples), dtype=np.int64)
        twiddle_1024 = TWIDDLE_1024 if os.path.exists(TWIDDLE_1024) else None
        for c in range(n_chirps):
            range_i[c], range_q[c] = run_range_fft(
                iq_i[c].astype(np.int64),
                iq_q[c].astype(np.int64),
                twiddle_file=twiddle_1024,
            )

        # --- Stage 2: Range bin decimation (1024 → 64) ---
        decim_i, decim_q = run_range_bin_decimator(range_i, range_q)

        # --- Stage 3: MTI canceller (pre-Doppler, per-chirp) ---
        mti_i, mti_q = run_mti_canceller(decim_i, decim_q, enable=self.mti_enable)

        # --- Stage 4: Doppler FFT (dual 16-pt Hamming) ---
        twiddle_16 = TWIDDLE_16 if os.path.exists(TWIDDLE_16) else None
        doppler_i, doppler_q = run_doppler_fft(mti_i, mti_q, twiddle_file_16=twiddle_16)

        # --- Stage 5: DC notch (bin zeroing) ---
        notch_i, notch_q = run_dc_notch(doppler_i, doppler_q, width=self.dc_notch_width)

        # --- Stage 6: Detection ---
        if self.cfar_enable:
            mode_str = _CFAR_MODE_MAP.get(self.cfar_mode, "CA")
            detect_flags, magnitudes, _thresholds = run_cfar_ca(
                notch_i,
                notch_q,
                guard=self.cfar_guard,
                train=self.cfar_train,
                alpha_q44=self.cfar_alpha,
                mode=mode_str,
            )
            det_mask = detect_flags.astype(np.uint8)
            mag = magnitudes.astype(np.float64)
        else:
            mag_raw, det_indices = run_detection(
                notch_i, notch_q, threshold=self.detect_threshold
            )
            mag = mag_raw.astype(np.float64)
            det_mask = np.zeros_like(mag, dtype=np.uint8)
            for idx in det_indices:
                det_mask[idx[0], idx[1]] = 1

        # --- Assemble RadarFrame ---
        frame = RadarFrame()
        frame.timestamp = timestamp
        frame.frame_number = frame_number
        frame.range_doppler_i = np.clip(notch_i, -32768, 32767).astype(np.int16)
        frame.range_doppler_q = np.clip(notch_q, -32768, 32767).astype(np.int16)
        frame.magnitude = mag
        frame.detections = det_mask
        frame.range_profile = np.sqrt(
            notch_i[:, 0].astype(np.float64) ** 2
            + notch_q[:, 0].astype(np.float64) ** 2
        )
        frame.detection_count = int(det_mask.sum())
        return frame


# ---------------------------------------------------------------------------
# Utility: quantize arbitrary complex IQ to 16-bit post-DDC format
# ---------------------------------------------------------------------------
def quantize_raw_iq(
    raw_complex: np.ndarray,
    n_chirps: int = DOPPLER_CHIRPS,
    n_samples: int = FFT_SIZE,
    peak_target: int = 200,
) -> tuple[np.ndarray, np.ndarray]:
    """Quantize complex IQ data to 16-bit signed, matching DDC output level.

    Parameters
    ----------
    raw_complex : ndarray, shape (chirps, samples) or (frames, chirps, samples)
        Complex64/128 baseband IQ from SDR capture.  If 3-D, the first
        axis is treated as frame index and only the first frame is used.
    n_chirps : int
        Number of chirps to keep (default 32, matching FPGA).
    n_samples : int
        Number of samples per chirp to keep (default 1024, matching FFT).
    peak_target : int
        Target peak magnitude after scaling (default 200, matching
        golden_reference INPUT_PEAK_TARGET).

    Returns
    -------
    iq_i, iq_q : ndarray, each (n_chirps, n_samples) int64
    """
    if raw_complex.ndim == 3:
        # (frames, chirps, samples) — take first frame
        raw_complex = raw_complex[0]

    # Truncate to FPGA dimensions
    block = raw_complex[:n_chirps, :n_samples]

    max_abs = np.max(np.abs(block))
    if max_abs == 0:
        return (
            np.zeros((n_chirps, n_samples), dtype=np.int64),
            np.zeros((n_chirps, n_samples), dtype=np.int64),
        )

    scale = peak_target / max_abs
    scaled = block * scale
    iq_i = np.clip(np.round(np.real(scaled)).astype(np.int64), -32768, 32767)
    iq_q = np.clip(np.round(np.imag(scaled)).astype(np.int64), -32768, 32767)
    return iq_i, iq_q
