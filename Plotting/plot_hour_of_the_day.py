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

# file_hod = "../WeatherCode/Main_Array/upto2015/Data/Herald_old/herald_old_above_2EeV_hour_of_the_day.dat"
# file_hod =  "../WeatherCode/AllTriggers/2019/weather_analysis/AllTriggers_1EeV_hour_of_the_day.dat"
# file_hod = "../WeatherCode/Main_Array/upto2019/Data/Herald_S38/S38_above_0EeV_hour_of_the_day.dat"
## This factor is for hexagons area, and the bins were made with
## 24 hours span 
file_hod = "../WeatherCode/wCorrections/Files_AllTriggers/1EeV_hour_of_the_day.dat"

# factor = 24*(2.566)

#Para como yo trabajé a all triggers
factor = 24*1.949# (Area/5) == 2.566

hours = np.arange(0,24,1)
offset= np.arange(+3,len(hours)+3,1)%24

def plot_two_graphs():
        
        ll,expected, measured,  hexagons, error_meas = np.loadtxt(file_hod, unpack=True)
        error_meas=np.sqrt(measured)
        ## Local hour GMT-3
        expected, measured, error_meas, hexagons =expected[offset], measured[offset], error_meas[offset], hexagons[offset]


        # fig, ax = plt.subplots(2, sharex=True)
        fig = plt.figure()
        ax1 = plt.subplot2grid((3,1), (0,0), rowspan=2)
        ax2 = plt.subplot2grid((3,1), (2,0))
        # plt.show()
        ax1.set_xticks([])
        ax1.set_xlim(-0.5,23.5)
        ax2.set_xticks(np.arange(0,27,2))
        # ax1.set_yticks(np.arange(0,1,0.002))
        ax2.set_yticks(np.arange(-4.8,5,0.6))
        ax2.set_xlim(-0.5,23.5)

        color="indianred"

        ax1.scatter(hours, factor*measured/(hexagons),label="Medición", 
                color=color, alpha=0.6)
        ax1.plot(hours, factor*expected/(hexagons), label="Predicción",
                color='black', alpha=0.6)


        ax1.errorbar(hours, factor*measured/(hexagons),
                yerr=factor*error_meas/hexagons, 
                fmt='none', color=color,     
                capsize=5, elinewidth=2,  
                markeredgewidth=2, alpha=0.4)

        ax2.scatter(hours, 1000*factor*(measured-expected)/(hexagons), 
                color=color, alpha=0.6)

        ax2.axhline(0, color='black', alpha=0.6, ls=':')



        ax1.set_ylabel("Tasa [km$^{-2}$día$^{-1}$]")
        ax2.set_ylabel("Residuo [10$^{-3}$]")
        ax2.set_xlabel("Hora local de Malargüe (GMT-3) [hr]")
        ax1.legend()

        plt.show()

# plot_two_graphs()
# exit()

# file_hod = "../WeatherCode/Main_Array/upto2015/Data/Herald_old/herald_old_above_1EeV_hour_of_the_day.dat"
# file_hod_ = "../WeatherCode/wCorrections/Files_AllTriggers/1EeV_hour_of_the_day.dat"


#
def plot_one_graph():
        cddc, expected, measured, hexagons, fff =  np.loadtxt(file_hod, unpack=True)
        # pepe, expected_, measured_,  hexagons_,peap = np.loadtxt(file_hod, unpack=True)
        error_meas = np.sqrt(measured)
        # ## Local hour GMT-3
        # expected, measured, error_meas, hexagons =expected[offset], measured[offset], error_meas[offset], hexagons[offset]
        # expected_,  hexagons_ = expected_[offset],  hexagons_[offset]

        # # fig, ax = plt.subplots(2, sharex=True)
        
        
        # expected, measured, error_meas, hexagons = np.loadtxt(file_hod, unpack=True)

        ## Local hour GMT-3
        expected, measured, error_meas, hexagons =expected[offset], measured[offset], error_meas[offset], hexagons[offset]


        color="green"
        
        plt.xticks(np.arange(0,27,2))
        plt.xlim(-0.5,23.5)
        
        plt.scatter(hours, factor*measured/(hexagons),label="Medición", 
                color=color, alpha=0.6)
        # mean_chi = np.sum((factor*measured/(hexagons)- np.mean(factor*measured/(hexagons)) )**2/ (factor*np.sqrt(measured)/(hexagons))**2 )/(24-3)
        chi_1=np.sum((factor*measured/(hexagons)- factor*expected/(hexagons) )**2/ (factor*np.sqrt(measured)/(hexagons))**2 )/(24-5)
        # chi_2=np.sum(((factor*measured/(hexagons)- (5.4*factor*expected_/(hexagons_) +0.037)) )**2/ (factor*np.sqrt(measured)/(hexagons))**2 )/(24-3)
        
        # chi_2=
        # print( chi_1, chi_2)
        
        # plt.plot(hours, factor*expected/(hexagons), label="Aab et al (2017), $\chi^2_\\nu={:2.2f}$".format(chi_1),
                # color='red', alpha=0.6, ls="--")
        # plt.plot(hours, 24*2.566*expected_/(hexagons_) , label="Predicción, $\chi^2_\\nu={:2.2f}$".format(chi_2),
        #         color='black', alpha=0.6)


        plt.errorbar(hours, factor*measured/(hexagons),
                yerr=factor*error_meas/hexagons, 
                fmt='none', color=color,     
                capsize=5, elinewidth=2,  
                markeredgewidth=2, alpha=0.4)

        # plt.axhline(y=np.mean(factor*measured/(hexagons)),color='black', alpha=0.6,ls=":",label="Media")
        plt.ylabel("Tasa [km$^{-2}$día$^{-1}$]")
        plt.xlabel("Hora local de Malargüe (GMT-3) [hr]")
        plt.legend()

        plt.show()
        
