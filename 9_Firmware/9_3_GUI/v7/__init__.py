"""
v7 — PLFM Radar GUI V7 (PyQt6 edition).

Re-exports all public classes and functions from sub-modules for convenient
top-level imports:

    from v7 import RadarDashboard, RadarTarget, RadarSettings, ...
"""

# Models / constants
from .models import (
    RadarTarget,
    RadarSettings,
    GPSData,
    ProcessingConfig,
    TileServer,
    WaveformConfig,
    DARK_BG, DARK_FG, DARK_ACCENT, DARK_HIGHLIGHT, DARK_BORDER,
    DARK_TEXT, DARK_BUTTON, DARK_BUTTON_HOVER,
    DARK_TREEVIEW, DARK_TREEVIEW_ALT,
    DARK_SUCCESS, DARK_WARNING, DARK_ERROR, DARK_INFO,
    USB_AVAILABLE, FTDI_AVAILABLE, SCIPY_AVAILABLE,
    SKLEARN_AVAILABLE, FILTERPY_AVAILABLE,
)

# Hardware interfaces — production protocol via radar_protocol.py
from .hardware import (
    FT2232HConnection,
    FT601Connection,
    RadarProtocol,
    Opcode,
    RadarAcquisition,
    RadarFrame,
    StatusResponse,
    DataRecorder,
    STM32USBInterface,
)

# Processing pipeline
from .processing import (
    RadarProcessor,
    USBPacketParser,
    apply_pitch_correction,
    polar_to_geographic,
    extract_targets_from_frame,
)

# Software FPGA (depends on golden_reference.py in FPGA cosim tree)
try:  # noqa: SIM105
    from .software_fpga import SoftwareFPGA, quantize_raw_iq
except ImportError:  # golden_reference.py not available (e.g. deployment without FPGA tree)
    pass

# Replay engine (no PyQt6 dependency, but needs SoftwareFPGA for raw IQ path)
try:  # noqa: SIM105
    from .replay import ReplayEngine, ReplayFormat
except ImportError:  # software_fpga unavailable → replay also unavailable
    pass

# Workers, map widget, and dashboard require PyQt6 — import lazily so that
# tests/CI environments without PyQt6 can still access models/hardware/processing.
try:
    from .workers import (
        RadarDataWorker,
        GPSDataWorker,
        TargetSimulator,
        ReplayWorker,
    )

    from .map_widget import (
        MapBridge,
        RadarMapWidget,
    )

    from .dashboard import (
        RadarDashboard,
        RangeDopplerCanvas,
    )
except ImportError:  # PyQt6 not installed (e.g. CI headless runner)
    pass

__all__ = [  # noqa: RUF022
    # models
    "RadarTarget", "RadarSettings", "GPSData", "ProcessingConfig", "TileServer",
    "WaveformConfig",
    "DARK_BG", "DARK_FG", "DARK_ACCENT", "DARK_HIGHLIGHT", "DARK_BORDER",
    "DARK_TEXT", "DARK_BUTTON", "DARK_BUTTON_HOVER",
    "DARK_TREEVIEW", "DARK_TREEVIEW_ALT",
    "DARK_SUCCESS", "DARK_WARNING", "DARK_ERROR", "DARK_INFO",
    "USB_AVAILABLE", "FTDI_AVAILABLE", "SCIPY_AVAILABLE",
    "SKLEARN_AVAILABLE", "FILTERPY_AVAILABLE",
    # hardware — production FPGA protocol
    "FT2232HConnection", "FT601Connection", "RadarProtocol", "Opcode",
    "RadarAcquisition", "RadarFrame", "StatusResponse", "DataRecorder",
    "STM32USBInterface",
    # processing
    "RadarProcessor", "USBPacketParser",
    "apply_pitch_correction", "polar_to_geographic",
    "extract_targets_from_frame",
    # software FPGA + replay
    "SoftwareFPGA", "quantize_raw_iq",
    "ReplayEngine", "ReplayFormat",
    # workers
    "RadarDataWorker", "GPSDataWorker", "TargetSimulator", "ReplayWorker",
    # map
    "MapBridge", "RadarMapWidget",
    # dashboard
    "RadarDashboard", "RangeDopplerCanvas",
]
