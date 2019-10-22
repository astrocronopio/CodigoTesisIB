
Loop_through_sin_2(){
	#------------------------------------Delayed Weather data----------------------------------------
	file_delay="/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh-binsdelayrho.dat" 

	for number in 1 2 3 4 5
	do
	file_sin_2=$1$2"_sector_"$number"_bins.dat"
	echo "Doing it with this ""$file_sin_2"
	head -1 "$file_sin_2"
	#----------------------------------New Data Set by Energy---------------------------
	#file_auger="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Herald_filter_by_energy_above_1EeV.dat"
	#file_events="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Herald_filter_by_energy_above_1EeV_bins.dat"
	#file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/herald_delay-perday.dat"
	
	#Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged"

	done
	exit 0
}

filepath="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_2/New/"
file_name="Herald_"


Loop_through_sin_2  "$filepath" "$file_name"
