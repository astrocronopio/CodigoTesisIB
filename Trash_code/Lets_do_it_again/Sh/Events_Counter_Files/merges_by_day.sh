project=$1
weather=$2
#project="/home/ponci/Desktop/TesisIB/Coronel/"
#'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
generate_file () {
	#							Delayed 		 Delayed
	#1		2	 	 3		4		5		6		7		8		9	
	#UTC,	events , sqrt, utc, avgtemp, avgpres, avgrho, avgrho24, shex6T5)
	awk '{if ($9>700 && $2>0) print $0 }'  $1 | awk '{print $4,$2,$6,$7,$8, $9, $2/$9}' > $2
}

Merged_Herald_Weather_2016 () {
	awk '{if ($1<mktime("2015 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }' $1 > events_time.dat
	awk '{if ($1<mktime("2015 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }' $2 > delay_time.dat

	paste events_time.dat	delay_time.dat	> events_delay.dat 
	rm events_time.dat && rm delay_time.dat	
	generate_file events_delay.dat 	$3

	rm events_delay.dat
}

Merged_Herald_Weather_2019 () {
	awk '{if ($1<mktime("2018 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }' $1 > events_time.dat
	awk '{if ($1<mktime("2018 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }' $2 > delay_time.dat

	paste events_time.dat	delay_time.dat	> events_delay.dat 

	generate_file events_delay.dat 	$3
	
	rm events_delay.dat
}

utctprh="/home/ponci/Desktop/TesisIB/Coronel/PC_Weather_paper/Weather/utctprh.dat"

#===========================by Energy =====in bins by day===================

filepath="$project""Merged_Herald_Weather/Energy_above_1EeV/Sin_2/New/"
file_auger="$project""Merged_Herald_Weather/Herald_weather_no-badperiod.dat"
file_name="Herald_"

file_events="$filepath""$file_name""_bins_day.dat"
file_bins="$project""Weather/utctprh_bins_by_day.dat"

merged_file="$filepath""$file_name""_weather_bin_by_day.dat"

python "$project"CodigoTesisIB/Python/bin_herald_and_weather_by_day.py "$file_auger" "$utctprh" "$file_events" "$file_bins"

Merged_Herald_Weather_2016  "$file_events" "$file_bins" "$merged_file"


#'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

filepath="$project""Merged_Herald_Weather/Energy_above_1EeV/Sin_2/Old/"

file_auger="$project""Merged_Herald_Weather/Old_herald_weather_no-badperiod.dat"
file_name="Herald_old"

file_events="$filepath""$file_name""_bins_day.dat"
file_bins="$project""Weather/utctprh_bins_by_day.dat"

merged_file="$filepath""$file_name""_weather_bin_by_day.dat"

python "$project"CodigoTesisIB/Python/bin_herald_and_weather_by_day.py "$file_auger" "$utctprh" "$file_events" "$file_bins"

Merged_Herald_Weather_2016  "$file_events" "$file_bins" "$merged_file"
