## This plot the output of weather data withou
#
#

import matplotlib.pyplot as plt
import matplotlib.dates as md
import numpy as np
import datetime as dt
import time

filename="/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh_without_badperiod_no_iw.dat"
#_______________________________________
#__Daily
utc, T, pressure, rho, av_rho, hex_6T5, hex_5T5, iw = np.loadtxt(filename, unpack=True)


def plot_utctprh(index, name, utc, data):
	plt.figure(index)
	utc_date=[dt.datetime.fromtimestamp(t) for t in utc]
	plt.subplots_adjust(bottom=0.2)
	plt.xticks( rotation=90 )
	ax=plt.gca()
	xfmt = md.DateFormatter('%Y-%m')
	ax.xaxis.set_major_formatter(xfmt)
	plt.title(name)
	plt.plot(utc_date,data, lw=0.5)
	pass

#________________________________________
plot_utctprh(1, "Temperature", utc, T)
#________________________________________
plot_utctprh(2, "Pressure", utc, pressure)
#________________________________________
plot_utctprh(3, "Density $\\rho$", utc, rho)
#________________________________________
plot_utctprh(4, "Daily Averange Density $\\rho_{average}$", utc, av_rho)
#________________________________________
plot_utctprh(5, "6T5", utc, hex_6T5)
#________________________________________
plot_utctprh(6, "5T5", utc, hex_5T5)


plt.show()