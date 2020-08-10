#!/usr/bin/env python
# -*- coding: utf-8 -*-
 


import matplotlib.pyplot as plt
import numpy as np

import matplotlib as mpl
mpl.rcParams.update({'font.size': 18,  'figure.figsize': [12, 6],  'figure.autolayout': True})

plt.figure(2)

plt.title(u"AllTriggers: 1 EeV - 2 EeV")
plt.ylabel(u"Amplitud del $1^{er}$ armónico")
plt.xlabel(u"Período [días sidéreos]")


# freq, modulo, por99 	= np.loadtxt("../Cpp/Anisotropy/x2019_AllTriggers_1_2_EeV.dat", unpack=True, usecols=(0,4,8))
# plt.plot(freq, modulo, color="black", label=u"Sin peso", linestyle='--')
# plt.plot(freq, por99, label="P99-sin", color="red", ls='--')


freq1, modulo1, por991 	= np.loadtxt("../Cpp/Anisotropy/xx2019_Main_Array_8_EeV_04_17.dat", unpack=True, usecols=(0,4,8))
plt.plot(freq1, modulo1, color="blue", label=u"Con peso", linestyle=':')
plt.plot(freq1, por991, label="P99-con", color="green", ls=':')


freq, modulo, por99 	= np.loadtxt("../../../Taborda_Original/ray_taborda/ray_multfrq_a8_04-0816_Eraw-noW.dat", unpack=True, usecols=(0,4,8))
plt.plot(freq, modulo, color="black", label=u"Sin peso", linestyle='--')
plt.plot(freq, por99, label="P99-sin", color="red", ls='--')



plt.legend(loc=4)
#plt.xlim(364.0,366.5)
plt.axvline(x=366.2559, color='green', linestyle='--') 	#	Año sidereo
plt.axvline(x=365.242190, color='green', linestyle=':')		#	Año normal común y silvestre


#plt.axvline(x=364.25, color='lightblue', linestyle='--')
plt.axvline(x=364.25, color='lightblue', linestyle='--') #Frecuencia antisiderea
#plt.axvline(x=365.2559, color='pink', linestyle=':')

plt.show()