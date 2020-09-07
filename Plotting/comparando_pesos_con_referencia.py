#!/usr/bin/env python
# -*- coding: utf-8 -*-

import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns

import matplotlib as mpl
mpl.rcParams.update({
	'font.size': 24,  
	'figure.figsize': [12, 8],  
	'figure.autolayout': True, 
	'font.family': 'serif', 
	'font.sans-serif': ['Times']}) 


title="paper 2018 N=288"
#plt.title("Enero 2004 - Enero 2017")

#plt.xlim(0,360)
plt.xlim(0,24)
#plt.ylabel("w" )
plt.xticks(np.arange(0, 25, 3))
plt.ylabel("$\\Delta N_{cell}$" )
plt.xlabel("Hora  GMT")
#plt.xlabel( u"Ascensión Recta [$^o$]")

# plot "../../Hexagons/hexagons_2018/dnhex_sidereal_288.dat" 		u ($0*360/288):1 w lp lc rgb "red" tit "Sid"
# replot "../../Hexagons/hexagons_2018/dnhex_antisiderea_288.dat" u ($0*360/288):1 w lp lc rgb "blue" tit "Anti"
# replot "../../Hexagons/hexagons_2018/dnhex_solar_288.dat"  		u ($0*360/288):1 w lp lc rgb "black" tit "Solar"


pesos_sid = np.loadtxt("../Cpp/Exposure/sidereal_2020_sol.txt" , unpack=True, usecols=(0))	#	u ($0*360/288):1 w lp lc rgb "red" tit "Sid"
pesos_ant = np.loadtxt("../Cpp/Exposure/antisiderea_2020_sol.txt", unpack=True, usecols=(0)) #u ($0*360/288):1 w lp lc rgb "blue" tit "Anti"
pesos_sol = np.loadtxt("../Cpp/Exposure/solar_2020_sol.txt" , unpack=True, usecols=(0)) #		u ($0*360/288):1 w lp lc rgb "black" tit "Solar"


angle = 24*np.arange(len(pesos_sol))/288 

#plt.plot(angle, pesos_ant, color="blue", label=u"Anti-sidérea")
plt.plot(angle, pesos_sol, color="red", label="Solar")
#plt.plot(angle, pesos_sid, color="black", label=u"Sidérea")


#plt.scatter(angle, pesos_ant, s=20, marker='s' , color="blue")
plt.scatter(angle, pesos_sol, s=20, marker='o' , color="red")
#plt.scatter(angle, pesos_sid, s=20, marker='*' , color="black")


plt.legend(loc=0)

sns.set_style("ticks",{'font.size': 24,  'font.family': 'sans-serif'})
#sns.set_style("whitegrid")



#plt.savefig("../Update/6_Dipole_1-2_EeV/weights_2013_2020.png")
plt.show()

