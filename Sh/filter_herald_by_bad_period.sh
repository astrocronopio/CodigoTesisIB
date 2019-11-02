##Usa los archivos los archivos del herald, los matchea con el weather y saca los eventos que estuvieron en una mala hora
#=================================================================================================
# 1			2		3		4			5			6			7			8		9			10			11			12			13		14
# UTC  >>	The	 >>	phi >> 	S1000 >> 	dS1000 >>	Energy >> iutc << " "<< t <<" "<< p << " "<<rho <<" "<< rhod <<" "<< iw <<" "<< ib << h6 
#=================================================================================================

#--------------------------------Weather------2005-2015---------------------------------------
utctprh="/home/ponci/Desktop/TesisIB/Coronel/PC_Weather_paper/Weather/utctprh.dat"
#---------------------------------------------------------------------------------------------

prepares_files()
{	eventdata=$1
	utctprh=$2
	outfile=$3
	outfilebp=$4
	outfile_energy_theta=$5
	outfile_energy_time=$6
	#---------------------------------------------------------------------------------------------
	../Cpp/merged_herald_weather "$eventdata"  "$utctprh"  "$outfile"
#---------------------------------------------------------------------------------------------
	awk '{ if($12<4 && $13==1) print $1,$2,$3,$4,$5,$6 }' "$outfile"  > "$outfilebp" && wc -l  "$outfilebp"
# Ahora tiene la forma: UTC  >>	The	 >>	phi >> 	S1000 >> 	dS1000 >>	Energy 
#---------------------------------------------------------------------------------------------
	awk '{if ($2<60 && $6>=1) print $0}' "$outfilebp" > "$outfile_energy_theta" && wc -l  "$outfile_energy_theta"
#Ahora ya filtré el 60 theta y la energía de 1EeV
#---------------------------------------------------------------------------------------------
	awk '{if ($1<mktime("2015 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }'  "$outfile_energy_theta" > "$outfile_energy_time" && wc -l  "$outfile_energy_time"
#Ahora ya filtré por tiempo
#---------------------------------------------------------------------------------------------
}

echo "filter_herald_by_bad_period.sh"

#-------------------------------------------OLD HERALD---------2005-2015----------------------------------------
echo "Old"
eventdata="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/All_Energy/Old_Herald.dat"
outfile="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/All_Energy/Old_Herald_weather.dat"
outfilebp="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/All_Energy/Old_herald_weather_no-badperiod.dat"
outfile_energy_theta="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Old_herald_1EeV_theta60_no_badperiods.dat"
outfile_energy_time="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Old_herald_1EeV_theta60_no_badperiods_01012005-to-31122015.dat"

prepares_files "$eventdata"  "$utctprh"  "$outfile"  "$outfilebp" "$outfile_energy_theta" "$outfile_energy_time"
#=================================================================================================
echo "New"
#-------------------------------------------NEW HERALD------------2005-2015----------------------------------
eventdata="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/All_Energy/Herald.dat"
outfile="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/All_Energy/Herald_weather.dat"
outfilebp="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/All_Energy/Herald_weather_no-badperiod.dat"
outfile_energy_theta="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Herald_1EeV_theta60_no_badperiods.dat"
outfile_energy_time="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Herald_1EeV_theta60_no_badperiods_01012005-to-31122015.dat"

prepares_files "$eventdata"  "$utctprh"  "$outfile"  "$outfilebp" "$outfile_energy_theta" "$outfile_energy_time"
#=================================================================================================

echo "S38"
auger_file_energy_output='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_filter_by_S38/Herald_S38.dat'
auger_file_5v_energy_output='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_filter_by_S38/Herald_old_S38.dat'

auger_file_time_output='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_filter_by_S38/Herald_S38_01012005-to-311122015.dat'
auger_file_5v_time_output='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_filter_by_S38/Herald_old_S38_01012005-to-311122015.dat'

awk '{if ($1<mktime("2015 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }'  "$auger_file_energy_output" > "$auger_file_time_output" && wc -l  "$auger_file_time_output"
awk '{if ($1<mktime("2015 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }'  "$auger_file_5v_energy_output" > "$auger_file_5v_time_output" && wc -l  "$auger_file_5v_time_output"

