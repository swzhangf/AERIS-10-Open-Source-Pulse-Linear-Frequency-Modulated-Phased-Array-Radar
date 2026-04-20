import tkinter as tk
from tkinter import ttk, messagebox
import queue
import time
import struct
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
from matplotlib.figure import Figure
import logging
from dataclasses import dataclass
from sklearn.cluster import DBSCAN
from filterpy.kalman import KalmanFilter
import crcmod
import math
import webbrowser
import os
import json

# Try to import tkinterweb for embedded browser
try:
    import tkinterweb

    TKINTERWEB_AVAILABLE = True
    logging.info("tkinterweb available - Embedded browser enabled")
except ImportError:
    TKINTERWEB_AVAILABLE = False
    logging.warning("tkinterweb not available. Please install: pip install tkinterweb")

try:
    import usb.core
    import usb.util

    USB_AVAILABLE = True
except ImportError:
    USB_AVAILABLE = False
    logging.warning("pyusb not available. USB CDC functionality will be disabled.")

try:
    from pyftdi.ftdi import Ftdi, FtdiError
    from pyftdi.usbtools import UsbTools

    FTDI_AVAILABLE = True
except ImportError:
    FTDI_AVAILABLE = False
    logging.warning("pyftdi not available. FTDI functionality will be disabled.")

# Configure logging
logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")

# Dark theme colors
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


@dataclass
class RadarTarget:
    id: int
    range: float
    velocity: float
    azimuth: int
    elevation: int
    latitude: float = 0.0
    longitude: float = 0.0
    snr: float = 0.0
    timestamp: float = 0.0
    track_id: int = -1


@dataclass
class RadarSettings:
    system_frequency: float = 10e9
    chirp_duration_1: float = 30e-6  # Long chirp duration
    chirp_duration_2: float = 0.5e-6  # Short chirp duration
    chirps_per_position: int = 32
    freq_min: float = 10e6
    freq_max: float = 30e6
    prf1: float = 1000
    prf2: float = 2000
    max_distance: float = 50000
    map_size: float = 50000  # Map size in meters


@dataclass
class GPSData:
    latitude: float
    longitude: float
    altitude: float
    pitch: float  # Pitch angle in degrees
    timestamp: float


class RadarProcessor:
    def __init__(self):
        self.range_doppler_map = np.zeros((1024, 32))
        self.detected_targets = []
        self.track_id_counter = 0
        self.tracks = {}
        self.frame_count = 0

    def dual_cpi_fusion(self, range_profiles_1, range_profiles_2):
        """Dual-CPI fusion for better detection"""
        return np.mean(range_profiles_1, axis=0) + np.mean(range_profiles_2, axis=0)

    def multi_prf_unwrap(self, doppler_measurements, prf1, prf2):
        """Multi-PRF velocity unwrapping"""
        lambda_wavelength = 3e8 / 10e9
        v_max1 = prf1 * lambda_wavelength / 2
        v_max2 = prf2 * lambda_wavelength / 2

        unwrapped_velocities = []
        for doppler in doppler_measurements:
            v1 = doppler * lambda_wavelength / 2
            v2 = doppler * lambda_wavelength / 2

            velocity = self._solve_chinese_remainder(v1, v2, v_max1, v_max2)
            unwrapped_velocities.append(velocity)

        return unwrapped_velocities

    def _solve_chinese_remainder(self, v1, v2, max1, max2):
        for k in range(-5, 6):
            candidate = v1 + k * max1
            if abs(candidate - v2) < max2 / 2:
                return candidate
        return v1

    def clustering(self, detections, eps=100, min_samples=2):
        """DBSCAN clustering of detections"""
        if len(detections) == 0:
            return []

        points = np.array([[d.range, d.velocity] for d in detections])
        clustering = DBSCAN(eps=eps, min_samples=min_samples).fit(points)

        clusters = []
        for label in set(clustering.labels_):
            if label != -1:
                cluster_points = points[clustering.labels_ == label]
                clusters.append(
                    {
                        "center": np.mean(cluster_points, axis=0),
                        "points": cluster_points,
                        "size": len(cluster_points),
                    }
                )

        return clusters

    def association(self, detections, _clusters):
        """Association of detections to tracks"""
        associated_detections = []

        for detection in detections:
            best_track = None
            min_distance = float("inf")

            for track_id, track in self.tracks.items():
                distance = np.sqrt(
                    (detection.range - track["state"][0]) ** 2
                    + (detection.velocity - track["state"][2]) ** 2
                )

                if distance < min_distance and distance < 500:
                    min_distance = distance
                    best_track = track_id

            if best_track is not None:
                detection.track_id = best_track
                associated_detections.append(detection)
            else:
                detection.track_id = self.track_id_counter
                self.track_id_counter += 1
                associated_detections.append(detection)

        return associated_detections

    def tracking(self, associated_detections):
        """Kalman filter tracking"""
        current_time = time.time()

        for detection in associated_detections:
            if detection.track_id not in self.tracks:
                kf = KalmanFilter(dim_x=4, dim_z=2)
                kf.x = np.array([detection.range, 0, detection.velocity, 0])
                kf.F = np.array([[1, 1, 0, 0], [0, 1, 0, 0], [0, 0, 1, 1], [0, 0, 0, 1]])
                kf.H = np.array([[1, 0, 0, 0], [0, 0, 1, 0]])
                kf.P *= 1000
                kf.R = np.diag([10, 1])
                kf.Q = np.eye(4) * 0.1

                self.tracks[detection.track_id] = {
                    "filter": kf,
                    "state": kf.x,
                    "last_update": current_time,
                    "hits": 1,
                }
            else:
                track = self.tracks[detection.track_id]
                track["filter"].predict()
                track["filter"].update([detection.range, detection.velocity])
                track["state"] = track["filter"].x
                track["last_update"] = current_time
                track["hits"] += 1

        stale_tracks = [
            tid for tid, track in self.tracks.items() if current_time - track["last_update"] > 5.0
        ]
        for tid in stale_tracks:
            del self.tracks[tid]


