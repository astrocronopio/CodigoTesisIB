import numpy as np 

ap=-0.000564
arho=-1.49887 
brho=-4.10865 

P0= 861.777
rho0= 1.05547



def MLE_fit( P, rho, rho_24):
	#recordemos que rho es el delay o no, y rho_24 es la densidad media en 24
	return 1 + ap*(P-P0) + arho*(rho_24-rho0) + brho*(rho-rho_24)

def read_weather_rate(file_herald, file_herald_rate, rate):

	output= open(file_herald_rate, "w")
	with open(file_herald) as f:
		for line in f:
			utc,	events,	P, rho, rho_24, hex6, rate_hour = line.split()
			theorical_rate=rate*MLE_fit(float(P), float(rho), float(rho_24))
			output.write("{} \t {} \n".format(utc, theorical_rate))
	pass

def main():
	file_herald 			= "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/merged_old.dat"#sys.argv[1]
	file_herald_rate 		= "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/merged_rate.dat"#sys.argv[2]
	rate 	 				= 0.158474
	
	read_weather_rate(file_herald, file_herald_rate, rate)
  
if __name__== "__main__":
	main()
