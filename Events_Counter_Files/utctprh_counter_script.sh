#!/bin/bash
#------------------------------------------------------------------------

# Same as before but for the weather and hexagons data
#Original 					Weather histogram		Weather Avg Histogram per hour
#'utctprh.dat'  creates  'utctprhdr-bins.dat' and 'utctprhcavg-binsh.dat'

file_utctprh="/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh.dat" 						#Weather Data
file_utctprh_bins="/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh-bins.dat" 	#Weather Data in bins of a hour
#file_utctprh_avg_bins="/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprhcavg-binsh.dat" 	#Weather Data of the average every hour
			#per day now
	python utctprh_bins.py "$file_utctprh" "$file_utctprh_bins" #"$file_utctprh_avg_bins"

#------------------- Delay the density 2 hrs--------
#1		2		3		4		5		6			
#utc, avgtemp, avgpres, avgrho, avgrho24, shex6T5)

file_delay="/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh-binsdelayrho.dat" 			#Weather Data delayed by two hours

	awk '{i=1}
			{	if(i>2)i=1;
				if(NR>2) print $1,t[i],$3,rho[i],$5,$6;
				t[i]=$2;
				rho[i]=$4;
				i++}' "$file_utctprh_bins"  > "$file_delay" 
#---------------------------------------------------