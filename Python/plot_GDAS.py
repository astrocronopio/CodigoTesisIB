import matplotlib.pyplot as plt
# import  seaborn as sns
import matplotlib as mpl
from scipy.optimize import curve_fit 
mpl.rcParams.update({
	'font.size': 20,
	'figure.figsize': [12, 6],
	'figure.autolayout': True,
	'font.family': 'serif',
	'font.sans-serif': ['Palatino']})

import numpy as np
cmap = plt.get_cmap('viridis_r',5)

def fit_sin(tt, yy):
    '''Fit sin to the input time sequence, and return fitting parameters "amp", "omega", "phase", "offset", "freq", "period" and "fitfunc"'''
    tt = np.array(tt)
    yy = np.array(yy)
    ff = np.fft.fftfreq(len(tt), (tt[1]-tt[0]))   # assume uniform spacing
    Fyy = abs(np.fft.fft(yy))
    guess_freq = abs(ff[np.argmax(Fyy[1:])+1])   # excluding the zero frequency "peak", which is related to offset
    guess_amp = np.std(yy) * 2.**0.5
    guess_offset = np.mean(yy)
    guess = np.array([guess_amp, 2.*np.pi*guess_freq, 0., guess_offset])

    def sinfunc(t, A, w, p, c):  return A * np.sin(w*t + p) + c
    popt, pcov = curve_fit(sinfunc, tt, yy, p0=guess)
    A, w, p, c = popt
    f = w/(2.*np.pi)
    fitfunc = lambda t: A * np.sin(w*t + p) + c
    return {"amp": A, "omega": w, "phase": p, "offset": c, "freq": f, "period": 1./f, "fitfunc": fitfunc, "maxcov": np.max(pcov), "rawres": (guess,popt,pcov)}

def fit_sin_plot(hr,d):
    lista1 = fit_sin(hr,d)
    x = np.linspace(1,24,500)
    y = lista1["amp"]*np.sin(lista1["omega"]*x + lista1["phase"]) + lista1["offset"]
    
    return x,y

filepath="../../Weather/GDAS.txt"

plt.ylabel("Temperatura [$^o$C]")
plt.xlabel("Hora local de Malargüe [hr]")

plt.xticks(np.arange(0,25,2))
plt.xlim(xmin=1, xmax=24)

hr, d1400, e1400, d2000, e2000, d2400, e2400, d2950,  e2950 = np.loadtxt(filepath, unpack=True)

plt.scatter(hr,d1400, label="1400 m", marker="s", color=cmap(1), s=50)
plt.errorbar(hr,d1400,e1400, fmt='none',  color=cmap(1))
x1,y1 = fit_sin_plot(hr,d1400)
plt.plot(x1,y1, color=cmap(1))

plt.scatter(hr,d2000, label="2000 m", marker="o",color=cmap(2), s=50)
plt.errorbar(hr,d2000,e2000, fmt='none',  color=cmap(2))
x2,y2 = fit_sin_plot(hr,d2000)
plt.plot(x2,y2, color=cmap(2))

plt.scatter(hr,d2400, label="2400 m", marker="^",color=cmap(3), s=50)
plt.errorbar(hr,d2400,e2400, fmt='none',  color=cmap(3))
x3,y3 = fit_sin_plot(hr,d2400)
plt.plot(x3,y3, color=cmap(3))

plt.scatter(hr,d2950, label="2950 m", marker="*",color=cmap(4), s=50)
plt.errorbar(hr,d2950,e2950, fmt='none',  color=cmap(4))
x4,y4 = fit_sin_plot(hr,d2950)
plt.plot(x4,y4, color=cmap(4))

plt.legend(title="Altura [msnm]", ncol=2)
plt.show()