	utctprh="/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh.dat"
#------------------------------------------------------------------------------------------------------------------------------------
	echo "Oscar"
	auger_file_simple_output_theta="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/AllTriggers_1_2_EeV.dat"
	outfile="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/AllTriggers_1_2_EeV_weather.dat"
	outfile_nobp="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/AllTriggers_1_2_EeV_weather_nobp.dat"

	../Cpp/merged_anisotropy "$auger_file_simple_output_theta"  "$utctprh"  "$outfile"
	awk '{if ($13 == 1) print $1, $2, $3, $4, $5, $6, $7, $8,  $9, $10, $11, $12}'  "$outfile" > "$outfile_nobp"
	


	echo "Herald"
	auger_file_simple_output_theta="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/AllTriggers_1_2_EeV_herald.dat"
	outfile="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/AllTriggers_1_2_EeV_herald_weather.dat"
	outfile_nobp="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/AllTriggers_1_2_EeV_herald_weather_nobp.dat"

	../Cpp/merged_anisotropy  "$auger_file_simple_output_theta"  "$utctprh"  "$outfile"
	awk '{if ($13 == 1) print $1, $2, $3, $4, $5, $6, $7,  $8,  $9, $10, $11, $12}'  "$outfile" > "$outfile_nobp"
