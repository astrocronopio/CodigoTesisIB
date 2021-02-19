import matplotlib.pyplot as plt
# import  seaborn as sns
import matplotlib as mpl
mpl.rcParams.update({
	'font.size': 20,
	'figure.figsize': [12, 7.5],
	'figure.autolayout': True,
	'font.family': 'serif',
	'font.sans-serif': ['Palatino']})

# mpl.rc('font', family = 'serif', serif = 'STIXGeneral') 

import numpy as np
from matplotlib.dates import epoch2num,MonthLocator, MONDAY, WeekdayLocator, DateFormatter, num2date

#Para como yo trabajé a all triggers
factor = 0.5#/1.949 # (Area/5)^[-1] == 2.566

## This factor is for hexagons area, and the bins for the aab 2017 were made with 2 hours span 
# factor = 2/(2.566) # (Area)^[-1] ; (2.566/2)^[-1]

months = MonthLocator(range(1, 13), bymonthday=1, interval=12)
monthsFmt = DateFormatter("%b '%y")

def plot_medi(filepath):
	utc, rate_measure, rate_estimate, hexagons = np.loadtxt(filepath, unpack=True)
	# hexagons*=5
	fig, ax = plt.subplots()
	ax.set_ylabel("Tasa [km$^{-2}$día$^{-1}$]")
	ax.set_xlabel("Fecha")
	# ax.set_ylim(ymin=0.2, ymax=0.4)
	ax.scatter(num2date(epoch2num(utc)), rate_measure/(hexagons*factor) , 
			marker="o", s=1.5, color="indianred", alpha=0.8)

	ax.fill_between(num2date(epoch2num(utc)), 
					rate_measure/(hexagons*factor) - np.sqrt(rate_measure)/(hexagons*factor),
					rate_measure/(hexagons*factor) + np.sqrt(rate_measure)/(hexagons*factor),
					color='indianred', alpha=0.2)

	ax.xaxis.set_major_locator(months)
	# ax.xaxis.set_major_formatter(monthsFmt)
	ax.autoscale_view()
	ax.grid(alpha=0.1)
	# fig.autofmt_xdate()


def plot_medi_prediction(filepath):
	utc, rate_measure, rate_estimate, hexagons = np.loadtxt(filepath, unpack=True)


	fig, ax = plt.subplots()
	ax.set_ylabel("Tasa [km$^{-2}$día$^{-1}$]")
	ax.set_xlabel("Fecha")
	# ax.set_ylim(ymin=0.2, ymax=0.4)
	color_main='indianred'
	ax.scatter(num2date(epoch2num(utc)), rate_measure/(hexagons*factor) , 
			marker="+", lw=1, s=8, color=color_main, alpha=0.8, label="Medición")

	ax.fill_between(num2date(epoch2num(utc)), 
					rate_measure/(hexagons*factor) - np.sqrt(rate_measure)/(hexagons*factor),
					rate_measure/(hexagons*factor) + np.sqrt(rate_measure)/(hexagons*factor),
					color=color_main, alpha=0.2)

	plt.scatter(num2date(epoch2num(utc)), rate_estimate/(hexagons*factor) ,
					color='black', s=3, marker="o", label="Predición")
	ax.xaxis.set_major_locator(months)
	# ax.xaxis.set_major_formatter(monthsFmt)
	ax.autoscale_view()
	ax.grid(alpha=0.1)
	ax.legend(markerscale=4)
	
	# fig.autofmt_xdate()


AllTriggers_2EeV_rate = "../WeatherCode/wCorrections/Files_AllTriggers/1EeV_rate_day.dat"
Main_Array_1EeV_rate = "../WeatherCode/Main_Array/upto2015/Data/Herald_old/herald_old_above_1EeV_rate_day.dat"
Main_Array_2EeV_rate = "../WeatherCode/Main_Array/upto2015/Data/Herald_old/herald_old_above_2EeV_rate_day.dat"

ICRC_2019_Array_1EeV_rate = "../WeatherCode/Main_Array/upto2019/Data/Herald/herald_above_1EeV_rate_day.dat"
ICRC_2019_Array_2EeV_rate = "../WeatherCode/Main_Array/upto2019/Data/Herald/herald_above_2EeV_rate_day.dat"


