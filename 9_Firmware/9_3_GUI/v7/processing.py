"""
v7.processing — Radar signal processing and GPS parsing.

Classes:
  - RadarProcessor   — dual-CPI fusion, multi-PRF unwrap, DBSCAN clustering,
                        association, Kalman tracking
  - USBPacketParser   — parse GPS text/binary frames from STM32 CDC

Note: RadarPacketParser (old A5/C3 sync + CRC16 format) was removed.
      All packet parsing now uses production RadarProtocol (0xAA/0xBB format)
      from radar_protocol.py.
"""

import struct
import time
import logging
import math

import numpy as np

from .models import (
    RadarTarget, GPSData, ProcessingConfig,
    SCIPY_AVAILABLE, SKLEARN_AVAILABLE, FILTERPY_AVAILABLE,
)

if SKLEARN_AVAILABLE:
    from sklearn.cluster import DBSCAN

if FILTERPY_AVAILABLE:
    from filterpy.kalman import KalmanFilter

if SCIPY_AVAILABLE:
    from scipy.signal import windows as scipy_windows

logger = logging.getLogger(__name__)


# =============================================================================
# Utility: pitch correction (Bug #4 fix — was never defined in V6)
# =============================================================================

def apply_pitch_correction(raw_elevation: float, pitch: float) -> float:
    """
    Apply platform pitch correction to a raw elevation angle.

    Returns the corrected elevation = raw_elevation - pitch.
    """
    return raw_elevation - pitch


# =============================================================================
# Radar Processor — signal-level processing & tracking pipeline
# =============================================================================

