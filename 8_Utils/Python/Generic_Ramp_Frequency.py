import numpy as np
from numpy.fft import fft, ifft
import matplotlib.pyplot as plt


fs=125*pow(10,6) #sampling frequency
Ts=1/fs # sampling time
Tb=0.5*pow(10,-6) # burst time
Tau=900*pow(10,-6) # pulse repetition time
fmax=30*pow(10,6) # maximum frequency on ramp
fmin=10*pow(10,6) # minimum frequency on ramp
n=int(Tb/Ts) # number of samples per ramp
N = np.arange(0, n, 1)
theta_n= 2*np.pi*(pow(N,2)*pow(Ts,2)*(fmax-fmin)/(2*Tb)+fmin*N*Ts) # instantaneous phase

y = 1 + np.sin(theta_n) # ramp signal in time domain

t = Ts*np.arange(0,n,1)
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
plt.xlim(0, (1.3*fmax))
plt.ylim(0, 60)

plt.subplot(122)
plt.plot(t, ifft(Y), 'r')
plt.xlabel('Time (s)')
plt.ylabel('Amplitude')
plt.tight_layout()

plt.show()
