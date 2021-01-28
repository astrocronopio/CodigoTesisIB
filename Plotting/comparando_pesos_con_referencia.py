#!/usr/bin/env python
# -*- coding: utf-8 -*-

import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns

import matplotlib as mpl
mpl.rcParams.update({
	'font.size': 20,
	'figure.figsize': [12, 7],
	'figure.autolayout': True,
	'font.family': 'serif',
	'font.sans-serif': ['Palatino']})


# title="paper 2018 N=288"
#plt.title("Enero 2004 - Enero 2017")

plt.xlim(0,360)
# plt.xlim(0,24)
#plt.ylabel("w" )
# plt.xticks(np.arange(0, 25, 3))
plt.ylabel("$\\Delta N_{cell}$" )
# plt.xlabel("Hora  GMT")
plt.xlabel( u"Ascensión Recta [$^o$]")

# plot "../../Hexagons/hexagons_2018/dnhex_sidereal_288.dat" 		u ($0*360/288):1 w lp lc rgb "red" tit "Sid"
# replot "../../Hexagons/hexagons_2018/dnhex_antisiderea_288.dat" u ($0*360/288):1 w lp lc rgb "blue" tit "Anti"
# replot "../../Hexagons/hexagons_2018/dnhex_solar_288.dat"  		u ($0*360/288):1 w lp lc rgb "black" tit "Solar"


# pesos_sid = np.loadtxt("../Cpp/Exposure/sidereal_2004-2017_sol.txt" , unpack=True, usecols=(0))	#	u ($0*360/288):1 w lp lc rgb "red" tit "Sid"
# pesos_ant = np.loadtxt("../Cpp/Exposure/antisiderea_2004-2017_sol.txt", unpack=True, usecols=(0)) #u ($0*360/288):1 w lp lc rgb "blue" tit "Anti"
# pesos_sol = np.loadtxt("../Cpp/Exposure/solar_2004-2017_sol.txt" , unpack=True, usecols=(0)) #		u ($0*360/288):1 w lp lc rgb "black" tit "Solar"

pesos_sid = np.loadtxt("../Cpp/Exposure/sidereal_2013-2020_sol.txt" , unpack=True, usecols=(0))	#	u ($0*360/288):1 w lp lc rgb "red" tit "Sid"
pesos_ant = np.loadtxt("../Cpp/Exposure/antisiderea_2013-2020_sol.txt", unpack=True, usecols=(0)) #u ($0*360/288):1 w lp lc rgb "blue" tit "Anti"
pesos_sol = np.loadtxt("../Cpp/Exposure/solar_2013-2020_sol.txt" , unpack=True, usecols=(0)) #		u ($0*360/288):1 w lp lc rgb "black" tit "Solar"

angle = 360*np.arange(len(pesos_sol))/288 
plt.xticks(np.arange(0, 361, 30))
plt.plot(angle, pesos_ant, marker='s' , color="blue", label=u"Anti-sidérea")
plt.plot(angle, pesos_sol, marker='o' , color="red", label="Solar")
plt.plot(angle, pesos_sid, marker='*' , color="black", label=u"Sidérea")


plt.legend(loc=0)

# sns.set_style("ticks",{'font.size': 24,  'font.family': 'sans-serif'})
#sns.set_style("whitegrid")



#plt.savefig("../Update/6_Dipole_1-2_EeV/weights_2013_2020.png")
plt.show()

