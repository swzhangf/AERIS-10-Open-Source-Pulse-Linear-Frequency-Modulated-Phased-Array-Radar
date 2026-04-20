"""
v7.models — Data classes, enums, and theme constants for the PLFM Radar GUI V7.

This module defines the core data structures used throughout the application:
  - RadarTarget, RadarSettings, GPSData (dataclasses)
  - TileServer (enum for map tile providers)
  - Dark theme color constants
  - Optional dependency availability flags
"""

import logging
from dataclasses import dataclass, asdict
from enum import Enum


# ---------------------------------------------------------------------------
# Optional dependency flags (graceful degradation)
# ---------------------------------------------------------------------------
try:
    import usb.core
    import usb.util  # noqa: F401 — availability check
    USB_AVAILABLE = True
except ImportError:
    USB_AVAILABLE = False
    logging.warning("pyusb not available. USB functionality will be disabled.")

try:
    from pyftdi.ftdi import Ftdi  # noqa: F401 — availability check
    from pyftdi.usbtools import UsbTools  # noqa: F401 — availability check
    from pyftdi.ftdi import FtdiError  # noqa: F401 — availability check
    FTDI_AVAILABLE = True
except ImportError:
    FTDI_AVAILABLE = False
    logging.warning("pyftdi not available. FTDI functionality will be disabled.")

try:
    from scipy import signal as _scipy_signal  # noqa: F401 — availability check
    SCIPY_AVAILABLE = True
except ImportError:
    SCIPY_AVAILABLE = False
    logging.warning("scipy not available. Some DSP features will be disabled.")

try:
    from sklearn.cluster import DBSCAN as _DBSCAN  # noqa: F401 — availability check
    SKLEARN_AVAILABLE = True
except ImportError:
    SKLEARN_AVAILABLE = False
    logging.warning("sklearn not available. Clustering will be disabled.")

try:
    from filterpy.kalman import KalmanFilter as _KalmanFilter  # noqa: F401 — availability check
    FILTERPY_AVAILABLE = True
except ImportError:
    FILTERPY_AVAILABLE = False
    logging.warning("filterpy not available. Kalman tracking will be disabled.")

# ---------------------------------------------------------------------------
# Dark theme color constants (shared by all modules)
# ---------------------------------------------------------------------------
DARK_BG = "#2b2b2b"
DARK_FG = "#e0e0e0"
DARK_ACCENT = "#3c3f41"
DARK_HIGHLIGHT = "#4e5254"
DARK_BORDER = "#555555"
DARK_TEXT = "#cccccc"
DARK_BUTTON = "#3c3f41"
DARK_BUTTON_HOVER = "#4e5254"
DARK_TREEVIEW = "#3c3f41"
DARK_TREEVIEW_ALT = "#404040"
DARK_SUCCESS = "#4CAF50"
DARK_WARNING = "#FFC107"
DARK_ERROR = "#F44336"
DARK_INFO = "#2196F3"

# ---------------------------------------------------------------------------
# Data classes
# ---------------------------------------------------------------------------

@dataclass
class RadarTarget:
    """Represents a detected radar target."""
    id: int
    range: float           # Range in meters
    velocity: float        # Velocity in m/s (positive = approaching)
    azimuth: float         # Azimuth angle in degrees
    elevation: float       # Elevation angle in degrees
    latitude: float = 0.0
    longitude: float = 0.0
    snr: float = 0.0       # Signal-to-noise ratio in dB
    timestamp: float = 0.0
    track_id: int = -1
    classification: str = "unknown"

    def to_dict(self) -> dict:
        """Convert to dictionary for JSON serialization."""
        return asdict(self)


@dataclass
class RadarSettings:
    """Radar system display/map configuration.

    FPGA register parameters (chirp timing, CFAR, MTI, gain, etc.) are
    controlled directly via 4-byte opcode commands — see the FPGA Control
    tab and Opcode enum in radar_protocol.py.  This dataclass holds only
    host-side display/map settings and physical-unit conversion factors.

    range_resolution and velocity_resolution should be calibrated to
    the actual waveform parameters.
    """
    system_frequency: float = 10.5e9    # Hz (carrier, used for velocity calc)
    range_resolution: float = 24.0       # Meters per range bin (c/(2*Fs)*decim)
    velocity_resolution: float = 1.0     # m/s per Doppler bin (calibrate to waveform)
    max_distance: float = 1536           # Max detection range (m)
    map_size: float = 2000               # Map display size (m)
    coverage_radius: float = 1536        # Map coverage radius (m)


@dataclass
class GPSData:
    """GPS position and orientation data."""
    latitude: float
    longitude: float
    altitude: float
    pitch: float            # Pitch angle in degrees
    heading: float = 0.0    # Heading in degrees (0 = North)
    timestamp: float = 0.0

    def to_dict(self) -> dict:
        return asdict(self)


