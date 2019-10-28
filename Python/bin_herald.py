##Con este script contamos la cantidad de eventos en un ancho de tiempo definido
import numpy as np
import sys

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

#_________________________________________

def main():
	file_auger 	= sys.argv[1]
	file_events	= sys.argv[2]
	binWidth 	= int(sys.argv[3])

	bin_archive_data(file_auger,file_events, binWidth)
	print("Done with {}!\n".format(file_events))
  
if __name__== "__main__":
	main()