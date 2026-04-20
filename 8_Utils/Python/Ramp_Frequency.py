import numpy as np
import matplotlib.pyplot as plt
n = np.arange(0, 61, 1)
Ts=8*pow(10,-9)
y = 1 + np.sin(2*np.pi*(-16*pow(10,12)*pow(n,2)*pow(Ts,2)+16*pow(10,6)*n*Ts))
plt.plot(n, y)
plt.show()
