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
##########################################################


output_file_EW_1="./Files_AllTriggers_0-25_0-5_EeV/output_threshold_0EW_v3.dat"
output_file_EW_2="./Files_AllTriggers_0-5_1_EeV/output_threshold_0EW_v3.dat"
output_file_EW_3="./Files_AllTriggers_1_2_EeV/output_threshold_0EW_v3.dat"

output_file_Ray_1="../Anisotropy/Files_AllTriggers_0-25_0-5_EeV/output_threshold_0con_peso_v11.dat"
output_file_Ray_2="../Anisotropy/Files_AllTriggers_0-5_1_EeV/output_threshold_0con_peso_v11.dat"
output_file_Ray_3="../Anisotropy/Files_AllTriggers_1_2_EeV/output_threshold_0con_peso_v11.dat"



file_plot_EW =output_file_EW_3
file_plot_Ray=output_file_Ray_3


f_EW,r_EW,r99_EW= np.loadtxt(file_plot_EW, usecols=(0,4,8), unpack=True)
f_Ray,r_Ray,r99_Ray= np.loadtxt(file_plot_Ray, usecols=(0,4,8), unpack=True)

r_EW, r99_EW = 100*r_EW, 100*r99_EW
r_Ray, r99_Ray = 100*r_Ray, 100*r99_Ray

def  plot_same_fig():
	# plt.figure(1)
	# plt.ylabel("Amplitud $r$")
	# plt.xlabel("Frecuencia [ciclos/año]")
	# plt.grid(alpha=0.1, ls=":")
 
	fig,ax = plt.subplots()
	ax.set_ylabel("Amplitud r (EW)")
	ax.set_xlabel("Frecuencia [ciclos/año]")
	ax.plot(f_EW, r_EW,label="EW", color='red', alpha=1)
	ax.plot(f_EW, r99_EW, ls=":", label="$r_{99}$ - EW", color='red', alpha=1)
	ax.legend(loc=(0.08,0.759))

	ax2=ax.twinx()
	ax2.plot(f_Ray, r_Ray,  marker="*",label="Rayleigh",color='blue', alpha=0.5)
	ax2.plot(f_Ray, r99_Ray, ls='--', label="$r_{99}$ - Rayleigh",color='blue', alpha=0.9)
	ax2.set_ylabel("Amplitud r (Rayleigh)")
	ax2.legend(loc=(0.65,0.759))
		
	y_ticks = np.arange(0.00, 2.8*np.max(r99_EW), 0.001)
	ax.set_yticks(y_ticks)

	y_ticks_2 = np.arange(0.00, 5.8*np.max(r99_Ray), 0.001)
	ax2.set_yticks(y_ticks_2)
	# ax.set_ylim(top=1.5*np.max(r99_EW))
	# ax2.set_ylim(top=2.5*np.max(r99_Ray))


	# plt.legend()
	# plt.show()



	# plt.plot(f,r, color='red', label="$r$")


	# plt.plot(f,r99, ls="--", color='black', label="$r_{99}$")
	ax2.axvline(x=364.25, ls=":", color="blue", alpha=0.5)
	ax2.axvline(x=365.25, ls=":", color="blue", alpha=0.5)
	ax2.axvline(x=366.25, ls=":", color="blue", alpha=0.5)
	# plt.legend(loc=0)

	plt.show()


def plot_dif_figs():
	plt.figure(1)
	plt.ylabel("Amplitud r [%] (EW)")
	plt.xlabel("Frecuencia [ciclos/año]")
	plt.plot(f_EW, r_EW,label="EW", color='red', alpha=1)
	plt.plot(f_EW, r99_EW, ls=":", label="$r_{99}$ - EW", color='red', alpha=1)
	plt.legend(loc=(0.08,0.759))
	y_ticks = np.arange(0.00, 1.1*np.max(r99_EW), 0.0008*100)
	plt.yticks(y_ticks)
	plt.axvline(x=364.25, ls=":", color="blue", alpha=0.5)
	plt.axvline(x=365.25, ls=":", color="blue", alpha=0.5)
	plt.axvline(x=366.25, ls=":", color="blue", alpha=0.5)
 
	plt.figure(2)
	plt.ylabel("Amplitud r [%] (Rayleigh)")
	plt.xlabel("Frecuencia [ciclos/año]")
	plt.plot(f_Ray, r_Ray,label="Rayleigh", color='blue', alpha=1)
	plt.plot(f_Ray, r99_Ray, ls=":", label="$r_{99}$ - Rayleigh", color='blue', alpha=1)
	plt.legend(loc=(0.65,0.759))
	y_ticks = np.arange(0.00, 1.3*np.max(r_Ray), 0.0008*100)
	plt.yticks(y_ticks)
	plt.axvline(x=364.25, ls=":", color="blue", alpha=0.5)
	plt.axvline(x=365.25, ls=":", color="blue", alpha=0.5)
	plt.axvline(x=366.25, ls=":", color="blue", alpha=0.5)
 
	plt.show()
 
 
	
plot_dif_figs()