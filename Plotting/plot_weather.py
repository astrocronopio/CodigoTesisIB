import matplotlib.pyplot as plt
# import  seaborn as sns
import matplotlib as mpl
mpl.rcParams.update({
	'font.size': 18,
	'figure.figsize': [12, 6],
	'figure.autolayout': True,
	'font.family': 'serif',
	'font.sans-serif': ['Palatino']})

import numpy as np
from matplotlib.dates import epoch2num,MonthLocator, MONDAY, WeekdayLocator, DateFormatter, num2date

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@222
file_utcprh="../../Weather/utctprh_bins.dat" 
file_24="../../Weather/utctprh_24_total.dat"
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@222

factor = 1.949 # Area/5
utc, avgtemp, avgpres, avgrho, avgrho24, hex6T5= np.loadtxt(file_utcprh, unpack=True)

months = MonthLocator(range(1, 13), bymonthday=1, interval=30)
monthsFmt = DateFormatter("%b '%y")

def zero_to_nan(values):
    """Replace every 0 with 'nan' and return a copy."""
    return [float('nan') if x==0 else x for x in values]


def plot_data(data,label, media, label_media="Media"):
    fig, ax = plt.subplots()
    ax.set_ylabel(label)
    ax.set_xlabel("Fecha")
    # ax.set_ylim(ymin=0.2, ymax=0.4)
    # ax.plot(num2date(epoch2num(utc)), data , 
    #          color="blue", alpha=0.9, lw=0.2)
    
    ax.scatter(num2date(epoch2num(utc)), data , 
            marker="o", s=0.5, color="blue", alpha=0.4)
    
    ax.axhline(y=media, color='black', label=label_media, ls=":", lw=3)
    ax.xaxis.set_major_locator(months)
    ax.autoscale_view()
    ax.grid(alpha=0.05)
    ax.legend(fontsize=14)
    

def plot_24_density(media):
    plt.figure(42)
    plt.ylabel("Densidad [kgm$^{-3}$]")
    plt.xlabel("Hora local de Malargüe (GMT-3) [hr]")
    plt.xticks(np.arange(0,27,2))
    # plt.xlim(0, 23)
    hour, density, n = np.loadtxt(file_24, usecols=(0,3,6), unpack=True)
    
    offset= np.arange(+3,len(hour)+3,1)%24
    # plt.plot(hour, density[-3:1],  marker="o", color="blue", alpha=0.6)
    plt.plot(hour, density[offset],  marker="o", color="blue", alpha=0.6)
    # plt.plot(hour, density,  marker="o", color="red", alpha=0.6)
    # plt.errorbar(hour, density[offset],np.sqrt(density[offset]/n), fmt='none',  color='blue')
    plt.axhline(y=media, color='black', label="Media", ls=":", lw=3)
   
    plt.legend(fontsize=14)
    
###@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
plot_data(avgpres, "Presión [hPa]", 861.777)
plot_data(avgrho, "Densidad [kgm$^{-3}$]", 1.05547)
plot_data(avgrho24, "Densidad [kgm$^{-3}$]", 1.05547)
plot_data(zero_to_nan(5*hex6T5/2.566), "Área [km$^2$]", 690/2.566 ,"Mínima área considerada")
plot_24_density(1.05547)
###@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


plt.show()