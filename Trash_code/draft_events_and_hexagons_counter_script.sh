#!/bin/bash
## Creates a file with the number of events and weather info in bin of an hour. 
## To ru this script with differents files, you need to change the filepath 
## in the code 
##

#------------------------------------------------------------------------

#_______New Data Set
file_auger="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Herald_simple_modified.dat"
file_events="Herald_simple_modified_bins.dat"

#_______Old Data Set
file_auger_old="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Herald_old_simple_modified.dat"
file_events_old="Herald_old_simple_modified_bins.dat"

	#python eventCounter.py "$file_auger" "$file_events"
	#python eventCounter.py "$file_auger_old" "$file_events_old"

#------------------------------------------------------------------------

# Same as before but for the weather and hexagons data

#Which archives is using right now?
#Original 					Weather histogram		Weather Avg Histogram per hour
#'utctprh.dat'  creates  'utctprhdr-bins.dat' and 'utctprhcavg-binsh.dat'
	
#To use this script, you update the bin size within the code, fortran is not nice
#so the utctprhdr-bins will have the same size as the file_events

	#gfortran average_utctprh_file.f -o average_utctprh_file.out
	#./average_utctprh_file.out


file_utctprh="utctprh.dat"
file_utctprh_bins="utctprh-bins-python.dat"
file_utctprh_avg_bins="utctprhcavg-binsh.dat"

file_delay="utctprh-binsdelayrho.dat"

	#python faster.py "$file_utctprh" "$file_utctprh_bins" "$file_utctprh_avg_bins"

#----- OPCIONAL: for delay the density 2 hrs--------
	#delayrho.sh

	#awk 'BEGIN{i=1}{if(i>2)i=1;if(NR>2)print $1,t[i],$3,rho[i],$5,$6;t[i]=$2;rho[i]=$4;i++}' "$file_utctprh_bins"  > "$file_delay" 
#---------------------------------------------------

#Elegir una fecha
#awk 'BEGIN 
#	{
#	desde_este_dia="2015 12 14 13 20 10"
#	hasta_este_dia="2015 12 31 23 59 59"
#
#	desde_dia_utc= mktime(desde_este_dia)
#	hasta_dia_utc= mktime(hasta_este_dia)
#	print(desde_dia_utc)
#	}
#	{if ($1<hasta_dia_utc && $1>hasta_dia_utc) print(hasta_dia_utc) }' "$file_utctprh_bins"


awk_time=$(cat << 'EOF'
	{ desde_este_dia="2015 01 01 00 00 00";
	  hasta_este_dia="2015 12 31 23 59 59";

	  desde_dia_utc= mktime(desde_este_dia);
	  hasta_dia_utc= mktime(hasta_este_dia);

	  if ($1<hasta_dia_utc && $1>desde_dia_utc) print $0 }
EOF
)


#awk '{desde_este_dia="2015 12 30 13 20 10";
#	  hasta_este_dia="2015 12 31 23 59 59";
#
#	  desde_dia_utc= mktime("2015 12 14 13 20 10");
#	  hasta_dia_utc= mktime("2015 12 31 23 59 59");
#
#	  if ($1<hasta_dia_utc && $1>desde_dia_utc) print $0 }' "$file_utctprh_bins" >  test.dat


file_utctprh_bins_time="time""$file_utctprh_bins"		
file_events_time="time""$file_events"
file_events_old_time="time""$file_events_old"	
file_delay_time="time""$file_delay"


	awk "$awk_time" "$file_utctprh_bins" 	> "$file_utctprh_bins_time"
	awk "$awk_time" "$file_events"		 	> "$file_events_time"
	awk "$awk_time" "$file_events_old"	 	> "$file_events_old_time"
	awk "$awk_time" "$file_delay"		 	> "$file_delay_time"

#---------------------------------------------------
# join the event data with the corresponding weather and hexagon one.
# Remember change the file according to your needs (delayed or current rho)
	#joinData.sh

	#join "$file_events_time" "$file_utctprh_bins_time" | awk  '{print $0}' > test1
	#join time"$file_events_old" 	"$file_utctprh_bins_time"  >test2
	#join time"$file_events"			"$file_delay_time"  >test3
	#join time"$file_events_old" 	"$file_delay_time"  >test4
 #join <( sort -n timeHerald_simple_modified_bins.dat) <(sort -n timeutctprh-bins-python.dat) < test4
paste "$file_events_time"  "$file_utctprh_bins_time" > join_herald_utctprh.dat


	
	
# Remove outliers 1333310000 < UTC < 1333490000 (anomalous low rate in this period)
	#awk '{if($1<1333310000 || $1>1333490000) print}' test_events_auger_herald.dat > HeraldData060weatherno.dat
