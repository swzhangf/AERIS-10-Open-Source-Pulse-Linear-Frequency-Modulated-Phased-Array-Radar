#!/usr/bin/env python3
"""
PLFM Radar Dashboard - PyQt6 Edition with Embedded Leaflet Map
===============================================================
A professional-grade radar tracking GUI using PyQt6 with embedded web-based
Leaflet.js maps for real-time target visualization.

Features:
- Embedded interactive Leaflet map with OpenStreetMap tiles
- Real-time target tracking and visualization
- Python-to-JavaScript bridge for seamless updates
- Dark theme UI matching existing radar dashboard style
- Support for multiple tile servers (OSM, Google, satellite)
- Marker clustering for dense target environments
- Coverage area visualization
- Target trails/history

Author: PLFM Radar Team
Version: 1.0.0
"""

import sys
import json
import math
import time
import random
import logging
from dataclasses import dataclass, asdict
from enum import Enum

# PyQt6 imports
from PyQt6.QtWidgets import (
    QApplication, QMainWindow, QWidget, QVBoxLayout, QHBoxLayout,
    QTabWidget, QLabel, QPushButton, QComboBox, QSpinBox, QDoubleSpinBox,
    QGroupBox, QGridLayout, QSplitter, QFrame, QStatusBar, QCheckBox,
    QTableWidget, QTableWidgetItem,
    QHeaderView
)
from PyQt6.QtCore import (
    Qt, QTimer, pyqtSignal, pyqtSlot, QObject
)
from PyQt6.QtGui import (
    QFont, QColor, QPalette
)
from PyQt6.QtWebEngineWidgets import QWebEngineView
from PyQt6.QtWebChannel import QWebChannel

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

# =============================================================================
# Dark Theme Colors (matching existing radar dashboard)
# =============================================================================
DARK_BG = "#2b2b2b"
DARK_FG = "#e0e0e0"
DARK_ACCENT = "#3c3f41"
DARK_HIGHLIGHT = "#4e5254"
DARK_BORDER = "#555555"
DARK_TEXT = "#cccccc"
DARK_BUTTON = "#3c3f41"
DARK_BUTTON_HOVER = "#4e5254"
DARK_SUCCESS = "#4CAF50"
DARK_WARNING = "#FFC107"
DARK_ERROR = "#F44336"
DARK_INFO = "#2196F3"

# =============================================================================
# Data Classes
# =============================================================================
@dataclass
class RadarTarget:
    """Represents a detected radar target"""
    id: int
    range: float          # Range in meters
    velocity: float       # Velocity in m/s (positive = approaching)
    azimuth: float        # Azimuth angle in degrees
    elevation: float      # Elevation angle in degrees
    latitude: float = 0.0
    longitude: float = 0.0
    snr: float = 0.0      # Signal-to-noise ratio in dB
    timestamp: float = 0.0
    track_id: int = -1
    classification: str = "unknown"
    
    def to_dict(self) -> dict:
        """Convert to dictionary for JSON serialization"""
        return asdict(self)


@dataclass
class GPSData:
    """GPS position and orientation data"""
    latitude: float
    longitude: float
    altitude: float
    pitch: float          # Pitch angle in degrees
    heading: float = 0.0  # Heading in degrees (0 = North)
    timestamp: float = 0.0
    
    def to_dict(self) -> dict:
        return asdict(self)


@dataclass 
class RadarSettings:
    """Radar system configuration"""
    system_frequency: float = 10e9    # Hz
    chirp_duration_1: float = 30e-6   # Long chirp duration (s)
    chirp_duration_2: float = 0.5e-6  # Short chirp duration (s)
    chirps_per_position: int = 32
    freq_min: float = 10e6            # Hz
    freq_max: float = 30e6            # Hz
    prf1: float = 1000                # PRF 1 (Hz)
    prf2: float = 2000                # PRF 2 (Hz)
    max_distance: float = 50000       # Max detection range (m)
    coverage_radius: float = 50000    # Map coverage radius (m)


class TileServer(Enum):
    """Available map tile servers"""
    OPENSTREETMAP = "osm"
    GOOGLE_MAPS = "google"
    GOOGLE_SATELLITE = "google_sat"
    GOOGLE_HYBRID = "google_hybrid"
    ESRI_SATELLITE = "esri_sat"


# =============================================================================
# JavaScript Bridge - Enables Python <-> JavaScript communication
# =============================================================================
class MapBridge(QObject):
    """
    Bridge object exposed to JavaScript for bidirectional communication.
    This allows Python to call JavaScript functions and vice versa.
    """
    
    # Signals emitted when JS calls Python
    mapClicked = pyqtSignal(float, float)  # lat, lon
    markerClicked = pyqtSignal(int)         # target_id
    mapReady = pyqtSignal()
    
    def __init__(self, parent=None):
        super().__init__(parent)
        self._map_ready = False
    
    @pyqtSlot(float, float)
    def onMapClick(self, lat: float, lon: float):
        """Called from JavaScript when map is clicked"""
        logger.debug(f"Map clicked at: {lat}, {lon}")
        self.mapClicked.emit(lat, lon)
    
    @pyqtSlot(int)
    def onMarkerClick(self, target_id: int):
        """Called from JavaScript when a target marker is clicked"""
        logger.debug(f"Marker clicked: Target #{target_id}")
        self.markerClicked.emit(target_id)
    
    @pyqtSlot()
    def onMapReady(self):
        """Called from JavaScript when map is fully initialized"""
        logger.info("Map is ready")
        self._map_ready = True
        self.mapReady.emit()
    
    @pyqtSlot(str)
    def logFromJS(self, message: str):
        """Receive log messages from JavaScript"""
        logger.debug(f"[JS] {message}")
    
    @property
    def is_ready(self) -> bool:
        return self._map_ready