class RadarProcessor:
    """Full radar processing pipeline: fusion, clustering, association, tracking."""

    def __init__(self):
        self.range_doppler_map = np.zeros((1024, 32))
        self.detected_targets: list[RadarTarget] = []
        self.track_id_counter: int = 0
        self.tracks: dict[int, dict] = {}
        self.frame_count: int = 0
        self.config = ProcessingConfig()

        # MTI state: store previous frames for cancellation
        self._mti_history: list[np.ndarray] = []

    # ---- Configuration -----------------------------------------------------

    def set_config(self, config: ProcessingConfig):
        """Update the processing configuration and reset MTI history if needed."""
        old_order = self.config.mti_order
        self.config = config
        if config.mti_order != old_order:
            self._mti_history.clear()

    # ---- Windowing ----------------------------------------------------------

    @staticmethod
    def apply_window(data: np.ndarray, window_type: str) -> np.ndarray:
        """Apply a window function along each column (slow-time dimension).

        *data* shape: (range_bins, doppler_bins).  Window is applied along
        axis-1 (Doppler / slow-time).
        """
        if window_type == "None" or not window_type:
            return data

        n = data.shape[1]
        if n < 2:
            return data

        if SCIPY_AVAILABLE:
            wtype = window_type.lower()
            if wtype == "hann":
                w = scipy_windows.hann(n, sym=False)
            elif wtype == "hamming":
                w = scipy_windows.hamming(n, sym=False)
            elif wtype == "blackman":
                w = scipy_windows.blackman(n)
            elif wtype == "kaiser":
                w = scipy_windows.kaiser(n, beta=14)
            elif wtype == "chebyshev":
                w = scipy_windows.chebwin(n, at=80)
            else:
                w = np.ones(n)
        else:
            # Fallback: numpy Hann
            wtype = window_type.lower()
            if wtype == "hann":
                w = np.hanning(n)
            elif wtype == "hamming":
                w = np.hamming(n)
            elif wtype == "blackman":
                w = np.blackman(n)
            else:
                w = np.ones(n)

        return data * w[np.newaxis, :]

    # ---- DC Notch (zero-Doppler removal) ------------------------------------

    @staticmethod
    def dc_notch(data: np.ndarray) -> np.ndarray:
        """Remove the DC (zero-Doppler) component by subtracting the
        mean along the slow-time axis for each range bin."""
        return data - np.mean(data, axis=1, keepdims=True)

    # ---- MTI (Moving Target Indication) -------------------------------------

    def mti_filter(self, frame: np.ndarray) -> np.ndarray:
        """Apply MTI cancellation of order 1, 2, or 3.

        Order-1: y[n] = x[n] - x[n-1]
        Order-2: y[n] = x[n] - 2*x[n-1] + x[n-2]
        Order-3: y[n] = x[n] - 3*x[n-1] + 3*x[n-2] - x[n-3]

        The internal history buffer stores up to 3 previous frames.
        """
        order = self.config.mti_order
        self._mti_history.append(frame.copy())

        # Trim history to order + 1 frames
        max_len = order + 1
        if len(self._mti_history) > max_len:
            self._mti_history = self._mti_history[-max_len:]

        if len(self._mti_history) < order + 1:
            # Not enough history yet — return zeros (suppress output)
            return np.zeros_like(frame)

        h = self._mti_history
        if order == 1:
            return h[-1] - h[-2]
        if order == 2:
            return h[-1] - 2.0 * h[-2] + h[-3]
        if order == 3:
            return h[-1] - 3.0 * h[-2] + 3.0 * h[-3] - h[-4]
        return h[-1] - h[-2]

    # ---- CFAR (Constant False Alarm Rate) -----------------------------------

    @staticmethod
    def cfar_1d(signal_vec: np.ndarray, guard: int, train: int,
                threshold_factor: float, cfar_type: str = "CA-CFAR") -> np.ndarray:
        """1-D CFAR detector.

        Parameters
        ----------
        signal_vec : 1-D array (power in linear scale)
        guard      : number of guard cells on each side
        train      : number of training cells on each side
        threshold_factor : multiplier on estimated noise level
        cfar_type  : CA-CFAR, OS-CFAR, GO-CFAR, or SO-CFAR

        Returns
        -------
        detections : boolean array, True where target detected
        """
        n = len(signal_vec)
        detections = np.zeros(n, dtype=bool)
        half = guard + train

        for i in range(half, n - half):
            # Leading training cells
            lead = signal_vec[i - half: i - guard]
            # Lagging training cells
            lag = signal_vec[i + guard + 1: i + half + 1]

            if cfar_type == "CA-CFAR":
                noise = (np.sum(lead) + np.sum(lag)) / (2 * train)
            elif cfar_type == "GO-CFAR":
                noise = max(np.mean(lead), np.mean(lag))
            elif cfar_type == "SO-CFAR":
                noise = min(np.mean(lead), np.mean(lag))
            elif cfar_type == "OS-CFAR":
                all_train = np.concatenate([lead, lag])
                all_train.sort()
                k = int(0.75 * len(all_train))  # 75th percentile
                noise = all_train[min(k, len(all_train) - 1)]
            else:
                noise = (np.sum(lead) + np.sum(lag)) / (2 * train)

            threshold = noise * threshold_factor
            if signal_vec[i] > threshold:
                detections[i] = True

        return detections

    def cfar_2d(self, rdm: np.ndarray) -> np.ndarray:
        """Apply 1-D CFAR along each range bin (across Doppler dimension).

        Returns a boolean mask of the same shape as *rdm*.
        """
        cfg = self.config
        mask = np.zeros_like(rdm, dtype=bool)
        for r in range(rdm.shape[0]):
            row = rdm[r, :]
            if row.max() > 0:
                mask[r, :] = self.cfar_1d(
                    row, cfg.cfar_guard_cells, cfg.cfar_training_cells,
                    cfg.cfar_threshold_factor, cfg.cfar_type,
                )
        return mask

    # ---- Full processing pipeline -------------------------------------------

    def process_frame(self, raw_frame: np.ndarray) -> tuple[np.ndarray, np.ndarray]:
        """Run the full signal processing chain on a Range x Doppler frame.

        Parameters
        ----------
        raw_frame : 2-D array (range_bins x doppler_bins), complex or real

        Returns
        -------
        (processed_rdm, detection_mask)
            processed_rdm  — processed Range-Doppler map (power, linear)
            detection_mask — boolean mask of CFAR / threshold detections
        """
        cfg = self.config
        data = raw_frame.astype(np.float64)

        # 1. DC Notch
        if cfg.dc_notch_enabled:
            data = self.dc_notch(data)

        # 2. Windowing (before FFT — applied along slow-time axis)
        if cfg.window_type and cfg.window_type != "None":
            data = self.apply_window(data, cfg.window_type)

        # 3. MTI
        if cfg.mti_enabled:
            data = self.mti_filter(data)

        # 4. Power (magnitude squared)
        power = np.abs(data) ** 2
        power = np.maximum(power, 1e-20)  # avoid log(0)

        # 5. CFAR detection or simple threshold
        if cfg.cfar_enabled:
            detection_mask = self.cfar_2d(power)
        else:
            # Simple threshold: convert dB threshold to linear
            power_db = 10.0 * np.log10(power)
            noise_floor = np.median(power_db)
            detection_mask = power_db > (noise_floor + cfg.detection_threshold_db)

        # Update stored RDM
        self.range_doppler_map = power
        self.frame_count += 1

        return power, detection_mask

    # ---- Dual-CPI fusion ---------------------------------------------------

    @staticmethod
    def dual_cpi_fusion(range_profiles_1: np.ndarray,
                        range_profiles_2: np.ndarray) -> np.ndarray:
        """Dual-CPI fusion for better detection."""
        return np.mean(range_profiles_1, axis=0) + np.mean(range_profiles_2, axis=0)

    # ---- DBSCAN clustering -------------------------------------------------

    @staticmethod
    def clustering(detections: list[RadarTarget],
                   eps: float = 100, min_samples: int = 2) -> list:
        """DBSCAN clustering of detections (requires sklearn)."""
        if not SKLEARN_AVAILABLE or len(detections) == 0:
            return []

        points = np.array([[d.range, d.velocity] for d in detections])
        labels = DBSCAN(eps=eps, min_samples=min_samples).fit(points).labels_

        clusters = []
        for label in set(labels):
            if label == -1:
                continue
            cluster_points = points[labels == label]
            clusters.append({
                "center": np.mean(cluster_points, axis=0),
                "points": cluster_points,
                "size": len(cluster_points),
            })
        return clusters

    # ---- Association -------------------------------------------------------

    def association(self, detections: list[RadarTarget],
                    _clusters: list) -> list[RadarTarget]:
        """Associate detections to existing tracks (nearest-neighbour)."""
        associated = []
        for det in detections:
            best_track = None
            min_dist = float("inf")
            for tid, track in self.tracks.items():
                dist = math.sqrt(
                    (det.range - track["state"][0]) ** 2
                    + (det.velocity - track["state"][2]) ** 2
                )
                if dist < min_dist and dist < 500:
                    min_dist = dist
                    best_track = tid

            if best_track is not None:
                det.track_id = best_track
            else:
                det.track_id = self.track_id_counter
                self.track_id_counter += 1

            associated.append(det)
        return associated

    # ---- Kalman tracking ---------------------------------------------------

    def tracking(self, associated_detections: list[RadarTarget]):
        """Kalman filter tracking (requires filterpy)."""
        if not FILTERPY_AVAILABLE:
            return

        now = time.time()

        for det in associated_detections:
            if det.track_id not in self.tracks:
                kf = KalmanFilter(dim_x=4, dim_z=2)
                kf.x = np.array([det.range, 0, det.velocity, 0])
                kf.F = np.array([
                    [1, 1, 0, 0],
                    [0, 1, 0, 0],
                    [0, 0, 1, 1],
                    [0, 0, 0, 1],
                ])
                kf.H = np.array([
                    [1, 0, 0, 0],
                    [0, 0, 1, 0],
                ])
                kf.P *= 1000
                kf.R = np.diag([10, 1])
                kf.Q = np.eye(4) * 0.1

                self.tracks[det.track_id] = {
                    "filter": kf,
                    "state": kf.x,
                    "last_update": now,
                    "hits": 1,
                }
            else:
                track = self.tracks[det.track_id]
                track["filter"].predict()
                track["filter"].update([det.range, det.velocity])
                track["state"] = track["filter"].x
                track["last_update"] = now
                track["hits"] += 1

        # Prune stale tracks (> 5 s without update)
        stale = [tid for tid, t in self.tracks.items()
                 if now - t["last_update"] > 5.0]
        for tid in stale:
            del self.tracks[tid]


