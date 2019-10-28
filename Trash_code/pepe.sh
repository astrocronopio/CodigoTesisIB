
project="/home/ponci/Desktop/TesisIB/Coronel/"
#'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
generate_file () {
	#							Delayed 		 Delayed
	#1		2	 	 3		4		5		6		7		8		9	
	#UTC,	events , sqrt, utc, avgtemp, avgpres, avgrho, avgrho24, shex6T5)
	#awk '{ if($9>700 &&  $6!=0 && $7!=0 && $8!= 0 && $2>0) print $0 }'  $1 | awk '{print $4,$2,$6,$7,$8, $9/2.566, $2*2.566/$9}' > $2
	awk '{if ($9>690 && $2>0  && $2*2.566/$9 > 0  && $2*2.566/$9 < 0.005) print $0 }'  $1 | awk '{print $4,$2,$6,$7,$8,$9/2.566, $2*2.566/$9}' > $2
}

Merged_Herald_Weather_2016 () {
	awk '{if ($1<mktime("2015 12 31 23 59 59") && $1>mktime("2009 05 01 00 00 00")) print $0 }' $1 > events_time.dat
	awk '{if ($1<mktime("2015 12 31 23 59 59") && $1>mktime("2009 05 01 00 00 00")) print $0 }' $2 > delay_time.dat

	paste events_time.dat	delay_time.dat	> events_delay.dat 
	rm events_time.dat && rm delay_time.dat	
	generate_file events_delay.dat 	$3

	rm events_delay.dat
}

Merged_Herald_Weather_2019 () {
	awk '{if ($1<mktime("2018 12 31 23 59 59") && $1>mktime("2009 05 01 00 00 00")) print $0 }' $1 > events_time.dat
	awk '{if ($1<mktime("2018 12 31 23 59 59") && $1>mktime("2009 05 01 00 00 00")) print $0 }' $2 > delay_time.dat

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
	
		file_merged_2016=$1$2"_sector_"$number"_weather_2009.dat"
		file_merged_2019=$1$2"_sector_"$number"_weather_2009_2019.dat"
		
		Merged_Herald_Weather_2016 "$file_events"  "$file_delay"  "$file_merged_2016"
		Merged_Herald_Weather_2019 "$file_events"  "$file_delay"  "$file_merged_2019"

		rm "$file_events" && rm "$file_bins"


	done
}
#'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

#------------------------------------Delayed Weather data----------------------------------------

file_delay="$project""Weather/utctprh_binsdelayrho.dat" 

#===========================by Energy =====in bins by hour===================

 filepath="$project""Merged_Herald_Weather/Energy_above_1EeV/New/"
 file_auger="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Herald_1EeV_theta60_no_badperiods.dat"
 file_name="Herald_"
 
 python "$project"/CodigoTesisIB/Python/creates_sin_2_files.py  "$filepath" "$file_auger"  "$file_name"
 
 Loop_through_sin_2  "$filepath" "$file_name"
 
 #'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 filepath="$project""Merged_Herald_Weather/Energy_above_1EeV/Old/"
 file_auger="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Old_herald_1EeV_theta60_no_badperiods.dat"
 file_name="Herald_old"
 
 python "$project"/CodigoTesisIB/Python/creates_sin_2_files.py  "$filepath" "$file_auger"  "$file_name"
 Loop_through_sin_2  "$filepath" "$file_name"


# 1			2		3		4			5			6			7			8		9			10			11			12			13		14
# UTC  >>	The	 >>	phi >> 	S1000 >> 	dS1000 >>	Energy >> iutc << " "<< t <<" "<< p << " "<<rho <<" "<< rhod <<" "<< iw <<" "<< ib << h6 
#1072959037 36.3800011 166.240005 3.50999999 2.19000006 0.660000026 1072959300 0.1633E+02 0.8663E+03 0.1042E+01 0.1054E+01 2 1

#awk '{ if($13==1 && $12<4 && $2<60.0 && $6>=1.0) print $0 }' "$file_auger" | awk '{if ($1<mktime("2015 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }'  > ihatemyself.dat
#awk '{ if($13==1 && $12<4 && $2<60.0 && $6>=1.0) print $0 }' "$file_auger" | awk '{if ($1<mktime("2015 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }'  > ihatemyself.dat

#python eventCounter.py ihatemyself.dat ihatemyself_bins.dat
#Merged_Herald_Weather_2016 ihatemyself_bins.dat "$file_delay" ihatemyself_merged_nuevo_weather.dat

#sumR=$(awk 'BEGIN {sum=0} {sum+=$7} END {print sum/NR}'  ihatemyself_merged_nuevo_weather.dat )
#echo $sumR 
