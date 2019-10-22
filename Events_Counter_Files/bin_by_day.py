import numpy as np
import sys

"""def arho(sin):
	return

def aP(sin):
	return

def brho

def fit_weather(the):
	sin_2= np.sin(the)*np.sin(the)
"""


def bin_archive_data(file_auger, file_events, binWidth):
	utc = np.loadtxt(file_auger, dtype= int , usecols=0)
	
	Width = len(utc)
	linfUTC=int(utc[0])
	
	nbin=((int(utc[-1]) -linfUTC)/binWidth) + 2
	
	binlist=np.zeros(nbin)
	for flag in xrange(0,Width):
		interval = (utc[flag]-linfUTC)/binWidth
		i = int(interval) + 1 
		binlist[i] = binlist[i] + 1
		pass
	
	output_file=open(file_events, "w+")
	
	for j in range(0,nbin):
		output_file.write("%i \t %i \t %f  \n" %(linfUTC + binWidth*j-binWidth/2, binlist[j], np.sqrt(float(binlist[j]))) )
	
	output_file.close()


from utctprh_bins import bin_weather


def main():
 
	file_auger	= sys.argv[1]
	file_utc	= sys.argv[2]
	file_events	= sys.argv[3]
	file_bins	= sys.argv[4]

	bin_weather(file_utc, file_bins, 3600*24)
	bin_archive_data(file_auger, file_events, 3600*24)


if __name__== "__main__":
	main()