class USBPacketParser:
    def __init__(self):
        self.crc16_func = crcmod.mkCrcFun(0x11021, rev=False, initCrc=0xFFFF, xorOut=0x0000)

    def parse_gps_data(self, data):
        """Parse GPS data from STM32 USB CDC with pitch angle"""
        if not data:
            return None

        try:
            # Try text format first: "GPS:lat,lon,alt,pitch\r\n"
            text_data = data.decode("utf-8", errors="ignore").strip()
            if text_data.startswith("GPS:"):
                parts = text_data.split(":")[1].split(",")
                if len(parts) == 4:  # Now expecting 4 values
                    lat = float(parts[0])
                    lon = float(parts[1])
                    alt = float(parts[2])
                    pitch = float(parts[3])  # Pitch angle in degrees
                    return GPSData(
                        latitude=lat,
                        longitude=lon,
                        altitude=alt,
                        pitch=pitch,
                        timestamp=time.time(),
                    )

            # Try binary format (30 bytes with pitch)
            if len(data) >= 30 and data[0:4] == b"GPSB":
                return self._parse_binary_gps_with_pitch(data)

        except (ValueError, struct.error) as e:
            logging.error(f"Error parsing GPS data: {e}")

        return None

    def _parse_binary_gps_with_pitch(self, data):
        """Parse binary GPS format with pitch angle (30 bytes)"""
        try:
            # Binary format: [Header 4][Latitude 8][Longitude 8][Altitude 4][Pitch 4][CRC 2]
            if len(data) < 30:
                return None

            # Verify CRC (simple checksum)
            crc_received = (data[28] << 8) | data[29]
            crc_calculated = sum(data[0:28]) & 0xFFFF

            if crc_received != crc_calculated:
                logging.warning("GPS CRC mismatch")
                return None

            # Parse latitude (double, big-endian)
            lat_bits = 0
            for i in range(8):
                lat_bits = (lat_bits << 8) | data[4 + i]
            latitude = struct.unpack(">d", struct.pack(">Q", lat_bits))[0]

            # Parse longitude (double, big-endian)
            lon_bits = 0
            for i in range(8):
                lon_bits = (lon_bits << 8) | data[12 + i]
            longitude = struct.unpack(">d", struct.pack(">Q", lon_bits))[0]

            # Parse altitude (float, big-endian)
            alt_bits = 0
            for i in range(4):
                alt_bits = (alt_bits << 8) | data[20 + i]
            altitude = struct.unpack(">f", struct.pack(">I", alt_bits))[0]

            # Parse pitch angle (float, big-endian)
            pitch_bits = 0
            for i in range(4):
                pitch_bits = (pitch_bits << 8) | data[24 + i]
            pitch = struct.unpack(">f", struct.pack(">I", pitch_bits))[0]

            return GPSData(
                latitude=latitude,
                longitude=longitude,
                altitude=altitude,
                pitch=pitch,
                timestamp=time.time(),
            )

        except (ValueError, struct.error) as e:
            logging.error(f"Error parsing binary GPS with pitch: {e}")
            return None


class RadarPacketParser:
    def __init__(self):
        self.sync_pattern = b"\xa5\xc3"
        self.crc16_func = crcmod.mkCrcFun(0x11021, rev=False, initCrc=0xFFFF, xorOut=0x0000)

    def parse_packet(self, data):
        if len(data) < 6:
            return None

        sync_index = data.find(self.sync_pattern)
        if sync_index == -1:
            return None

        packet = data[sync_index:]

        if len(packet) < 6:
            return None

        _sync = packet[0:2]
        packet_type = packet[2]
        length = packet[3]

        if len(packet) < (4 + length + 2):
            return None

        payload = packet[4 : 4 + length]
        crc_received = struct.unpack("<H", packet[4 + length : 4 + length + 2])[0]

        crc_calculated = self.calculate_crc(packet[0 : 4 + length])
        if crc_calculated != crc_received:
            logging.warning(
                f"CRC mismatch: got {crc_received:04X}, calculated {crc_calculated:04X}"
            )
            return None

        if packet_type == 0x01:
            return self.parse_range_packet(payload)
        if packet_type == 0x02:
            return self.parse_doppler_packet(payload)
        if packet_type == 0x03:
            return self.parse_detection_packet(payload)
        logging.warning(f"Unknown packet type: {packet_type:02X}")
        return None

    def calculate_crc(self, data):
        return self.crc16_func(data)

    def parse_range_packet(self, payload):
        if len(payload) < 12:
            return None

        try:
            range_value = struct.unpack(">I", payload[0:4])[0]
            elevation = payload[4] & 0x1F
            azimuth = payload[5] & 0x3F
            chirp_counter = payload[6] & 0x1F

            return {
                "type": "range",
                "range": range_value,
                "elevation": elevation,
                "azimuth": azimuth,
                "chirp": chirp_counter,
                "timestamp": time.time(),
            }
        except (ValueError, struct.error) as e:
            logging.error(f"Error parsing range packet: {e}")
            return None

    def parse_doppler_packet(self, payload):
        if len(payload) < 12:
            return None

        try:
            doppler_real = struct.unpack(">h", payload[0:2])[0]
            doppler_imag = struct.unpack(">h", payload[2:4])[0]
            elevation = payload[4] & 0x1F
            azimuth = payload[5] & 0x3F
            chirp_counter = payload[6] & 0x1F

            return {
                "type": "doppler",
                "doppler_real": doppler_real,
                "doppler_imag": doppler_imag,
                "elevation": elevation,
                "azimuth": azimuth,
                "chirp": chirp_counter,
                "timestamp": time.time(),
            }
        except (ValueError, struct.error) as e:
            logging.error(f"Error parsing Doppler packet: {e}")
            return None

    def parse_detection_packet(self, payload):
        if len(payload) < 8:
            return None

        try:
            detection_flag = (payload[0] & 0x01) != 0
            elevation = payload[1] & 0x1F
            azimuth = payload[2] & 0x3F
            chirp_counter = payload[3] & 0x1F

            return {
                "type": "detection",
                "detected": detection_flag,
                "elevation": elevation,
                "azimuth": azimuth,
                "chirp": chirp_counter,
                "timestamp": time.time(),
            }
        except (ValueError, struct.error) as e:
            logging.error(f"Error parsing detection packet: {e}")
            return None