# ---------------------------------------------------------------------------
# Tile server enum
# ---------------------------------------------------------------------------

@dataclass
class ProcessingConfig:
    """Host-side signal processing pipeline configuration.

    These control host-side DSP that runs AFTER the FPGA processing
    pipeline.  FPGA-side MTI, CFAR, and DC notch are controlled via
    register opcodes from the FPGA Control tab.

    Controls: DBSCAN clustering, Kalman tracking, and optional
    host-side reprocessing (MTI, CFAR, windowing, DC notch).
    """

    # MTI (Moving Target Indication)
    mti_enabled: bool = False
    mti_order: int = 2                     # 1, 2, or 3

    # CFAR (Constant False Alarm Rate)
    cfar_enabled: bool = False
    cfar_type: str = "CA-CFAR"             # CA-CFAR, OS-CFAR, GO-CFAR, SO-CFAR
    cfar_guard_cells: int = 2
    cfar_training_cells: int = 8
    cfar_threshold_factor: float = 5.0     # PFA-related scalar

    # DC Notch / DC Removal
    dc_notch_enabled: bool = False

    # Windowing (applied before FFT)
    window_type: str = "Hann"              # None, Hann, Hamming, Blackman, Kaiser, Chebyshev

    # Detection threshold (dB above noise floor)
    detection_threshold_db: float = 12.0

    # DBSCAN Clustering
    clustering_enabled: bool = True
    clustering_eps: float = 100.0
    clustering_min_samples: int = 2

    # Kalman Tracking
    tracking_enabled: bool = True


# ---------------------------------------------------------------------------
# Tile server enum
# ---------------------------------------------------------------------------

class TileServer(Enum):
    """Available map tile servers."""
    OPENSTREETMAP = "osm"
    GOOGLE_MAPS = "google"
    GOOGLE_SATELLITE = "google_sat"
    GOOGLE_HYBRID = "google_hybrid"
    ESRI_SATELLITE = "esri_sat"


# ---------------------------------------------------------------------------
# Waveform configuration (physical parameters for bin→unit conversion)
# ---------------------------------------------------------------------------

@dataclass
class WaveformConfig:
    """Physical waveform parameters for converting bins to SI units.

    Encapsulates the radar waveform so that range/velocity resolution
    can be derived automatically instead of hardcoded in RadarSettings.

    Defaults match the AERIS-10 production system parameters from
    radar_scene.py / plfm_chirp_controller.v:
      100 MSPS DDC output, 20 MHz chirp BW, 30 us long chirp,
      167 us long-chirp PRI, X-band 10.5 GHz carrier.
    """

    sample_rate_hz: float = 100e6        # DDC output I/Q rate (matched filter input)
    bandwidth_hz: float = 20e6           # Chirp bandwidth (not used in range calc;
                                         # retained for time-bandwidth product / display)
    chirp_duration_s: float = 30e-6      # Long chirp ramp time
    pri_s: float = 167e-6               # Pulse repetition interval (chirp + listen)
    center_freq_hz: float = 10.5e9       # Carrier frequency (radar_scene.py: F_CARRIER)
    n_range_bins: int = 64               # After decimation
    n_doppler_bins: int = 32             # Total Doppler bins (2 sub-frames x 16)
    chirps_per_subframe: int = 16        # Chirps in one Doppler sub-frame
    fft_size: int = 1024                 # Pre-decimation FFT length
    decimation_factor: int = 16          # 1024 → 64

    @property
    def range_resolution_m(self) -> float:
        """Meters per decimated range bin (matched-filter pulse compression).

        For FFT-based matched filtering, each IFFT output bin spans
        c / (2 * Fs) in range, where Fs is the I/Q sample rate at the
        matched-filter input (DDC output).  After decimation the bin
        spacing grows by *decimation_factor*.
        """
        c = 299_792_458.0
        raw_bin = c / (2.0 * self.sample_rate_hz)
        return raw_bin * self.decimation_factor

    @property
    def velocity_resolution_mps(self) -> float:
        """m/s per Doppler bin.

        lambda / (2 * chirps_per_subframe * PRI), matching radar_scene.py.
        """
        c = 299_792_458.0
        wavelength = c / self.center_freq_hz
        return wavelength / (2.0 * self.chirps_per_subframe * self.pri_s)

    @property
    def max_range_m(self) -> float:
        """Maximum unambiguous range in meters."""
        return self.range_resolution_m * self.n_range_bins

    @property
    def max_velocity_mps(self) -> float:
        """Maximum unambiguous velocity (±) in m/s."""
        return self.velocity_resolution_mps * self.n_doppler_bins / 2.0
