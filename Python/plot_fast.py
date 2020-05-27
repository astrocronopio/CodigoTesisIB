#!/usr/bin/env python
# -*- coding: utf-8 -*-

import matplotlib.pyplot as plt
import numpy as np

import matplotlib as mpl
mpl.rcParams.update({'font.size': 19,  'figure.figsize': [8, 8],  'figure.autolayout': True, 'font.family': 'serif', 'font.sans-serif': ['Helvetica']})

def plot_anisotropy_given_name(filename, title_name, png_name, number):
	plt.figure(number)
	freq, modulo, por99 = np.loadtxt(filename, unpack=True, usecols=(0,4,8))
	
	#plt.title(title_name)
	plt.ylabel(u"Amplitud del $1^{er}$ armónico")
	plt.xlabel(u"Período [días]")
	
	plt.plot(freq, modulo, color="black")
	plt.plot(freq, por99, label="P99", color="red", ls='--')
	
	plt.legend(loc=0, fontsize='small', markerscale=0.8)
	plt.xlim(363.25, 367.25)
	plt.axvline(x=366.25, color='lightblue', linestyle='--')
	plt.axvline(x=365.25, color='blue', linestyle=':')
	plt.axvline(x=364.25, color='lightblue', linestyle='--')
	plt.savefig(png_name)
	pass



def plot_anisotropy_con_vs_sin(filename_con, filename_sin, title_name, png_name, number):
	plt.figure(number)
	freq, modulo, por99 	= np.loadtxt(filename_con, unpack=True, usecols=(0,4,8))
	freq1, modulo1, por991 	= np.loadtxt(filename_sin, unpack=True, usecols=(0,4,8))
	
	#plt.title(title_name)
	plt.ylabel(u"Amplitud del $1^{er}$ armónico")
	plt.xlabel(u"Período [días]")
	
	plt.plot(freq, modulo, color="black", label="Con peso")
	plt.plot(freq, por99, label="P99", color="red", ls='--')
	
	plt.plot(freq1, modulo1, color="brown", label="Sin peso", alpha=0.5, ls=":")
	#plt.plot(freq1, por991, label="P99", color="pink", ls=':')
	


	plt.xlim(366.11, 366.61)
	plt.ylim(0.000,0.006)
	plt.axvline(x=366.25, color='lightblue', linestyle='--')
	plt.axvline(x=365.25, color='blue', linestyle=':')
	plt.axvline(x=364.25, color='lightblue', linestyle='--')
	
	plt.axvline(x=366.21, color='green', linestyle='-.')#, label="366.21")
	plt.axvline(x=366.506, color='green', linestyle='-.')#, label="366.506")
	
	plt.legend(loc=3, ncol=1, columnspacing=0.6, fontsize='small', markerscale=0.8)
	
	plt.savefig(png_name)
	#plt.show()
	pass



def plot_only_a_graph():
	
	plot_anisotropy_given_name(	"../Cpp/Anisotropy/x2019_Main_Array_8_EeV_peso.dat",
								u"(2019) Disparo estándar: sobre 8 EeV", 
								"../Cpp/Anisotropy/Report/2019_Main_Array_8_EeV_peso.png", 4)
	
	
	plot_anisotropy_given_name(	"../Cpp/Anisotropy/x2019_AllTriggers_1_2_EeV.dat",
								"(2019) Todos los disparos: entre 1 EeV y 2 EeV", 
								"../Cpp/Anisotropy/Report/x2019_AllTriggers_1_2_EeV.png", 1)
	
	plot_anisotropy_given_name(	"../Cpp/Anisotropy/x2019_AllTriggers_2_4_EeV_peso.dat",
								"(2019) Todos los disparos: entre 2 EeV y 4 EeV", 
								"../Cpp/Anisotropy/Report/2019_AllTriggers_2_4_EeV_peso.png", 2)
	plot_anisotropy_given_name(	"../Cpp/Anisotropy/x2019_Main_Array_4_8_EeV_peso.dat",
								u"(2019) Disparo estándar: entre 4 EeV y 8 EeV", 
								"../Cpp/Anisotropy/Report/2019_Main_Array_4_8_EeV_peso.png", 3)
	
	pass
	
def plot_con_vs_sin_pesos():

	
	plot_anisotropy_con_vs_sin(	"../Cpp/Anisotropy/x2019_AllTriggers_1_2_EeV_peso.dat",
								"../Cpp/Anisotropy/x2019_AllTriggers_1_2_EeV.dat",
								"(2019) Todos los disparos: entre 1 EeV y 2 EeV", 
								"../Cpp/Anisotropy/Report/2019_AllTriggers_1_2_EeV_con_vs_sin_peso.png", 11)
	
	plot_anisotropy_con_vs_sin(	"../Cpp/Anisotropy/x2019_AllTriggers_2_4_EeV_peso.dat",
								"../Cpp/Anisotropy/x2019_AllTriggers_2_4_EeV.dat",
								"(2019) Todos los disparos: entre 2 EeV y 4 EeV", 
								"../Cpp/Anisotropy/Report/2019_AllTriggers_2_4_EeV_con_vs_sin_peso.png", 12)
	
	plot_anisotropy_con_vs_sin(	"../Cpp/Anisotropy/x2019_Main_Array_4_8_EeV_peso.dat",
								"../Cpp/Anisotropy/x2019_Main_Array_4_8_EeV.dat",
								u"(2019) Disparo estándar: entre 4 EeV y 8 EeV", 
								"../Cpp/Anisotropy/Report/2019_Main_Array_4_8_EeV_con_vs_sin_peso.png", 13)
		
	plot_anisotropy_con_vs_sin(	"../Cpp/Anisotropy/x2019_Main_Array_8_EeV_peso.dat",
								"../Cpp/Anisotropy/x2019_Main_Array_8_EeV.dat",
								u"(2019) Disparo estándar: sobre 8 EeV", 
								"../Cpp/Anisotropy/Report/2019_Main_Array_8_EeV_con_vs_sin_peso.png", 14)

	##################################################################################################333


	plot_anisotropy_con_vs_sin(	"../Cpp/Anisotropy/x2019_Main_Array_4_8_EeV_peso_extended.dat",
								"../Cpp/Anisotropy/x2019_Main_Array_4_8_EeV_extended.dat",
								u"(2019) Disparo estándar: entre 4 EeV y 8 EeV", 
								"../Cpp/Anisotropy/Report/2019_Main_Array_4_8_EeV_con_vs_sin_peso_extended.png", 23)
	
	plot_anisotropy_con_vs_sin(	"../Cpp/Anisotropy/x2019_Main_Array_8_EeV_peso_extended.dat",
								"../Cpp/Anisotropy/x2019_Main_Array_8_EeV_extended.dat",
								u"(2019) Disparo estándar: sobre 8 EeV", 
								"../Cpp/Anisotropy/Report/2019_Main_Array_8_EeV_con_vs_sin_peso_extended.png", 24)
	


def main():
	#plot_con_vs_sin_pesos()
	#plot_only_a_graph()

	plot_anisotropy_con_vs_sin(	"../Cpp/Anisotropy/x2019_AllTriggers_1_2_EeV_peso.dat",
								"../Cpp/Anisotropy/x2019_AllTriggers_1_2_EeV.dat",
								"(2019) Todos los disparos: entre 1 EeV y 2 EeV", 
								"../Update/report_5_22_05_2020/zoom_anis.png", 11)
	plt.show()


if __name__== "__main__":
	main()
