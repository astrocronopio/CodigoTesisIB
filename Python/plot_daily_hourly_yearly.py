

import matplotlib.pyplot as plt
import matplotlib.dates as md
import numpy as np
import datetime as dt
import time

filename="/home/ponci/Desktop/TesisLicenciaturaBalseiro/Trabajo_de_Coronel/Code/Cpp/test1.dat"
#_______________________________________
#__Daily
utc, events, pressure, \
rho, av_rho, hexagons = np.loadtxt(filename, unpack=True)


def plot_utctprh(index, name, utc, data):
	plt.figure(index)
	utc_date=[dt.datetime.fromtimestamp(t) for t in utc]
	plt.subplots_adjust(bottom=0.2)
	plt.xticks( rotation=90 )
	ax=plt.gca()
	xfmt = md.DateFormatter('%Y-%m')
	ax.xaxis.set_major_formatter(xfmt)
	plt.title(name)
	plt.plot(utc_date,data)
	pass

#________________________________________
plot_utctprh(1, "Events", utc, events)
#________________________________________
plot_utctprh(2, "Pressure", utc, pressure)
#________________________________________
plot_utctprh(3, "Density $\\rho$", utc, rho)
#________________________________________
plot_utctprh(4, "Daily Averange Density $\\rho_{average}$", utc, pressure)

plt.show()