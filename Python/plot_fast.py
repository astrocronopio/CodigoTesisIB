#!/usr/bin/env python
# -*- coding: utf-8 -*-

import matplotlib.pyplot as plt
import numpy as np

import matplotlib as mpl
mpl.rcParams.update({'font.size': 18,  'figure.figsize': [8, 6],  'figure.autolayout': True})


freq, modulo, por99 = np.loadtxt("Cpp/AllTriggers_Oscar_data_file_Eraw_8EeV_hex_short_range.txt", unpack=True, usecols=(0,4,8))

plt.title(u"All Triggers Oscar 8 EeV")
plt.ylabel(u"Amplitud del $1^{er}$ armónico")
plt.xlabel(u"Período [días]")

plt.plot(freq, modulo, color="black")
plt.plot(freq, por99, label="P99", color="red", ls='--')

plt.legend(loc=3)
plt.xlim(364.0,366.5)
plt.axvline(x=366.25, color='lightblue', linestyle='--')
plt.axvline(x=365.25, color='blue', linestyle=':')
plt.axvline(x=364.25, color='lightblue', linestyle='--')

plt.show()