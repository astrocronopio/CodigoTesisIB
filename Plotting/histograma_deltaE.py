import matplotlib.pyplot as plt
import numpy as np

import matplotlib as mpl
mpl.rcParams.update({'font.size': 18,  'figure.figsize': [8, 6],  'figure.autolayout': True})


e1, e2 = np.loadtxt("../../AllTriggers/AllTriggers_compare_energy_s38.dat", unpack=True, usecols=(1,2))

plt.hist(e1-e2, 100000)
plt.show()