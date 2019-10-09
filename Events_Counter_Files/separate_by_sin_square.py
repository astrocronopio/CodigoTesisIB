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

def the_all_mighty_function(file_auger, file_type, whereisit):
	file_auger_array=[]
	file_auger_array_output=[]
	file_auger_array_bins=[]
	
	for i in range(1,6):
		file_auger_1= whereisit+file_type+"_sector"+str(i)+".dat"
		file_auger_array.append(file_auger_1)
		file_auger_array_output.append(open(file_auger_1, "w+"))
	
		file_auger_2= whereisit+file_type+"_sector"+str(i)+"_bins.dat"
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


	for i in range(0,5):
		file_bash.write("""\n\nfile_auger="%s" \n file_events="%s" \n file_merged="%s" \n""" %(file_auger_array[i], file_auger_array_bins[i], whereisit+file_type+"_sector"+str(i+1)+"merged.dat"))
		file_bash.write("""Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" \n\n""")
		pass
##################3=====================================================================================================================================================
file_bash=open("sin_square.sh", "w+")
	
file_bash.write("generate_file () { \n")
file_bash.write("	awk '{if ($10>2000) print $0 }' $1  >aux \n")
file_bash.write("				#utc events  T  P  Rho The \n")
file_bash.write("	awk '{print $5,  $2,$7,  $8,$9,$10,$4}' aux	> $2 \n")
file_bash.write("	rm $1 && rm aux \n")
file_bash.write("} \n")
file_bash.write(" \n")
file_bash.write("Merged_Herald_Weather () { \n")
file_bash.write("	python eventCounter.py  $1  $2 \n")
file_bash.write(" \n")
file_bash.write("""	awk '{if ($1<mktime("2011 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }' $2 > events_time.dat \n""")
file_bash.write("""	awk '{if ($1<mktime("2011 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }' $3 > delay_time.dat \n""")
file_bash.write(" \n")
file_bash.write("	paste events_time.dat	delay_time.dat	> events_delay.dat  \n")
file_bash.write("	rm events_time.dat && rm delay_time.dat	 \n")
file_bash.write("	generate_file events_delay.dat 	$4 \n")
file_bash.write("} \n")
file_bash.write(" \n")

file_bash.write("""file_delay="/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh-binsdelayrho.dat" \n\n\n""") #_________Delay_weather


##################3=====================================================================================================================================================

#----------------------------------New Data Set by Energy---------------------------
file_auger="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Herald_filter_by_energy_above_1EeV.dat"
file_name= "Herald_filter_by_energy_above_1EeV"
file_path= "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/New/"
the_all_mighty_function(file_auger, file_name, file_path)

#----------------------------------Old Data Set by Energy---------------------------
file_auger="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Old_Herald_filter_by_energy_above_1EeV.dat"
file_name= "Old_Herald_filter_by_energy_above_1EeV"
file_path= "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/Old/"
the_all_mighty_function(file_auger, file_name, file_path)

#----------------------------------New Data Set by S38---------------------------
file_auger="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_filter_by_S38/Herald_S38.dat"
file_name= "Herald_S38"
file_path= "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/New/"
the_all_mighty_function(file_auger, file_name, file_path)

#----------------------------------Old Data Set by S38---------------------------
file_auger="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_filter_by_S38/Herald_old_S38.dat"
file_name= "Herald_old_S38"
file_path= "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/Old/"
the_all_mighty_function(file_auger, file_name, file_path)

#==========================================2019!!=========================================================
file_auger="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Herald_filter_by_energy_above_1EeV.dat"
file_name= "Herald_filter_by_energy_above_1EeV"
file_path= "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/New/"
the_all_mighty_function(file_auger, file_name, file_path)

#----------------------------------Old Data Set by Energy---------------------------
file_auger="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Old_Herald_filter_by_energy_above_1EeV.dat"
file_name= "Old_Herald_filter_by_energy_above_1EeV"
file_path= "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/Old/"
the_all_mighty_function(file_auger, file_name, file_path)

#----------------------------------New Data Set by S38---------------------------
file_auger="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_filter_by_S38/Herald_S38.dat"
file_name= "Herald_S38"
file_path= "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/New/"
the_all_mighty_function(file_auger, file_name, file_path)

#----------------------------------Old Data Set by S38---------------------------
file_auger="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_filter_by_S38/Herald_old_S38.dat"
file_name= "Herald_old_S38"
file_path= "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/Old/"
the_all_mighty_function(file_auger, file_name, file_path)

print("Done!")