# =============================================================================
# Map Widget - Embedded Leaflet Map
# =============================================================================
class RadarMapWidget(QWidget):
    """
    Custom widget embedding a Leaflet.js map via QWebEngineView.
    Provides methods for updating radar position, targets, and coverage.
    """
    
    targetSelected = pyqtSignal(int)  # Emitted when a target is selected
    
    def __init__(self, parent=None):
        super().__init__(parent)
        
        # State
        self._radar_position = GPSData(
            latitude=40.7128,   # Default: New York City
            longitude=-74.0060,
            altitude=100.0,
            pitch=0.0
        )
        self._targets: list[RadarTarget] = []
        self._coverage_radius = 50000  # meters
        self._tile_server = TileServer.OPENSTREETMAP
        self._show_coverage = True
        self._show_trails = False
        self._target_history: dict[int, list[tuple[float, float]]] = {}
        
        # Setup UI
        self._setup_ui()
        
        # Setup bridge
        self._bridge = MapBridge(self)
        self._bridge.mapReady.connect(self._on_map_ready)
        self._bridge.markerClicked.connect(self._on_marker_clicked)
        
        # Setup web channel
        self._channel = QWebChannel()
        self._channel.registerObject("bridge", self._bridge)
        self._web_view.page().setWebChannel(self._channel)
        
        # Load map
        self._load_map()
    
    def _setup_ui(self):
        """Setup the widget UI"""
        layout = QVBoxLayout(self)
        layout.setContentsMargins(0, 0, 0, 0)
        
        # Control bar
        control_bar = QFrame()
        control_bar.setStyleSheet(f"background-color: {DARK_ACCENT}; border-radius: 4px;")
        control_layout = QHBoxLayout(control_bar)
        control_layout.setContentsMargins(8, 4, 8, 4)
        
        # Tile server selector
        self._tile_combo = QComboBox()
        self._tile_combo.addItem("OpenStreetMap", TileServer.OPENSTREETMAP)
        self._tile_combo.addItem("Google Maps", TileServer.GOOGLE_MAPS)
        self._tile_combo.addItem("Google Satellite", TileServer.GOOGLE_SATELLITE)
        self._tile_combo.addItem("Google Hybrid", TileServer.GOOGLE_HYBRID)
        self._tile_combo.addItem("ESRI Satellite", TileServer.ESRI_SATELLITE)
        self._tile_combo.currentIndexChanged.connect(self._on_tile_server_changed)
        self._tile_combo.setStyleSheet(f"""
            QComboBox {{
                background-color: {DARK_BUTTON};
                color: {DARK_FG};
                border: 1px solid {DARK_BORDER};
                padding: 4px 8px;
                border-radius: 4px;
            }}
        """)
        control_layout.addWidget(QLabel("Tiles:"))
        control_layout.addWidget(self._tile_combo)
        
        # Coverage toggle
        self._coverage_check = QCheckBox("Show Coverage")
        self._coverage_check.setChecked(True)
        self._coverage_check.stateChanged.connect(self._on_coverage_toggled)
        control_layout.addWidget(self._coverage_check)
        
        # Trails toggle
        self._trails_check = QCheckBox("Show Trails")
        self._trails_check.setChecked(False)
        self._trails_check.stateChanged.connect(self._on_trails_toggled)
        control_layout.addWidget(self._trails_check)
        
        # Center on radar button
        center_btn = QPushButton("Center on Radar")
        center_btn.clicked.connect(self._center_on_radar)
        center_btn.setStyleSheet(f"""
            QPushButton {{
                background-color: {DARK_BUTTON};
                color: {DARK_FG};
                border: 1px solid {DARK_BORDER};
                padding: 4px 12px;
                border-radius: 4px;
            }}
            QPushButton:hover {{
                background-color: {DARK_BUTTON_HOVER};
            }}
        """)
        control_layout.addWidget(center_btn)
        
        # Fit all button
        fit_btn = QPushButton("Fit All Targets")
        fit_btn.clicked.connect(self._fit_all_targets)
        fit_btn.setStyleSheet(center_btn.styleSheet())
        control_layout.addWidget(fit_btn)
        
        control_layout.addStretch()
        
        # Status label
        self._status_label = QLabel("Initializing map...")
        self._status_label.setStyleSheet(f"color: {DARK_INFO};")
        control_layout.addWidget(self._status_label)
        
        layout.addWidget(control_bar)
        
        # Web view for map
        self._web_view = QWebEngineView()
        self._web_view.setMinimumSize(400, 300)
        layout.addWidget(self._web_view, stretch=1)
    
    def _get_map_html(self) -> str:
        """Generate the complete HTML for the Leaflet map"""
        return f'''<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Radar Map</title>
    
    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
        integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY="
        crossorigin=""/>
    
    <!-- Leaflet JS -->
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"
        integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo="
        crossorigin=""></script>
    
    <!-- QWebChannel -->
    <script src="qrc:///qtwebchannel/qwebchannel.js"></script>
    
    <style>
        * {{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }}
        
        html, body {{
            height: 100%;
            width: 100%;
            font-family: 'Segoe UI', Arial, sans-serif;
        }}
        
        #map {{
            height: 100%;
            width: 100%;
            background-color: {DARK_BG};
        }}
        
        .leaflet-container {{
            background-color: {DARK_BG} !important;
        }}
        
        /* Custom popup styling */
        .leaflet-popup-content-wrapper {{
            background-color: {DARK_ACCENT};
            color: {DARK_FG};
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.4);
        }}
        
        .leaflet-popup-tip {{
            background-color: {DARK_ACCENT};
        }}
        
        .leaflet-popup-content {{
            margin: 12px;
        }}
        
        .popup-title {{
            font-size: 14px;
            font-weight: bold;
            color: #4e9eff;
            margin-bottom: 8px;
            border-bottom: 1px solid {DARK_BORDER};
            padding-bottom: 6px;
        }}
        
        .popup-row {{
            display: flex;
            justify-content: space-between;
            margin: 4px 0;
            font-size: 12px;
        }}
        
        .popup-label {{
            color: {DARK_TEXT};
        }}
        
        .popup-value {{
            color: {DARK_FG};
            font-weight: 500;
        }}
        
        .status-approaching {{
            color: #F44336;
        }}
        
        .status-receding {{
            color: #2196F3;
        }}
        
        .status-stationary {{
            color: #9E9E9E;
        }}
        
        /* Legend */
        .legend {{
            background-color: {DARK_ACCENT};
            color: {DARK_FG};
            padding: 10px 14px;
            border-radius: 6px;
            font-size: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.3);
        }}
        
        .legend-title {{
            font-weight: bold;
            margin-bottom: 8px;
            color: #4e9eff;
        }}
        
        .legend-item {{
            display: flex;
            align-items: center;
            margin: 4px 0;
        }}
        
        .legend-color {{
            width: 14px;
            height: 14px;
            border-radius: 50%;
            margin-right: 8px;
            border: 1px solid white;
        }}
    </style>
</head>
<body>
    <div id="map"></div>
    
    <script>
        // Global variables
        var map;
        var radarMarker;
        var coverageCircle;
        var targetMarkers = {{}};
        var targetTrails = {{}};           // Polyline objects for display
        var targetTrailHistory = {{}};     // Store position history even when trails hidden
        var bridge = null;
        var currentTileLayer = null;
        var showCoverage = true;
        var showTrails = false;
        var maxTrailLength = 30;           // Maximum number of points in trail
        
        // Tile server configurations
        var tileServers = {{
            'osm': {{
                url: 'https://{{s}}.tile.openstreetmap.org/{{z}}/{{x}}/{{y}}.png',
                attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>',
                maxZoom: 19
            }},
            'google': {{
                url: 'https://mt0.google.com/vt/lyrs=m&hl=en&x={{x}}&y={{y}}&z={{z}}&s=Ga',
                attribution: '&copy; Google Maps',
                maxZoom: 22
            }},
            'google_sat': {{
                url: 'https://mt0.google.com/vt/lyrs=s&hl=en&x={{x}}&y={{y}}&z={{z}}&s=Ga',
                attribution: '&copy; Google Maps',
                maxZoom: 22
            }},
            'google_hybrid': {{
                url: 'https://mt0.google.com/vt/lyrs=y&hl=en&x={{x}}&y={{y}}&z={{z}}&s=Ga',
                attribution: '&copy; Google Maps',
                maxZoom: 22
            }},
            'esri_sat': {{
                url: 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{{z}}/{{y}}/{{x}}',
                attribution: '&copy; Esri',
                maxZoom: 19
            }}
        }};
        
        // Initialize map
        function initMap() {{
            console.log('Initializing map...');
            
            // Create map centered on default position
            map = L.map('map', {{
                preferCanvas: true,
                zoomControl: true
            }}).setView([{self._radar_position.latitude}, {self._radar_position.longitude}], 10);
            
            // Add default tile layer
            setTileServer('osm');
            
            // Create radar marker
            var radarIcon = L.divIcon({{
                className: 'radar-icon',
                html: '<div style="' +
                    'background: radial-gradient(circle, #FF5252 0%, #D32F2F 100%);' +
                    'width: 24px; height: 24px;' +
                    'border-radius: 50%;' +
                    'border: 3px solid white;' +
                    'box-shadow: 0 2px 8px rgba(0,0,0,0.5);' +
                    '"></div>',
                iconSize: [24, 24],
                iconAnchor: [12, 12]
            }});
            
            radarMarker = L.marker(
                [{self._radar_position.latitude}, {self._radar_position.longitude}],
                {{ icon: radarIcon, zIndexOffset: 1000 }}
            ).addTo(map);
            
            // Radar popup
            updateRadarPopup();
            
            // Coverage circle
            coverageCircle = L.circle(
                [{self._radar_position.latitude}, {self._radar_position.longitude}],
                {{
                    radius: {self._coverage_radius},
                    color: '#FF5252',
                    fillColor: '#FF5252',
                    fillOpacity: 0.08,
                    weight: 2,
                    dashArray: '8, 8'
                }}
            ).addTo(map);
            
            // Add legend
            addLegend();
            
            // Map click handler
            map.on('click', function(e) {{
                if (bridge) {{
                    bridge.onMapClick(e.latlng.lat, e.latlng.lng);
                }}
            }});
            
            console.log('Map initialized successfully');
        }}
        
        function setTileServer(serverId) {{
            var config = tileServers[serverId];
            if (!config) return;
            
            if (currentTileLayer) {{
                map.removeLayer(currentTileLayer);
            }}
            
            currentTileLayer = L.tileLayer(config.url, {{
                attribution: config.attribution,
                maxZoom: config.maxZoom
            }}).addTo(map);
        }}
        
        function updateRadarPopup() {{
            if (!radarMarker) return;
            
            var content = '<div class="popup-title">Radar System</div>' +
                (
                    '<div class="popup-row"><span class="popup-label">Latitude:</span>' +
                    '<span class="popup-value">'
                ) +
                    radarMarker.getLatLng().lat.toFixed(6) + '</span></div>' +
                (
                    '<div class="popup-row"><span class="popup-label">Longitude:</span>' +
                    '<span class="popup-value">'
                ) +
                    radarMarker.getLatLng().lng.toFixed(6) + '</span></div>' +
                (
                    '<div class="popup-row"><span class="popup-label">Status:</span>' +
                    '<span class="popup-value status-approaching">Active</span></div>'
                );
            
            radarMarker.bindPopup(content);
        }}
        
        function addLegend() {{
            var legend = L.control({{ position: 'bottomright' }});
            
            legend.onAdd = function(map) {{
                var div = L.DomUtil.create('div', 'legend');
                div.innerHTML = 
                    '<div class="legend-title">Target Legend</div>' +
                    (
                        '<div class="legend-item"><div class="legend-color" ' +
                        'style="background:#F44336"></div>Approaching</div>'
                    ) +
                    (
                        '<div class="legend-item"><div class="legend-color" ' +
                        'style="background:#2196F3"></div>Receding</div>'
                    ) +
                    (
                        '<div class="legend-item"><div class="legend-color" ' +
                        'style="background:#9E9E9E"></div>Stationary</div>'
                    ) +
                    (
                        '<div class="legend-item"><div class="legend-color" ' +
                        'style="background:#FF5252"></div>Radar</div>'
                    );
                return div;
            }};
            
            legend.addTo(map);
        }}
        
        // Update radar position
        function updateRadarPosition(lat, lon, alt, pitch, heading) {{
            if (!radarMarker || !coverageCircle) return;
            
            var newPos = [lat, lon];
            radarMarker.setLatLng(newPos);
            coverageCircle.setLatLng(newPos);
            updateRadarPopup();
            
            if (bridge) {{
                bridge.logFromJS(
                    'Radar position updated: ' + lat.toFixed(4) + ', ' + lon.toFixed(4)
                );
            }}
        }}
        
        // Update targets on map
        function updateTargets(targetsJson) {{
            var targets = JSON.parse(targetsJson);
            
            // Track which target IDs are in this update
            var currentIds = {{}};
            
            targets.forEach(function(target) {{
                currentIds[target.id] = true;
                
                // Calculate position
                var lat = target.latitude;
                var lon = target.longitude;
                
                // Determine color based on velocity
                var color = getTargetColor(target.velocity);
                var size = Math.max(10, Math.min(20, 10 + target.snr / 3));
                
                // Always update trail history (even if trails not visible)
                if (!targetTrailHistory[target.id]) {{
                    targetTrailHistory[target.id] = [];
                }}
                targetTrailHistory[target.id].push([lat, lon]);
                if (targetTrailHistory[target.id].length > maxTrailLength) {{
                    targetTrailHistory[target.id].shift();
                }}
                
                // Create or update marker
                if (targetMarkers[target.id]) {{
                    // Update existing marker position
                    targetMarkers[target.id].setLatLng([lat, lon]);
                    
                    // Update marker icon (color may change with velocity)
                    var newIcon = L.divIcon({{
                        className: 'target-icon',
                        html: '<div style="' +
                            'background-color: ' + color + ';' +
                            'width: ' + size + 'px;' +
                            'height: ' + size + 'px;' +
                            'border-radius: 50%;' +
                            'border: 2px solid white;' +
                            'box-shadow: 0 2px 6px rgba(0,0,0,0.4);' +
                            '"></div>',
                        iconSize: [size, size],
                        iconAnchor: [size/2, size/2]
                    }});
                    targetMarkers[target.id].setIcon(newIcon);
                    
                    // Update trail polyline if it exists and trails are visible
                    if (targetTrails[target.id]) {{
                        targetTrails[target.id].setLatLngs(targetTrailHistory[target.id]);
                        targetTrails[target.id].setStyle({{ color: color }});
                    }}
                }} else {{
                    // Create new marker
                    var icon = L.divIcon({{
                        className: 'target-icon',
                        html: '<div style="' +
                            'background-color: ' + color + ';' +
                            'width: ' + size + 'px;' +
                            'height: ' + size + 'px;' +
                            'border-radius: 50%;' +
                            'border: 2px solid white;' +
                            'box-shadow: 0 2px 6px rgba(0,0,0,0.4);' +
                            '"></div>',
                        iconSize: [size, size],
                        iconAnchor: [size/2, size/2]
                    }});
                    
                    var marker = L.marker([lat, lon], {{ icon: icon }})
                        .addTo(map);
                    
                    // Add click handler
                    marker.on('click', function() {{
                        if (bridge) {{
                            bridge.onMarkerClick(target.id);
                        }}
                    }});
                    
                    targetMarkers[target.id] = marker;
                    
                    // Create trail polyline if trails are enabled
                    if (showTrails) {{
                        targetTrails[target.id] = L.polyline(targetTrailHistory[target.id], {{
                            color: color,
                            weight: 3,
                            opacity: 0.7,
                            lineCap: 'round',
                            lineJoin: 'round'
                        }}).addTo(map);
                    }}
                }}
                
                // Update popup
                updateTargetPopup(target);
            }});
            
            // Remove markers for targets no longer present
            for (var id in targetMarkers) {{
                if (!currentIds[id]) {{
                    map.removeLayer(targetMarkers[id]);
                    delete targetMarkers[id];
                    
                    if (targetTrails[id]) {{
                        map.removeLayer(targetTrails[id]);
                        delete targetTrails[id];
                    }}
                    
                    // Also clean up trail history
                    delete targetTrailHistory[id];
                }}
            }}
        }}
        
        function updateTargetPopup(target) {{
            if (!targetMarkers[target.id]) return;
            
            var statusClass = target.velocity > 1 ? 'status-approaching' : 
                             (target.velocity < -1 ? 'status-receding' : 'status-stationary');
            var statusText = target.velocity > 1 ? 'Approaching' : 
                            (target.velocity < -1 ? 'Receding' : 'Stationary');
            
            var content = '<div class="popup-title">Target #' + target.id + '</div>' +
                (
                    '<div class="popup-row"><span class="popup-label">Range:</span>' +
                    '<span class="popup-value">'
                ) +
                    target.range.toFixed(1) + ' m</span></div>' +
                (
                    '<div class="popup-row"><span class="popup-label">Velocity:</span>' +
                    '<span class="popup-value">'
                ) +
                    target.velocity.toFixed(1) + ' m/s</span></div>' +
                (
                    '<div class="popup-row"><span class="popup-label">Azimuth:</span>' +
                    '<span class="popup-value">'
                ) +
                    target.azimuth.toFixed(1) + '&deg;</span></div>' +
                (
                    '<div class="popup-row"><span class="popup-label">Elevation:</span>' +
                    '<span class="popup-value">'
                ) +
                    target.elevation.toFixed(1) + '&deg;</span></div>' +
                (
                    '<div class="popup-row"><span class="popup-label">SNR:</span>' +
                    '<span class="popup-value">'
                ) +
                    target.snr.toFixed(1) + ' dB</span></div>' +
                (
                    '<div class="popup-row"><span class="popup-label">Track ID:</span>' +
                    '<span class="popup-value">'
                ) +
                    target.track_id + '</span></div>' +
                (
                    '<div class="popup-row"><span class="popup-label">Status:</span>' +
                    '<span class="popup-value '
                ) +
                    statusClass + '">' + statusText + '</span></div>';
            
            targetMarkers[target.id].bindPopup(content);
        }}
        
        function getTargetColor(velocity) {{
            if (velocity > 50) return '#FF1744';      // Fast approaching - red
            if (velocity > 10) return '#FF5252';      // Medium approaching - light red
            if (velocity > 1) return '#FF8A65';       // Slow approaching - orange
            if (velocity < -50) return '#1565C0';     // Fast receding - dark blue
            if (velocity < -10) return '#2196F3';     // Medium receding - blue
            if (velocity < -1) return '#64B5F6';      // Slow receding - light blue
            return '#9E9E9E';                          // Stationary - gray
        }}
        
        // Coverage circle controls
        function setCoverageVisible(visible) {{
            showCoverage = visible;
            if (coverageCircle) {{
                if (visible) {{
                    coverageCircle.addTo(map);
                }} else {{
                    map.removeLayer(coverageCircle);
                }}
            }}
        }}
        
        function setCoverageRadius(radius) {{
            if (coverageCircle) {{
                coverageCircle.setRadius(radius);
            }}
        }}
        
        // Trail controls
        function setTrailsVisible(visible) {{
            showTrails = visible;
            
            if (visible) {{
                // Create trails for all existing markers using stored history
                for (var id in targetMarkers) {{
                    if (
                        !targetTrails[id] &&
                        targetTrailHistory[id] &&
                        targetTrailHistory[id].length > 1
                    ) {{
                        // Get color from current marker position (approximate)
                        var color = '#4CAF50';  // Default green
                        targetTrails[id] = L.polyline(targetTrailHistory[id], {{
                            color: color,
                            weight: 3,
                            opacity: 0.7,
                            lineCap: 'round',
                            lineJoin: 'round'
                        }}).addTo(map);
                    }} else if (targetTrails[id]) {{
                        // Trail exists but may have been removed, re-add it
                        targetTrails[id].addTo(map);
                    }}
                }}
            }} else {{
                // Hide all trails (but keep history)
                for (var id in targetTrails) {{
                    map.removeLayer(targetTrails[id]);
                }}
            }}
            
            if (bridge) {{
                bridge.logFromJS('Trails visibility set to: ' + visible);
            }}
        }}
        
        // View controls
        function centerOnRadar() {{
            if (radarMarker) {{
                map.setView(radarMarker.getLatLng(), map.getZoom());
            }}
        }}
        
        function fitAllTargets() {{
            var bounds = L.latLngBounds([]);
            
            if (radarMarker) {{
                bounds.extend(radarMarker.getLatLng());
            }}
            
            for (var id in targetMarkers) {{
                bounds.extend(targetMarkers[id].getLatLng());
            }}
            
            if (bounds.isValid()) {{
                map.fitBounds(bounds, {{ padding: [50, 50] }});
            }}
        }}
        
        function setZoom(level) {{
            map.setZoom(level);
        }}
        
        // Initialize QWebChannel and map
        document.addEventListener('DOMContentLoaded', function() {{
            new QWebChannel(qt.webChannelTransport, function(channel) {{
                bridge = channel.objects.bridge;
                console.log('QWebChannel connected');
                
                // Initialize map after channel is ready
                initMap();
                
                // Notify Python that map is ready
                if (bridge) {{
                    bridge.onMapReady();
                }}
            }});
        }});
    </script>
</body>
</html>'''
    
    def _load_map(self):
        """Load the map HTML into the web view"""
        html = self._get_map_html()
        self._web_view.setHtml(html)
        logger.info("Map HTML loaded")
    
    def _on_map_ready(self):
        """Called when the map is fully initialized"""
        self._status_label.setText(f"Map ready - {len(self._targets)} targets")
        self._status_label.setStyleSheet(f"color: {DARK_SUCCESS};")
        logger.info("Map widget ready")
    
    def _on_marker_clicked(self, target_id: int):
        """Handle marker click events"""
        self.targetSelected.emit(target_id)
    
    def _on_tile_server_changed(self, _index: int):
        """Handle tile server change"""
        server = self._tile_combo.currentData()
        self._tile_server = server
        self._run_js(f"setTileServer('{server.value}')")
    
    def _on_coverage_toggled(self, state: int):
        """Handle coverage visibility toggle"""
        visible = state == Qt.CheckState.Checked.value
        self._show_coverage = visible
        self._run_js(f"setCoverageVisible({str(visible).lower()})")
    
    def _on_trails_toggled(self, state: int):
        """Handle trails visibility toggle"""
        visible = state == Qt.CheckState.Checked.value
        self._show_trails = visible
        self._run_js(f"setTrailsVisible({str(visible).lower()})")
    
    def _center_on_radar(self):
        """Center map view on radar position"""
        self._run_js("centerOnRadar()")
    
    def _fit_all_targets(self):
        """Fit map view to show all targets"""
        self._run_js("fitAllTargets()")
    
    def _run_js(self, script: str):
        """Execute JavaScript in the web view"""
        self._web_view.page().runJavaScript(script)
    
    # Public API
    def set_radar_position(self, gps_data: GPSData):
        """Update the radar position on the map"""
        self._radar_position = gps_data
        self._run_js(
            f"updateRadarPosition({gps_data.latitude}, {gps_data.longitude}, "
            f"{gps_data.altitude}, {gps_data.pitch}, {gps_data.heading})"
        )
    
    def set_targets(self, targets: list[RadarTarget]):
        """Update all targets on the map"""
        self._targets = targets
        
        # Convert targets to JSON
        targets_data = [t.to_dict() for t in targets]
        targets_json = json.dumps(targets_data)
        
        # Update status
        self._status_label.setText(f"{len(targets)} targets tracked")
        
        # Call JavaScript update function
        self._run_js(f"updateTargets('{targets_json}')")
    
    def set_coverage_radius(self, radius: float):
        """Set the coverage circle radius in meters"""
        self._coverage_radius = radius
        self._run_js(f"setCoverageRadius({radius})")
    
    def set_zoom(self, level: int):
        """Set map zoom level (0-19)"""
        level = max(0, min(19, level))
        self._run_js(f"setZoom({level})")


