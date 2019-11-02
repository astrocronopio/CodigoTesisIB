#--------------------------------------------------------------------------------------------------------
	
	#bash "/home/ponci/Desktop/TesisIB/Coronel/CodigoTesisIB/Sh/creates_sin_2_files_and_merges_by_hour.sh"
	
	
	#output_file="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/fitted_parameters.dat"
	
	#rm "$output_file"
	
	#for number in 1 2 3 4 5
	#	do 
	#	bash MLE_file.sh "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/New/Herald__sector_""$number""_weather.dat"  "$output_file"	
	#	done
	#
	#echo "Empezamos el otro"
	#
	#for number in 1 2 3 4 5
	#	do
	#	bash MLE_file.sh "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Old/Herald_old_sector_""$number""_weather.dat"  "$output_file"							
	#	done
	
	#cd ../../Merged_Herald_Weather
	
	#bash "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/creates_files_fit.sh"  "$output_file"
	
	#gnuplot "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/comparando_con_oscar.gp"
	
#--------------------------------------------------------------------------------------------------------

	#output_file="/home/ponci/Desktop/TesisIB/Coronel/PC_Weather_paper/Merged/fitted_parameters_PC.dat"
	
	#rm "$output_file"
	
	#for number in 1 2 3 4 5
	#	do
	#	bash MLE_file.sh "/home/ponci/Desktop/TesisIB/Coronel/PC_Weather_paper/Merged/Herald__sector_""$number""_weather.dat"  "$output_file"							
	#	done

#--------------------------------------------------------------------------------------------------------
	output_file="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/fitted_parameters_global_fit.dat"
	
	rm "$output_file"
	
	bash MLE_file.sh "/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Bins_by_day/merged.dat"  "$output_file"							

#--------------------------------------------------------------------------------------------------------
