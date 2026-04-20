#!/usr/bin/env python3

# =============================================================================
# DEPRECATED: GUI V6 Demo is superseded by GUI_V65_Tk and V7.
# This file is retained for reference only. Do not use for new development.
# Removal planned for next major release.
# =============================================================================

"""
Radar System GUI - Fully Functional Demo Version
All buttons work, simulated radar data is generated in real-time
"""

import tkinter as tk
from tkinter import ttk, messagebox
import time
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.backends.backend_tkagg import FigureCanvasTkAgg
from matplotlib.figure import Figure
import logging
from dataclasses import dataclass
import random
import json
from datetime import datetime

# Configure logging
logging.basicConfig(level=logging.INFO, 
                   format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)

# ============================================================================
# DATA CLASSES
# ============================================================================

@dataclass
class RadarTarget:
    id: int
    range: float
    velocity: float
    azimuth: float
    elevation: float
    snr: float

@dataclass
class RadarSettings:
    frequency: float = 10.0  # GHz
    long_chirp_us: float = 30.0
    short_chirp_us: float = 0.5
    chirps_per_frame: int = 32
    range_bins: int = 1024
    doppler_bins: int = 32
    prf: float = 1000
    max_range: float = 5000
    max_velocity: float = 100
    cfar_threshold: float = 13.0

# ============================================================================
# SIMULATED RADAR PROCESSOR
# ============================================================================

class SimulatedRadarProcessor:
    """Generates realistic simulated radar data"""
    
    def __init__(self):
        self.settings = RadarSettings()
        self.frame_count = 0
        self.targets = self._create_targets()
        self.noise_floor = 10
        self.clutter_level = 5
        
    def _create_targets(self) -> list[dict]:
        """Create moving targets"""
        return [
            {
                'id': 1,
                'range': 2500,
                'velocity': -80,
                'azimuth': 45,
                'elevation': 5,
                'snr': 25,
                'range_drift': -0.8,
                'azimuth_drift': 0.15,
                'velocity_drift': 0.1
            },
            {
                'id': 2,
                'range': 800,
                'velocity': 15,
                'azimuth': -30,
                'elevation': 0,
                'snr': 18,
                'range_drift': 0.3,
                'azimuth_drift': -0.1,
                'velocity_drift': -0.05
            },
            {
                'id': 3,
                'range': 1500,
                'velocity': 0,
                'azimuth': 10,
                'elevation': 2,
                'snr': 22,
                'range_drift': 0,
                'azimuth_drift': 0.05,
                'velocity_drift': 0
            },
            {
                'id': 4,
                'range': 3500,
                'velocity': 50,
                'azimuth': -15,
                'elevation': 3,
                'snr': 15,
                'range_drift': 0.5,
                'azimuth_drift': -0.2,
                'velocity_drift': -0.3
            },
            {
                'id': 5,
                'range': 500,
                'velocity': -20,
                'azimuth': 60,
                'elevation': 1,
                'snr': 30,
                'range_drift': -0.2,
                'azimuth_drift': 0.3,
                'velocity_drift': 0.2
            }
        ]
    
    def generate_frame(self) -> tuple:
        """Generate a complete radar frame"""
        self.frame_count += 1
        
        # Update target positions
        for target in self.targets:
            target['range'] += target['range_drift']
            target['azimuth'] += target['azimuth_drift']
            target['velocity'] += target['velocity_drift']
            
            # Keep within bounds with wrapping/reflection
            if target['range'] < 100:
                target['range'] = 100
                target['range_drift'] *= -1
            elif target['range'] > 4800:
                target['range'] = 4800
                target['range_drift'] *= -1
                
            if target['azimuth'] < -90:
                target['azimuth'] = -90
                target['azimuth_drift'] *= -1
            elif target['azimuth'] > 90:
                target['azimuth'] = 90
                target['azimuth_drift'] *= -1
                
            if target['velocity'] < -95:
                target['velocity'] = -95
                target['velocity_drift'] *= -1
            elif target['velocity'] > 95:
                target['velocity'] = 95
                target['velocity_drift'] *= -1
        
        # Generate range-Doppler map
        rd_map = self._generate_range_doppler()
        
        # Extract detected targets
        detected = self._detect_targets()
        
        return rd_map, detected
    
    def _generate_range_doppler(self) -> np.ndarray:
        """Generate simulated range-Doppler map"""
        # Base noise
        noise = self.noise_floor * np.random.random(
            (self.settings.range_bins, self.settings.doppler_bins)
        )
        
        # Add clutter (constant at low velocities)
        clutter = np.zeros_like(noise)
        clutter[:, 14:18] = self.clutter_level * (0.8 + 0.4 * np.random.random())
        
        # Add targets
        targets = np.zeros_like(noise)
        for t in self.targets:
            # Convert to bin indices
            r_bin = int((t['range'] / self.settings.max_range) * 
                       (self.settings.range_bins - 1))
            v_bin = int(((t['velocity'] + self.settings.max_velocity) / 
                        (2 * self.settings.max_velocity)) * 
                        (self.settings.doppler_bins - 1))
            
            # Ensure valid indices
            r_bin = max(0, min(self.settings.range_bins - 1, r_bin))
            v_bin = max(0, min(self.settings.doppler_bins - 1, v_bin))
            
            # Add target with spreading
            for dr in range(-2, 3):
                for dv in range(-2, 3):
                    rr = r_bin + dr
                    vv = v_bin + dv
                    if 0 <= rr < self.settings.range_bins and 0 <= vv < self.settings.doppler_bins:
                        distance = np.sqrt(dr**2 + dv**2)
                        if distance < 2.5:
                            amplitude = t['snr'] * np.exp(-distance/1.5)
                            targets[rr, vv] += amplitude * (0.7 + 0.6 * random.random())
        
        # Combine
        rd_map = noise + clutter + targets
        
        # Add some range-varying gain
        range_gain = np.linspace(1, 0.3, self.settings.range_bins)
        rd_map *= range_gain[:, np.newaxis]
        
        return rd_map
    
    def _detect_targets(self) -> list[RadarTarget]:
        """Detect targets from current state"""
        return [
            RadarTarget(
                id=t['id'],
                range=t['range'] + random.gauss(0, 10),
                velocity=t['velocity'] + random.gauss(0, 2),
                azimuth=t['azimuth'] + random.gauss(0, 1),
                elevation=t['elevation'] + random.gauss(0, 0.5),
                snr=t['snr'] + random.gauss(0, 2)
            )
            for t in self.targets
            if random.random() < (t['snr'] / 35)
        ]