# =============================================================================
# Utility Functions
# =============================================================================
def polar_to_geographic(
    radar_lat: float, 
    radar_lon: float, 
    range_m: float, 
    azimuth_deg: float
) -> tuple[float, float]:
    """
    Convert polar coordinates (range, azimuth) relative to radar
    to geographic coordinates (latitude, longitude).
    
    Args:
        radar_lat: Radar latitude in degrees
        radar_lon: Radar longitude in degrees
        range_m: Range from radar in meters
        azimuth_deg: Azimuth angle in degrees (0 = North, clockwise)
    
    Returns:
        Tuple of (latitude, longitude) for the target
    """
    # Earth's radius in meters
    R = 6371000
    
    # Convert to radians
    lat1 = math.radians(radar_lat)
    lon1 = math.radians(radar_lon)
    bearing = math.radians(azimuth_deg)
    
    # Calculate new position
    lat2 = math.asin(
        math.sin(lat1) * math.cos(range_m / R) +
        math.cos(lat1) * math.sin(range_m / R) * math.cos(bearing)
    )
    
    lon2 = lon1 + math.atan2(
        math.sin(bearing) * math.sin(range_m / R) * math.cos(lat1),
        math.cos(range_m / R) - math.sin(lat1) * math.sin(lat2)
    )
    
    return (math.degrees(lat2), math.degrees(lon2))


