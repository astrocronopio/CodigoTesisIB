##Este codigo lo que es hace es agarrar el texto filtrado por filter_by_etc y lo binea por sin^2 y hace los mismo al final wtf

import numpy as np
import thread

def bin_archive_data(file_auger, file_events):
	binWidth =3600 # In seconds
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

def the_all_mighty_function(file_auger, file_name, wherewillitbe):
	file_auger_array=[]
	file_auger_array_output=[]
	file_auger_array_bins=[]
	
	for i in range(1,6):
		file_auger_1= wherewillitbe+file_name+"_sector"+str(i)+".dat"
		file_auger_array.append(file_auger_1)
		file_auger_array_output.append(open(file_auger_1, "w+"))
	
		file_auger_2= wherewillitbe+file_name+"_sector"+str(i)+"_bins.dat"
		file_auger_array_bins.append(file_auger_2)
	
		sin_square= lambda theta: (np.sin(theta*np.pi/180.0))*(np.sin(theta*np.pi/180.0))
	sin_square_60=	sin_square(60)

	with open(file_auger) as f:
		for line in f:
			utc,the,phi,S1000,dS1000,energy = line.split()
			sector=int(5*sin_square(float(the))/sin_square_60)
	
			file_auger_array_output[sector].write("%i \t %s \t %s \t %s \t %s \t %s \n"%(int(utc),the,phi,S1000,dS1000,energy))
			file_auger_array_output[sector].flush()
	
	for i in range(0,5):
		bin_archive_data(file_auger_array[i], file_auger_array_bins[i])
	
	for i in range(0,5):
		file_auger_array_output[i].close()


#________________________Energy up to 2012_______________________
wherewillitbe="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/New/"
file_new_auger = "/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Herald_filter_by_energy_above_1EeV.dat"
file_new_name  = "Herald_filter_by_energy_above_1EeV"
the_all_mighty_function(file_new_auger, file_new_name, wherewillitbe)

wherewillitbe="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/Old/"
file_new_auger = "/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Old_Herald_filter_by_energy_above_1EeV.dat"
file_new_name  = "Herald_filter_by_energy_above_1EeV"
the_all_mighty_function(file_new_auger, file_new_name, wherewillitbe)


print("Done!")