# =============================================================================
# USB / GPS Packet Parser
# =============================================================================

class USBPacketParser:
    """
    Parse GPS (and general) data arriving from the STM32 via USB CDC.

    Supports:
      - Text format: ``GPS:lat,lon,alt,pitch\\r\\n``
      - Binary format: ``GPSB`` header, 30 bytes total
    """

    def __init__(self):
        pass

    def parse_gps_data(self, data: bytes) -> GPSData | None:
        """Attempt to parse GPS data from a raw USB CDC frame."""
        if not data:
            return None

        try:
            # Text format: "GPS:lat,lon,alt,pitch\r\n"
            text = data.decode("utf-8", errors="ignore").strip()
            if text.startswith("GPS:"):
                parts = text.split(":")[1].split(",")
                if len(parts) >= 4:
                    return GPSData(
                        latitude=float(parts[0]),
                        longitude=float(parts[1]),
                        altitude=float(parts[2]),
                        pitch=float(parts[3]),
                        timestamp=time.time(),
                    )

            # Binary format: [GPSB 4][lat 8][lon 8][alt 4][pitch 4][CRC 2] = 30 bytes
            if len(data) >= 30 and data[0:4] == b"GPSB":
                return self._parse_binary_gps(data)
        except (ValueError, struct.error) as e:
            logger.error(f"Error parsing GPS data: {e}")
        return None

    @staticmethod
    def _parse_binary_gps(data: bytes) -> GPSData | None:
        """Parse 30-byte binary GPS frame."""
        try:
            if len(data) < 30:
                return None

            # Simple checksum CRC
            crc_rcv = (data[28] << 8) | data[29]
            crc_calc = sum(data[0:28]) & 0xFFFF
            if crc_rcv != crc_calc:
                logger.warning("GPS binary CRC mismatch")
                return None

            lat = struct.unpack(">d", data[4:12])[0]
            lon = struct.unpack(">d", data[12:20])[0]
            alt = struct.unpack(">f", data[20:24])[0]
            pitch = struct.unpack(">f", data[24:28])[0]

            return GPSData(
                latitude=lat,
                longitude=lon,
                altitude=alt,
                pitch=pitch,
                timestamp=time.time(),
            )
        except (ValueError, struct.error) as e:
            logger.error(f"Error parsing binary GPS: {e}")
            return None