# ============================================================================
# MAIN GUI APPLICATION
# ============================================================================

class RadarDemoGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("Radar System Demo - Fully Functional")
        self.root.geometry("1400x900")
        
        # Set minimum window size
        self.root.minsize(1200, 700)
        
        # Configure style
        self.style = ttk.Style()
        self.style.theme_use('clam')
        
        # Initialize components
        self.settings = RadarSettings()
        self.processor = SimulatedRadarProcessor()
        self.running = False
        self.recording = False
        self.frame_count = 0
        self.fps = 0
        self.last_frame_time = time.time()
        self.recorded_frames = []
        
        # Data storage
        self.current_rd_map = np.zeros((1024, 32))
        self.current_targets = []
        self.target_history = []
        
        # Settings variables
        self.settings_vars = {}
        
        # Create GUI
        self.create_menu()
        self.create_main_layout()
        self.create_status_bar()
        
        # Start animation
        self.animate()
        
        # Handle window close
        self.root.protocol("WM_DELETE_WINDOW", self.on_closing)
        
        logger.info("Radar Demo GUI initialized")
    
    def create_menu(self):
        """Create application menu"""
        menubar = tk.Menu(self.root)
        self.root.config(menu=menubar)
        
        # File menu
        file_menu = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label="File", menu=file_menu)
        file_menu.add_command(label="Load Configuration", command=self.load_config)
        file_menu.add_command(label="Save Configuration", command=self.save_config)
        file_menu.add_separator()
        file_menu.add_command(label="Export Data", command=self.export_data)
        file_menu.add_separator()
        file_menu.add_command(label="Exit", command=self.on_closing)
        
        # View menu
        view_menu = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label="View", menu=view_menu)
        self.show_grid = tk.BooleanVar(value=True)
        self.show_targets = tk.BooleanVar(value=True)
        self.color_map = tk.StringVar(value='hot')
        
        view_menu.add_checkbutton(label="Show Grid", variable=self.show_grid)
        view_menu.add_checkbutton(label="Show Targets", variable=self.show_targets)
        view_menu.add_separator()
        
        # Color map submenu
        color_menu = tk.Menu(view_menu, tearoff=0)
        view_menu.add_cascade(label="Color Map", menu=color_menu)
        for cmap in ['hot', 'jet', 'viridis', 'plasma']:
            color_menu.add_radiobutton(label=cmap.capitalize(), 
                                      variable=self.color_map, 
                                      value=cmap)
        
        # Tools menu
        tools_menu = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label="Tools", menu=tools_menu)
        tools_menu.add_command(label="Calibration", command=self.show_calibration)
        tools_menu.add_command(label="Diagnostics", command=self.show_diagnostics)
        tools_menu.add_command(label="Reset Simulation", command=self.reset_simulation)
        
        # Help menu
        help_menu = tk.Menu(menubar, tearoff=0)
        menubar.add_cascade(label="Help", menu=help_menu)
        help_menu.add_command(label="Documentation", command=self.show_docs)
        help_menu.add_command(label="About", command=self.show_about)
    
    def create_main_layout(self):
        """Create main application layout"""
        # Main container
        main_frame = ttk.Frame(self.root)
        main_frame.pack(fill='both', expand=True, padx=5, pady=5)
        
        # Control panel (top)
        control_frame = ttk.LabelFrame(main_frame, text="System Control", padding=5)
        control_frame.pack(fill='x', pady=(0, 5))
        
        self.create_control_panel(control_frame)
        
        # Notebook for tabs
        self.notebook = ttk.Notebook(main_frame)
        self.notebook.pack(fill='both', expand=True)
        
        # Create tabs
        self.create_radar_tab()
        self.create_scope_tab()
        self.create_spectrum_tab()
        self.create_settings_tab()
    
    def create_control_panel(self, parent):
        """Create control panel with working buttons"""
        # Left side - Status and controls
        left_frame = ttk.Frame(parent)
        left_frame.pack(side='left', fill='x', expand=True)
        
        # Mode indicator
        ttk.Label(left_frame, text="Mode:", font=('Arial', 10, 'bold')).grid(
            row=0, column=0, padx=5, pady=2, sticky='w')
        self.mode_label = ttk.Label(left_frame, text="DEMO", 
                                    foreground='green', font=('Arial', 10, 'bold'))
        self.mode_label.grid(row=0, column=1, padx=5, pady=2, sticky='w')
        
        # Device indicator
        ttk.Label(left_frame, text="Device:", font=('Arial', 10)).grid(
            row=0, column=2, padx=(20,5), pady=2, sticky='w')
        self.device_label = ttk.Label(left_frame, text="Simulated FT601")
        self.device_label.grid(row=0, column=3, padx=5, pady=2, sticky='w')
        
        # Frame counter
        ttk.Label(left_frame, text="Frame:", font=('Arial', 10)).grid(
            row=0, column=4, padx=(20,5), pady=2, sticky='w')
        self.frame_label = ttk.Label(left_frame, text="0")
        self.frame_label.grid(row=0, column=5, padx=5, pady=2, sticky='w')
        
        # Right side - Control buttons (ALL WORKING)
        right_frame = ttk.Frame(parent)
        right_frame.pack(side='right', padx=10)
        
        self.start_button = ttk.Button(right_frame, text="▶ START", 
                                      command=self.start_radar, width=10)
        self.start_button.pack(side='left', padx=2)
        
        self.stop_button = ttk.Button(right_frame, text="■ STOP", 
                                     command=self.stop_radar, width=10,
                                     state='disabled')
        self.stop_button.pack(side='left', padx=2)
        
        self.record_button = ttk.Button(right_frame, text="● RECORD", 
                                       command=self.toggle_recording, width=10,
                                       state='disabled')
        self.record_button.pack(side='left', padx=2)
        
        ttk.Button(right_frame, text="⚙ SETTINGS", 
                  command=lambda: self.notebook.select(3)).pack(side='left', padx=2)
    
    def create_radar_tab(self):
        """Create main radar display tab"""
        tab = ttk.Frame(self.notebook)
        self.notebook.add(tab, text="Radar Display")
        
        # Main display area
        display_frame = ttk.Frame(tab)
        display_frame.pack(fill='both', expand=True, padx=5, pady=5)
        
        # Range-Doppler map
        map_frame = ttk.LabelFrame(display_frame, text="Range-Doppler Map", padding=5)
        map_frame.pack(side='left', fill='both', expand=True)
        
        # Create matplotlib figure
        self.rd_fig = Figure(figsize=(8, 6), facecolor='#2b2b2b')
        self.rd_ax = self.rd_fig.add_subplot(111)
        self.rd_ax.set_facecolor('#1a1a1a')
        
        # Initialize plot
        self.rd_img = self.rd_ax.imshow(
            np.zeros((1024, 32)),
            aspect='auto',
            cmap='hot',
            extent=[-100, 100, 5000, 0],
            interpolation='bilinear'
        )
        
        self.rd_ax.set_xlabel('Velocity (m/s)', color='white')
        self.rd_ax.set_ylabel('Range (m)', color='white')
        self.rd_ax.set_title('Real-Time Radar Data', color='white', fontsize=12, fontweight='bold')
        self.rd_ax.tick_params(colors='white')
        self.rd_ax.grid(True, alpha=0.3) if self.show_grid.get() else None
        
        # Add colorbar
        self.rd_cbar = self.rd_fig.colorbar(self.rd_img, ax=self.rd_ax)
        self.rd_cbar.ax.yaxis.set_tick_params(color='white')
        self.rd_cbar.ax.set_ylabel('Power (dB)', color='white')
        plt.setp(plt.getp(self.rd_cbar.ax.axes, 'yticklabels'), color='white')
        
        # Embed in tkinter
        self.rd_canvas = FigureCanvasTkAgg(self.rd_fig, map_frame)
        self.rd_canvas.draw()
        self.rd_canvas.get_tk_widget().pack(fill='both', expand=True)
        
        # Target list panel
        target_frame = ttk.LabelFrame(display_frame, text="Detected Targets", padding=5, width=300)
        target_frame.pack(side='right', fill='y', padx=(5, 0))
        target_frame.pack_propagate(False)
        
        # Treeview for targets
        columns = ('ID', 'Range', 'Velocity', 'Azimuth', 'Elevation', 'SNR')
        self.target_tree = ttk.Treeview(target_frame, columns=columns, show='headings', height=20)
        
        # Define headings
        self.target_tree.heading('ID', text='ID')
        self.target_tree.heading('Range', text='Range (m)')
        self.target_tree.heading('Velocity', text='Vel (m/s)')
        self.target_tree.heading('Azimuth', text='Az (°)')
        self.target_tree.heading('Elevation', text='El (°)')
        self.target_tree.heading('SNR', text='SNR (dB)')
        
        # Set column widths
        self.target_tree.column('ID', width=40, anchor='center')
        self.target_tree.column('Range', width=80, anchor='center')
        self.target_tree.column('Velocity', width=80, anchor='center')
        self.target_tree.column('Azimuth', width=70, anchor='center')
        self.target_tree.column('Elevation', width=70, anchor='center')
        self.target_tree.column('SNR', width=70, anchor='center')
        
        # Add scrollbar
        scrollbar = ttk.Scrollbar(target_frame, orient='vertical', 
                                  command=self.target_tree.yview)
        self.target_tree.configure(yscrollcommand=scrollbar.set)
        
        self.target_tree.pack(side='left', fill='both', expand=True)
        scrollbar.pack(side='right', fill='y')
        
        # Clear targets button
        ttk.Button(target_frame, text="Clear List", 
                  command=self.clear_targets).pack(pady=5)
    
    def create_scope_tab(self):
        """Create A-scope tab"""
        tab = ttk.Frame(self.notebook)
        self.notebook.add(tab, text="A-Scope")
        
        # Create figure
        self.scope_fig = Figure(figsize=(10, 6), facecolor='#2b2b2b')
        self.scope_ax = self.scope_fig.add_subplot(111)
        self.scope_ax.set_facecolor('#1a1a1a')
        
        # Initialize plot
        self.scope_line, = self.scope_ax.plot([], [], 'g-', linewidth=1.5)
        self.scope_ax.set_xlim(0, 5000)
        self.scope_ax.set_ylim(0, 50)
        self.scope_ax.set_xlabel('Range (m)', color='white')
        self.scope_ax.set_ylabel('Amplitude (dB)', color='white')
        self.scope_ax.set_title('Range Profile', color='white', fontsize=12, fontweight='bold')
        self.scope_ax.grid(True, alpha=0.3)
        self.scope_ax.tick_params(colors='white')
        
        self.scope_canvas = FigureCanvasTkAgg(self.scope_fig, tab)
        self.scope_canvas.draw()
        self.scope_canvas.get_tk_widget().pack(fill='both', expand=True)
    
    def create_spectrum_tab(self):
        """Create Doppler spectrum tab"""
        tab = ttk.Frame(self.notebook)
        self.notebook.add(tab, text="Doppler Spectrum")
        
        # Create figure
        self.spec_fig = Figure(figsize=(10, 6), facecolor='#2b2b2b')
        self.spec_ax = self.spec_fig.add_subplot(111)
        self.spec_ax.set_facecolor('#1a1a1a')
        
        # Initialize plot
        self.spec_line, = self.spec_ax.plot([], [], 'b-', linewidth=1.5)
        self.spec_ax.set_xlim(-100, 100)
        self.spec_ax.set_ylim(0, 50)
        self.spec_ax.set_xlabel('Velocity (m/s)', color='white')
        self.spec_ax.set_ylabel('Power (dB)', color='white')
        self.spec_ax.set_title('Doppler Spectrum', color='white', fontsize=12, fontweight='bold')
        self.spec_ax.grid(True, alpha=0.3)
        self.spec_ax.tick_params(colors='white')
        
        self.spec_canvas = FigureCanvasTkAgg(self.spec_fig, tab)
        self.spec_canvas.draw()
        self.spec_canvas.get_tk_widget().pack(fill='both', expand=True)
        
        # Range bin selector
        control_frame = ttk.Frame(tab)
        control_frame.pack(fill='x', pady=5)
        
        ttk.Label(control_frame, text="Range Bin:").pack(side='left', padx=5)
        self.range_slider = ttk.Scale(control_frame, from_=0, to=1023,
                                      orient='horizontal', length=400,
                                      command=self.update_range_label)
        self.range_slider.pack(side='left', padx=5)
        self.range_slider.set(512)
        
        self.range_label = ttk.Label(control_frame, text="512")
        self.range_label.pack(side='left', padx=5)
    
    def create_settings_tab(self):
        """Create settings tab with working controls"""
        tab = ttk.Frame(self.notebook)
        self.notebook.add(tab, text="Settings")
        
        # Create notebook for settings categories
        settings_notebook = ttk.Notebook(tab)
        settings_notebook.pack(fill='both', expand=True, padx=5, pady=5)
        
        # Radar settings
        radar_frame = ttk.Frame(settings_notebook)
        settings_notebook.add(radar_frame, text="Radar")
        self.create_radar_settings(radar_frame)
        
        # Display settings
        display_frame = ttk.Frame(settings_notebook)
        settings_notebook.add(display_frame, text="Display")
        self.create_display_settings(display_frame)
        
        # Simulation settings
        sim_frame = ttk.Frame(settings_notebook)
        settings_notebook.add(sim_frame, text="Simulation")
        self.create_simulation_settings(sim_frame)
    
    def create_radar_settings(self, parent):
        """Create radar settings controls"""
        # Create scrollable frame
        canvas = tk.Canvas(parent, bg='#2b2b2b', highlightthickness=0)
        scrollbar = ttk.Scrollbar(parent, orient='vertical', command=canvas.yview)
        scrollable_frame = ttk.Frame(canvas)
        
        scrollable_frame.bind(
            "<Configure>",
            lambda _e: canvas.configure(scrollregion=canvas.bbox("all"))
        )
        
        canvas.create_window((0, 0), window=scrollable_frame, anchor="nw")
        canvas.configure(yscrollcommand=scrollbar.set)
        
        # Settings with variables
        settings = [
            ('Frequency (GHz):', 'freq', 10.0, 1.0, 20.0),
            ('Long Chirp (µs):', 'long_dur', 30.0, 1.0, 100.0),
            ('Short Chirp (µs):', 'short_dur', 0.5, 0.1, 10.0),
            ('Chirps/Frame:', 'chirps', 32, 8, 128),
            ('Range Bins:', 'range_bins', 1024, 256, 2048),
            ('Doppler Bins:', 'doppler_bins', 32, 8, 128),
            ('PRF (Hz):', 'prf', 1000, 100, 10000),
            ('Max Range (m):', 'max_range', 5000, 100, 50000),
            ('Max Velocity (m/s):', 'max_vel', 100, 10, 500),
            ('CFAR Threshold (dB):', 'cfar', 13.0, 5.0, 30.0)
        ]
        
        for _i, (label, key, default, minv, maxv) in enumerate(settings):
            frame = ttk.Frame(scrollable_frame)
            frame.pack(fill='x', padx=10, pady=5)
            
            ttk.Label(frame, text=label, width=20).pack(side='left')
            
            var = tk.DoubleVar(value=default)
            self.settings_vars[key] = var
            
            entry = ttk.Entry(frame, textvariable=var, width=15)
            entry.pack(side='left', padx=5)
            
            ttk.Label(frame, text=f"({minv}-{maxv})").pack(side='left')
        
        canvas.pack(side='left', fill='both', expand=True)
        scrollbar.pack(side='right', fill='y')
        
        # Apply button
        ttk.Button(scrollable_frame, text="Apply Settings", 
                  command=self.apply_settings).pack(pady=10)
    
    def create_display_settings(self, parent):
        """Create display settings controls"""
        frame = ttk.Frame(parent)
        frame.pack(fill='both', expand=True, padx=20, pady=20)
        
        # Update rate
        ttk.Label(frame, text="Update Rate (Hz):").grid(row=0, column=0, 
                                                        sticky='w', pady=5)
        self.update_rate = ttk.Scale(frame, from_=1, to=60, 
                                     orient='horizontal', length=200)
        self.update_rate.set(20)
        self.update_rate.grid(row=0, column=1, padx=10, pady=5)
        self.update_rate_value = ttk.Label(frame, text="20")
        self.update_rate_value.grid(row=0, column=2, sticky='w')
        self.update_rate.configure(
            command=lambda v: self.update_rate_value.config(text=f"{float(v):.0f}")
        )
        
        # Color map
        ttk.Label(frame, text="Color Map:").grid(row=1, column=0, sticky='w', pady=5)
        cmap_combo = ttk.Combobox(frame, textvariable=self.color_map,
                                  values=['hot', 'jet', 'viridis', 'plasma'],
                                  state='readonly', width=15)
        cmap_combo.grid(row=1, column=1, padx=10, pady=5, sticky='w')
        
        # Grid
        ttk.Checkbutton(frame, text="Show Grid", 
                       variable=self.show_grid).grid(row=2, column=0, 
                                                     columnspan=2, sticky='w', pady=5)
        
        # Targets
        ttk.Checkbutton(frame, text="Show Targets", 
                       variable=self.show_targets).grid(row=3, column=0, 
                                                        columnspan=2, sticky='w', pady=5)
        
        # Apply display button
        ttk.Button(frame, text="Apply Display Settings", 
                  command=self.apply_display_settings).grid(row=4, column=0, 
                                                            columnspan=2, pady=20)
    
    def create_simulation_settings(self, parent):
        """Create simulation settings controls"""
        frame = ttk.Frame(parent)
        frame.pack(fill='both', expand=True, padx=20, pady=20)
        
        # Noise floor
        ttk.Label(frame, text="Noise Floor:").grid(row=0, column=0, sticky='w', pady=5)
        self.noise_floor = ttk.Scale(frame, from_=0, to=20, 
                                     orient='horizontal', length=200)
        self.noise_floor.set(10)
        self.noise_floor.grid(row=0, column=1, padx=10, pady=5)
        self.noise_value = ttk.Label(frame, text="10")
        self.noise_value.grid(row=0, column=2, sticky='w')
        self.noise_floor.configure(
            command=lambda v: self.noise_value.config(text=f"{float(v):.1f}")
        )
        
        # Clutter level
        ttk.Label(frame, text="Clutter Level:").grid(row=1, column=0, sticky='w', pady=5)
        self.clutter_level = ttk.Scale(frame, from_=0, to=20, 
                                       orient='horizontal', length=200)
        self.clutter_level.set(5)
        self.clutter_level.grid(row=1, column=1, padx=10, pady=5)
        self.clutter_value = ttk.Label(frame, text="5")
        self.clutter_value.grid(row=1, column=2, sticky='w')
        self.clutter_level.configure(
            command=lambda v: self.clutter_value.config(text=f"{float(v):.1f}")
        )
        
        # Number of targets
        ttk.Label(frame, text="Number of Targets:").grid(row=2, column=0, sticky='w', pady=5)
        self.num_targets = ttk.Scale(frame, from_=1, to=10, 
                                     orient='horizontal', length=200)
        self.num_targets.set(5)
        self.num_targets.grid(row=2, column=1, padx=10, pady=5)
        self.targets_value = ttk.Label(frame, text="5")
        self.targets_value.grid(row=2, column=2, sticky='w')
        self.num_targets.configure(
            command=lambda v: self.targets_value.config(text=f"{float(v):.0f}")
        )
        
        # Reset button
        ttk.Button(frame, text="Reset Simulation", 
                  command=self.reset_simulation).grid(row=3, column=0, 
                                                      columnspan=2, pady=20)
    
    def create_status_bar(self):
        """Create status bar at bottom"""
        status_frame = ttk.Frame(self.root)
        status_frame.pack(side='bottom', fill='x')
        
        # Left status
        self.status_label = ttk.Label(status_frame, text="Status: READY", 
                                      relief='sunken', padding=2)
        self.status_label.pack(side='left', fill='x', expand=True)
        
        # Right indicators
        self.fps_label = ttk.Label(status_frame, text="FPS: 0", 
                                   relief='sunken', width=10)
        self.fps_label.pack(side='right', padx=1)
        
        self.targets_label = ttk.Label(status_frame, text="Targets: 0", 
                                       relief='sunken', width=12)
        self.targets_label.pack(side='right', padx=1)
        
        self.time_label = ttk.Label(status_frame, text=time.strftime("%H:%M:%S"),
                                    relief='sunken', width=8)
        self.time_label.pack(side='right', padx=1)
    
    # ============================================================================
    # GUI UPDATE METHODS
    # ============================================================================
    
    def animate(self):
        """Animation loop - updates all displays"""
        if not hasattr(self, 'animation_running'):
            self.animation_running = True
        
        try:
            # Calculate FPS
            current_time = time.time()
            dt = current_time - self.last_frame_time
            if dt > 0:
                self.fps = 0.9 * self.fps + 0.1 / dt
            self.last_frame_time = current_time
            
            # Update displays if running
            if self.running:
                self.update_radar_data()
                self.frame_count += 1
                self.frame_label.config(text=str(self.frame_count))
            
            # Update status bar
            self.update_status_bar()
            
            # Update time
            self.time_label.config(text=time.strftime("%H:%M:%S"))
            
        except (ValueError, IndexError) as e:
            logger.error(f"Animation error: {e}")
        
        # Schedule next update
        update_ms = int(1000 / max(1, self.update_rate.get()))
        self.root.after(update_ms, self.animate)
    
    def update_radar_data(self):
        """Generate and display new radar data"""
        # Generate frame
        rd_map, targets = self.processor.generate_frame()
        
        # Apply simulation settings
        self.processor.noise_floor = self.noise_floor.get()
        self.processor.clutter_level = self.clutter_level.get()
        
        # Store current data
        self.current_rd_map = rd_map
        self.current_targets = targets
        
        # Update range-Doppler map
        log_map = 10 * np.log10(rd_map + 1)
        self.rd_img.set_data(log_map)
        self.rd_img.set_cmap(self.color_map.get())
        
        # Update color limits
        vmin = np.percentile(log_map, 5)
        vmax = np.percentile(log_map, 95)
        self.rd_img.set_clim(vmin, vmax)
        
        # Draw target markers if enabled
        if self.show_targets.get():
            # Clear previous markers
            for artist in self.rd_ax.lines + self.rd_ax.texts:
                if hasattr(artist, 'is_target_marker') and artist.is_target_marker:
                    artist.remove()
            
            # Add new markers
            for target in targets:
                x = target.velocity
                y = target.range
                marker = self.rd_ax.plot(x, y, 'wo', markersize=8, 
                                        markeredgecolor='red', markeredgewidth=2)[0]
                marker.is_target_marker = True
                text = self.rd_ax.text(x, y-150, str(target.id), color='white',
                                      ha='center', va='top', fontsize=8,
                                      fontweight='bold')
                text.is_target_marker = True
        
        # Update grid
        if self.show_grid.get():
            self.rd_ax.grid(True, alpha=0.3)
        else:
            self.rd_ax.grid(False)
        
        # Update canvas
        self.rd_canvas.draw_idle()
        
        # Update target list
        self.update_target_list()
        
        # Update A-scope
        range_profile = np.mean(rd_map, axis=1)
        range_axis = np.linspace(0, 5000, len(range_profile))
        self.scope_line.set_data(range_axis, 10 * np.log10(range_profile + 1))
        self.scope_ax.relim()
        self.scope_ax.autoscale_view(scalex=False)
        self.scope_canvas.draw_idle()
        
        # Update Doppler spectrum
        range_bin = int(self.range_slider.get())
        spectrum = rd_map[range_bin, :]
        vel_axis = np.linspace(-100, 100, len(spectrum))
        self.spec_line.set_data(vel_axis, 10 * np.log10(spectrum + 1))
        self.spec_ax.relim()
        self.spec_ax.autoscale_view(scalex=False)
        self.spec_canvas.draw_idle()
        
        # Record if enabled
        if self.recording:
            self.recorded_frames.append({
                'frame': self.frame_count,
                'time': time.time(),
                'map': rd_map.copy(),
                'targets': [(t.range, t.velocity, t.azimuth, t.snr) for t in targets]
            })
    
    def update_target_list(self):
        """Update the targets treeview"""
        # Clear existing items
        for item in self.target_tree.get_children():
            self.target_tree.delete(item)
        
        # Add new targets
        for target in self.current_targets:
            values = (
                target.id,
                f"{target.range:.1f}",
                f"{target.velocity:.1f}",
                f"{target.azimuth:.1f}",
                f"{target.elevation:.1f}",
                f"{target.snr:.1f}"
            )
            self.target_tree.insert('', 'end', values=values)
        
        # Update targets label
        self.targets_label.config(text=f"Targets: {len(self.current_targets)}")
    
    def update_status_bar(self):
        """Update status bar information"""
        if self.running:
            status = "RUNNING"
            if self.recording:
                status = "RECORDING"
        else:
            status = "READY"
        
        self.status_label.config(text=f"Status: {status}")
        self.fps_label.config(text=f"FPS: {self.fps:.1f}")
    
    def update_range_label(self, value):
        """Update range bin label"""
        self.range_label.config(text=f"{int(float(value))}")
    
    # ============================================================================
    # COMMAND HANDLERS (ALL WORKING)
    # ============================================================================
    
    def start_radar(self):
        """Start radar simulation"""
        self.running = True
        self.start_button.config(state='disabled')
        self.stop_button.config(state='normal')
        self.record_button.config(state='normal')
        self.mode_label.config(text="RUNNING", foreground='green')
        logger.info("Radar started")
    
    def stop_radar(self):
        """Stop radar simulation"""
        self.running = False
        self.recording = False
        self.start_button.config(state='normal')
        self.stop_button.config(state='disabled')
        self.record_button.config(state='disabled', text='● RECORD')
        self.mode_label.config(text="STOPPED", foreground='red')
        logger.info("Radar stopped")
    
    def toggle_recording(self):
        """Toggle data recording"""
        if not self.running:
            messagebox.showwarning("Warning", "Start radar first")
            return
        
        self.recording = not self.recording
        if self.recording:
            self.record_button.config(text="● RECORDING", foreground='red')
            self.recorded_frames = []  # Clear previous recording
            logger.info("Recording started")
        else:
            self.record_button.config(text="● RECORD", foreground='black')
            logger.info(f"Recording stopped. Captured {len(self.recorded_frames)} frames")
    
    def clear_targets(self):
        """Clear target list"""
        for item in self.target_tree.get_children():
            self.target_tree.delete(item)
        self.current_targets = []
        logger.info("Target list cleared")
    
    def apply_settings(self):
        """Apply radar settings"""
        try:
            self.settings.frequency = self.settings_vars['freq'].get()
            self.settings.long_chirp_us = self.settings_vars['long_dur'].get()
            self.settings.short_chirp_us = self.settings_vars['short_dur'].get()
            self.settings.chirps_per_frame = int(self.settings_vars['chirps'].get())
            self.settings.range_bins = int(self.settings_vars['range_bins'].get())
            self.settings.doppler_bins = int(self.settings_vars['doppler_bins'].get())
            self.settings.prf = self.settings_vars['prf'].get()
            self.settings.max_range = self.settings_vars['max_range'].get()
            self.settings.max_velocity = self.settings_vars['max_vel'].get()
            self.settings.cfar_threshold = self.settings_vars['cfar'].get()
            
            # Update processor settings
            self.processor.settings = self.settings
            
            # Update plot extents
            self.rd_ax.set_xlim(-self.settings.max_velocity, self.settings.max_velocity)
            self.rd_ax.set_ylim(self.settings.max_range, 0)
            self.spec_ax.set_xlim(-self.settings.max_velocity, self.settings.max_velocity)
            self.scope_ax.set_xlim(0, self.settings.max_range)
            
            messagebox.showinfo("Success", "Settings applied")
            logger.info("Settings updated")
            
        except (ValueError, tk.TclError) as e:
            messagebox.showerror("Error", f"Invalid settings: {e}")
    
    def apply_display_settings(self):
        """Apply display settings"""
        # Update grid
        if self.show_grid.get():
            self.rd_ax.grid(True, alpha=0.3)
            self.scope_ax.grid(True, alpha=0.3)
            self.spec_ax.grid(True, alpha=0.3)
        else:
            self.rd_ax.grid(False)
            self.scope_ax.grid(False)
            self.spec_ax.grid(False)
        
        # Redraw
        self.rd_canvas.draw_idle()
        self.scope_canvas.draw_idle()
        self.spec_canvas.draw_idle()
        
        messagebox.showinfo("Success", "Display settings applied")
    
    def reset_simulation(self):
        """Reset the simulation"""
        if messagebox.askyesno("Confirm", "Reset simulation to initial state?"):
            self.processor = SimulatedRadarProcessor()
            self.frame_count = 0
            self.frame_label.config(text="0")
            self.current_targets = []
            self.update_target_list()
            logger.info("Simulation reset")
    
    def load_config(self):
        """Load configuration from file"""
        from tkinter import filedialog
        filename = filedialog.askopenfilename(
            title="Load Configuration",
            filetypes=[("JSON files", "*.json"), ("All files", "*.*")]
        )
        if filename:
            try:
                with open(filename) as f:
                    config = json.load(f)
                
                # Apply settings
                for key, value in config.get('settings', {}).items():
                    if key in self.settings_vars:
                        self.settings_vars[key].set(value)
                
                # Apply display settings
                display = config.get('display', {})
                if 'color_map' in display:
                    self.color_map.set(display['color_map'])
                if 'show_grid' in display:
                    self.show_grid.set(display['show_grid'])
                if 'show_targets' in display:
                    self.show_targets.set(display['show_targets'])
                
                self.apply_settings()
                self.apply_display_settings()
                
                messagebox.showinfo("Success", f"Loaded configuration from {filename}")
                logger.info(f"Configuration loaded from {filename}")
                
            except (OSError, json.JSONDecodeError, ValueError, tk.TclError) as e:
                messagebox.showerror("Error", f"Failed to load: {e}")
    
    def save_config(self):
        """Save configuration to file"""
        from tkinter import filedialog
        filename = filedialog.asksaveasfilename(
            title="Save Configuration",
            defaultextension=".json",
            filetypes=[("JSON files", "*.json"), ("All files", "*.*")]
        )
        if filename:
            try:
                config = {
                    'settings': {k: v.get() for k, v in self.settings_vars.items()},
                    'display': {
                        'color_map': self.color_map.get(),
                        'show_grid': self.show_grid.get(),
                        'show_targets': self.show_targets.get()
                    }
                }
                with open(filename, 'w') as f:
                    json.dump(config, f, indent=2)
                
                messagebox.showinfo("Success", f"Saved configuration to {filename}")
                logger.info(f"Configuration saved to {filename}")
                
            except (OSError, TypeError, ValueError) as e:
                messagebox.showerror("Error", f"Failed to save: {e}")
    
    def export_data(self):
        """Export recorded data"""
        if not self.recorded_frames:
            messagebox.showwarning("Warning", "No recorded data to export")
            return
        
        from tkinter import filedialog
        filename = filedialog.asksaveasfilename(
            title="Export Data",
            defaultextension=".npz",
            filetypes=[("NumPy files", "*.npz"), ("All files", "*.*")]
        )
        if filename:
            try:
                # Prepare data for export
                frames = np.array([f['map'] for f in self.recorded_frames])
                times = np.array([f['time'] for f in self.recorded_frames])
                
                # Save
                np.savez(filename, 
                         frames=frames,
                         times=times,
                         settings=vars(self.settings))
                
                messagebox.showinfo("Success", f"Exported {len(frames)} frames to {filename}")
                logger.info(f"Data exported to {filename}")
                
            except (OSError, ValueError) as e:
                messagebox.showerror("Error", f"Failed to export: {e}")
    
    def show_calibration(self):
        """Show calibration dialog"""
        messagebox.showinfo("Calibration", 
                           "Calibration Wizard\n\n"
                           "1. Set noise floor\n"
                           "2. Run noise measurement\n"
                           "3. Apply calibration factors\n\n"
                           f"Current noise floor: {self.processor.noise_floor:.1f} dB")
    
    def show_diagnostics(self):
        """Show system diagnostics"""
        import platform
        info = f"""
        SYSTEM DIAGNOSTICS
        =================
        
        Radar Status
        ------------
        Mode: {'RUNNING' if self.running else 'STOPPED'}
        Frames: {self.frame_count}
        Targets: {len(self.current_targets)}
        FPS: {self.fps:.1f}
        
        Simulation Parameters
        ---------------------
        Noise Floor: {self.processor.noise_floor:.1f} dB
        Clutter Level: {self.processor.clutter_level:.1f} dB
        Active Targets: {len(self.processor.targets)}
        
        Display Settings
        ----------------
        Color Map: {self.color_map.get()}
        Update Rate: {self.update_rate.get():.0f} Hz
        Grid: {'On' if self.show_grid.get() else 'Off'}
        
        System Info
        -----------
        Platform: {platform.platform()}
        Python: {platform.python_version()}
        Time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}
        """
        
        # Create diagnostics window
        diag_window = tk.Toplevel(self.root)
        diag_window.title("Diagnostics")
        diag_window.geometry("500x600")
        
        text_widget = tk.Text(diag_window, bg='#2b2b2b', fg='#e0e0e0',
                              font=('Courier', 10), wrap='none')
        text_widget.pack(fill='both', expand=True, padx=10, pady=10)
        text_widget.insert('1.0', info)
        text_widget.config(state='disabled')
        
        # Add scrollbar
        scrollbar = ttk.Scrollbar(diag_window, orient='vertical',
                                  command=text_widget.yview)
        scrollbar.pack(side='right', fill='y')
        text_widget.config(yscrollcommand=scrollbar.set)
    
    def show_docs(self):
        """Show documentation"""
        docs = """
        RADAR SYSTEM DEMO - USER GUIDE
        ===============================
        
        Getting Started
        ---------------
        1. Click START to begin radar simulation
        2. Watch real-time range-Doppler display
        3. Detected targets appear in the list
        4. Use tabs to view different displays
        
        Controls
        --------
        • START/STOP: Control radar simulation
        • RECORD: Capture data for export
        • SETTINGS: Configure radar parameters
        • Clear List: Remove targets from display
        
        Display Tabs
        ------------
        • Radar Display: Main range-Doppler view
        • A-Scope: Range profile plot
        • Doppler Spectrum: Velocity analysis
        • Settings: Configure all parameters
        
        Tips
        ----
        • Adjust update rate in Display settings
        • Change color map for better visibility
        • Export recorded data for analysis
        • Reset simulation to restart targets
        
        For more information, visit:
        https://github.com/radar-system/docs
        """
        
        messagebox.showinfo("Documentation", docs)
    
    def show_about(self):
        """Show about dialog"""
        about = """
        Radar System Demo
        Version 2.0.0
        
        A fully functional radar simulation
        and visualization tool.
        
        Features:
        • Real-time range-Doppler processing
        • Multiple moving targets
        • A-scope and spectrum displays
        • Data recording and export
        • Configurable parameters
        
        Created for demonstration and testing
        of radar signal processing concepts.
        
        © 2025 Radar Systems Inc.
        """
        
        messagebox.showinfo("About", about)
    
    def on_closing(self):
        """Handle window closing"""
        if messagebox.askokcancel("Quit", "Exit radar demo?"):
            self.animation_running = False
            self.running = False
            self.root.destroy()

# ============================================================================
# MAIN ENTRY POINT
# ============================================================================

def main():
    """Main application entry point"""
    try:
        # Create root window
        root = tk.Tk()
        
        # Create application
        _app = RadarDemoGUI(root)  # keeps reference alive
        
        # Center window
        root.update_idletasks()
        width = root.winfo_width()
        height = root.winfo_height()
        x = (root.winfo_screenwidth() // 2) - (width // 2)
        y = (root.winfo_screenheight() // 2) - (height // 2)
        root.geometry(f'{width}x{height}+{x}+{y}')
        
        # Start main loop
        root.mainloop()
        
    except Exception as e:  # noqa: BLE001
        logger.error(f"Fatal error: {e}")
        messagebox.showerror("Fatal Error", f"Application failed to start:\n{e}")

if __name__ == "__main__":
    main()
