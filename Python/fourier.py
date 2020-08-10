import numpy as np
import matplotlib.pyplot as plt
from scipy import pi
from scipy.fftpack import fft

filename=""

def ncell_t(utc, ncell_list, t):
	Ncell_t= 0
	initial_time= utc[0]

	counter=0

	for ncell in ncell_list:
			Ncell_t+=ncell
			if counter<t:
				counter++
			else counter==t:
				break;


utc, the, energy, ra, dec = np.loadtxt(filename, unpack=True)