import matplotlib.pyplot as plt
# import  seaborn as sns
import matplotlib as mpl
mpl.rcParams.update({
	'font.size': 20,
	'figure.figsize': [12, 8],
	'figure.autolayout': True,
	'font.family': 'serif',
	'font.sans-serif': ['Palatino']})

import numpy as np

# file_hod = "../WeatherCode/Main_Array/upto2015/Data/Herald_old/herald_old_above_1EeV_hour_of_the_day.dat"
file_hod =  "../WeatherCode/AllTriggers/2019/weather_analysis/AllTriggers_S38_over_1EeV_hour_of_the_day.dat"

## This factor is for hexagons area, and the bins were made with
## 24 hours span 

# factor = 24*(2.566)

#Para como yo trabajé a all triggers
factor = 24/1.949 # (Area/5) == 2.566

hours = np.arange(0,24,1)
offset= np.arange(+3,len(hours)+3,1)%24

expected, measured, error_meas, hexagons = np.loadtxt(file_hod, unpack=True)

## Local hour GMT-3
expected, measured, error_meas, hexagons =expected[offset], measured[offset], error_meas[offset], hexagons[offset]


# fig, ax = plt.subplots(2, sharex=True)
fig = plt.figure()
ax1 = plt.subplot2grid((3,1), (0,0), rowspan=2)
ax2 = plt.subplot2grid((3,1), (2,0))
# plt.show()
ax1.set_xticks([])
ax1.set_xlim(-0.5,23.5)
ax2.set_xticks(np.arange(0,27,2))
ax2.set_yticks(np.arange(-4.8,5,0.8))
ax2.set_xlim(-0.5,23.5)


ax1.scatter(hours, factor*measured/(hexagons),label="Medición", 
           color='blue', alpha=0.6)
ax1.plot(hours, factor*expected/(hexagons), label="Predicción",
        color='black', alpha=0.6)


ax1.errorbar(hours, factor*measured/(hexagons),
             yerr=factor*error_meas/hexagons, 
             fmt='none', color='blue',     
             capsize=5, elinewidth=2,  
             markeredgewidth=2, alpha=0.4)

ax2.scatter(hours, 1000*factor*(measured-expected)/(hexagons), 
           color='blue', alpha=0.6)

ax2.axhline(0, color='black', alpha=0.6, ls=':')



ax1.set_ylabel("Tasa [km$^{-2}$día$^{-1}$]")
ax2.set_ylabel("Residuo [10$^{-3}$]")
ax2.set_xlabel("Hora local de Malargüe (GMT-3) [hr]")
ax1.legend()

plt.show()