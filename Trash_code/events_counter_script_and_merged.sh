#!/bin/bash
## Creates a file with the number of events and weather info in bin of an hour. 
## To run this script with differents files, you need to change the filepath 
## in the code 
generate_file () {
	awk '{if ($9>2000) print $0 }'  	 $1 > aux.dat
	awk '{print $4,$2,$6,$7,$8,$9}'	aux.dat > $2
	rm aux.dat && rm $1
}

Merged_Herald_Weather_2016 () {
	python eventCounter.py  $1  $2

	awk '{if ($1<mktime("2015 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }' $2 > events_time.dat
	awk '{if ($1<mktime("2015 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }' $3 > delay_time.dat

	paste events_time.dat	delay_time.dat	> events_delay.dat 
	rm events_time.dat && rm delay_time.dat	
	generate_file events_delay.dat 	$4
}

Merged_Herald_Weather_2019 () {
	python eventCounter.py  $1  $2

	awk '{if ($1<mktime("2018 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }' $2 > events_time.dat
	awk '{if ($1<mktime("2018 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }' $3 >delay_time.dat

	paste events_time.dat	delay_time.dat	> events_delay.dat 
	rm events_time.dat && rm delay_time.dat	
	generate_file events_delay.dat 	$4
}

#------------------------------------Delayed Weather data----------------------------------------
file_delay="/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh-binsdelayrho.dat" 	

#----------------------------------New Data Set by Energy---------------------------
file_auger="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Herald_filter_by_energy_above_1EeV.dat"
file_events="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Herald_filter_by_energy_above_1EeV_bins.dat"
file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/herald_delay-perday.dat"

Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged"
