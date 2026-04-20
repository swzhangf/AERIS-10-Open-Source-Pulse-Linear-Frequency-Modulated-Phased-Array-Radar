import numpy as np
import pandas as pd
import math

def generate_radar_csv(filename="pulse_compression_output.csv"):
    """
    Generate realistic radar CSV data for testing the Python GUI
    """
    
    # Radar parameters matching your testbench
    num_long_chirps = 16
    num_short_chirps = 16
    samples_per_chirp = 512  # Reduced for manageable file size
    fs_adc = 400e6  # 400 MHz ADC
    timestamp_ns = 0
    
    # Target parameters
    targets = [
        {
            'range': 3000, 'velocity': 25, 'snr': 30, 'azimuth': 10, 'elevation': 5
        },  # Fast moving target
        {
            'range': 5000, 'velocity': -15, 'snr': 25, 'azimuth': 20, 'elevation': 2
        },  # Approaching target
        {
            'range': 8000, 'velocity': 5, 'snr': 20, 'azimuth': 30, 'elevation': 8
        },  # Slow moving target
        {
            'range': 12000, 'velocity': -8, 'snr': 18, 'azimuth': 45, 'elevation': 3
        },  # Distant target
    ]
    
    # Noise parameters
    noise_std = 5
    clutter_std = 10
    
    data = []
    chirp_number = 0
    
    # Generate Long Chirps (30µs duration equivalent)
    for chirp in range(num_long_chirps):
        for sample in range(samples_per_chirp):
            # Base noise
            i_val = np.random.normal(0, noise_std)
            q_val = np.random.normal(0, noise_std)
            
            # Add clutter (stationary targets)
            _clutter_range = 2000  # Fixed clutter at 2km
            if sample < 100:  # Simulate clutter in first 100 samples
                i_val += np.random.normal(0, clutter_std)
                q_val += np.random.normal(0, clutter_std)
            
            # Add moving targets with Doppler shift
            for target in targets:
                # Calculate range bin (simplified)
                range_bin = int(target['range'] / 20)  # ~20m per bin
                doppler_phase = (
                    2 * math.pi * target['velocity'] * chirp / 100
                )  # Doppler phase shift
                
                # Target appears around its range bin with some spread
                if abs(sample - range_bin) < 10:
                    # Signal amplitude decreases with range
                    amplitude = target['snr'] * (10000 / target['range'])
                    phase = 2 * math.pi * sample / 50 + doppler_phase
                    
                    i_val += amplitude * math.cos(phase)
                    q_val += amplitude * math.sin(phase)
            
            # Calculate derived values
            magnitude_squared = i_val**2 + q_val**2
            
            data.append({
                'timestamp_ns': timestamp_ns,
                'chirp_number': chirp_number,
                'chirp_type': 'LONG',
                'sample_index': sample,
                'I_value': int(i_val),
                'Q_value': int(q_val),
                'magnitude_squared': int(magnitude_squared)
            })
            
            timestamp_ns += int(1e9 / fs_adc)  # 2.5ns per sample at 400MHz
        
        chirp_number += 1
        timestamp_ns += 137000  # Add listening period (137µs)
    
    # Guard time between long and short chirps
    timestamp_ns += 175400  # 175.4µs guard time
    
    # Generate Short Chirps (0.5µs duration equivalent)
    for chirp in range(num_short_chirps):
        for sample in range(samples_per_chirp):
            # Base noise
            i_val = np.random.normal(0, noise_std)
            q_val = np.random.normal(0, noise_std)
            
            # Add clutter (different characteristics for short chirps)
            if sample < 50:  # Less clutter for short chirps
                i_val += np.random.normal(0, clutter_std/2)
                q_val += np.random.normal(0, clutter_std/2)
            
            # Add moving targets with different Doppler for short chirps
            for target in targets:
                # Range bin calculation (different for short chirps)
                range_bin = int(target['range'] / 40)  # Different range resolution
                doppler_phase = (
                    2 * math.pi * target['velocity'] * (chirp + 5) / 80
                )  # Different Doppler
                
                # Target appears around its range bin
                if abs(sample - range_bin) < 8:
                    # Different amplitude characteristics for short chirps
                    amplitude = target['snr'] * 0.7 * (8000 / target['range'])  # 70% amplitude
                    phase = 2 * math.pi * sample / 30 + doppler_phase
                    
                    i_val += amplitude * math.cos(phase)
                    q_val += amplitude * math.sin(phase)
            
            # Calculate derived values
            magnitude_squared = i_val**2 + q_val**2
            
            data.append({
                'timestamp_ns': timestamp_ns,
                'chirp_number': chirp_number,
                'chirp_type': 'SHORT',
                'sample_index': sample,
                'I_value': int(i_val),
                'Q_value': int(q_val),
                'magnitude_squared': int(magnitude_squared)
            })
            
            timestamp_ns += int(1e9 / fs_adc)  # 2.5ns per sample
        
        chirp_number += 1
        timestamp_ns += 174500  # Add listening period (174.5µs)
    
    # Create DataFrame
    df = pd.DataFrame(data)
    
    # Save to CSV
    df.to_csv(filename, index=False)
    
    return df

def analyze_generated_data(df):
    """
    Analyze the generated data to verify target detection
    """
    
    # Basic statistics
    df[df['chirp_type'] == 'LONG']
    df[df['chirp_type'] == 'SHORT']
    
    
    # Calculate actual magnitude and phase for analysis
    df['magnitude'] = np.sqrt(df['I_value']**2 + df['Q_value']**2)
    df['phase_rad'] = np.arctan2(df['Q_value'], df['I_value'])
    
    # Find high-magnitude samples (potential targets)
    high_mag_threshold = df['magnitude'].quantile(0.95)  # Top 5%
    targets_detected = df[df['magnitude'] > high_mag_threshold]
    
    
    # Group by chirp type
    targets_detected[targets_detected['chirp_type'] == 'LONG']
    targets_detected[targets_detected['chirp_type'] == 'SHORT']
    
    
    return df

if __name__ == "__main__":
    # Generate the CSV file
    df = generate_radar_csv("test_radar_data.csv")
    
    # Analyze the generated data
    analyze_generated_data(df)
    
