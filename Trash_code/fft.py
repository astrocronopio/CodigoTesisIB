import numpy as np
import matplotlib.pyplot as plt
import scipy.fftpack



def plot_fft(filename, number, name, color):
	plt.figure(number)
	utc, events, p, rho, rho_avg, hex6T5 = np.loadtxt(filename, unpack=True)
	N= len(utc)
	T= 3600
	yauger=scipy.fftpack.fft(rho/hex6T5)
	xauger=np.linspace(0.0,1.0/(2.0*T), N/2)
	plt.plot(xauger,2.0/N * np.abs(yauger[:N//2]), color=color)
	plt.title(name)
	pass


filename_old="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/All_data/herald_old_utctprh.dat"
filename_old_delay="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/All_data/herald_old_delay.dat"

filename="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/All_data/herald_utctprh.dat"
filename_delay="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/All_data/herald_delay.dat"

plot_fft(filename,1,"Herald Data", "red")
plot_fft(filename_delay,2,"Herald Data (Delayed)","blue")



plt.show()