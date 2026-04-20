import numpy as np

def calculate_patch_antenna_parameters(frequency, epsilon_r, h_sub, h_cu, array):
    # Constants
    c = 3e8  # Speed of light in m/s
    
    # Convert height from mm to meters
    h_sub_m = h_sub * 1e-3
    h_cu_m = h_cu * 1e-3

    # Calculate Lambda
    lamb = c /(frequency * 1e9)
    
    # Calculate the effective dielectric constant
    epsilon_eff = (
        (epsilon_r + 1) / 2
        + (epsilon_r - 1) / 2 * (1 + 12 * h_sub_m / (array[1] * h_cu_m)) ** (-0.5)
    )
    
    # Calculate the width of the patch
    W = c / (2 * frequency * 1e9) * np.sqrt(2 / (epsilon_r + 1))
    
    # Calculate the effective length
    delta_L = (
        0.412
        * h_sub_m
        * (epsilon_eff + 0.3)
        * (W / h_sub_m + 0.264)
        / ((epsilon_eff - 0.258) * (W / h_sub_m + 0.8))
    )
    
    # Calculate the length of the patch
    L = c / (2 * frequency * 1e9 * np.sqrt(epsilon_eff)) - 2 * delta_L
    
    # Calculate the separation distance in the horizontal axis (dx)
    dx = lamb/2  # Typically 1.5 times the width of the patch
    
    # Calculate the separation distance in the vertical axis (dy)
    dy = lamb/2  # Typically 1.5 times the length of the patch
    
    # Calculate the feeding line width (W_feed)
    Z0 = 50  # Characteristic impedance of the feeding line (typically 50 ohms)
    A = (
        Z0 / 60 * np.sqrt((epsilon_r + 1) / 2)
        + (epsilon_r - 1) / (epsilon_r + 1) * (0.23 + 0.11 / epsilon_r)
    )
    W_feed = 8 * h_sub_m / np.exp(A) - 2 * h_cu_m
    
    # Convert results back to mm
    W_mm = W * 1e3
    L_mm = L * 1e3
    dx_mm = dx * 1e3
    dy_mm = dy * 1e3
    W_feed_mm = W_feed * 1e3
    
    return W_mm, L_mm, dx_mm, dy_mm, W_feed_mm

# Example usage
frequency = 10.5  # Frequency in GHz
epsilon_r = 3.48  # Relative permittivity of the substrate
h_sub = 0.102  # Height of substrate in mm
h_cu = 0.07  # Height of copper in mm
array = [2, 2]  # 2x2 array

W_mm, L_mm, dx_mm, dy_mm, W_feed_mm = calculate_patch_antenna_parameters(
    frequency, epsilon_r, h_sub, h_cu, array
)

