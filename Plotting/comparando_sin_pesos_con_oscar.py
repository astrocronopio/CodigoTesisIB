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



plt.figure(2)

#plt.title(u"AllTriggers: 1 EeV - 2 EeV")
plt.ylabel(u"Amplitud del $1^{er}$ armónico")
plt.xlabel(u"Frecuencia [ciclos]")



freq, modulo, por99 	= np.loadtxt("../../../Taborda_Original/ray_taborda/ray_multfrq_a8_04-0816_Eraw-noW.dat", unpack=True, usecols=(0,4,8))
plt.plot(freq, modulo, color="black" , alpha=0.7)
plt.scatter(freq, modulo, color="black",alpha=0.7, marker='o', s=25, label=u"Taborda (2018)")

plt.plot(freq, por99, label="$r_{99}$", color="red", ls='--')


freq1, modulo1, por991 	= np.loadtxt("../Cpp/Anisotropy/xx2019_Main_Array_8_EeV_04_17.dat", unpack=True, usecols=(0,4,8))
plt.plot(freq1, modulo1, color="blue" , alpha=0.7)
plt.scatter(freq1, modulo1, color="blue", alpha=0.7, marker='*', s=35,  label=u"Este Trabajo")

#plt.plot(freq1, por991, label="P99-con", color="green", ls=':')


plt.legend(loc=2, ncol=1)
plt.xlim(363.25,367.25)
plt.axvline(x=366.2559, color='green', linestyle='--') 	#	Año sidereo
plt.axvline(x=365.242190, color='green', linestyle=':')		#	Año normal común y silvestre


#plt.axvline(x=364.25, color='lightblue', linestyle='--')
plt.axvline(x=364.25, color='lightblue', linestyle='--') #Frecuencia antisiderea
#plt.axvline(x=365.2559, color='pink', linestyle=':')

sns.set_style("ticks",{'font.size': 24,  'font.family': 'sans-serif'})
#sns.despine()

plt.savefig("../../CodigoTesisIB/Update/report_0_Introduccion/sin_pesos_referencia_8_EeV.png")
plt.show()