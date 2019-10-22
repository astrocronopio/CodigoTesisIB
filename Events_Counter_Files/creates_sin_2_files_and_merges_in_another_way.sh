#filepath 		= sys.argv[1]
#file_auger 	= sys.argv[2]
#file_name  	= sys.argv[3]
#the_all_mighty_function(file_auger, file_name, filepath)


#'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
generate_file () {
	#							Delayed 		 Delayed
	#1		2	 	 3		4		5		6		7		8		9	
	#UTC,	events , sqrt, utc, avgtemp, avgpres, avgrho, avgrho24, shex6T5)
	awk '{ if($9>2000 &&  $6!=0 && $7!=0 && $8!= 0 ) print $0 }'  $1 | awk '{print $4,$2,$6,$7,$8,$9}' > $2
	#rm $1
}

Merged_Herald_Weather_2016 () {
	awk '{if ($1<mktime("2015 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }' $1 > events_time.dat
	awk '{if ($1<mktime("2015 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }' $2 > delay_time.dat

	paste events_time.dat	delay_time.dat	> events_delay.dat 
	rm events_time.dat && rm delay_time.dat	
	generate_file events_delay.dat 	$3
}

Merged_Herald_Weather_2019 () {
	awk '{if ($1<mktime("2018 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }' $1 > events_time.dat
	awk '{if ($1<mktime("2018 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }' $2 > delay_time.dat

	paste events_time.dat	delay_time.dat	> events_delay.dat 
	rm events_time.dat && rm delay_time.dat	
	generate_file events_delay.dat 	$3
}
Loop_through_sin_2(){
	#------------------------------------Delayed Weather data----------------------------------------
	file_delay="/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh-binsdelayrho.dat" 

	for number in 1 2 3 4 5
	do
	file_events=$1$2"_sector_"$number"_bins.dat"
	echo "Doing it with this ""$file_events"

	#----------------------------------New Data Set by Energy---------------------------

	file_merged_2016=$1$2"_sector_"$number"_weather.dat"
	file_merged_2019=$1$2"_sector_"$number"_weather_2019.dat"
	
	Merged_Herald_Weather_2016 "$file_events"  "$file_delay"  "$file_merged_2016"
	Merged_Herald_Weather_2019 "$file_events"  "$file_delay"  "$file_merged_2019"

	done
}
#'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

#===========================by Energy ========================

filepath="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Another_way_around/Energy_above_1EeV/Sin_2/New/"
file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Another_way_around/Herald_weather_no_badperiods.dat"
file_name="Herald_"

python creates_sin_2_files.py  "$filepath" "$file_auger"  "$file_name"

Loop_through_sin_2  "$filepath" "$file_name"

filepath="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Another_way_around/Energy_above_1EeV/Sin_2/Old/"
file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Another_way_around/Old_herald_weather_no_badperiods.dat"
file_name="Herald_old"

python creates_sin_2_files.py  "$filepath" "$file_auger"  "$file_name"
Loop_through_sin_2  "$filepath" "$file_name"

#=============================by S38==========================
filepath="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Another_way_around/Energy_filter_by_S38/Sin_2/New/"
file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Another_way_around/Herald_weather_S38_no_badperiods.dat"
file_name="Herald_S38"

python creates_sin_2_files.py  "$filepath" "$file_auger"  "$file_name"
Loop_through_sin_2  "$filepath" "$file_name"

filepath="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Another_way_around/Energy_filter_by_S38/Sin_2/Old/"
file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Another_way_around/Old_herald_weather_S38_no_badperiods.dat"
file_name="Herald_old_S38"

python creates_sin_2_files.py  "$filepath" "$file_auger"  "$file_name"
Loop_through_sin_2  "$filepath" "$file_name"