#!/bin/bash
## Creates a file with the number of events and weather info in bin of an hour. 
## To run this script with differents files, you need to change the filepath 
## in the code 
#------------------------------------layed Weather data----------------------------------------
file_delay="/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh-binsdelayrho.dat" 

#----------------------------------New Data Set by Energy---------------------------
file_auger="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Herald_filter_by_energy_above_1EeV.dat"
file_events="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Herald_filter_by_energy_above_1EeV_bins.dat"

#	python eventCounter.py "$file_auger" 		"$file_events"

#----------------------------------Old Data Set by Energy---------------------------
file_auger_old="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Old_Herald_filter_by_energy_above_1EeV.dat"
file_events_old="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Old_Herald_filter_by_energy_above_1EeV_bins.dat"

#	python eventCounter.py "$file_auger_old" 	"$file_events_old"

#---------------------------------Filter by time------------------------------------------------
desde_este_dia="2005 01 01 00 00 00"
hasta_este_dia="2011 12 31 23 59 59"

awk_time=$(cat << 'EOF'
	{ desde_dia_utc=mktime($desde_este_dia);
	  hasta_dia_utc=mktime($hasta_este_dia);

	  if ($1<hasta_dia_utc && $1>desde_dia_utc) print $0 }
EOF
)

	awk "$awk_time" "$file_delay"		 	> delay_time.dat
	awk "$awk_time" "$file_events"		 	> events_time.dat
	awk "$awk_time" "$file_events_old"	 	> old_events_time.dat


#------------------------------------Merged Files by Energy------------------------------------------------
	    herald_delay="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/herald_delay.dat"
	herald_old_delay="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/herald_old_delay.dat"
#---------------------------------------------------

# join the event data with the corresponding weather and hexagon one.

	paste events_time.dat 		delay_time.dat	> join_herald_delay.dat
	paste old_events_time.dat	delay_time.dat 	> join_herald_old_delay.dat
#---------------------------------------------------
	#rm delay_time.dat
	#rm events_time.dat
	#rm old_events_time.dat

#--------------------------------------------------------
generate_file () {
	awk '{if ($9>1500) print $0 }' $1 > aux.dat
	awk '{print $4,$2,$6,$7,$8,$9}'	aux.dat > $2
	#rm aux.dat && rm $1
}

generate_file join_herald_delay.dat 		"$herald_delay"			 
generate_file join_herald_old_delay.dat 	"$herald_old_delay"	#