AllTriggers_S38_over_1EeV_rate = "../WeatherCode/AllTriggers/2019/weather_analysis/AllTriggers_S38_over_1EeV_rate.dat"
ICRC_2019_S38_over_1EeV_rate = "../WeatherCode/Main_Array/upto2019/Data/Herald_S38/S38_above_0EeV_rate_day.dat"



# herald_above_1EeV_r#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#################################################################################################################################
# ate_day="../WeatherCode/Main_Array/upto2015/Data/Herald/herald_above_1EeV_rate_day.dat"
# S38_above_0EeV_rate_day="../WeatherCode/Main_Array/upto2019/Data/Herald_S38/S38_above_0EeV_rate_day.dat"


plot_medi(AllTriggers_2EeV_rate)
plt.show()
exit()
# plot_medi(ICRC_2019_Array_1EeV_rate)
# plot_medi(ICRC_2019_Array_2EeV_rate)

# plot_medi_prediction(Main_Array_1EeV_rate)
# plot_medi_prediction(AllTriggers_S38_over_1EeV_rate)
# plot_medi_prediction(ICRC_2019_S38_over_1EeV_rate)

# plt.show()
# exit()

file_hod_1="../WeatherCode/wCorrections/Files_Wide_Range_Reconstruction_AllTriggers/1EeV_rate_day.dat"
file_hod_2="../WeatherCode/wCorrections/Files_Wide_Range_Reconstruction_AllTriggers/2EeV_rate_day.dat"
def plot_two_graphs_hod():
	
	utc, rate_measure, rate_estimate, hexagons = np.loadtxt(file_hod_1, unpack=True)

	utc1, rate_measure1, rate_estimate1, hexagons1 = np.loadtxt(file_hod_2, unpack=True)

	rate_measure1, rate_estimate1 = 2*rate_measure1, 2*rate_estimate1,

	# fig, ax = plt.subplots(2, sharex=True)
	fig = plt.figure()
	ax1 = plt.subplot2grid((2,1), (0,0))
	ax2 = plt.subplot2grid((2,1), (1,0))
	# plt.show()
	ax1.set_xticks([])
	# ax1.set_xlim(-0.5,23.5)
	# ax2.set_xticks(np.arange(0,27,2))
	ax1.set_yticks(np.arange(0,1,0.02))
	ax2.set_yticks(np.arange(0,1,0.006))
	# ax2.set_xlim(-0.5,23.5)

	color="indianred"

	ax1.scatter(num2date(epoch2num(utc)), rate_measure/(hexagons*factor) , label="Energía > 1 EeV",
		marker="o", s=1.5, color=color, alpha=0.8)

	ax1.fill_between(num2date(epoch2num(utc)), 
				rate_measure/(hexagons*factor) - np.sqrt(rate_measure)/(hexagons*factor),
				rate_measure/(hexagons*factor) + np.sqrt(rate_measure)/(hexagons*factor),
				color=color, alpha=0.2)


	color1="green"
	ax2.scatter(num2date(epoch2num(utc1)), rate_measure1/(hexagons1*factor) , label="Energía > 2 EeV",
		marker="o", s=1.5, color=color1, alpha=0.8)

	ax2.fill_between(num2date(epoch2num(utc1)), 
				rate_measure1/(hexagons1*factor) - np.sqrt(rate_measure1)/(hexagons1*factor),
				rate_measure1/(hexagons1*factor) + np.sqrt(rate_measure1)/(hexagons1*factor),
				color=color1, alpha=0.2)


	ax1.set_ylabel("Tasa [km$^{-2}$día$^{-1}$]")
	ax2.set_ylabel("Tasa [km$^{-2}$día$^{-1}$]")
	ax2.set_xlabel("Fecha")
	ax1.legend(fontsize=18)
	ax2.legend(fontsize=18)
	ax1.xaxis.set_major_locator(months)
	# # ax.xaxis.set_major_formatter(monthsFmt)
	# ax1.autoscale_view()
 
	ax2.xaxis.set_major_locator(months)
	# ax.xaxis.set_major_formatter(monthsFmt)
	ax2.autoscale_view()
	
	
	
	plt.show()

plot_two_graphs_hod()
plt.show()