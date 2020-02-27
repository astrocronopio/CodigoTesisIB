import numpy as np 

pi = np.pi

P0= 861.777
rho0= 1.05547



def MLE_fit( P, rho, rho_24, ap, arho, brho):
	#recordemos que rho es el delay o no, y rho_24 es la densidad media en 24
	return 1 + ap*(P-P0) + arho*(rho_24-rho0) + brho*(rho-rho_24)


def signal_fit( P, rho, rho_24, ap, arho, brho):
	#recordemos que rho es el delay o no, y rho_24 es la densidad media en 24
	return 1+(ap*(P-P0) + arho*(rho_24-rho0) + brho*(rho-rho_24))/(2.3)

def read_weather_rate(file_herald, file_herald_rate, rate, ap, arho, brho):

	output= open(file_herald_rate, "w")
	with open(file_herald) as f:
		for line in f:
			utc,	events,	P, rho, rho_24, hex6, rate_hour = line.split()
			theorical_rate=rate*MLE_fit(float(P), float(rho), float(rho_24))
			output.write("{} \t {} \n".format(utc, theorical_rate))
	pass

def corrections(file_herald, file_herald_expected, ap, arho, brho):
	A= 0.1762996
	B= 1.0331

	ap_0     = 0.001	#0.00106014       +/- 0.0002825  
	ap_1     = -0.025 	#-0.025414        +/- 0.001789   
	ap_2     = 0.0250	#0.0246409        +/- 0.002348   
	
	arho_0   = -2.56 	#-2.5641          +/- 0.06742    
	arho_1   = 1.5 		#1.51531          +/- 0.427      
	arho_2   = 2.1 		#2.05202          +/- 0.5607     
	
	
	brho_0   = -1.06   	#-1.05752         +/- 0.09041      (8.549%)
	brho_1   = 1.6     	#1.62036          +/- 0.5727       (35.34%)
	brho_2   = -0   	#-0.395823        +/- 0.7524       (190.1%)

	output= open(file_herald_expected, "w")
	output_diff = open("diferencia.dat", "w")
	with open(file_herald) as f:
		for line in f:
			utc,the, S38, energy ,p,rho,rhod =  line.split()
			sq= np.sin(float(the)*pi/180.0)*np.sin(float(the)*pi/180.0)
		
			ap	= 	ap_0 + 	 ap_1*sq + 	 ap_2*sq*sq
			arho= arho_0 + arho_1*sq + arho_2*sq*sq
			brho= brho_0 + brho_1*sq + brho_2*sq*sq

			theorical= signal_fit(float(p),float(rho), float(rhod), ap, arho, brho)	

			energy_expected=A*(float(S38)/theorical)**B
			output_diff.write("{}\n".format(energy_expected-float(energy)))

			output.write("{}\t{}\t{}\t{}\t{}\t{}\t 1 \n".format(utc, the ,S38, energy_expected, p, rho, rhod))


def rate():
	file_herald 			= "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/merged_old_dat.dat"#sys.argv[1]
	file_herald_rate 		= "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/merged_old_day_rate_expected.dat"#sys.argv[2]
	rate 	 				= 0.155328

	ap=	  -0.001368
	arho= -0.740068
	brho= -0.22728 

	
	read_weather_rate(file_herald, file_herald_rate, rate)


	file_herald 			= "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/merged_day.dat"#sys.argv[1]
	file_herald_rate 		= "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/merged_day_rate_expected.dat"#sys.argv[2]
	rate 	 				= 0.155328

	ap=	  -0.0009058
	arho= -0.0760722
	brho= -0.0168998

	
	read_weather_rate(file_herald, file_herald_rate, rate)


	file_herald 			= "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/merged_S38_day.dat"#sys.argv[1]
	file_herald_rate 		= "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/merged_S38_day_rate_expected.dat"#sys.argv[2]
	rate 	 				= 0.170766

	ap=	  -0.001647
	arho= -0.704713
	brho= -0.226258


	read_weather_rate(file_herald, file_herald_rate, rate)
	
def cic_weather():
	outfilenobp="../../Merged_Herald_Weather/Herald_S38_S1000/Herald_weather_s1000_s38_nobp.dat"
	outfile="../../Merged_Herald_Weather/Herald_weather_s1000_s38_nobp_expected.dat"


	ap=	  -0.0016
	arho= -0.70
	brho= -0.22

	corrections(outfilenobp, outfile, ap, arho, brho)

	outfilenobp="../../Merged_Herald_Weather/Herald_S38_w_S1000/Herald_weather_s1000_s38_w_nobp.dat"
	outfile="../../Merged_Herald_Weather/Herald_weather_s1000_s38_w_nobp_expected.dat"


	ap=	  -0.0012
	arho= -0.35
	brho= -0.10

	corrections(outfilenobp, outfile, ap, arho, brho)

	pass

def main():
	#rate()
	cic_weather();
if __name__== "__main__":
	main()