# =============================================================================
# Target Simulator (Demo Mode)
# =============================================================================
class TargetSimulator(QObject):
    """Simulates radar targets for demonstration purposes"""
    
    targetsUpdated = pyqtSignal(list)  # Emits list of RadarTarget
    
    def __init__(self, radar_position: GPSData, parent=None):
        super().__init__(parent)
        
        self._radar_position = radar_position
        self._targets: list[RadarTarget] = []
        self._next_id = 1
        self._timer = QTimer()
        self._timer.timeout.connect(self._update_targets)
        
        # Initialize some targets
        self._initialize_targets()
    
    def _initialize_targets(self, count: int = 8):
        """Create initial set of simulated targets"""
        for _ in range(count):
            self._add_random_target()
    
    def _add_random_target(self):
        """Add a new random target"""
        # Random range between 5km and 40km
        range_m = random.uniform(5000, 40000)
        
        # Random azimuth
        azimuth = random.uniform(0, 360)
        
        # Random velocity (-100 to +100 m/s)
        velocity = random.uniform(-100, 100)
        
        # Random elevation
        elevation = random.uniform(-5, 45)
        
        # Calculate geographic position
        lat, lon = polar_to_geographic(
            self._radar_position.latitude,
            self._radar_position.longitude,
            range_m,
            azimuth
        )
        
        target = RadarTarget(
            id=self._next_id,
            range=range_m,
            velocity=velocity,
            azimuth=azimuth,
            elevation=elevation,
            latitude=lat,
            longitude=lon,
            snr=random.uniform(10, 35),
            timestamp=time.time(),
            track_id=self._next_id,
            classification=random.choice(["aircraft", "drone", "bird", "unknown"])
        )
        
        self._next_id += 1
        self._targets.append(target)
    
    def _update_targets(self):
        """Update target positions (called by timer)"""
        updated_targets = []
        
        for target in self._targets:
            # Update range based on velocity
            new_range = target.range - target.velocity * 0.5  # 0.5 second update
            
            # Check if target is still in range
            if new_range < 500 or new_range > 50000:
                # Remove this target and add a new one
                continue
            
            # Slightly vary velocity
            new_velocity = target.velocity + random.uniform(-2, 2)
            new_velocity = max(-150, min(150, new_velocity))
            
            # Slightly vary azimuth (simulate turning)
            new_azimuth = (target.azimuth + random.uniform(-0.5, 0.5)) % 360
            
            # Calculate new geographic position
            lat, lon = polar_to_geographic(
                self._radar_position.latitude,
                self._radar_position.longitude,
                new_range,
                new_azimuth
            )
            
            updated_target = RadarTarget(
                id=target.id,
                range=new_range,
                velocity=new_velocity,
                azimuth=new_azimuth,
                elevation=target.elevation + random.uniform(-0.1, 0.1),
                latitude=lat,
                longitude=lon,
                snr=target.snr + random.uniform(-1, 1),
                timestamp=time.time(),
                track_id=target.track_id,
                classification=target.classification
            )
            
            updated_targets.append(updated_target)
        
        # Occasionally add new targets
        if len(updated_targets) < 5 or (random.random() < 0.05 and len(updated_targets) < 15):
            self._add_random_target()
            updated_targets.append(self._targets[-1])
        
        self._targets = updated_targets
        self.targetsUpdated.emit(updated_targets)
    
    def start(self, interval_ms: int = 500):
        """Start the simulation"""
        self._timer.start(interval_ms)
    
    def stop(self):
        """Stop the simulation"""
        self._timer.stop()
    
    def set_radar_position(self, gps_data: GPSData):
        """Update radar position"""
        self._radar_position = gps_data


