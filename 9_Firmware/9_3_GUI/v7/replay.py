"""
v7.replay — ReplayEngine: auto-detect format, load, and iterate RadarFrames.

Supports three data sources:
  1. **FPGA co-sim directory** — pre-computed ``.npy`` files from golden_reference
  2. **Raw IQ cube** ``.npy`` — complex baseband capture (e.g. ADI Phaser)
  3. **HDF5 recording** ``.h5`` — frames captured by ``DataRecorder``

For raw IQ data the engine uses :class:`SoftwareFPGA` to run the full
bit-accurate signal chain, so changing FPGA control registers in the
dashboard re-processes the data.
"""

from __future__ import annotations

import logging
import time
from enum import Enum, auto
from pathlib import Path
from typing import TYPE_CHECKING

import numpy as np

if TYPE_CHECKING:
    from .software_fpga import SoftwareFPGA

# radar_protocol is a sibling module (not inside v7/)
import sys as _sys

_GUI_DIR = str(Path(__file__).resolve().parent.parent)
if _GUI_DIR not in _sys.path:
    _sys.path.insert(0, _GUI_DIR)
from radar_protocol import RadarFrame  # noqa: E402

log = logging.getLogger(__name__)

# Lazy import — h5py is optional
try:
    import h5py

    HDF5_AVAILABLE = True
except ImportError:
    HDF5_AVAILABLE = False


class ReplayFormat(Enum):
    """Detected input format."""

    COSIM_DIR = auto()
    RAW_IQ_NPY = auto()
    HDF5 = auto()


# ───────────────────────────────────────────────────────────────────
# Format detection
# ───────────────────────────────────────────────────────────────────

_COSIM_REQUIRED = {"doppler_map_i.npy", "doppler_map_q.npy"}


def detect_format(path: str) -> ReplayFormat:
    """Auto-detect the replay data format from *path*.

    Raises
    ------
    ValueError
        If the format cannot be determined.
    """
    p = Path(path)

    if p.is_dir():
        children = {f.name for f in p.iterdir()}
        if _COSIM_REQUIRED.issubset(children):
            return ReplayFormat.COSIM_DIR
        msg = f"Directory {p} does not contain required co-sim files: {_COSIM_REQUIRED - children}"
        raise ValueError(msg)

    if p.suffix == ".h5":
        return ReplayFormat.HDF5

    if p.suffix == ".npy":
        return ReplayFormat.RAW_IQ_NPY

    msg = f"Cannot determine replay format for: {p}"
    raise ValueError(msg)


# ───────────────────────────────────────────────────────────────────
# ReplayEngine
# ───────────────────────────────────────────────────────────────────

