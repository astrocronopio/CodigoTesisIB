	utctprh="/home/ponci/Desktop/TesisIB/Coronel/PC_Weather_paper/Weather/utctprh.dat"
##------------------------------------------------------------------------------------------------------------------------------------
#	auger_file_simple_output_theta="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Old_herald_1EeV_theta60.dat"
#	outfile="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Old_Herald_weather.dat"
#	outfile_nobp="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Old_Herald_weather_noBP.dat"
#
#	../Cpp/merged_herald_weather "$auger_file_simple_output_theta"  "$utctprh"  "$outfile"
#	awk '{if ($8 == 1) print $1, $2, $3, $4, $5, $6, $7}'  "$outfile" > "$outfile_nobp"
#	
##------------------------------------------------------------------------------------------------------------------------------------
#	auger_file_simple_output_theta="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Herald_1EeV_theta60.dat"
#	outfile="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Herald_weather.dat"
#	outfile_nobp="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Herald_weather_noBP.dat"
#
#	../Cpp/merged_herald_weather "$auger_file_simple_output_theta"  "$utctprh"  "$outfile"
#	awk '{if ($8 == 1) print $1, $2, $3, $4, $5, $6, $7}'  "$outfile" > "$outfile_nobp"
#
##------------------------------------------------------------------------------------------------------------------------------------
	auger_file_simple_output_theta='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_filter_by_S38/Herald_S38.dat'
	outfile="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Herald_S38_weather.dat"
	outfile_nobp="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Herald_S38_weather_noBP.dat"

	../Cpp/merged_herald_weather "$auger_file_simple_output_theta"  "$utctprh"  "$outfile"
	awk '{if ($8 == 1) print $1, $2, $3, $4, $5, $6, $7}'  "$outfile" > "$outfile_nobp"


##------------------------------------------------------------------------------------------------------------------------------------
#
#	auger_file_simple_output_theta='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_filter_by_S38/Herald_old_S38.dat'
#	outfile="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Herald_old_S38_weather.dat"
#	outfile_nobp="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Herald_old_S38_weather_noBP.dat"
#
#	../Cpp/merged_herald_weather "$auger_file_simple_output_theta"  "$utctprh"  "$outfile"
#	awk '{if ($8 == 1) print $1, $2, $3, $4, $5, $6, $7}'  "$outfile" > "$outfile_nobp"
##------------------------------------------------------------------------------------------------------------------------------------
