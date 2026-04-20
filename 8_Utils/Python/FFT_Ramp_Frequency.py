import numpy as np
from numpy.fft import fft, ifft
import matplotlib.pyplot as plt

n = np.arange(0, 61, 1)
Fs=125e6
Ts = 1.0 / Fs
Tb=1e-6
y = 1 + np.sin(2*np.pi*(29e6*(n**2)*(Ts**2)/(2.0*Tb)+1e6*n*Ts))

t = Ts*np.arange(0,61,1)
Y = fft(y)
M =len(Y)
m = np.arange(M)
T = M*Ts
freq = m/T


plt.figure(figsize = (12, 6))
plt.subplot(121)
plt.stem(freq, np.abs(Y), 'b', \
         markerfmt=" ", basefmt="-b")
plt.xlabel('Freq (Hz)')
plt.ylabel('FFT Amplitude |Y(freq)|')
plt.xlim(0, 40*pow(10,6))
plt.ylim(0, 20)

plt.subplot(122)
plt.plot(t, ifft(Y), 'r')
plt.xlabel('Time (s)')
plt.ylabel('Amplitude')
plt.tight_layout()

plt.show()
