##Con este script contamos la cantidad de eventos en un ancho de tiempo definido
import numpy as np
import sys

file_auger = sys.argv[1]
file_events= sys.argv[2]
#file_auger="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Herald_simple_modified.dat"
#file_events="Herald_simple_modified_bins.dat"

binWidth =3600 # In seconds

def bin_archive_data(file_auger, file_events):
	utc = np.loadtxt(file_auger, dtype= int ,usecols=0)
	
	Width = len(utc)
	linfUTC=utc[0]
	
	nbin=((utc[-1] -linfUTC)/binWidth) + 2
	
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

#_________________________________________
bin_archive_data(file_auger,file_events)
print("Done!\n")