# =============================================================================
# Main Dashboard Window
# =============================================================================
class RadarDashboard(QMainWindow):
    """Main application window for the radar dashboard"""
    
    def __init__(self):
        super().__init__()
        
        # State
        self._radar_position = GPSData(
            latitude=40.7128,
            longitude=-74.0060,
            altitude=100.0,
            pitch=0.0,
            heading=0.0,
            timestamp=time.time()
        )
        self._settings = RadarSettings()
        self._simulator: TargetSimulator | None = None
        self._demo_mode = True
        
        # Setup UI
        self._setup_window()
        self._setup_dark_theme()
        self._setup_ui()
        self._setup_statusbar()
        
        # Start demo mode
        self._start_demo_mode()
    
    def _setup_window(self):
        """Configure main window properties"""
        self.setWindowTitle("PLFM Radar Dashboard - PyQt6 Edition")
        self.setMinimumSize(1200, 800)
        self.resize(1400, 900)
    
    def _setup_dark_theme(self):
        """Apply dark theme to the application"""
        palette = QPalette()
        palette.setColor(QPalette.ColorRole.Window, QColor(DARK_BG))
        palette.setColor(QPalette.ColorRole.WindowText, QColor(DARK_FG))
        palette.setColor(QPalette.ColorRole.Base, QColor(DARK_ACCENT))
        palette.setColor(QPalette.ColorRole.AlternateBase, QColor(DARK_HIGHLIGHT))
        palette.setColor(QPalette.ColorRole.ToolTipBase, QColor(DARK_ACCENT))
        palette.setColor(QPalette.ColorRole.ToolTipText, QColor(DARK_FG))
        palette.setColor(QPalette.ColorRole.Text, QColor(DARK_FG))
        palette.setColor(QPalette.ColorRole.Button, QColor(DARK_BUTTON))
        palette.setColor(QPalette.ColorRole.ButtonText, QColor(DARK_FG))
        palette.setColor(QPalette.ColorRole.BrightText, QColor(DARK_FG))
        palette.setColor(QPalette.ColorRole.Highlight, QColor(DARK_INFO))
        palette.setColor(QPalette.ColorRole.HighlightedText, QColor(DARK_FG))
        
        self.setPalette(palette)
        
        # Global stylesheet
        self.setStyleSheet(f"""
            QMainWindow {{
                background-color: {DARK_BG};
            }}
            
            QTabWidget::pane {{
                border: 1px solid {DARK_BORDER};
                background-color: {DARK_BG};
            }}
            
            QTabBar::tab {{
                background-color: {DARK_ACCENT};
                color: {DARK_FG};
                padding: 8px 20px;
                margin-right: 2px;
                border-top-left-radius: 4px;
                border-top-right-radius: 4px;
            }}
            
            QTabBar::tab:selected {{
                background-color: {DARK_HIGHLIGHT};
                border-bottom: 2px solid {DARK_INFO};
            }}
            
            QTabBar::tab:hover {{
                background-color: {DARK_BUTTON_HOVER};
            }}
            
            QGroupBox {{
                font-weight: bold;
                border: 1px solid {DARK_BORDER};
                border-radius: 6px;
                margin-top: 12px;
                padding-top: 10px;
                background-color: {DARK_ACCENT};
            }}
            
            QGroupBox::title {{
                subcontrol-origin: margin;
                left: 10px;
                padding: 0 8px;
                color: {DARK_INFO};
            }}
            
            QPushButton {{
                background-color: {DARK_BUTTON};
                color: {DARK_FG};
                border: 1px solid {DARK_BORDER};
                padding: 6px 16px;
                border-radius: 4px;
                font-weight: 500;
            }}
            
            QPushButton:hover {{
                background-color: {DARK_BUTTON_HOVER};
            }}
            
            QPushButton:pressed {{
                background-color: {DARK_HIGHLIGHT};
            }}
            
            QLineEdit, QSpinBox, QDoubleSpinBox, QComboBox {{
                background-color: {DARK_ACCENT};
                color: {DARK_FG};
                border: 1px solid {DARK_BORDER};
                padding: 4px 8px;
                border-radius: 4px;
            }}
            
            QLabel {{
                color: {DARK_FG};
            }}
            
            QTableWidget {{
                background-color: {DARK_ACCENT};
                color: {DARK_FG};
                gridline-color: {DARK_BORDER};
                border: 1px solid {DARK_BORDER};
            }}
            
            QTableWidget::item {{
                padding: 4px;
            }}
            
            QTableWidget::item:selected {{
                background-color: {DARK_INFO};
            }}
            
            QHeaderView::section {{
                background-color: {DARK_HIGHLIGHT};
                color: {DARK_FG};
                padding: 6px;
                border: none;
                border-right: 1px solid {DARK_BORDER};
            }}
            
            QScrollBar:vertical {{
                background-color: {DARK_ACCENT};
                width: 12px;
                margin: 0;
            }}
            
            QScrollBar::handle:vertical {{
                background-color: {DARK_HIGHLIGHT};
                border-radius: 6px;
                min-height: 20px;
            }}
            
            QStatusBar {{
                background-color: {DARK_ACCENT};
                color: {DARK_FG};
            }}
        """)
    
    def _setup_ui(self):
        """Setup the main UI layout"""
        # Central widget
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        main_layout = QVBoxLayout(central_widget)
        main_layout.setContentsMargins(8, 8, 8, 8)
        main_layout.setSpacing(8)
        
        # Tab widget
        self._tabs = QTabWidget()
        main_layout.addWidget(self._tabs)
        
        # Create tabs
        self._create_map_tab()
        self._create_targets_tab()
        self._create_settings_tab()
    
    def _create_map_tab(self):
        """Create the map visualization tab"""
        tab = QWidget()
        layout = QHBoxLayout(tab)
        layout.setContentsMargins(4, 4, 4, 4)
        
        # Splitter for map and sidebar
        splitter = QSplitter(Qt.Orientation.Horizontal)
        
        # Map widget (main area)
        self._map_widget = RadarMapWidget()
        self._map_widget.targetSelected.connect(self._on_target_selected)
        splitter.addWidget(self._map_widget)
        
        # Sidebar
        sidebar = QWidget()
        sidebar.setMaximumWidth(320)
        sidebar.setMinimumWidth(280)
        sidebar_layout = QVBoxLayout(sidebar)
        sidebar_layout.setContentsMargins(8, 8, 8, 8)
        
        # Radar Position Group
        pos_group = QGroupBox("Radar Position")
        pos_layout = QGridLayout(pos_group)
        
        self._lat_spin = QDoubleSpinBox()
        self._lat_spin.setRange(-90, 90)
        self._lat_spin.setDecimals(6)
        self._lat_spin.setValue(self._radar_position.latitude)
        self._lat_spin.valueChanged.connect(self._on_position_changed)
        
        self._lon_spin = QDoubleSpinBox()
        self._lon_spin.setRange(-180, 180)
        self._lon_spin.setDecimals(6)
        self._lon_spin.setValue(self._radar_position.longitude)
        self._lon_spin.valueChanged.connect(self._on_position_changed)
        
        self._alt_spin = QDoubleSpinBox()
        self._alt_spin.setRange(0, 50000)
        self._alt_spin.setDecimals(1)
        self._alt_spin.setValue(self._radar_position.altitude)
        self._alt_spin.setSuffix(" m")
        
        pos_layout.addWidget(QLabel("Latitude:"), 0, 0)
        pos_layout.addWidget(self._lat_spin, 0, 1)
        pos_layout.addWidget(QLabel("Longitude:"), 1, 0)
        pos_layout.addWidget(self._lon_spin, 1, 1)
        pos_layout.addWidget(QLabel("Altitude:"), 2, 0)
        pos_layout.addWidget(self._alt_spin, 2, 1)
        
        sidebar_layout.addWidget(pos_group)
        
        # Coverage Group
        coverage_group = QGroupBox("Coverage")
        coverage_layout = QGridLayout(coverage_group)
        
        self._coverage_spin = QDoubleSpinBox()
        self._coverage_spin.setRange(1, 100)
        self._coverage_spin.setDecimals(1)
        self._coverage_spin.setValue(self._settings.coverage_radius / 1000)
        self._coverage_spin.setSuffix(" km")
        self._coverage_spin.valueChanged.connect(self._on_coverage_changed)
        
        coverage_layout.addWidget(QLabel("Radius:"), 0, 0)
        coverage_layout.addWidget(self._coverage_spin, 0, 1)
        
        sidebar_layout.addWidget(coverage_group)
        
        # Demo Controls
        demo_group = QGroupBox("Demo Mode")
        demo_layout = QVBoxLayout(demo_group)
        
        self._demo_btn = QPushButton("Stop Demo")
        self._demo_btn.setCheckable(True)
        self._demo_btn.setChecked(True)
        self._demo_btn.clicked.connect(self._toggle_demo_mode)
        demo_layout.addWidget(self._demo_btn)
        
        add_target_btn = QPushButton("Add Random Target")
        add_target_btn.clicked.connect(self._add_demo_target)
        demo_layout.addWidget(add_target_btn)
        
        sidebar_layout.addWidget(demo_group)
        
        # Target Info
        info_group = QGroupBox("Selected Target")
        info_layout = QVBoxLayout(info_group)
        
        self._target_info_label = QLabel("No target selected")
        self._target_info_label.setWordWrap(True)
        self._target_info_label.setStyleSheet(f"color: {DARK_TEXT}; padding: 8px;")
        info_layout.addWidget(self._target_info_label)
        
        sidebar_layout.addWidget(info_group)
        
        sidebar_layout.addStretch()
        
        splitter.addWidget(sidebar)
        splitter.setSizes([900, 300])
        
        layout.addWidget(splitter)
        
        self._tabs.addTab(tab, "Map View")
    
    def _create_targets_tab(self):
        """Create the targets table tab"""
        tab = QWidget()
        layout = QVBoxLayout(tab)
        layout.setContentsMargins(8, 8, 8, 8)
        
        # Targets table
        self._targets_table = QTableWidget()
        self._targets_table.setColumnCount(9)
        self._targets_table.setHorizontalHeaderLabels([
            "ID", "Track", "Range (m)", "Velocity (m/s)", 
            "Azimuth (°)", "Elevation (°)", "SNR (dB)", 
            "Classification", "Status"
        ])
        
        header = self._targets_table.horizontalHeader()
        header.setSectionResizeMode(QHeaderView.ResizeMode.Stretch)
        
        self._targets_table.setSelectionBehavior(
            QTableWidget.SelectionBehavior.SelectRows
        )
        self._targets_table.setAlternatingRowColors(True)
        
        layout.addWidget(self._targets_table)
        
        self._tabs.addTab(tab, "Targets")
    
    def _create_settings_tab(self):
        """Create the settings tab"""
        tab = QWidget()
        layout = QVBoxLayout(tab)
        layout.setContentsMargins(8, 8, 8, 8)
        
        # Radar Settings Group
        radar_group = QGroupBox("Radar Parameters")
        radar_layout = QGridLayout(radar_group)
        
        radar_layout.addWidget(QLabel("System Frequency:"), 0, 0)
        freq_spin = QDoubleSpinBox()
        freq_spin.setRange(1, 100)
        freq_spin.setValue(self._settings.system_frequency / 1e9)
        freq_spin.setSuffix(" GHz")
        radar_layout.addWidget(freq_spin, 0, 1)
        
        radar_layout.addWidget(QLabel("Max Range:"), 1, 0)
        range_spin = QDoubleSpinBox()
        range_spin.setRange(1, 200)
        range_spin.setValue(self._settings.max_distance / 1000)
        range_spin.setSuffix(" km")
        radar_layout.addWidget(range_spin, 1, 1)
        
        radar_layout.addWidget(QLabel("PRF 1:"), 2, 0)
        prf1_spin = QSpinBox()
        prf1_spin.setRange(100, 10000)
        prf1_spin.setValue(int(self._settings.prf1))
        prf1_spin.setSuffix(" Hz")
        radar_layout.addWidget(prf1_spin, 2, 1)
        
        radar_layout.addWidget(QLabel("PRF 2:"), 3, 0)
        prf2_spin = QSpinBox()
        prf2_spin.setRange(100, 10000)
        prf2_spin.setValue(int(self._settings.prf2))
        prf2_spin.setSuffix(" Hz")
        radar_layout.addWidget(prf2_spin, 3, 1)
        
        layout.addWidget(radar_group)
        
        # About
        about_group = QGroupBox("About")
        about_layout = QVBoxLayout(about_group)
        about_text = QLabel(
            "<b>PLFM Radar Dashboard</b><br>"
            "PyQt6 Edition with Embedded Leaflet Map<br><br>"
            "Version: 1.0.0<br>"
            "Map: OpenStreetMap + Leaflet.js<br>"
            "Framework: PyQt6 + QWebEngine"
        )
        about_text.setStyleSheet(f"color: {DARK_TEXT}; padding: 12px;")
        about_layout.addWidget(about_text)
        
        layout.addWidget(about_group)
        layout.addStretch()
        
        self._tabs.addTab(tab, "Settings")
    
    def _setup_statusbar(self):
        """Setup the status bar"""
        self._statusbar = QStatusBar()
        self.setStatusBar(self._statusbar)
        
        self._status_label = QLabel("Ready")
        self._statusbar.addWidget(self._status_label)
        
        self._target_count_label = QLabel("Targets: 0")
        self._statusbar.addPermanentWidget(self._target_count_label)
        
        self._mode_label = QLabel("Demo Mode")
        self._mode_label.setStyleSheet(f"color: {DARK_INFO}; font-weight: bold;")
        self._statusbar.addPermanentWidget(self._mode_label)
    
    def _start_demo_mode(self):
        """Start the demo mode with simulated targets"""
        self._simulator = TargetSimulator(self._radar_position, self)
        self._simulator.targetsUpdated.connect(self._on_targets_updated)
        self._simulator.start(500)  # Update every 500ms
        
        self._demo_mode = True
        self._demo_btn.setChecked(True)
        self._demo_btn.setText("Stop Demo")
        self._mode_label.setText("Demo Mode")
        self._status_label.setText("Demo mode active")
        
        logger.info("Demo mode started")
    
    def _toggle_demo_mode(self, checked: bool):
        """Toggle demo mode on/off"""
        if checked:
            self._start_demo_mode()
        else:
            if self._simulator:
                self._simulator.stop()
            self._demo_mode = False
            self._demo_btn.setText("Start Demo")
            self._mode_label.setText("Idle")
            self._status_label.setText("Demo mode stopped")
            logger.info("Demo mode stopped")
    
    def _add_demo_target(self):
        """Add a random target in demo mode"""
        if self._simulator:
            self._simulator._add_random_target()
            logger.info("Added random target")
    
    def _on_targets_updated(self, targets: list[RadarTarget]):
        """Handle updated target list from simulator"""
        # Update map
        self._map_widget.set_targets(targets)
        
        # Update status bar
        self._target_count_label.setText(f"Targets: {len(targets)}")
        
        # Update table
        self._update_targets_table(targets)
    
    def _update_targets_table(self, targets: list[RadarTarget]):
        """Update the targets table"""
        self._targets_table.setRowCount(len(targets))
        
        for row, target in enumerate(targets):
            # ID
            self._targets_table.setItem(row, 0, QTableWidgetItem(str(target.id)))
            
            # Track ID
            self._targets_table.setItem(row, 1, QTableWidgetItem(str(target.track_id)))
            
            # Range
            self._targets_table.setItem(row, 2, QTableWidgetItem(f"{target.range:.1f}"))
            
            # Velocity
            vel_item = QTableWidgetItem(f"{target.velocity:+.1f}")
            if target.velocity > 1:
                vel_item.setForeground(QColor(DARK_ERROR))
            elif target.velocity < -1:
                vel_item.setForeground(QColor(DARK_INFO))
            self._targets_table.setItem(row, 3, vel_item)
            
            # Azimuth
            self._targets_table.setItem(row, 4, QTableWidgetItem(f"{target.azimuth:.1f}"))
            
            # Elevation
            self._targets_table.setItem(row, 5, QTableWidgetItem(f"{target.elevation:.1f}"))
            
            # SNR
            self._targets_table.setItem(row, 6, QTableWidgetItem(f"{target.snr:.1f}"))
            
            # Classification
            self._targets_table.setItem(row, 7, QTableWidgetItem(target.classification))
            
            # Status
            status = "Approaching" if target.velocity > 1 else (
                "Receding" if target.velocity < -1 else "Stationary"
            )
            status_item = QTableWidgetItem(status)
            if status == "Approaching":
                status_item.setForeground(QColor(DARK_ERROR))
            elif status == "Receding":
                status_item.setForeground(QColor(DARK_INFO))
            self._targets_table.setItem(row, 8, status_item)
    
    def _on_target_selected(self, target_id: int):
        """Handle target selection from map"""
        # Find target
        if self._simulator:
            for target in self._simulator._targets:
                if target.id == target_id:
                    self._show_target_info(target)
                    break
    
    def _show_target_info(self, target: RadarTarget):
        """Display target information in sidebar"""
        status = "Approaching" if target.velocity > 1 else (
            "Receding" if target.velocity < -1 else "Stationary"
        )
        
        info = f"""
        <b>Target #{target.id}</b><br><br>
        <b>Track ID:</b> {target.track_id}<br>
        <b>Range:</b> {target.range:.1f} m<br>
        <b>Velocity:</b> {target.velocity:+.1f} m/s<br>
        <b>Azimuth:</b> {target.azimuth:.1f}°<br>
        <b>Elevation:</b> {target.elevation:.1f}°<br>
        <b>SNR:</b> {target.snr:.1f} dB<br>
        <b>Classification:</b> {target.classification}<br>
        <b>Status:</b> <span style="color: {
            DARK_ERROR if status == 'Approaching' else 
            (DARK_INFO if status == 'Receding' else DARK_TEXT)
        }">{status}</span>
        """
        
        self._target_info_label.setText(info)
    
    def _on_position_changed(self):
        """Handle radar position change from UI"""
        self._radar_position.latitude = self._lat_spin.value()
        self._radar_position.longitude = self._lon_spin.value()
        self._radar_position.altitude = self._alt_spin.value()
        
        self._map_widget.set_radar_position(self._radar_position)
        
        if self._simulator:
            self._simulator.set_radar_position(self._radar_position)
    
    def _on_coverage_changed(self, value: float):
        """Handle coverage radius change"""
        radius_m = value * 1000
        self._settings.coverage_radius = radius_m
        self._map_widget.set_coverage_radius(radius_m)
    
    def closeEvent(self, event):
        """Handle window close"""
        if self._simulator:
            self._simulator.stop()
        event.accept()


# =============================================================================
# Main Entry Point
# =============================================================================
def main():
    """Application entry point"""
    # Create application
    app = QApplication(sys.argv)
    app.setApplicationName("PLFM Radar Dashboard")
    app.setApplicationVersion("1.0.0")
    
    # Set font
    font = QFont("Segoe UI", 10)
    app.setFont(font)
    
    # Create and show main window
    window = RadarDashboard()
    window.show()
    
    logger.info("Application started")
    
    # Run event loop
    sys.exit(app.exec())


if __name__ == "__main__":
    main()
