	utctprh="/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh.dat"
#------------------------------------------------------------------------------------------------------------------------------------
	echo "Old"
	auger_file_simple_output_theta="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Old_herald_8EeV.dat"
	outfile="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Herald_Old/Old_Herald_weather_8EeV.dat"
	outfile_nobp="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Herald_Old/Old_Herald_weather_8EeV_noBP.dat"

	#../Cpp/merged_anisotropy "$auger_file_simple_output_theta"  "$utctprh"  "$outfile"
	#awk '{if ($13 == 1) print $1, $2, $3, $4, $5, $6, $7, $8,  $9, $10, $11, $12}'  "$outfile" > "$outfile_nobp"
	


	echo "New"
	auger_file_simple_output_theta="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Herald_8EeV.dat"
	outfile="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Herald/Herald_weather_8EeV.dat"
	outfile_nobp="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Herald/Herald_weather_8EeV_noBP.dat"

	../Cpp/merged_anisotropy  "$auger_file_simple_output_theta"  "$utctprh"  "$outfile"
	awk '{if ($13 == 1) print $1, $2, $3, $4, $5, $6, $7,  $8,  $9, $10, $11, $12}'  "$outfile" > "$outfile_nobp"
