##This a very neat python script  to bin by a given a bin width in seconds to generate
## a file of the average in that time :)

import numpy as np
import sys


def bin_weather(file_utctpth, file_utctpth_bins, binWidth):
	n=int(binWidth/300)
	counter = mean	= 0
	avgtemp = avgpres = avgrho  = avgrho24 = shex6T5 = 0.0 

	output_bins 		 	= open(file_utctpth_bins, "w+")

	with open(file_utctpth) as f:
		for line in f:
			utc,temp,pres,rho,rho24,hex6T5,d5T5,iw,bp= line.split()
		
			avgtemp = avgtemp 	+ float(temp)
			avgpres = avgpres 	+ float(pres)
			avgrho 	= avgrho 	+ float(rho)
			avgrho24= avgrho24 	+ float(rho24)
			
			if(int(bp)==1 and int(iw)< 4):
				shex6T5 = shex6T5 + float(hex6T5)
				mean+=1
			
			counter +=1
	
			if counter==n:
				avgtemp = avgtemp/counter
				avgpres = avgpres/counter
				avgrho 	= avgrho/counter
				avgrho24= avgrho24/counter
				shex6T5 = shex6T5/mean if mean!=0 else 0

				output_bins.write("%i \t %.7f \t %.7f \t %.7f \t %f \t %.7f \n"%(int(utc)-binWidth//2, avgtemp, avgpres, avgrho, avgrho24, shex6T5))
				output_bins.flush()
	
				counter = mean	= 0
				avgtemp = avgpres = avgrho  = avgrho24 = shex6T5 = 0.0   
	
	output_bins.close()

def main():

	file_utctpth 			= sys.argv[1]
	file_utctpth_bins 		= sys.argv[2]
	binWidth 				= int(sys.argv[3])
	bin_weather(file_utctpth, file_utctpth_bins, binWidth)
  
if __name__== "__main__":
	main()
