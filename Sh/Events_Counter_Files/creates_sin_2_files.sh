#filepath 		= sys.argv[1]
#file_auger 	= sys.argv[2]
#file_name  	= sys.argv[3]
#the_all_mighty_function(file_auger, file_name, filepath)

#===========================by Energy ========================

filepath="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_2/New/"
file_auger="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Herald_filter_by_energy_above_1EeV.dat"
file_name="Herald_"

python ../../Python/creates_sin_2_files.py  "$filepath" "$file_auger"  "$file_name"

filepath="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_2/Old/"
file_auger="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Old_Herald_filter_by_energy_above_1EeV.dat"
file_name="Herald_old"

python ../../Python/creates_sin_2_files.py  "$filepath" "$file_auger"  "$file_name"

#=============================by S38==========================
filepath="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_2/New/"
file_auger="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_filter_by_S38/Herald_S38.dat"
file_name="Herald_S38"

python ../../Python/creates_sin_2_files.py  "$filepath" "$file_auger"  "$file_name"

filepath="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_2/Old/"
file_auger="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_filter_by_S38/Herald_old_S38.dat"
file_name="Herald_old_S38"

python ../../Python/creates_sin_2_files.py  "$filepath" "$file_auger"  "$file_name"