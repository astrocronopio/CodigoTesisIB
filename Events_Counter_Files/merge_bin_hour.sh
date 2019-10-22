#'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
generate_file () {
	#							Delayed 		 Delayed
	#1		2	 	 3		4		5		6		7		8		9	
	#UTC,	events , fit,  utc, avgtemp, avgpres, avgrho, avgrho24, shex6T5)
	awk '{if ($9>800) print $0 }'  $1 | awk '{print $4,$2,$6,$7,$8,$9, $2/$6}' > $2
	rm $1
}

Merged_Herald_Weather_2016 () {
	awk '{if ($1<mktime("2015 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }' $1 > events_time.dat
	awk '{if ($1<mktime("2015 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }' $2 > delay_time.dat

	paste events_time.dat	delay_time.dat	> events_delay.dat 
	rm events_time.dat && rm delay_time.dat	
	generate_file events_delay.dat 	$3
}

file_auger="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Old_Herald_filter_by_energy_above_1EeV.dat"
file_utc="/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh.dat"

file_events="../../Merged_Herald_Weather/Bins_by_day/Herald_events_by_day.dat"
file_bins="../../Merged_Herald_Weather/Bins_by_day/utctprh_bins_by_day.dat"

merged_file="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/merged.dat"

#python bin_by_day.py "$file_auger" "$file_utc" "$file_events" "$file_bins"

#Merged_Herald_Weather_2016  "$file_events" "$file_bins" "$merged_file"

sumR=$(awk 'BEGIN {sum=0} {sum+=$7} END {print sum/NR}'  /home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/merged.dat)
echo $sumR 