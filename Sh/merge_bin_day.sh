#'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
generate_file () {
	#							Delayed 		 Delayed
	#1		2	 	 3		4		5		6		7		8		9	
	#UTC,	events , fit,  utc, avgtemp, avgpres, avgrho, avgrho24, shex6T5)
	#awk '{if ($9>690 && $6!=0 && $7!=0 && $8!= 0 && $2>0 && $2*2.566/$9 <0.21 && $2*2.566/$9> 0.11) print $0 }'  $1 | awk '{print $4,$2,$6,$7,$8,$9/2.566, $2*2.566/$9}' > $2
	awk '{if ($9>690 && $2>0) print $0 }'  $1 | awk '{print $4,$2,$6,$7,$8,$9/2.566, $2*2.566/$9}' > $2
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
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$         OLD HERALD        $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

	eventdata="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/All_Energy/Old_Herald.dat"
	utctprh="/home/ponci/Desktop/TesisIB/Coronel/PC_Weather_paper/Weather/utctprh.dat"
	
	outfile="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Old_Herald_weather_noBP.dat"
	
	#../Cpp/merged_herald_weather "$eventdata"  "$utctprh"  "$outfile"

#=================================================================================================

	#outfiletime="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Old_herald_weather_01-01-2005-to-31-12-2015.dat"
	#awk '{ if($13==1 && $12<4 && $2<60.0 && $6>=1.0) print $0 }' "$outfile"   > "$outfiletime"

#=================================================================================================
file_auger="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/All_Energy/Old_Herald_all_energy.dat"
	file_auger="$outfile"
	
	file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/Old_herald_events_by_hour.dat"
	file_bins="/home/ponci/Desktop/TesisIB/Coronel/PC_Weather_paper/Weather/utctprh_bins.dat" 
	
	merged_file="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/merged_old_hour.dat"
	
	python ../Python/bin_herald.py "$file_auger" "$file_events"  3600
	
	Merged_Herald_Weather_2016  "$file_events" "$file_bins" "$merged_file"
 
#=================================================================================================
	#Average rate of the events/area
	sumR=$(awk 'BEGIN {sum=0} {sum+=$7} END {print sum/NR}'  $merged_file)
	echo $sumR 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/All_Energy/Old_Herald_all_energy.dat"
	file_auger="$outfile"
	
	file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/Old_herald_events_by_dat.dat"
	file_bins="/home/ponci/Desktop/TesisIB/Coronel/PC_Weather_paper/Weather/utctprh_bins_by_day.dat" 
	
	merged_file="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/merged_old_dat.dat"
	
	python ../Python/bin_herald.py "$file_auger" "$file_events"  86400
	
	Merged_Herald_Weather_2016  "$file_events" "$file_bins" "$merged_file"
 
#=================================================================================================
	#Average rate of the events/area
	sumR=$(awk 'BEGIN {sum=0} {sum+=$7} END {print sum/NR}'  $merged_file)
	echo $sumR 

#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$            New HERALD               $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


	#---------------------------------------------------------------------------------------------
	utctprh="/home/ponci/Desktop/TesisIB/Coronel/PC_Weather_paper/Weather/utctprh.dat"
	
	file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Herald_weather_noBP.dat"
	
	file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/Herald_events_by_hour.dat"
	file_bins="/home/ponci/Desktop/TesisIB/Coronel/PC_Weather_paper/Weather/utctprh_bins.dat" 
	
	merged_file="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/merged_hour.dat"
	
	python ../Python/bin_herald.py "$file_auger" "$file_events"  3600
	
	Merged_Herald_Weather_2016  "$file_events" "$file_bins" "$merged_file"
 
#=================================================================================================
	#Average rate of the events/area
	sumR=$(awk 'BEGIN {sum=0} {sum+=$7} END {print sum/NR}'  $merged_file)
	echo $sumR 
	
	
	#gnuplot "plot_merged.gp"

	#file_auger="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/All_Energy/Old_Herald_all_energy.dat"
	file_auger="$outfile"
	
	file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/Herald_events_by_day.dat"
	file_bins="/home/ponci/Desktop/TesisIB/Coronel/PC_Weather_paper/Weather/utctprh_bins_by_day.dat" 
	
	merged_file="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/merged_day.dat"
	
	python ../Python/bin_herald.py "$file_auger" "$file_events"  86400
	
	Merged_Herald_Weather_2016  "$file_events" "$file_bins" "$merged_file"
 
#=================================================================================================
	#Average rate of the events/area
	sumR=$(awk 'BEGIN {sum=0} {sum+=$7} END {print sum/NR}'  $merged_file)
	echo $sumR 
	
	#gnuplot "plot_merged.gp"

#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$     HERALD S38        $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$


	#---------------------------------------------------------------------------------------------
	utctprh="/home/ponci/Desktop/TesisIB/Coronel/PC_Weather_paper/Weather/utctprh.dat"
	outfile="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Herald_S38_weather.dat"

#=================================================================================================

	file_auger="$outfile"
	
	file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/Herald_S38_events_by_hour.dat"
	file_bins="/home/ponci/Desktop/TesisIB/Coronel/PC_Weather_paper/Weather/utctprh_bins.dat" 
	
	merged_file="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/merged_S38_hour.dat"
	
	python ../Python/bin_herald.py "$file_auger" "$file_events"  3600
	
	Merged_Herald_Weather_2016  "$file_events" "$file_bins" "$merged_file"
 
#=================================================================================================
	#Average rate of the events/area
	sumR=$(awk 'BEGIN {sum=0} {sum+=$7} END {print sum/NR}'  $merged_file)
	echo $sumR 
	
	file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/Herald_S38_events_by_day.dat"
	file_bins="/home/ponci/Desktop/TesisIB/Coronel/PC_Weather_paper/Weather/utctprh_bins_by_day.dat" 
	
	merged_file="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/merged_S38_day.dat"
	
	python ../Python/bin_herald.py "$file_auger" "$file_events"  86400
	
	Merged_Herald_Weather_2016  "$file_events" "$file_bins" "$merged_file"
 
#=================================================================================================
	#Average rate of the events/area
	sumR=$(awk 'BEGIN {sum=0} {sum+=$7} END {print sum/NR}'  $merged_file)
	echo $sumR 

