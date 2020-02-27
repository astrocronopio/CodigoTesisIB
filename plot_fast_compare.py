#!/usr/bin/env python
# -*- coding: utf-8 -*-
 


import matplotlib.pyplot as plt
import numpy as np

import matplotlib as mpl
mpl.rcParams.update({'font.size': 18,  'figure.figsize': [12, 6],  'figure.autolayout': True})


freq, modulo, por99 	= np.loadtxt("../Anisotropy/ICRC/2015/ICRC2015_data_file_Eraw_exp.txt", unpack=True, usecols=(0,4,8))
freq1, modulo1, por991 	= np.loadtxt("../Anisotropy/ICRC/2015/ICRC2015_data_file_Eraw_new_exp.txt", unpack=True, usecols=(0,4,8))


plt.ylabel(u"Amplitud del $1^{er}$ armónico")
plt.xlabel(u"Período [días]")

plt.title(u"All Triggers de Herald")
plt.plot(freq, modulo, color="black", label=u"Sin peso", linestyle='--')
plt.plot(freq1, modulo1, color="blue", label=u"Con peso", linestyle=':')

plt.plot(freq1, por991, label="P99", color="red", ls='--')

plt.legend(loc=1)
#plt.xlim(364.0,366.5)
plt.axvline(x=366.25, color='lightblue', linestyle='--')
plt.axvline(x=365.25, color='lightblue', linestyle=':')
plt.axvline(x=364.25, color='lightblue', linestyle='--')


plt.show()