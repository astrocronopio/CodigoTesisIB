##Usa los archivos los archivos del herald, los matchea con el weather y saca los eventos que estuvieron en una mala hora

#=================================================================================================
# 1			2		3		4			5			6			7			8		9			10			11			12			13		14
# UTC  >>	The	 >>	phi >> 	S1000 >> 	dS1000 >>	Energy >> iutc << " "<< t <<" "<< p << " "<<rho <<" "<< rhod <<" "<< iw <<" "<< ib << h6 

#=================================================================================================
project=$1
filepath=$2
#Weather------2005-2015---------------
utctprh="$filepath""utctprh.dat"

#--------------------------------------------OLD HERALD---------2005-2015----------------------------------------

eventdata="$project""Herald/Central/Modified/All_Energy/Old_Herald.dat"
outfile="$project""Merged_Herald_Weather/Old_herald_weather.dat"
#---------------------------------------------------------------------------------------------

		"$project"/CodigoTesisIB/Cpp/merged_herald_weather "$eventdata"  "$utctprh"  "$outfile"

#=================================================================================================

outfiletime="$project""Merged_Herald_Weather/Old_herald_weather_no-badperiod.dat"
#---------------------------------------------------------------------------------------------

awk '{ if($13==1 && $12<4 && $2<60.0 && $6>=1.0) print $1,$2,$3,$4,$5,$6 }' "$outfile"  > "$outfiletime"


#=================================================================================================
#=================================================================================================

#--------------------------------------------NEW HERALD------------2005-2015----------------------------------
eventdata="$project""Herald/Central/Modified/All_Energy/Old_Herald.dat"
outfile="$project""Merged_Herald_Weather/Herald_weather.dat"
#---------------------------------------------------------------------------------------------

		"$project"/CodigoTesisIB/Cpp/merged_herald_weather "$eventdata"  "$utctprh"  "$outfile"

#=================================================================================================

outfiletime="$project""Merged_Herald_Weather/Herald_weather_no-badperiod.dat"
#---------------------------------------------------------------------------------------------
awk '{ if($13==1 && $12<4 && $2<60.0 && $6>=1.0) print $1,$2,$3,$4,$5,$6 }' "$outfile"  > "$outfiletime"
