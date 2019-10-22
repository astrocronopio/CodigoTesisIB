import numpy as np
import sys
from eventCounter import bin_archive_data

def the_all_mighty_function(file_auger, file_name, filepath):
	file_auger_array=[]
	file_auger_array_output=[]
	file_auger_array_bins=[]
	
	for i in range(1,6):
		file_auger_sector= filepath+file_name+"_sector_"+str(i)+".dat"
		file_auger_array.append(file_auger_sector)

		file_auger_array_bins.append(filepath+file_name+"_sector_"+str(i)+"_bins.dat")

		file_auger_array_output.append(open(file_auger_sector, "w+"))
	

	sin_square= lambda theta: (np.sin(theta*np.pi/180.0))*(np.sin(theta*np.pi/180.0))
	sin_square_60=	sin_square(60)

	with open(file_auger) as f:
		for line in f:
			utc, the, phi, S1000,  dS1000, energy = line.split()

			which_bin= int(np.floor(5*sin_square(float(the))/sin_square_60)) 

			sector= which_bin if  which_bin < 5 else 4
	
			file_auger_array_output[sector].write("%i \t %s \t %s \t %s \t %s \t %s \n"%(int(utc),the,phi,S1000,dS1000,energy))
			file_auger_array_output[sector].flush()
	
	for i in range(0,5):
		bin_archive_data(file_auger_array[i], file_auger_array_bins[i], 3600)

		file_auger_array_output[i].close()

#******************************************************************************

def main():
	filepath 	= sys.argv[1]
	file_auger 	= sys.argv[2]
	file_name  	= sys.argv[3]
	the_all_mighty_function(file_auger, file_name, filepath)
	print("Done with {}!".format(file_name))

if __name__== "__main__":
	main()