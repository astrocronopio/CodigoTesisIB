import matplotlib.pyplot as plt
import numpy as np

import matplotlib as mpl

mpl.rcParams.update({
	'font.size': 24,  
	'figure.figsize': [12, 8],  
	'figure.autolayout': True, 
	'font.family': 'serif', 
	'font.sans-serif': ['Times']}) 



e1, e2 = np.loadtxt("../../Trash/AllTriggers_compare_energy_s38.dat", unpack=True, usecols=(1,2))

plt.hist(e1-e2, 100000)
plt.show()