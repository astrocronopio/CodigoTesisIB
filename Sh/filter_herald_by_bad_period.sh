##Usa los archivos los archivos del herald, los matchea con el weather y saca los eventos que estuvieron en una mala hora
#=================================================================================================
# 1			2		3		4			5			6			7			8		9			10			11			12			13		14
# UTC  >>	The	 >>	phi >> 	S1000 >> 	dS1000 >>	Energy >> iutc << " "<< t <<" "<< p << " "<<rho <<" "<< rhod <<" "<< iw <<" "<< ib << h6 
#=================================================================================================

#Weather------2005-2015---------------
utctprh="/home/ponci/Desktop/TesisIB/Coronel/PC_Weather_paper/Weather/utctprhdrc_010104_090516.dat"

prepares_files()
{	eventdata=$1
	utctprh=$2
	outfile=$3
	outfilebp=$4
	outfile_energy_theta=$5
#---------------------------------------------------------------------------------------------
	../Cpp/merged_herald_weather "$eventdata"  "$utctprh"  "$outfile"
#---------------------------------------------------------------------------------------------
	awk '{ if($13==1 && $12<4 ) print $1,$2,$3,$4,$5,$6 }' "$outfile"  > "$outfilebp"
#---------------------------------------------------------------------------------------------
	awk '{if ($2<60 && $4 > 1) print $0}' "$outfiletime" > "$outfile_energy_theta"
#---------------------------------------------------------------------------------------------
}


#--------------------------------------------OLD HERALD---------2005-2015----------------------------------------

eventdata="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/All_Energy/Old_Herald.dat"
outfile="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/All_Energy/Old_Herald_weather.dat"
outfiletime="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/All_Energy/Old_herald_weather_no-badperiod.dat"
outfile_energy_theta="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Old_herald_1EeV_theta60_no_badperiods.dat"

prepares_files "$eventdata"  "$utctprh"  "$outfile"  "$outfiletime" "$outfile_energy_theta"
#=================================================================================================

#--------------------------------------------NEW HERALD------------2005-2015----------------------------------
eventdata="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/All_Energy/Herald.dat"
outfile="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/All_Energy/Herald_weather.dat"
outfiletime="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/All_Energy/Herald_weather_no-badperiod.dat"
outfile_energy_theta="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Herald_1EeV_theta60_no_badperiods.dat"

prepares_files "$eventdata"  "$utctprh"  "$outfile"  "$outfiletime" "$outfile_energy_theta"
#=================================================================================================