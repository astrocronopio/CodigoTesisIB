import numpy as np
import sys


file_utctpth 			="utctprh.dat"
file_utctpth_bins 		="utctprh-bins-python.dat"
file_utctpth_avg_bins	="utctprhcavg-binsh.dat"

nbin		= 96469
binWidth 	= 3600	
n 			= 12

output_bins 		 = open(file_utctpth_bins, "w+")
output_bins_avg_bins = open(file_utctpth_avg_bins, "w+")

utc,temp,pres,rho,rhod,hex6T5,d5T5,iw,bp,hum,rho_hum,rho_av_hum=np.loadtxt(file_utctpth, unpack=True, dtype= float)


for j in range(0,len(utc)):
	counter = 0
	avgtemp = 0.0
	avgpres = 0.0
	avgrho 	= 0.0
	avgrhod = 0.0
	shex6T5 = 0.0
		
	while counter<n:
		avgtemp = avgtemp 	+ temp[j+counter]
		avgpres = avgpres 	+ pres[j+counter]
		avgrho 	= avgrho 	+ rho[j+counter]
		avgrhod = avgrhod 	+ rhod[j+counter]

		if(bp[j+counter]==1 and iw[j+counter]< 4):
			shex6T5 = shex6T5 + hex6T5[j+counter]
		counter +=1
		
	avgtemp = avgtemp/counter
	avgpres = avgpres/counter
	avgrho 	= avgrho/counter
	avgrhod = avgrhod/counter
	shex6T5 = shex6T5/counter
					  #utc 	temp  pres rho,rhod,hex6T5,5T5,iw,bp,hum,rho_hum,rho_av_hum
	output_bins.write("%i \t %.7f \t %.7f \t %.7f \t %f \t %.7f \n"%(utc[j]-binWidth//2, avgtemp, avgpres, avgrho, avgrhod, shex6T5))
	output_bins.flush()

output_bins.close()