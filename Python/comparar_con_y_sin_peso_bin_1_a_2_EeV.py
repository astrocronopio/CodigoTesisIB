#!/usr/bin/env python
# -*- coding: utf-8 -*-

import matplotlib.pyplot as plt
import numpy as np

import matplotlib as mpl
mpl.rcParams.update({'font.size': 19,  'figure.figsize': [13, 8],  'figure.autolayout': True, 'font.family': 'serif', 'font.sans-serif': ['Helvetica']})



def plot_anisotropy_con_vs_sin(filename_con, filename_sin, title_name, png_name, number):
	plt.figure(number)
	freq, modulo, por99 	= np.loadtxt(filename_con, unpack=True, usecols=(0,4,8))
	freq1, modulo1, por991 	= np.loadtxt(filename_sin, unpack=True, usecols=(0,4,8))
	#freq2, modulo2, por992 	= np.loadtxt(filename_corr, unpack=True, usecols=(0,4,8))
	
	
	plt.title(title_name)
	plt.ylabel(u"Amplitud del $1^{er}$ armónico")
	plt.xlabel(u"Frecuencia [ciclos]")
	
	plt.plot(freq, modulo, color="black", label="Con peso")
	plt.plot(freq, por99, label="$r_{99}$-con", color="red")
	
	plt.plot(freq1, modulo1, color="brown", label="Sin peso", alpha=0.5, ls=":")
	#plt.plot(freq2, modulo2, color="blue", label="Corr.", alpha=0.5, ls=":")
	
	plt.plot(freq1, por991, label="$r_{99}$-sin", color="pink", ls="-.")
	

	plt.legend(loc=0, ncol=2, columnspacing=0.6, fontsize='small', markerscale=0.8)
	plt.xlim(363.25,367.25)
	plt.axvline(x=366.25, color='lightblue', linestyle='--')
	plt.axvline(x=365.25, color='blue', linestyle=':')
	plt.axvline(x=364.25, color='lightblue', linestyle='--')
	plt.savefig(png_name)
	#plt.show()
	pass

def main():
	plot_anisotropy_con_vs_sin(	"../Cpp/Anisotropy/xx2019_AllTriggers_1_2_EeV_peso.dat",
								"../Cpp/Anisotropy/xx2019_AllTriggers_1_2_EeV.dat",
								"(2019) Todos los disparos: entre 1 EeV y 2 EeV", 
								"../Update/6_Dipole_1-2_EeV/pesos_sin_con_1_2_EeV.png", 11)
	plt.show()


if __name__== "__main__":
	main()
