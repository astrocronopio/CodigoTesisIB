import matplotlib.pyplot as plt
# import  seaborn as sns
import matplotlib as mpl
mpl.rcParams.update({
	'font.size': 20,
	'figure.figsize': [12, 8],
	'figure.autolayout': True,
	'font.family': 'serif',
	'font.serif': ['STIXGeneral']})

import numpy as np
##########################################################


output_file_1="./Files_AllTriggers_0-25_0-5_EeV/output_threshold_0EW_v3.dat"
output_file_2="./Files_AllTriggers_0-5_1_EeV/output_threshold_0EW_v3.dat"
output_file_3="./Files_AllTriggers_1_2_EeV/output_threshold_0EW_v3.dat"



file_plot =output_file_2


plt.figure(1)
plt.ylabel("Amplitud $r$")
plt.xlabel("Frecuencia [ciclos/año]")
plt.grid(alpha=0.1, ls=":")

f,r,r99,r_plus,r_minus= np.loadtxt(file_plot, usecols=(0,4,8,9,10), unpack=True)

y_ticks = np.arange(0.00, 2*np.max(r99), 0.001)
plt.yticks(y_ticks)
# plt.ylim(top=1.5*np.max(r99))

plt.plot(f,r, color='red', label="$r$")
#plt.fill_between(f, np.maximum(r-r_minus,0), r+r_plus, color="red", alpha=0.1)

plt.plot(f,r99, ls="--", color='black', label="$r_{99}$")
plt.axvline(x=364.25, ls=":", color="blue", alpha=0.5)
plt.axvline(x=365.25, ls=":", color="blue", alpha=0.5)
plt.axvline(x=366.25, ls=":", color="blue", alpha=0.5)
plt.legend(loc=0)

plt.show()