class ReplayEngine:
    """Load replay data and serve RadarFrames on demand.

    Parameters
    ----------
    path : str
        File or directory path to load.
    software_fpga : SoftwareFPGA | None
        Required only for ``RAW_IQ_NPY`` format.  For other formats the
        data is already processed and the FPGA instance is ignored.
    """

    def __init__(self, path: str, software_fpga: SoftwareFPGA | None = None) -> None:
        self.path = path
        self.fmt = detect_format(path)
        self.software_fpga = software_fpga

        # Populated by _load_*
        self._total_frames: int = 0
        self._raw_iq: np.ndarray | None = None   # for RAW_IQ_NPY
        self._h5_file = None
        self._h5_keys: list[str] = []
        self._cosim_frame = None  # single RadarFrame for co-sim

        self._load()

    # ------------------------------------------------------------------
    # Loading
    # ------------------------------------------------------------------

    def _load(self) -> None:
        if self.fmt is ReplayFormat.COSIM_DIR:
            self._load_cosim()
        elif self.fmt is ReplayFormat.RAW_IQ_NPY:
            self._load_raw_iq()
        elif self.fmt is ReplayFormat.HDF5:
            self._load_hdf5()

    def _load_cosim(self) -> None:
        """Load FPGA co-sim directory (already-processed .npy arrays).

        Prefers fullchain (MTI-enabled) files when CFAR outputs are present,
        so that I/Q data is consistent with the detection mask.  Falls back
        to the non-MTI ``doppler_map`` files when fullchain data is absent.
        """
        d = Path(self.path)

        # CFAR outputs (from the MTI→Doppler→DC-notch→CFAR chain)
        cfar_flags = d / "fullchain_cfar_flags.npy"
        cfar_mag = d / "fullchain_cfar_mag.npy"
        has_cfar = cfar_flags.exists() and cfar_mag.exists()

        # MTI-consistent I/Q (same chain that produced CFAR outputs)
        mti_dop_i = d / "fullchain_mti_doppler_i.npy"
        mti_dop_q = d / "fullchain_mti_doppler_q.npy"
        has_mti_doppler = mti_dop_i.exists() and mti_dop_q.exists()

        # Choose I/Q: prefer MTI-chain when CFAR data comes from that chain
        if has_cfar and has_mti_doppler:
            dop_i = np.load(mti_dop_i).astype(np.int16)
            dop_q = np.load(mti_dop_q).astype(np.int16)
            log.info("Co-sim: using fullchain MTI+Doppler I/Q (matches CFAR chain)")
        else:
            dop_i = np.load(d / "doppler_map_i.npy").astype(np.int16)
            dop_q = np.load(d / "doppler_map_q.npy").astype(np.int16)
            log.info("Co-sim: using non-MTI doppler_map I/Q")

        frame = RadarFrame()
        frame.range_doppler_i = dop_i
        frame.range_doppler_q = dop_q

        if has_cfar:
            frame.detections = np.load(cfar_flags).astype(np.uint8)
            frame.magnitude = np.load(cfar_mag).astype(np.float64)
        else:
            frame.magnitude = np.sqrt(
                dop_i.astype(np.float64) ** 2 + dop_q.astype(np.float64) ** 2
            )
            frame.detections = np.zeros_like(dop_i, dtype=np.uint8)

        frame.range_profile = frame.magnitude[:, 0]
        frame.detection_count = int(frame.detections.sum())
        frame.frame_number = 0
        frame.timestamp = time.time()

        self._cosim_frame = frame
        self._total_frames = 1
        log.info("Loaded co-sim directory: %s (1 frame)", self.path)

    def _load_raw_iq(self) -> None:
        """Load raw complex IQ cube (.npy)."""
        data = np.load(self.path, mmap_mode="r")
        if data.ndim == 2:
            # (chirps, samples) — single frame
            data = data[np.newaxis, ...]
        if data.ndim != 3:
            msg = f"Expected 3-D array (frames, chirps, samples), got shape {data.shape}"
            raise ValueError(msg)
        self._raw_iq = data
        self._total_frames = data.shape[0]
        log.info(
            "Loaded raw IQ: %s, shape %s (%d frames)",
            self.path,
            data.shape,
            self._total_frames,
        )

    def _load_hdf5(self) -> None:
        """Load HDF5 recording (.h5)."""
        if not HDF5_AVAILABLE:
            msg = "h5py is required to load HDF5 recordings"
            raise ImportError(msg)
        self._h5_file = h5py.File(self.path, "r")
        frames_grp = self._h5_file.get("frames")
        if frames_grp is None:
            msg = f"HDF5 file {self.path} has no 'frames' group"
            raise ValueError(msg)
        self._h5_keys = sorted(frames_grp.keys())
        self._total_frames = len(self._h5_keys)
        log.info("Loaded HDF5: %s (%d frames)", self.path, self._total_frames)

    # ------------------------------------------------------------------
    # Public API
    # ------------------------------------------------------------------

    @property
    def total_frames(self) -> int:
        return self._total_frames

    def get_frame(self, index: int) -> RadarFrame:
        """Return the RadarFrame at *index* (0-based).

        For ``RAW_IQ_NPY`` format, this runs the SoftwareFPGA chain
        on the requested frame's chirps.
        """
        if index < 0 or index >= self._total_frames:
            msg = f"Frame index {index} out of range [0, {self._total_frames})"
            raise IndexError(msg)

        if self.fmt is ReplayFormat.COSIM_DIR:
            return self._get_cosim(index)
        if self.fmt is ReplayFormat.RAW_IQ_NPY:
            return self._get_raw_iq(index)
        return self._get_hdf5(index)

    def close(self) -> None:
        """Release any open file handles."""
        if self._h5_file is not None:
            self._h5_file.close()
            self._h5_file = None

    # ------------------------------------------------------------------
    # Per-format frame getters
    # ------------------------------------------------------------------

    def _get_cosim(self, _index: int) -> RadarFrame:
        """Co-sim: single static frame (index ignored).

        Uses deepcopy so numpy arrays are not shared with the source,
        preventing in-place mutation from corrupting cached data.
        """
        import copy
        frame = copy.deepcopy(self._cosim_frame)
        frame.timestamp = time.time()
        return frame

    def _get_raw_iq(self, index: int) -> RadarFrame:
        """Raw IQ: quantize one frame and run through SoftwareFPGA."""
        if self.software_fpga is None:
            msg = "SoftwareFPGA is required for raw IQ replay"
            raise RuntimeError(msg)

        from .software_fpga import quantize_raw_iq

        raw = self._raw_iq[index]  # (chirps, samples) complex
        iq_i, iq_q = quantize_raw_iq(raw[np.newaxis, ...])
        return self.software_fpga.process_chirps(
            iq_i, iq_q, frame_number=index, timestamp=time.time()
        )

    def _get_hdf5(self, index: int) -> RadarFrame:
        """HDF5: reconstruct RadarFrame from stored datasets."""
        key = self._h5_keys[index]
        grp = self._h5_file["frames"][key]

        frame = RadarFrame()
        frame.timestamp = float(grp.attrs.get("timestamp", time.time()))
        frame.frame_number = int(grp.attrs.get("frame_number", index))
        frame.detection_count = int(grp.attrs.get("detection_count", 0))

        frame.range_doppler_i = np.array(grp["range_doppler_i"], dtype=np.int16)
        frame.range_doppler_q = np.array(grp["range_doppler_q"], dtype=np.int16)
        frame.magnitude = np.array(grp["magnitude"], dtype=np.float64)
        frame.detections = np.array(grp["detections"], dtype=np.uint8)
        frame.range_profile = np.array(grp["range_profile"], dtype=np.float64)

        return frame
