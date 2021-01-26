from datetime import datetime
import numpy as np
import sys

def bin_total_weather(file_utctpth, file_utctpth_bins, width):

	counter = mean	= 0
	avgtemp = np.zeros(width) 
	avgpres = np.zeros(width) 
	avgrho  = np.zeros(width) 
	avgrho24= np.zeros(width) 
	shex6T5 = np.zeros(width) 


	output_bins 		 	= open(file_utctpth_bins, "w+")

	with open(file_utctpth) as f:
		for line in f:
			utc,temp,pres,rho,rho24,hex6T5,d5T5,iw,bp, x1, x2, x3= line.split()

			bin= int(hour_utc(int(utc), width))
		
			avgtemp[bin] 	+= float(temp)
			avgpres[bin] 	+= float(pres)
			avgrho[bin] 	+= float(rho)
			avgrho24[bin] 	+= float(rho24)
			
			if(int(bp)==1 and int(iw)< 4):
				shex6T5[bin] = shex6T5[bin] + float(hex6T5)
				mean+=1
			
			counter +=1
	
	for x in range(0,width):
		avgtemp[x] = width*avgtemp[x]/counter
		avgpres[x] = width*avgpres[x]/counter
		avgrho[x] =  width*avgrho[x]/counter
		avgrho24[x]= width*avgrho24[x]/counter
		shex6T5[x] = width*shex6T5[x]/mean if mean!=0 else 0

		output_bins.write("%i \t %.7f \t %.7f \t %.7f \t %f \t %.7f \t %.7f \n"%(x, avgtemp[x], avgpres[x], avgrho[x], avgrho24[x], shex6T5[x], counter))
		output_bins.flush()


	output_bins.close()


def hour_utc(utc, width):
	dt_object = datetime.fromtimestamp(utc)
	if width==24:
		return dt_object.hour
	if width==12:
		return dt_object.month -1


def main():

	file_utctpth 			= "/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh_12052020.dat"
	file_utctpth_bins 		= "/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh_24_total.dat"#sys.argv[2]

	bin_total_weather(file_utctpth, file_utctpth_bins, 24)

if __name__== "__main__":
	main()
