#!/usr/bin/env python
# -*- coding: utf-8 -*-

import matplotlib.pyplot as plt
import numpy as np
import matplotlib.dates as mdates
import datetime as dt
import matplotlib as mpl
mpl.rcParams.update({'font.size': 18,  'figure.figsize': [8, 6],  'figure.autolayout': True})

from datetime import datetime


title_plot=u"Energía encima de 1 EeV. Herald"
utc,  medido, expected, area = np.loadtxt("../../weather_code/AllTriggers/AllTriggers_1EeV_herald_weather_nobp_rate_day.dat", unpack=True)

dateconv = np.vectorize(dt.datetime.fromtimestamp)
date = dateconv(utc)


rate_med  = [[],[]]
rate_exp  = []

for x in range(len(utc)):
	rate_med[0].append( medido[x]/area[x] if area[x]>0 else 0)
	rate_med[1].append( np.sqrt(medido[x])/area[x] if area[x]>0 else 0)
	rate_exp.append( expected[x]/area[x] if area[x]>0 else 0)
	pass

plt.ylim(0.10,0.30)
plt.ylabel("Tasa de eventos")
plt.errorbar(date, rate_med[0], yerr= rate_med[1] , fmt='o', ms=2, capsize=3, color='green', label="Datos")
plt.errorbar(date, rate_exp, yerr= 0, fmt='s', ms=2.5, color='black')
plt.legend(loc=2)
plt.title(title_plot)

ax=plt.gca()
xfmt = mdates.DateFormatter('%Y')
ax.xaxis.set_major_locator(mdates.YearLocator())
ax.xaxis.set_minor_locator(mdates.MonthLocator())
ax.xaxis.set_major_formatter(xfmt)


plt.show()