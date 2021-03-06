import matplotlib.pyplot as plt
# import  seaborn as sns
import matplotlib as mpl
mpl.rcParams.update({
	'font.size': 26,
	'figure.figsize': [12, 6],
	'figure.autolayout': True,
	'font.family': 'serif',
	'font.sans-serif': ['Palatino']})

import numpy as np

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@@@@@@@@@@@@@@@ REF WEATHER 2017 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
ap_ref      = np.array([0.00025,-0.0026,-0.0042,-0.0046,-0.0041])
ap_ref_err  = 0.0007*np.ones_like(ap_ref)

arho_ref    = np.array([-2.57,-2.25 ,-1.85 ,-1.35 ,-0.75 ])
arho_ref_err= 0.1*np.ones_like(arho_ref)

brho_ref    = np.array([-0.875, -0.725, -0.575, -0.30 , -0.2  ])
brho_ref_err= 0.075*np.ones_like(brho_ref)

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

sin_theta   = 0.15*np.arange(0,5,1) + 0.075

def plot_fit(x,y,y_err,
             y_, err_, c_, 
             label_y):
    params= np.polyfit(x,y,2)
    X = np.linspace(0, 0.75, 100)
    Y = params[2] + params[1]*X +params[0]*X*X
    
    
    params_2= np.polyfit(x,y_,2)
    Y_ = params_2[2] + params_2[1]*X +params_2[0]*X*X
    
    plt.ylabel(label_y)
    plt.xlabel("$\sin^2 \\theta$")    
    print(params, params_2)
    
    plt.xticks(np.arange(0,1,0.1))
    plt.xlim(0.00, 0.75)
    
    color_2='red'
    plt.scatter(x,y, marker='x', s=120,color='blue', alpha=0.8, label="Aab A. et al (2017)")
    
    plt.errorbar(x,y, yerr=y_err, fmt='none', color='blue',     
                 capsize=5, elinewidth=2,  markeredgewidth=2, alpha=0.7)
    
    plt.scatter(x,y_, marker='s', s=120,color=color_2, alpha=0.8, label="Este trabajo")
    
    plt.errorbar(x,y_, yerr=err_, fmt='none', color=color_2,     
                 capsize=5, elinewidth=2,  markeredgewidth=2, alpha=0.7)
    
    plt.axhline(c_, color=color_2, alpha=0.6, ls='--',label="Todos los eventos con $\\theta<60^o$")
    
    plt.plot(X,Y, color='blue', alpha=0.6)
    plt.plot(X,Y_, color=color_2, alpha=0.6)
    plt.legend(fontsize=21,handlelength=1)


# file_params = "../WeatherCode/Main_Array/upto2015/Data/Herald_old/herald_old_above_1EeV_all_sin2.dat"
# ap_hline, arho_hline, brho_hline=-0.0032,-1.71,-0.51

file_params = "../WeatherCode/Main_Array/upto2019/Data/Herald_S38/S38_above_0EeV_all_sin2.dat"
ap_hline, arho_hline, brho_hline=-0.0033,-1.75,-0.51

# file_params="../WeatherCode/wCorrections/Files_AllTriggers_S38/0EeV_all_sin2.dat"
# ap_hline, arho_hline, brho_hline=-0.0048,-1.54,-0.55

r1,ap, ap_err, arho, arho_err, brho, brho_err,r = np.loadtxt(file_params,unpack=True)

plt.figure(1)
plot_fit(sin_theta, 1000*ap_ref  , 1000*ap_ref_err, 
                    1000*ap      , 1000*ap_err    , 1000*ap_hline, 
         " $a_P\,$ [$10^{-3}\,$hPa$^{-1}$]")

plt.figure(2)
plot_fit(sin_theta, arho_ref  , arho_ref_err, 
                    arho      , arho_err    , arho_hline, 
         " $a_\\rho\,$[kg$^{-1}$m$^{3}$]")

plt.figure(3)
plot_fit(sin_theta, brho_ref  , brho_ref_err, 
                    brho      , brho_err    , brho_hline, 
         " $b_\\rho\,$[kg$^{-1}$m$^{3}$]")


plt.show()    
    