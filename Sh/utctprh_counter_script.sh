#----------------------------------------------------------------------------------------------------------------
filepath="/home/ponci/Desktop/TesisIB/Coronel/Weather/"

file_utctprh="$filepath""utctprh.dat" 
	   delay="$filepath""utctprh_delay.dat" 		#Weather Data
file_utctprh_bins="$filepath""utctprh_bins.dat" 	#Weather Data in bins of a hour
file_utctprh_bins_day="$filepath""utctprh_bins_by_day.dat" 


#python /home/ponci/Desktop/TesisIB/Coronel/CodigoTesisIB/Python/bin_weather.py "$file_utctprh" "$file_utctprh_bins" 	 3600
#python /home/ponci/Desktop/TesisIB/Coronel/CodigoTesisIB/Python/bin_weather.py "$file_utctprh" "$file_utctprh_bins_day"  86400

#---------------------------------------------- Delay the density 2 hrs------------------------------------------
#1		2		3		4		5		6			
#utc, avgtemp, avgpres, avgrho, avgrho24, shex6T5)

file_delay="$filepath""utctprh_binsdelayrho.dat" 			#Weather Data delayed by two hours

##----------------------------------------------------------------------------------------------------------------
#
#	awk '{i=1}
#			{	if(i>2)i=1;
#				if(NR>2) print $1,t[i],$3,rho[i],$5,$6;
#				t[i]=$2;
#				rho[i]=$4;
#				i++}' "$file_utctprh_bins"  > "$file_delay" 
##----------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------

	awk '{i=1}
			{	if(i>48)i=1;
				if(NR>48) print $1,$2,$3,$4,$5,$6,$7,$8,$9,rho[i]; rho[i]=$4; i++}'  "$file_utctprh"  > test.dat 
#----------------------------------------------------------------------------------------------------------------

#----------------------------------------------------------------------------------------------------------------

	awk '{i=1}
			{	if(i>144) i=1;
				if(NR>144) print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10, rhod[i];
				rhod[i]=$5;
				i++}' test.dat > "$delay"
#----------------------------------------------------------------------------------------------------------------

##rm test.dat