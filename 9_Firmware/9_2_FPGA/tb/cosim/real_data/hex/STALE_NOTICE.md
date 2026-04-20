# Golden Reference Hex Files

These hex files are **committed golden references** for strict bit-exact
real-data regression tests (`tb_doppler_realdata.v`, `tb_fullchain_realdata.v`).

## When to regenerate

Regenerate whenever the Doppler processing pipeline changes:

- `doppler_processor.v` (FFT size, window, sub-frame structure)
- `xfft_16.v` / `fft_engine.v` (butterfly arithmetic, twiddle lookup)
- `range_bin_decimator.v` (decimation mode, peak detection logic)
- `fft_twiddle_16.mem` (twiddle factor ROM)

## How to regenerate

```bash
cd 9_Firmware/9_2_FPGA
python3 tb/cosim/real_data/golden_reference.py
# Then copy the Doppler-specific files:
python3 -c "
import numpy as np, os, shutil
h = 'tb/cosim/real_data/hex'
# Regenerate packed stimulus from range FFT npy
ri = np.load(f'{h}/range_fft_all_i.npy')
rq = np.load(f'{h}/range_fft_all_q.npy')
with open(f'{h}/doppler_input_realdata.hex','w') as f:
    for c in range(32):
        for r in range(64):
            i=int(ri[c,r])&0xFFFF; q=int(rq[c,r])&0xFFFF
            f.write(f'{(q<<16)|i:08X}\n')
shutil.copy2(f'{h}/doppler_map_i.hex', f'{h}/doppler_ref_i.hex')
shutil.copy2(f'{h}/doppler_map_q.hex', f'{h}/doppler_ref_q.hex')
"
```

## Architecture

Generated against the **dual 16-point FFT** Doppler architecture
(2 staggered-PRI sub-frames x 16-point Hamming-windowed FFT).

Source data: ADI CN0566 Phaser radar (10.525 GHz X-band FMCW, 4 MSPS).
