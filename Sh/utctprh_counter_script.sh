#----------------------------------------------------------------------------------------------------------------
filepath="/home/ponci/Desktop/TesisIB/Coronel/Weather/"

file_utctprh="/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh_12052020.dat" 
#file_utctprh="/home/ponci/Desktop/TesisIB/Coronel/Weather_PC/Weather/Raw/utctprhdrc_010104_090516.dat"
	   delay="$filepath""utctprh_delay.dat" 		#Weather Data
file_utctprh_bins="$filepath""utctprh_bins.dat" 	#Weather Data in bins of a hour
file_utctprh_bins_day="$filepath""utctprh_bins_by_day.dat" 


python ../Python/bin_weather.py "$file_utctprh" "$file_utctprh_bins" 	 3600
python ../Python/bin_weather.py "$file_utctprh" "$file_utctprh_bins_day"  86400

exit
#---------------------------------------------- Delay the density 2 hrs------------------------------------------
#1		2		3		4		5		6			 7 		 8  /////	9		10		11		12	
#utc, avgtemp, avgpres, avgrho, avgrho24, shex6T5,	5t5, 	iw, ///// 	ib		hum		hum		hum

file_delay="$filepath""utctprh_binsdelayrho.dat" 			#Weather Data delayed by two hours

#----------------------------------------------------------------------------------------------------------------

	# awk '{i=1}
	# 		{	if(i>2)i=1;
	# 			if(NR>2) print $1,t[i],$3,rho[i],$5,$6;
	# 			t[i]= $2;
	# 			rho[i]=$4;
	# 			i++}' "$file_utctprh_bins"  > "$file_delay" 
#----------------------------------------------------------------------------------------------------------------
#----------------------------------------------------------------------------------------------------------------

################################################################
# This is for a delay of two hours
# For some reason I dont remember, in order to make both shifts, 
	awk 'BEGIN{i=1}
			{	if(i>24)i=1;
				if(NR>24) 
					print $1,$2,$3,$4,$5,$6,$7,$8,$9,rhodelay2[i]; 
					utc[i]=$2;
					rhodelay2[i]=$4; 
					i++}'  "$file_utctprh"  > test.dat 
#----------------------------------------------------------------------------------------------------------------

#----------------------------------------------------------------------------------------------------------------
################################################################
# This is for a delay of 12 hours of the mean average of the density
echo "--"
	awk 'BEGIN{i=1}
			{	if(i>144) i=1;
				if(NR>144)
					print utc[i], temp[i], pre[i], rho[i], rho24[i], hex6[i], hex5[i], rhod[i], iw[i], rhodelay2[i], $5/1.0;
					utc[i]=$1/1.0;
					temp[i]=$2/1.0;
					pre[i]=$3/1.0;
					rho[i]=$4/1.0;
					rho24[i]=$5/1.0;
					hex6[i]=$6/1.0;
					hex5[i]=$7/1.0;
					rhod[i]=$8/1.0;
					iw[i]=$9/1.0;
					rhodelay2[i]=$10/1.0;
					i++}' test.dat > "$delay"
#----------------------------------------------------------------------------------------------------------------

rm test.dat