class MapGenerator:
    def __init__(self):
        self.map_file_path = None
        self.map_html_template = """<!DOCTYPE html>
<html>
<head>
    <title>Radar Live Map - OpenStreetMap</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
        integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY="
        crossorigin=""/>
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"
        integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo="
        crossorigin=""></script>
    <style>
        body { 
            margin: 0; 
            padding: 0; 
            font-family: Arial, sans-serif;
            background-color: #2b2b2b;
            color: #e0e0e0;
        }
        #map { 
            height: 100vh; 
            width: 100%; 
        }
        #status-bar {
            position: absolute;
            top: 10px;
            left: 50%;
            transform: translateX(-50%);
            background: rgba(0, 0, 0, 0.7);
            color: white;
            padding: 8px 15px;
            border-radius: 5px;
            z-index: 1000;
            font-size: 14px;
            font-weight: bold;
        }
        .info-window {
            font-family: Arial, sans-serif;
            font-size: 14px;
            padding: 10px;
            min-width: 200px;
            background-color: #3c3f41;
            color: #e0e0e0;
            border-radius: 5px;
        }
        .info-window h3 {
            margin-top: 0;
            color: #4e9eff;
        }
        .info-window p {
            margin: 5px 0;
        }
        .leaflet-container {
            background-color: #2b2b2b !important;
        }
    </style>
</head>
<body>
    <div id="status-bar">Loading radar map...</div>
    <div id="map"></div>
    
    <script>
        var map;
        var radarMarker;
        var coverageCircle;
        var targetMarkers = [];
        
        function initMap() {
            console.log('Initializing OpenStreetMap...');
            
            var radarLat = {lat};
            var radarLng = {lon};
            var radarPosition = [radarLat, radarLng];
            
            // Initialize map with OpenStreetMap tiles
            map = L.map('map', {
                preferCanvas: true // Better performance
            }).setView(radarPosition, 12);
            
            // Add OpenStreetMap tile layer
            L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                attribution:
                    '&copy; <a href="https://www.openstreetmap.org/copyright">'
                    + 'OpenStreetMap</a> contributors',
                maxZoom: 19
            }).addTo(map);
            
            // Radar position marker
            radarMarker = L.marker(radarPosition, {
                title: 'Radar System',
                icon: L.divIcon({
                    className: 'radar-icon',
                    html:
                        '<div style="background-color:red;border-radius:50%;'
                        + 'border:2px solid white;width:20px;height:20px;"></div>',
                    iconSize: [20, 20]
                })
            }).addTo(map);
            
            // Radar coverage area
            coverageCircle = L.circle(radarPosition, {
                color: '#FF0000',
                fillColor: '#FF0000',
                fillOpacity: 0.1,
                radius: {coverage_radius}
            }).addTo(map);
            
            // Info window for radar
            var radarPopup = L.popup().setContent(
                '<div class="info-window">' +
                '<h3>Radar System</h3>' +
                '<p>Latitude: ' + radarLat.toFixed(6) + '</p>' +
                '<p>Longitude: ' + radarLng.toFixed(6) + '</p>' +
                '<p>Altitude: {alt:.1f}m</p>' +
                '<p>Pitch: {pitch:+.1f}°</p>' +
                '<p>Coverage: {coverage_radius_km:.1f} km</p>' +
                '<p>Status: <span style="color:green">Active</span></p>' +
                '</div>'
            );
            
            radarMarker.bindPopup(radarPopup);
            
            // Auto-open radar popup
            setTimeout(function() { radarMarker.openPopup(); }, 1000);
            
            // Display initial targets if any
            if (window.initialTargets && window.initialTargets.length > 0) {
                updateTargets(window.initialTargets);
            }
            
            updateStatus(
                'Map initialized with '
                + (window.initialTargets ? window.initialTargets.length : 0)
                + ' targets'
            );
        }
        
        function updateTargets(targets) {
            console.log('Updating targets:', targets.length);
            
            // Clear existing targets
            targetMarkers.forEach(function(marker) { 
                map.removeLayer(marker); 
            });
            targetMarkers = [];
            
            // Add new targets
            targets.forEach(function(target) {
                var targetColor = getTargetColor(target.velocity);
                var markerSize = 12 + (target.snr / 5); // Size based on SNR
                
                var targetMarker = L.marker([target.lat, target.lng], {
                    title:
                        'Target #' + target.id
                        + ' - Range: ' + target.range.toFixed(1)
                        + 'm, Vel: ' + target.velocity.toFixed(1) + 'm/s',
                    icon: L.divIcon({
                        className: 'target-icon',
                        html:
                            '<div style="background-color:' + targetColor
                            + ';border-radius:50%;border:1px solid white;width:'
                            + markerSize + 'px;height:' + markerSize + 'px;"></div>',
                        iconSize: [markerSize, markerSize]
                    })
                }).addTo(map);
                
                var targetPopup = L.popup().setContent(
                    '<div class="info-window">' +
                    '<h3>Target #' + target.id + '</h3>' +
                    '<p><b>Range:</b> ' + target.range.toFixed(1) + ' m</p>' +
                    '<p><b>Velocity:</b> ' + target.velocity.toFixed(1) + ' m/s</p>' +
                    '<p><b>Azimuth:</b> ' + target.azimuth + '°</p>' +
                    '<p><b>Elevation:</b> ' + target.elevation.toFixed(1) + '°</p>' +
                    '<p><b>SNR:</b> ' + target.snr.toFixed(1) + ' dB</p>' +
                    '<p><b>Track ID:</b> ' + target.track_id + '</p>' +
                    '<p><b>Status:</b> '
                    + (
                        target.velocity > 0
                        ? '<span style="color:red">Approaching</span>'
                        : '<span style="color:blue">Receding</span>'
                    )
                    + '</p>' +
                    '</div>'
                );
                
                targetMarker.bindPopup(targetPopup);
                targetMarkers.push(targetMarker);
            });
            
            updateStatus(targets.length + ' targets displayed');
        }
        
        function getTargetColor(velocity) {
            // Color code based on velocity
            if (velocity > 100) return '#FF0000'; // Red for fast approaching
            if (velocity > 50) return '#FF6600';  // Orange for medium
            if (velocity > 0) return '#00FF00';   // Green for slow approaching
            if (velocity < -100) return '#0000FF'; // Blue for fast receding
            if (velocity < 0) return '#0066FF';    // Light blue for slow receding
            return '#888888'; // Gray for stationary
        }
        
        function updateRadarPosition(lat, lng, alt, pitch) {
            var newPosition = [lat, lng];
            radarMarker.setLatLng(newPosition);
            coverageCircle.setLatLng(newPosition);
            map.setView(newPosition);
            
            updateStatus('Radar moved to: ' + lat.toFixed(6) + ', ' + lng.toFixed(6));
        }
        
        function updateStatus(message) {
            var statusBar = document.getElementById('status-bar');
            if (statusBar) {
                statusBar.textContent = message;
            }
            console.log('Status:', message);
        }
        
        // Function to be called from Python updates
        window.updateMapData = function(lat, lng, alt, pitch, targets) {
            console.log('Received update from Python');
            updateRadarPosition(lat, lng, alt, pitch);
            updateTargets(targets);
        };
        
        // Initialize map when page loads
        document.addEventListener('DOMContentLoaded', function() {
            initMap();
        });
    </script>
</body>
</html>"""

    def generate_map_html_content(self, gps_data, targets, coverage_radius):
        """Generate map HTML as string (for embedded browser)"""
        # Convert targets for JavaScript
        map_targets = []
        for target in targets:
            target_lat, target_lon = self.polar_to_geographic(
                gps_data.latitude, gps_data.longitude, target.range, target.azimuth
            )
            map_targets.append(
                {
                    "id": target.id,
                    "lat": target_lat,
                    "lng": target_lon,
                    "range": target.range,
                    "velocity": target.velocity,
                    "azimuth": target.azimuth,
                    "elevation": target.elevation,
                    "snr": target.snr,
                    "track_id": target.track_id,
                }
            )

        # Calculate coverage radius in km
        coverage_radius_km = coverage_radius / 1000.0

        # Generate HTML content
        targets_json = json.dumps(map_targets)
        return (
            self.map_html_template.replace("{lat}", str(gps_data.latitude))
            .replace("{lon}", str(gps_data.longitude))
            .replace("{alt:.1f}", f"{gps_data.altitude:.1f}")
            .replace("{pitch:+.1f}", f"{gps_data.pitch:+.1f}")
            .replace("{coverage_radius}", str(coverage_radius))
            .replace("{coverage_radius_km:.1f}", f"{coverage_radius_km:.1f}")
            .replace("{target_count}", str(len(map_targets)))
            .replace(
                "// Display initial targets if any",
                "window.initialTargets = "
                f"{targets_json};\n        // Display initial targets if any",
            )
        )

    def polar_to_geographic(self, radar_lat, radar_lon, range_m, azimuth_deg):
        """
        Convert polar coordinates (range, azimuth) to geographic coordinates
        using simple flat-earth approximation (good for small distances)
        """
        # Earth radius in meters
        earth_radius = 6371000

        # Convert azimuth to radians (0° = North, 90° = East)
        azimuth_rad = math.radians(90 - azimuth_deg)  # Convert to math convention

        # Convert range to angular distance
        angular_distance = range_m / earth_radius

        # Convert to geographic coordinates
        target_lat = radar_lat + math.cos(azimuth_rad) * angular_distance * (180 / math.pi)
        target_lon = radar_lon + math.sin(azimuth_rad) * angular_distance * (
            180 / math.pi
        ) / math.cos(math.radians(radar_lat))

        return target_lat, target_lon


