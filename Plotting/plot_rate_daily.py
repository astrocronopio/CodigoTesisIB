import matplotlib.pyplot as plt
# import  seaborn as sns
import matplotlib as mpl
mpl.rcParams.update({
	'font.size': 20,
	'figure.figsize': [12, 6],
	'figure.autolayout': True,
	'font.family': 'serif',
	'font.sans-serif': ['Palatino']})

import numpy as np
from matplotlib.dates import epoch2num,MonthLocator, MONDAY, WeekdayLocator, DateFormatter, num2date


# file_plot_rate = "../WeatherCode/AllTriggers/2019/weather_analysis/AllTriggers_1EeV_rate.dat"
file_plot_rate = "../WeatherCode/AllTriggers/2019/weather_analysis/AllTriggers_S38_over_1EeV_rate.dat"


factor = 1.949 # Area/5
utc, rate_measure, rate_estimate, hexagons = np.loadtxt(file_plot_rate, unpack=True)

months = MonthLocator(range(1, 13), bymonthday=1, interval=12)
monthsFmt = DateFormatter("%b '%y")

fig, ax = plt.subplots()
ax.set_ylabel("Tasa [km$^{-2}$día$^{-1}$]")
ax.set_xlabel("Fecha")
ax.set_ylim(ymin=0.2, ymax=0.4)
ax.scatter(num2date(epoch2num(utc)), rate_measure/(hexagons*factor) , 
           marker="o", label="Medido", s=9, color="red", alpha=0.8)
ax.fill_between(num2date(epoch2num(utc)), 
                rate_measure/(hexagons*factor) - np.sqrt(rate_measure)/(hexagons*factor),
                rate_measure/(hexagons*factor) + np.sqrt(rate_measure)/(hexagons*factor),
                color='red', alpha=0.2)


# plt.scatter(utc, rate_estimate/hexagons , color='black', lw=1, s=5)
ax.xaxis.set_major_locator(months)
# ax.xaxis.set_major_formatter(monthsFmt)
ax.autoscale_view()
ax.grid(alpha=0.1)
# fig.autofmt_xdate()

plt.show()