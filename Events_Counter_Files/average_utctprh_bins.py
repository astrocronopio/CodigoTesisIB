##This script creates a file with bins of a given width of the average of the
##weather parameters

import numpy as np
import sys

file_utctpth 			=sys.argv[1]
file_utctpth_bins 		=sys.argv[2]
file_utctpth_avg_bins	=sys.argv[3]

output_bins 		 	= open(file_utctpth_bins, "w+")

binWidth 	= 3600*12	
n 			= 12*12

counter = 0
avgtemp = 0.0
avgpres = 0.0
avgrho 	= 0.0
avgrhod = 0.0
shex6T5 = 0.0  

with open(file_utctpth) as f:
	for line in f:
		utc,temp,pres,rho,rhod,hex6T5,d5T5,iw,bp,hum,rho_hum,rho_av_hum= line.split()
	
		avgtemp = avgtemp 	+ float(temp)
		avgpres = avgpres 	+ float(pres)
		avgrho 	= avgrho 	+ float(rho)
		avgrhod = avgrhod 	+ float(rhod)
	
		if(int(bp)==1 and int(iw)!= 4):
			shex6T5 = shex6T5 + float(hex6T5)
		counter +=1

		if counter==n:
			avgtemp = avgtemp/counter
			avgpres = avgpres/counter
			avgrho 	= avgrho/counter
			avgrhod = avgrhod/counter
			shex6T5 = shex6T5/counter
				  #utc 	temp  pres rho,rhod,hex6T5,5T5,iw,bp,hum,rho_hum,rho_av_hum
			output_bins.write("%i \t %.7f \t %.7f \t %.7f \t %f \t %.7f \n"%(int(utc)-binWidth//2, avgtemp, avgpres, avgrho, avgrhod, shex6T5))
			output_bins.flush()

			counter = 0
			avgtemp = 0.0
			avgpres = 0.0
			avgrho 	= 0.0
			avgrhod = 0.0
			shex6T5 = 0.0  
output_bins.close()
