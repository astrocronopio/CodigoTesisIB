import numpy as np
import matplotlib.pyplot as plt
from scipy import pi
from scipy.fftpack import fft


def plot_fft(filename, number, name, color):
	
	plt.figure(number)
	utc, the, energy, ra, dec = np.loadtxt(filename, unpack=True)
	N= len(utc)
	T= 3600
	cos_ra=np.cos(ra*pi/180.0)
	sin_ra=np.sin(ra*pi/180.0)
	yauger=  np.sqrt(sin_ra**2 + cos_ra**2)#fft(ra)
	xauger=np.linspace(0.0,1.0/(2.0*T), N/2)
	plt.yscale("log")
	plt.plot(xauger,2.0/N * np.abs(yauger[:N//2]), color=color)
	plt.title(name)
	pass

filename="../../Herald/Central/Modified/Energy_above_1EeV/Herald_8EeV.dat"

plot_fft(filename, 1, "test", "red")
plt.show()