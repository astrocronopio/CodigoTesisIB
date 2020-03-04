#!/usr/bin/env python
# -*- coding: utf-8 -*-
 


import matplotlib.pyplot as plt
import numpy as np

import matplotlib as mpl
mpl.rcParams.update({'font.size': 18,  'figure.figsize': [12, 6],  'figure.autolayout': True})


freq, modulo, por99 	= np.loadtxt("Cpp/AllTriggers_Herald_data_file_Eraw_8_EeV_short_range.txt", unpack=True, usecols=(0,4,8))
freq1, modulo1, por991 	= np.loadtxt("Cpp/AllTriggers_Herald_data_file_Eraw_8_EeV_hex_short_range.txt", unpack=True, usecols=(0,4,8))
plt.title(u"AllTriggers Herald. Short range. Above 8 EeV")

plt.ylabel(u"Amplitud del $1^{er}$ armónico")
plt.xlabel(u"Período [días]")


plt.plot(freq, modulo, color="black", label=u"Sin peso", linestyle='--')
plt.plot(freq1, modulo1, color="blue", label=u"Con peso", linestyle=':')

plt.plot(freq, por99, label="P99", color="red", ls='--')

plt.legend(loc=4)
#plt.xlim(364.0,366.5)
plt.axvline(x=366.25, color='lightblue', linestyle='--')
plt.axvline(x=365.25, color='lightblue', linestyle=':')
plt.axvline(x=364.25, color='lightblue', linestyle='--')


plt.show()