# ... [Other classes remain the same: STM32USBInterface, FTDIInterface,
# ... RadarProcessor, USBPacketParser, RadarPacketParser] ...
class STM32USBInterface:
    def __init__(self):
        self.device = None
        self.is_open = False
        self.ep_in = None
        self.ep_out = None

    def list_devices(self):
        """List available STM32 USB CDC devices"""
        if not USB_AVAILABLE:
            logging.warning("USB not available - please install pyusb")
            return []

        try:
            devices = []
            # STM32 USB CDC devices typically use these vendor/product IDs
            stm32_vid_pids = [
                (0x0483, 0x5740),  # STM32 Virtual COM Port
                (0x0483, 0x3748),  # STM32 Discovery
                (0x0483, 0x374B),  # STM32 CDC
                (0x0483, 0x374D),  # STM32 CDC
                (0x0483, 0x374E),  # STM32 CDC
                (0x0483, 0x3752),  # STM32 CDC
            ]

            for vid, pid in stm32_vid_pids:
                found_devices = usb.core.find(find_all=True, idVendor=vid, idProduct=pid)
                for dev in found_devices:
                    try:
                        product = (
                            usb.util.get_string(dev, dev.iProduct) if dev.iProduct else "STM32 CDC"
                        )
                        serial = (
                            usb.util.get_string(dev, dev.iSerialNumber)
                            if dev.iSerialNumber
                            else "Unknown"
                        )
                        devices.append(
                            {
                                "description": f"{product} ({serial})",
                                "vendor_id": vid,
                                "product_id": pid,
                                "device": dev,
                            }
                        )
                    except (usb.core.USBError, ValueError):
                        devices.append(
                            {
                                "description": f"STM32 CDC (VID:{vid:04X}, PID:{pid:04X})",
                                "vendor_id": vid,
                                "product_id": pid,
                                "device": dev,
                            }
                        )

            return devices
        except usb.core.USBError as e:
            logging.error(f"Error listing USB devices: {e}")
            # Return mock devices for testing
            return [
                {"description": "STM32 Virtual COM Port", "vendor_id": 0x0483, "product_id": 0x5740}
            ]

    def open_device(self, device_info):
        """Open STM32 USB CDC device"""
        if not USB_AVAILABLE:
            logging.error("USB not available - cannot open device")
            return False

        try:
            self.device = device_info["device"]

            # Detach kernel driver if active
            if self.device.is_kernel_driver_active(0):
                self.device.detach_kernel_driver(0)

            # Set configuration
            self.device.set_configuration()

            # Get CDC endpoints
            cfg = self.device.get_active_configuration()
            intf = cfg[(0, 0)]

            # Find bulk endpoints (CDC data interface)
            self.ep_out = usb.util.find_descriptor(
                intf,
                custom_match=lambda e: (
                    usb.util.endpoint_direction(e.bEndpointAddress) == usb.util.ENDPOINT_OUT
                ),
            )

            self.ep_in = usb.util.find_descriptor(
                intf,
                custom_match=lambda e: (
                    usb.util.endpoint_direction(e.bEndpointAddress) == usb.util.ENDPOINT_IN
                ),
            )

            if self.ep_out is None or self.ep_in is None:
                logging.error("Could not find CDC endpoints")
                return False

            self.is_open = True
            logging.info(f"STM32 USB device opened: {device_info['description']}")
            return True

        except usb.core.USBError as e:
            logging.error(f"Error opening USB device: {e}")
            return False

    def send_start_flag(self):
        """Step 12: Send start flag to STM32 via USB"""
        start_packet = bytes([23, 46, 158, 237])
        logging.info("Sending start flag to STM32 via USB...")
        return self._send_data(start_packet)

    def send_settings(self, settings):
        """Step 13: Send radar settings to STM32 via USB"""
        try:
            packet = self._create_settings_packet(settings)
            logging.info("Sending radar settings to STM32 via USB...")
            return self._send_data(packet)
        except (usb.core.USBError, struct.error) as e:
            logging.error(f"Error sending settings via USB: {e}")
            return False

    def read_data(self, size=64, timeout=1000):
        """Read data from STM32 via USB"""
        if not self.is_open or self.ep_in is None:
            return None

        try:
            data = self.ep_in.read(size, timeout=timeout)
            return bytes(data)
        except usb.core.USBError as e:
            if e.errno == 110:  # Timeout
                return None
            logging.error(f"USB read error: {e}")
            return None

    def _send_data(self, data):
        """Send data to STM32 via USB"""
        if not self.is_open or self.ep_out is None:
            return False

        try:
            # USB CDC typically uses 64-byte packets
            packet_size = 64
            for i in range(0, len(data), packet_size):
                chunk = data[i : i + packet_size]
                # Pad to packet size if needed
                if len(chunk) < packet_size:
                    chunk += b"\x00" * (packet_size - len(chunk))
                self.ep_out.write(chunk)

            return True
        except usb.core.USBError as e:
            logging.error(f"Error sending data via USB: {e}")
            return False

    def _create_settings_packet(self, settings):
        """Create binary settings packet for USB transmission"""
        packet = b"SET"
        packet += struct.pack(">d", settings.system_frequency)
        packet += struct.pack(">d", settings.chirp_duration_1)
        packet += struct.pack(">d", settings.chirp_duration_2)
        packet += struct.pack(">I", settings.chirps_per_position)
        packet += struct.pack(">d", settings.freq_min)
        packet += struct.pack(">d", settings.freq_max)
        packet += struct.pack(">d", settings.prf1)
        packet += struct.pack(">d", settings.prf2)
        packet += struct.pack(">d", settings.max_distance)
        packet += struct.pack(">d", settings.map_size)
        packet += b"END"
        return packet

    def close(self):
        """Close USB device"""
        if self.device and self.is_open:
            try:
                usb.util.dispose_resources(self.device)
                self.is_open = False
            except usb.core.USBError as e:
                logging.error(f"Error closing USB device: {e}")