plot_one_graph()
exit()      

# file_hod_1="../WeatherCode/Main_Array/upto2019/Data/Herald/herald_above_2EeV_hour_of_the_day.dat"
# file_hod_2="../WeatherCode/Main_Array/upto2019/Data/Herald_S38_S1000_expected/expected_above_2EeV_hour_of_the_day.dat"
file_hod_1="../WeatherCode/Main_Array/upto2019/Data/Herald/herald_above_1EeV_hour_of_the_day.dat"
file_hod_2="../WeatherCode/Main_Array/upto2019/Data/Herald/herald_above_2EeV_hour_of_the_day.dat"
def plot_two_graphs_hod():
        factor=1
        expected, measured, error_meas, hexagons = np.loadtxt(file_hod_1, unpack=True)

        ## Local hour GMT-3
        expected, measured, error_meas, hexagons =expected[offset], measured[offset], error_meas[offset], hexagons[offset]

        expected1, measured1, error_meas1, hexagons1 = np.loadtxt(file_hod_2, unpack=True)

        ## Local hour GMT-3
        expected1, measured1, error_meas1, hexagons1 =expected1[offset], measured1[offset], error_meas1[offset], hexagons1[offset]


        # fig, ax = plt.subplots(2, sharex=True)
        fig = plt.figure()
        ax1 = plt.subplot2grid((2,1), (0,0))
        ax2 = plt.subplot2grid((2,1), (1,0))
        # plt.show()
        ax1.set_xticks([])
        ax1.set_xlim(-0.5,23.5)
        ax2.set_xticks(np.arange(0,27,2))
        ax1.set_yticks(np.arange(0,1,0.0008))
        ax2.set_yticks(np.arange(0,1,0.0005))
        ax2.set_xlim(-0.5,23.5)

        color="indianred"

        ax1.scatter(hours, factor*measured/(hexagons),label="Energía > 1 EeV", 
                color=color, alpha=0.6)

        ax1.axhline(np.mean(factor*measured/(hexagons)), color='black', alpha=0.6, ls=':', label="Media")

        ax1.errorbar(hours, factor*measured/(hexagons),
                yerr=factor*error_meas/hexagons, 
                fmt='none', color=color,     
                capsize=5, elinewidth=2,  
                markeredgewidth=2, alpha=0.4)

        color1="darkolivegreen"
        ax2.scatter(hours, factor*measured1/(hexagons1),label="Energía > 2 EeV", 
                color=color1, alpha=0.6, marker="s")

        ax2.axhline(np.mean(factor*measured1/(hexagons1)), color='black', alpha=0.6, ls=':')

        ax2.errorbar(hours, factor*measured1/(hexagons1),
                yerr=factor*error_meas1/hexagons1, 
                fmt='none', color=color1,     
                capsize=5, elinewidth=2,  
                markeredgewidth=2, alpha=0.4)

        ax1.set_ylabel("Tasa [km$^{-2}$día$^{-1}$]")
        ax2.set_ylabel("Tasa [km$^{-2}$día$^{-1}$]")
        ax2.set_xlabel("Hora local de Malargüe (GMT-3) [hr]")
        ax1.legend(fontsize=18)
        ax2.legend(fontsize=18)
        
        plt.show()

plot_two_graphs_hod()