## This scripts allows the user to select data, creates a new file with the selected data. Each line has a comment of the command. 
## All the scripts should not be use at the same time. DO NOT FORGET TO COMMENT THE FUNCTION AFTER USE

##All data is below 60 the for the weather paper, because of the effective path the CR has in the atmosphere

# $1 	$2		$3		$4		$5		$6		$7 		$8		$9			$10			$11`			$12
# utc 	T 		P 		rho		rho_av	6T5 	5T5		iw		Bad Period	Humedad		rho_hum			rho_av,hum
weather_file='/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh.dat'
weather_file_no_bp='/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh_without_badperiod_no_iw.dat'

awk '{if ($8!=4 && $9==1) print $0}' "$weather_file"  > "$weather_file_no_bp"