class FTDIInterface:
    def __init__(self):
        self.ftdi = None
        self.is_open = False

    def list_devices(self):
        """List available FTDI devices using pyftdi"""
        if not FTDI_AVAILABLE:
            logging.warning("FTDI not available - please install pyftdi")
            return []

        try:
            # Get list of all FTDI devices
            return [
                {"description": f"FTDI Device {device}", "url": f"ftdi://{device}/1"}
                for device in UsbTools.find_all([(0x0403, 0x6010)])
            ]  # FT2232H vendor/product ID
        except usb.core.USBError as e:
            logging.error(f"Error listing FTDI devices: {e}")
            # Return mock devices for testing
            return [{"description": "FT2232H Device A", "url": "ftdi://device/1"}]

    def open_device(self, device_url):
        """Open FTDI device using pyftdi"""
        if not FTDI_AVAILABLE:
            logging.error("FTDI not available - cannot open device")
            return False

        try:
            self.ftdi = Ftdi()
            self.ftdi.open_from_url(device_url)

            # Configure for synchronous FIFO mode
            self.ftdi.set_bitmode(0xFF, Ftdi.BitMode.SYNCFF)

            # Set latency timer
            self.ftdi.set_latency_timer(2)

            # Purge buffers
            self.ftdi.purge_buffers()

            self.is_open = True
            logging.info(f"FTDI device opened: {device_url}")
            return True

        except FtdiError as e:
            logging.error(f"Error opening FTDI device: {e}")
            return False

    def read_data(self, bytes_to_read):
        """Read data from FTDI"""
        if not self.is_open or self.ftdi is None:
            return None

        try:
            data = self.ftdi.read_data(bytes_to_read)
            if data:
                return bytes(data)
            return None
        except FtdiError as e:
            logging.error(f"Error reading from FTDI: {e}")
            return None

    def close(self):
        """Close FTDI device"""
        if self.ftdi and self.is_open:
            self.ftdi.close()
            self.is_open = False


class RadarGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("Advanced Radar System GUI - USB CDC with Embedded Map")
        self.root.geometry("1400x900")

        # Apply dark theme to root window
        self.root.configure(bg=DARK_BG)

        # Configure ttk style for dark theme
        self.style = ttk.Style()
        self.style.theme_use("clam")  # Use 'clam' as base for better customization

        # Configure dark theme colors
        self.configure_dark_theme()

        # Initialize interfaces
        self.stm32_usb_interface = STM32USBInterface()
        self.ftdi_interface = FTDIInterface()
        self.radar_processor = RadarProcessor()
        self.usb_packet_parser = USBPacketParser()
        self.radar_packet_parser = RadarPacketParser()
        self.map_generator = MapGenerator()
        self.last_map_update = 0
        self.map_update_interval = 5  # Update map every 5 seconds
        self.settings = RadarSettings()

        # Embedded browser
        self.browser_frame = None
        self.browser = None
        self.current_map_html = ""

        # Data queues
        self.radar_data_queue = queue.Queue()
        self.gps_data_queue = queue.Queue()

        # Thread control
        self.running = False
        self.radar_thread = None
        self.gps_thread = None

        # Counters
        self.received_packets = 0
        self.current_gps = GPSData(
            latitude=41.9028, longitude=12.4964, altitude=0, pitch=0.0, timestamp=0
        )
        self.corrected_elevations = []  # Store corrected elevation values

        self.create_gui()
        self.start_background_threads()

        # Demo mode variables
        self.demo_mode_active = False
        self.demo_thread = None
        self.demo_targets = []

    def create_gui(self):
        """Create the main GUI with tabs"""
        self.notebook = ttk.Notebook(self.root)
        self.notebook.pack(fill="both", expand=True, padx=10, pady=10)

        self.tab_main = ttk.Frame(self.notebook)
        self.tab_map = ttk.Frame(self.notebook)
        self.tab_diagnostics = ttk.Frame(self.notebook)
        self.tab_settings = ttk.Frame(self.notebook)

        self.notebook.add(self.tab_main, text="Main View")
        self.notebook.add(self.tab_map, text="Map View")
        self.notebook.add(self.tab_diagnostics, text="Diagnostics")
        self.notebook.add(self.tab_settings, text="Settings")

        self.setup_main_tab()
        self.setup_map_tab()
        self.setup_settings_tab()

    def setup_main_tab(self):
        """Setup the main radar display tab"""
        # Control frame
        control_frame = ttk.Frame(self.tab_main)
        control_frame.pack(fill="x", padx=10, pady=5)

        # USB Device selection
        ttk.Label(control_frame, text="STM32 USB Device:").grid(row=0, column=0, padx=5)
        self.stm32_usb_combo = ttk.Combobox(control_frame, state="readonly", width=40)
        self.stm32_usb_combo.grid(row=0, column=1, padx=5)

        ttk.Label(control_frame, text="FTDI Device:").grid(row=0, column=2, padx=5)
        self.ftdi_combo = ttk.Combobox(control_frame, state="readonly", width=30)
        self.ftdi_combo.grid(row=0, column=3, padx=5)

        ttk.Button(control_frame, text="Refresh Devices", command=self.refresh_devices).grid(
            row=0, column=4, padx=5
        )

        self.start_button = ttk.Button(control_frame, text="Start Radar", command=self.start_radar)
        self.start_button.grid(row=0, column=5, padx=5)

        self.stop_button = ttk.Button(
            control_frame, text="Stop Radar", command=self.stop_radar, state="disabled"
        )
        self.stop_button.grid(row=0, column=6, padx=5)

        # DEMO BUTTONS
        self.demo_button = ttk.Button(
            control_frame, text="Start Demo", command=self.start_demo_mode
        )
        self.demo_button.grid(row=0, column=7, padx=5)

        self.stop_demo_button = ttk.Button(
            control_frame, text="Stop Demo", command=self.stop_demo_mode, state="disabled"
        )
        self.stop_demo_button.grid(row=0, column=8, padx=5)

        # GPS and Pitch info
        self.gps_label = ttk.Label(control_frame, text="GPS: Waiting for data...")
        self.gps_label.grid(row=1, column=0, columnspan=4, sticky="w", padx=5, pady=2)

        # Pitch display
        self.pitch_label = ttk.Label(control_frame, text="Pitch: --.--°")
        self.pitch_label.grid(row=1, column=4, columnspan=2, padx=5, pady=2)

        # Status info
        self.status_label = ttk.Label(control_frame, text="Status: Ready")
        self.status_label.grid(row=1, column=6, sticky="e", padx=5, pady=2)

        # Main display area
        display_frame = ttk.Frame(self.tab_main)
        display_frame.pack(fill="both", expand=True, padx=10, pady=5)

        # Range-Doppler Map with dark theme
        plt.style.use("dark_background")
        fig = Figure(figsize=(10, 6), facecolor=DARK_BG)
        self.range_doppler_ax = fig.add_subplot(111, facecolor=DARK_ACCENT)
        self.range_doppler_plot = self.range_doppler_ax.imshow(
            np.random.rand(1024, 32), aspect="auto", cmap="hot", extent=[0, 32, 0, 1024]
        )
        self.range_doppler_ax.set_title("Range-Doppler Map (Pitch Corrected)", color=DARK_FG)
        self.range_doppler_ax.set_xlabel("Doppler Bin", color=DARK_FG)
        self.range_doppler_ax.set_ylabel("Range Bin", color=DARK_FG)
        self.range_doppler_ax.tick_params(colors=DARK_FG)
        self.range_doppler_ax.spines["bottom"].set_color(DARK_FG)
        self.range_doppler_ax.spines["top"].set_color(DARK_FG)
        self.range_doppler_ax.spines["left"].set_color(DARK_FG)
        self.range_doppler_ax.spines["right"].set_color(DARK_FG)

        self.canvas = FigureCanvasTkAgg(fig, display_frame)
        self.canvas.draw()
        self.canvas.get_tk_widget().pack(side="left", fill="both", expand=True)

        # Targets list
        targets_frame = ttk.LabelFrame(display_frame, text="Detected Targets")
        targets_frame.pack(side="right", fill="y", padx=5)

        self.targets_tree = ttk.Treeview(
            targets_frame,
            columns=("ID", "Range", "Velocity", "Azimuth", "Elevation", "SNR"),
            show="headings",
            height=20,
        )
        self.targets_tree.heading("ID", text="Track ID")
        self.targets_tree.heading("Range", text="Range (m)")
        self.targets_tree.heading("Velocity", text="Velocity (m/s)")
        self.targets_tree.heading("Azimuth", text="Azimuth")
        self.targets_tree.heading("Elevation", text="Elevation")
        self.targets_tree.heading("SNR", text="SNR (dB)")

        self.targets_tree.column("ID", width=70)
        self.targets_tree.column("Range", width=90)
        self.targets_tree.column("Velocity", width=90)
        self.targets_tree.column("Azimuth", width=70)
        self.targets_tree.column("Elevation", width=70)
        self.targets_tree.column("SNR", width=70)

        # Add scrollbar to targets tree
        tree_scroll = ttk.Scrollbar(
            targets_frame, orient="vertical", command=self.targets_tree.yview
        )
        self.targets_tree.configure(yscrollcommand=tree_scroll.set)
        self.targets_tree.pack(side="left", fill="both", expand=True, padx=5, pady=5)
        tree_scroll.pack(side="right", fill="y", padx=(0, 5), pady=5)

    def setup_map_tab(self):
        """Setup the map display tab with embedded browser"""
        # Main container
        main_container = ttk.Frame(self.tab_map)
        main_container.pack(fill="both", expand=True, padx=10, pady=10)

        # Top frame for controls
        controls_frame = ttk.Frame(main_container)
        controls_frame.pack(fill="x", pady=(0, 10))

        # Map controls
        ttk.Button(controls_frame, text="Generate/Refresh Map", command=self.generate_map).pack(
            side="left", padx=5
        )

        if TKINTERWEB_AVAILABLE:
            ttk.Button(
                controls_frame, text="Open in External Browser", command=self.open_external_browser
            ).pack(side="left", padx=5)
        else:
            ttk.Label(
                controls_frame,
                text="Install tkinterweb: pip install tkinterweb",
                foreground="orange",
                font=("Arial", 9),
            ).pack(side="left", padx=5)
            ttk.Button(
                controls_frame, text="Open in Browser", command=self.open_external_browser
            ).pack(side="left", padx=5)

        self.map_status_label = ttk.Label(controls_frame, text="Map: Ready to generate")
        self.map_status_label.pack(side="left", padx=20)

        # Map info display
        info_frame = ttk.Frame(main_container)
        info_frame.pack(fill="x", pady=(0, 10))

        self.map_info_label = ttk.Label(
            info_frame, text="No GPS data received yet", font=("Arial", 10)
        )
        self.map_info_label.pack()

        # Embedded browser area - This is where the map will appear
        self.browser_container = ttk.Frame(main_container)
        self.browser_container.pack(fill="both", expand=True)

        # Create browser widget if tkinterweb is available
        if TKINTERWEB_AVAILABLE:
            try:
                self.browser = tkinterweb.HtmlFrame(self.browser_container)
                self.browser.pack(fill="both", expand=True)

                # Initial placeholder HTML
                placeholder_html = """
                <html>
                <body style="background-color:#2b2b2b; color:#e0e0e0; padding:20px;">
                    <h2>Radar Map Display</h2>
                    <p>Click "Generate/Refresh Map" button to load the interactive map.</p>
                    <p>The map will display:</p>
                    <ul>
                        <li>Radar position (red marker)</li>
                        <li>Coverage area (red circle)</li>
                        <li>Detected targets (colored markers)</li>
                    </ul>
                    <p>Map updates automatically every 5 seconds when new data is available.</p>
                </body>
                </html>
                """
                self.browser.load_html(placeholder_html)

            except (tk.TclError, RuntimeError) as e:
                logging.error(f"Failed to create embedded browser: {e}")
                self.create_browser_fallback()
        else:
            self.create_browser_fallback()

    def setup_settings_tab(self):
        """Setup the settings tab"""
        settings_frame = ttk.Frame(self.tab_settings)
        settings_frame.pack(fill="both", expand=True, padx=10, pady=10)

        entries = [
            ("System Frequency (Hz):", "system_frequency", 10e9),
            ("Chirp Duration 1 - Long (s):", "chirp_duration_1", 30e-6),
            ("Chirp Duration 2 - Short (s):", "chirp_duration_2", 0.5e-6),
            ("Chirps per Position:", "chirps_per_position", 32),
            ("Frequency Min (Hz):", "freq_min", 10e6),
            ("Frequency Max (Hz):", "freq_max", 30e6),
            ("PRF1 (Hz):", "prf1", 1000),
            ("PRF2 (Hz):", "prf2", 2000),
            ("Max Distance (m):", "max_distance", 50000),
            ("Map Size (m):", "map_size", 50000),
        ]

        self.settings_vars = {}

        for i, (label, attr, default) in enumerate(entries):
            ttk.Label(settings_frame, text=label).grid(row=i, column=0, sticky="w", padx=5, pady=5)
            var = tk.StringVar(value=str(default))
            entry = ttk.Entry(settings_frame, textvariable=var, width=25)
            entry.grid(row=i, column=1, padx=5, pady=5)
            self.settings_vars[attr] = var

        # Map type info
        ttk.Label(settings_frame, text="Map Type:", font=("Arial", 10, "bold")).grid(
            row=len(entries), column=0, sticky="w", padx=5, pady=10
        )
        ttk.Label(settings_frame, text="OpenStreetMap (Free)", foreground="green").grid(
            row=len(entries), column=1, sticky="w", padx=5, pady=10
        )

        ttk.Button(settings_frame, text="Apply Settings", command=self.apply_settings).grid(
            row=len(entries) + 1, column=0, columnspan=2, pady=10
        )

    def create_browser_fallback(self):
        """Create a fallback display when tkinterweb is not available"""
        for widget in self.browser_container.winfo_children():
            widget.destroy()

        # Create text widget as fallback
        text_frame = ttk.Frame(self.browser_container)
        text_frame.pack(fill="both", expand=True)

        text_widget = tk.Text(
            text_frame, wrap="word", bg=DARK_ACCENT, fg=DARK_FG, font=("Courier", 10)
        )
        scrollbar = ttk.Scrollbar(text_frame, orient="vertical", command=text_widget.yview)
        text_widget.configure(yscrollcommand=scrollbar.set)

        text_widget.pack(side="left", fill="both", expand=True)
        scrollbar.pack(side="right", fill="y")

        # Insert placeholder text
        placeholder = """EMBEDDED BROWSER NOT AVAILABLE

To enable the interactive map viewer, please install tkinterweb:

    pip install tkinterweb

Without tkinterweb, you can still:
1. Generate maps using the button above
2. View them in your external browser
3. See map data in the text display below

Map HTML will appear here when generated.
"""
        text_widget.insert("1.0", placeholder)
        text_widget.configure(state="disabled")

        # Store reference for later updates
        self.fallback_text = text_widget

    def update_embedded_browser(self, html_content):
        """Update the embedded browser with new HTML content"""
        try:
            if TKINTERWEB_AVAILABLE and hasattr(self, "browser") and self.browser:
                # Update existing browser
                self.browser.load_html(html_content)
                logging.info("Embedded browser updated with new map")
            elif hasattr(self, "fallback_text"):
                # Update fallback text widget
                self.fallback_text.configure(state="normal")
                self.fallback_text.delete("1.0", tk.END)
                self.fallback_text.insert("1.0", html_content)
                self.fallback_text.configure(state="disabled")
                self.fallback_text.see("1.0")  # Scroll to top
                logging.info("Fallback text widget updated with map HTML")
        except (tk.TclError, RuntimeError) as e:
            logging.error(f"Error updating embedded browser: {e}")

    def generate_map(self):
        """Generate or update the map display"""
        if self.current_gps.latitude == 0 and self.current_gps.longitude == 0:
            messagebox.showinfo(
                "Info", "No GPS data available yet. Start demo mode or wait for GPS data."
            )
            return

        current_time = time.time()

        # Only update map at specified intervals
        if current_time - self.last_map_update < 1.0:  # 1 second minimum between updates
            return

        try:
            # Get current targets (demo + real)
            targets = self.get_combined_targets()

            # Generate map HTML
            map_html = self.map_generator.generate_map_html_content(
                self.current_gps, targets, self.settings.map_size
            )

            self.current_map_html = map_html

            # Update embedded browser
            self.update_embedded_browser(map_html)

            # Update map status
            self.map_status_label.config(text=f"Map: Generated with {len(targets)} targets")

            # Update map info display
            self.map_info_label.config(
                text=f"Radar: {self.current_gps.latitude:.6f}, {self.current_gps.longitude:.6f} | "
                f"Targets: {len(targets)} | "
                f"Pitch: {self.current_gps.pitch:+.1f}° | "
                f"Coverage: {self.settings.map_size / 1000:.1f}km"
            )

            self.last_map_update = current_time

            logging.info(f"Map generated with {len(targets)} targets")

        except (OSError, ValueError) as e:
            logging.error(f"Error generating map: {e}")
            self.map_status_label.config(text=f"Map: Error - {str(e)[:50]}")

    def open_external_browser(self):
        """Open map in external browser"""
        if not self.current_map_html:
            messagebox.showinfo("Info", "Generate a map first using 'Generate/Refresh Map' button.")
            return

        try:
            # Create temporary HTML file
            import tempfile

            with tempfile.NamedTemporaryFile(
                mode="w", suffix=".html", delete=False, encoding="utf-8"
            ) as temp_file:
                temp_file.write(self.current_map_html)
                temp_file_path = temp_file.name

            # Open in default browser
            webbrowser.open("file://" + os.path.abspath(temp_file_path))
            logging.info(f"Map opened in external browser: {temp_file_path}")

        except (OSError, ValueError) as e:
            logging.error(f"Error opening external browser: {e}")
            messagebox.showerror("Error", f"Failed to open browser: {e}")

    # ... [Rest of the methods remain the same - demo mode, radar processing, etc.] ...


# IMPORTANT: You need to install tkinterweb first!
# Run: pip install tkinterweb


def main():
    """Main application entry point"""
    try:
        root = tk.Tk()
        _app = RadarGUI(root)
        root.mainloop()
    except Exception as e:  # noqa: BLE001
        logging.error(f"Application error: {e}")
        messagebox.showerror("Fatal Error", f"Application failed to start: {e}")


if __name__ == "__main__":
    main()
