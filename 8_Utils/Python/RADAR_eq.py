import tkinter as tk
from tkinter import ttk, messagebox
import math
import numpy as np

class RadarCalculatorGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("RADAR Parameters Calculator")
        self.root.geometry("850x750")
        
        # Configure colors
        self.bg_color = '#f0f0f0'
        self.root.configure(bg=self.bg_color)
        
        # Create main container
        self.main_frame = ttk.Frame(root, padding="10")
        self.main_frame.pack(fill=tk.BOTH, expand=True)
        
        # Title
        title_label = tk.Label(self.main_frame, text="RADAR PARAMETERS CALCULATOR", 
                              font=('Arial', 16, 'bold'), bg=self.bg_color)
        title_label.pack(pady=10)
        
        # Create notebook for tabs
        self.notebook = ttk.Notebook(self.main_frame)
        self.notebook.pack(fill=tk.BOTH, expand=True, pady=10)
        
        # Input tab
        self.input_frame = ttk.Frame(self.notebook)
        self.notebook.add(self.input_frame, text="Input Parameters")
        
        # Results tab
        self.results_frame = ttk.Frame(self.notebook)
        self.notebook.add(self.results_frame, text="Results")
        
        # Create input fields
        self.create_input_fields()
        
        # Create results display
        self.create_results_display()
        
        # Create button frame (outside notebook)
        self.button_frame = ttk.Frame(self.main_frame)
        self.button_frame.pack(fill=tk.X, pady=10)
        
        # Create calculate button
        self.create_calculate_button()
        
        # Constants
        self.c = 3e8  # Speed of light in m/s
        
    def create_input_fields(self):
        """Create all input fields with labels and units"""
        
        # Create a canvas with scrollbar for input fields
        canvas = tk.Canvas(self.input_frame, borderwidth=0)
        scrollbar = ttk.Scrollbar(self.input_frame, orient="vertical", command=canvas.yview)
        scrollable_frame = ttk.Frame(canvas)
        
        scrollable_frame.bind(
            "<Configure>",
            lambda _e: canvas.configure(scrollregion=canvas.bbox("all"))
        )
        
        canvas.create_window((0, 0), window=scrollable_frame, anchor="nw")
        canvas.configure(yscrollcommand=scrollbar.set)
        
        # Input fields with default values
        inputs = [
            ("Frequency (GHz):", "10.0"),
            ("Pulse duration (μs):", "1.0"),
            ("PRF (Hz):", "1000"),
            ("Emitted power (dBm):", "30"),
            ("Antenna gain (dBi):", "20"),
            ("Receiver sensitivity (dBm):", "-90"),
            ("Radar cross section (m²):", "1.0"),
            ("System losses (dB):", "3"),
            ("Noise figure (dB):", "3"),
            ("Boltzmann constant (k) - optional:", "1.38e-23"),
            ("Temperature (K):", "290")
        ]
        
        self.entries = {}
        
        for _i, (label, default) in enumerate(inputs):
            # Create a frame for each input row
            row_frame = ttk.Frame(scrollable_frame)
            row_frame.pack(fill=tk.X, pady=5)
            
            # Label
            ttk.Label(row_frame, text=label, width=30, anchor='w').pack(side=tk.LEFT, padx=5)
            
            # Entry
            entry = ttk.Entry(row_frame, width=20, font=('Arial', 10))
            entry.pack(side=tk.LEFT, padx=5)
            entry.insert(0, default)
            self.entries[label] = entry
        
        # Additional notes
        notes_label = tk.Label(scrollable_frame, 
                              text="Note: All values must be numeric. Use point (.) for decimals.", 
                              font=('Arial', 9, 'italic'), fg='gray')
        notes_label.pack(pady=20)
        
        # Pack canvas and scrollbar
        canvas.pack(side="left", fill="both", expand=True)
        scrollbar.pack(side="right", fill="y")
        
    def create_calculate_button(self):
        """Create the calculate button"""
        calculate_btn = tk.Button(self.button_frame, 
                                 text="CALCULATE RADAR PARAMETERS", 
                                 command=self.calculate_parameters,
                                 bg='#4CAF50', fg='white',
                                 font=('Arial', 12, 'bold'),
                                 padx=30, pady=10,
                                 cursor='hand2')
        calculate_btn.pack()
        
        # Bind hover effect
        calculate_btn.bind("<Enter>", lambda _e: calculate_btn.config(bg='#45a049'))
        calculate_btn.bind("<Leave>", lambda _e: calculate_btn.config(bg='#4CAF50'))
        
    def create_results_display(self):
        """Create the results display area"""
        
        # Results title
        title_label = tk.Label(self.results_frame, text="RADAR PERFORMANCE PARAMETERS", 
                              font=('Arial', 14, 'bold'))
        title_label.pack(pady=(20, 20))
        
        # Create frame for results with scrollbar
        canvas = tk.Canvas(self.results_frame, borderwidth=0)
        scrollbar = ttk.Scrollbar(self.results_frame, orient="vertical", command=canvas.yview)
        scrollable_frame = ttk.Frame(canvas)
        
        scrollable_frame.bind(
            "<Configure>",
            lambda _e: canvas.configure(scrollregion=canvas.bbox("all"))
        )
        
        canvas.create_window((0, 0), window=scrollable_frame, anchor="nw")
        canvas.configure(yscrollcommand=scrollbar.set)
        
        # Results fields
        results = [
            ("Maximum detectable range:", "range_result"),
            ("Range resolution:", "range_res_result"),
            ("Maximum unambiguous range:", "max_range_result"),
            ("Maximum detectable speed:", "speed_result"),
            ("Speed resolution:", "speed_res_result"),
            ("Doppler frequency resolution:", "doppler_res_result"),
            ("Pulse width (s):", "pulse_width_result"),
            ("Bandwidth (Hz):", "bandwidth_result"),
            ("SNR (dB):", "snr_result")
        ]
        
        self.results_labels = {}
        
        for _i, (label, key) in enumerate(results):
            # Create a frame for each result row
            row_frame = ttk.Frame(scrollable_frame)
            row_frame.pack(fill=tk.X, pady=10, padx=20)
            
            # Label
            ttk.Label(row_frame, text=label, font=('Arial', 11, 'bold'), 
                     width=30, anchor='w').pack(side=tk.LEFT)
            
            # Value
            value_label = ttk.Label(row_frame, text="---", font=('Arial', 11), 
                                   foreground='blue', anchor='w')
            value_label.pack(side=tk.LEFT, padx=(20, 0))
            self.results_labels[key] = value_label
        
        # Add separator
        ttk.Separator(scrollable_frame, orient='horizontal').pack(fill=tk.X, pady=20)
        
        # Add explanatory note
        note_text = """
        NOTES:
        • Maximum detectable range is calculated using the radar equation
        • Range resolution = c x τ / 2, where τ is pulse duration
        • Maximum unambiguous range = c / (2 x PRF)
        • Maximum detectable speed = λ x PRF / 4
        • Speed resolution = λ x PRF / (2 x N) where N is number of pulses (assumed 1)
        • λ (wavelength) = c / f
        """
        
        note_label = tk.Label(scrollable_frame, text=note_text, font=('Arial', 9), 
                             justify=tk.LEFT, bg='#f8f9fa', relief='solid', 
                             padx=10, pady=10)
        note_label.pack(fill=tk.X, padx=20, pady=10)
        
        # Pack canvas and scrollbar
        canvas.pack(side="left", fill="both", expand=True)
        scrollbar.pack(side="right", fill="y")
        
    def get_float_value(self, entry, default=None):
        """Safely get float value from entry"""
        try:
            return float(entry.get())
        except ValueError:
            return default
            
    def calculate_parameters(self):
        """Perform all RADAR calculations"""
        
        try:
            # Get all input values
            f_ghz = self.get_float_value(self.entries["Frequency (GHz):"])
            pulse_duration_us = self.get_float_value(self.entries["Pulse duration (μs):"])
            prf = self.get_float_value(self.entries["PRF (Hz):"])
            p_dbm = self.get_float_value(self.entries["Emitted power (dBm):"])
            g_dbi = self.get_float_value(self.entries["Antenna gain (dBi):"])
            sens_dbm = self.get_float_value(self.entries["Receiver sensitivity (dBm):"])
            rcs = self.get_float_value(self.entries["Radar cross section (m²):"])
            losses_db = self.get_float_value(self.entries["System losses (dB):"])
            nf_db = self.get_float_value(self.entries["Noise figure (dB):"])
            k = self.get_float_value(self.entries["Boltzmann constant (k) - optional:"])
            temp = self.get_float_value(self.entries["Temperature (K):"])
            
            # Validate inputs
            if None in [
                f_ghz, pulse_duration_us, prf, p_dbm, g_dbi,
                sens_dbm, rcs, losses_db, nf_db, temp,
            ]:
                messagebox.showerror("Error", "Please enter valid numeric values for all fields")
                return
                
            # Convert units
            f_hz = f_ghz * 1e9
            pulse_duration_s = pulse_duration_us * 1e-6
            wavelength = self.c / f_hz
            
            # Convert dB values to linear
            p_linear = 10 ** ((p_dbm - 30) / 10)  # Convert dBm to Watts
            g_linear = 10 ** (g_dbi / 10)
            sens_linear = 10 ** ((sens_dbm - 30) / 10)
            losses_linear = 10 ** (losses_db / 10)
            _nf_linear = 10 ** (nf_db / 10)
            
            # Calculate receiver noise power
            if k is None:
                k = 1.38e-23  # Default Boltzmann constant
            
            # Calculate SNR
            snr_linear = (p_linear * g_linear**2 * wavelength**2 * rcs) / (
                (4 * np.pi)**3 * sens_linear * losses_linear)
            snr_db = 10 * math.log10(snr_linear) if snr_linear > 0 else float('-inf')
            
            # Maximum detectable range using radar equation
            if snr_linear > 0:
                range_max = ((p_linear * g_linear**2 * wavelength**2 * rcs) / 
                            ((4 * np.pi)**3 * sens_linear * losses_linear)) ** (1/4)
            else:
                range_max = 0
                
            # Range resolution
            range_res = (self.c * pulse_duration_s) / 2
            
            # Maximum unambiguous range
            max_unambiguous_range = self.c / (2 * prf)
            
            # Maximum detectable speed (using half the Nyquist sampling theorem)
            max_speed = (wavelength * prf) / 4
            
            # Speed resolution (for a single pulse, approximate)
            speed_res = max_speed  # For single pulse, resolution equals max speed
            
            # Doppler frequency resolution
            doppler_res = 1 / pulse_duration_s
            
            # Bandwidth
            bandwidth = 1 / pulse_duration_s
            
            # Update results display with formatted values
            self.results_labels["range_result"].config(
                text=f"{range_max:.2f} m  ({range_max/1000:.2f} km)")
            self.results_labels["range_res_result"].config(
                text=f"{range_res:.2f} m")
            self.results_labels["max_range_result"].config(
                text=f"{max_unambiguous_range:.2f} m  ({max_unambiguous_range/1000:.2f} km)")
            self.results_labels["speed_result"].config(
                text=f"{max_speed:.2f} m/s  ({max_speed*3.6:.2f} km/h)")
            self.results_labels["speed_res_result"].config(
                text=f"{speed_res:.2f} m/s  ({speed_res*3.6:.2f} km/h)")
            self.results_labels["doppler_res_result"].config(
                text=f"{doppler_res:.2f} Hz")
            self.results_labels["pulse_width_result"].config(
                text=f"{pulse_duration_s:.2e} s")
            self.results_labels["bandwidth_result"].config(
                text=f"{bandwidth:.2e} Hz")
            self.results_labels["snr_result"].config(
                text=f"{snr_db:.2f} dB")
            
            # Switch to results tab
            self.notebook.select(1)
            
            # Show success message
            messagebox.showinfo("Success", "Calculation completed successfully!")
            
        except (ValueError, ZeroDivisionError) as e:
            messagebox.showerror(
                "Calculation Error",
                f"An error occurred during calculation:\n{e!s}",
            )
            
def main():
    root = tk.Tk()
    _app = RadarCalculatorGUI(root)
    root.mainloop()

if __name__ == "__main__":
    main()
