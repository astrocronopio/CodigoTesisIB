
project="/home/ponci/Desktop/TesisIB/Coronel/"
#'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
generate_file () {
	#							Delayed 		 Delayed
	#1		2	 	 3		4		5		6		7		8		9	
	#UTC,	events , sqrt, utc, avgtemp, avgpres, avgrho, avgrho24, shex6T5)
	#awk '{ if($9>700 &&  $6!=0 && $7!=0 && $8!= 0 && $2>0) print $0 }'  $1 | awk '{print $4,$2,$6,$7,$8, $9/2.566, $2*2.566/$9}' > $2
	awk '{if ($9>690 && $2>0  && $2*2.566/$9 > 0  && $2*2.566/$9 < 0.007) print $0 }'  $1 | awk '{print $4,$2,$6,$7,$8,$9/2.566, $2*2.566/$9}' > $2
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
	awk '{if ($1<mktime("2018 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }' $1 > events_time.dat &&
	awk '{if ($1<mktime("2018 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }' $2 > delay_time.dat

	paste events_time.dat	delay_time.dat	> events_delay.dat 

	generate_file events_delay.dat 	$3
	
	rm events_delay.dat
}

Loop_through_sin_2(){


	for number in 1 2 3 4 5
	do
		file_bins=$1$2"_sector_"$number".dat"
		file_events=$1$2"_sector_"$number"_bins.dat"
		echo "Doing it with this ""$file_events"
	
		file_merged_2016=$1$2"_sector_"$number"_weather.dat"
		file_merged_2019=$1$2"_sector_"$number"_weather_2019.dat"
		
		Merged_Herald_Weather_2016 "$file_events"  "$file_delay"  "$file_merged_2016" &&
		Merged_Herald_Weather_2019 "$file_events"  "$file_delay"  "$file_merged_2019"

		rm "$file_events" && rm "$file_bins"


	done
}
#'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

#------------------------------------Delayed Weather data----------------------------------------

file_delay="/home/ponci/Desktop/TesisIB/Coronel/PC_Weather_paper/Weather/utctprh_binsdelayrho.dat" 

#===========================by Energy =====in bins by hour===================
 filepath="$project""Merged_Herald_Weather/Energy_above_1EeV/New/"
 file_auger="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Herald_1EeV_theta60.dat"
 file_name="Herald_"
#'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 filepath_old="$project""Merged_Herald_Weather/Energy_above_1EeV/Old/"
 file_auger_old="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Old_herald_1EeV_theta60.dat"
 file_name_old="Herald_old"
 #'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

 python "$project"/CodigoTesisIB/Python/creates_sin_2_files.py  "$filepath" 	"$file_auger"  		"$file_name" &&  
 python "$project"/CodigoTesisIB/Python/creates_sin_2_files.py  "$filepath_old" "$file_auger_old"   "$file_name_old"
 wait
 Loop_through_sin_2  "$filepath" 		"$file_name"  && 
 Loop_through_sin_2  "$filepath_old" 	"$file_name_old"