# ============================================================================
# Utility: polar → geographic coordinate conversion
# ============================================================================

def polar_to_geographic(
    radar_lat: float,
    radar_lon: float,
    range_m: float,
    azimuth_deg: float,
) -> tuple:
    """Convert polar (range, azimuth) relative to radar → (lat, lon).

    azimuth_deg: 0 = North, clockwise.
    """
    r_earth = 6_371_000.0  # Earth radius in metres

    lat1 = math.radians(radar_lat)
    lon1 = math.radians(radar_lon)
    bearing = math.radians(azimuth_deg)

    lat2 = math.asin(
        math.sin(lat1) * math.cos(range_m / r_earth)
        + math.cos(lat1) * math.sin(range_m / r_earth) * math.cos(bearing)
    )
    lon2 = lon1 + math.atan2(
        math.sin(bearing) * math.sin(range_m / r_earth) * math.cos(lat1),
        math.cos(range_m / r_earth) - math.sin(lat1) * math.sin(lat2),
    )
    return (math.degrees(lat2), math.degrees(lon2))


# ============================================================================
# Shared target extraction (used by both RadarDataWorker and ReplayWorker)
# ============================================================================

def extract_targets_from_frame(
    frame,
    range_resolution: float = 1.0,
    velocity_resolution: float = 1.0,
    gps: GPSData | None = None,
) -> list[RadarTarget]:
    """Extract RadarTarget list from a RadarFrame's detection mask.

    This is the bin-to-physical conversion + geo-mapping shared between
    the live and replay data paths.

    Parameters
    ----------
    frame : RadarFrame
        Frame with populated ``detections``, ``magnitude``, ``range_doppler_i/q``.
    range_resolution : float
        Meters per range bin.
    velocity_resolution : float
        m/s per Doppler bin.
    gps : GPSData | None
        GPS position for geo-mapping (latitude/longitude).

    Returns
    -------
    list[RadarTarget]
        One target per detection cell.
    """
    det_indices = np.argwhere(frame.detections > 0)
    n_doppler = frame.detections.shape[1] if frame.detections.ndim == 2 else 32
    doppler_center = n_doppler // 2

    targets: list[RadarTarget] = []
    for idx in det_indices:
        rbin, dbin = int(idx[0]), int(idx[1])
        mag = float(frame.magnitude[rbin, dbin])
        snr = 10.0 * math.log10(max(mag, 1.0)) if mag > 0 else 0.0

        range_m = float(rbin) * range_resolution
        velocity_ms = float(dbin - doppler_center) * velocity_resolution

        lat, lon, azimuth, elevation = 0.0, 0.0, 0.0, 0.0
        if gps is not None:
            azimuth = gps.heading
            # Spread detections across ±15° sector for single-beam radar
            if len(det_indices) > 1:
                spread = (dbin - doppler_center) / max(doppler_center, 1) * 15.0
                azimuth = gps.heading + spread
            lat, lon = polar_to_geographic(
                gps.latitude, gps.longitude, range_m, azimuth,
            )

        targets.append(RadarTarget(
            id=len(targets),
            range=range_m,
            velocity=velocity_ms,
            azimuth=azimuth,
            elevation=elevation,
            latitude=lat,
            longitude=lon,
            snr=snr,
            timestamp=frame.timestamp,
        ))
    return targets
