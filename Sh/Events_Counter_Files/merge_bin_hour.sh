#'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
generate_file () {
	#							Delayed 		 Delayed
	#1		2	 	 3		4		5		6		7		8		9	
	#UTC,	events , fit,  utc, avgtemp, avgpres, avgrho, avgrho24, shex6T5)
	awk '{if ($9>0 && $2>0  && $2*2.566/$9 > 0.13  && $2*2.566/$9 < 0.2) print $0 }'  $1 | awk '{print $4,$2,$6,$7,$8,$9/2.566, $2*2.566/$9}' > $2
	rm $1
}

Merged_Herald_Weather_2016 () {
	awk '{if ($1<mktime("2015 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }' $1 > events_time.dat
	awk '{if ($1<mktime("2015 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }' $2 > delay_time.dat

	paste events_time.dat	delay_time.dat	> events_delay.dat 
	rm events_time.dat && rm delay_time.dat	
	generate_file events_delay.dat 	$3
}
#---------------------------------------------------------------------------------------------

eventdata="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/All_Energy/Old_Herald.dat"
utctprh="/home/ponci/Desktop/TesisIB/Coronel/PC_Weather_paper/Weather/utctprhdrc_010104_090516.dat"
outfile="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Another_way_around/Old_herald_weather.dat"

../../Cpp/merged_herald_weather "$eventdata"  "$utctprh"  "$outfile"

#=================================================================================================

outfiletime="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Another_way_around/Old_herald_weather_01-01-2005-to-31-12-2015.dat"

awk '{ if($13==1 && $12<4 && $2<60.0 && $6>=1.0) print $0 }' "$outfile" | 
		awk '{if ($1<mktime("2015 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $1,$2,$3,$4,$5,$6,$7 }'  > "$outfiletime"

#=================================================================================================
#file_auger="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/All_Energy/Old_Herald_all_energy.dat"
file_auger="$outfiletime"

file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/Old_herald_events_by_day.dat"
file_bins="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/utctprh_bins_by_day.dat"

merged_file="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/merged.dat"

python ../../Python/bin_herald_and_weather_by_day.py "$file_auger" "$utctprh" "$file_events" "$file_bins"

Merged_Herald_Weather_2016  "$file_events" "$file_bins" "$merged_file"

#=================================================================================================
#Average rate of the events/area
sumR=$(awk 'BEGIN {sum=0} {sum+=$7} END {print sum/NR}'  $merged_file)
echo $sumR 