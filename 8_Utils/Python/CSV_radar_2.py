import numpy as np
import pandas as pd
import math

def generate_small_radar_csv(filename="small_test_radar_data.csv"):
    """
    Generate a smaller, faster-to-process radar CSV
    """
    # Reduced parameters for faster processing
    num_long_chirps = 8    # Reduced from 16
    num_short_chirps = 8   # Reduced from 16  
    samples_per_chirp = 128 # Reduced from 512
    fs_adc = 400e6
    
    targets = [
        {'range': 3000, 'velocity': 25, 'snr': 40},
        {'range': 5000, 'velocity': -15, 'snr': 35},
    ]
    
    data = []
    chirp_number = 0
    timestamp_ns = 0
    
    # Generate Long Chirps
    for chirp in range(num_long_chirps):
        for sample in range(samples_per_chirp):
            i_val = np.random.normal(0, 3)
            q_val = np.random.normal(0, 3)
            
            # Add targets
            for target in targets:
                range_bin = int(target['range'] / 40)
                doppler_phase = 2 * math.pi * target['velocity'] * chirp / 50
                
                if abs(sample - range_bin) < 5:
                    amplitude = target['snr'] * (8000 / target['range'])
                    phase = 2 * math.pi * sample / 30 + doppler_phase
                    i_val += amplitude * math.cos(phase)
                    q_val += amplitude * math.sin(phase)
            
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
            
            timestamp_ns += int(1e9 / fs_adc)
        
        chirp_number += 1
        timestamp_ns += 137000
    
    # Generate Short Chirps
    for chirp in range(num_short_chirps):
        for sample in range(samples_per_chirp):
            i_val = np.random.normal(0, 3)
            q_val = np.random.normal(0, 3)
            
            for target in targets:
                range_bin = int(target['range'] / 60)
                doppler_phase = 2 * math.pi * target['velocity'] * (chirp + 2) / 40
                
                if abs(sample - range_bin) < 4:
                    amplitude = target['snr'] * 0.6 * (6000 / target['range'])
                    phase = 2 * math.pi * sample / 25 + doppler_phase
                    i_val += amplitude * math.cos(phase)
                    q_val += amplitude * math.sin(phase)
            
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
            
            timestamp_ns += int(1e9 / fs_adc)
        
        chirp_number += 1
        timestamp_ns += 174500
    
    df = pd.DataFrame(data)
    df.to_csv(filename, index=False)
    return df

generate_small_radar_csv()
