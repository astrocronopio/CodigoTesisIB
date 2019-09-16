#Weather Data
file_utctprh_bins="/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh-bins-python.dat" 	#Weather Data in bins of a hour
file_utctprh_avg_bins="/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprhcavg-binsh.dat" 	#Weather Data of the average every hour

#----- OPCIONAL: for delay the density 2 hrs--------
file_delay="/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh-binsdelayrho.dat" 			#Weather Data delayed by two hours

filepath_sin_square="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/"
filename_sin_square="Herald_simple_modified_sector5_bins"

file_sin_square="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/""$filename_sin_square"".dat"

#Elegir una fecha
awk_time=$(cat << 'EOF'
	{ desde_este_dia="2005 01 01 00 00 00";
	  hasta_este_dia="2011 12 31 23 59 59";

	  desde_dia_utc=mktime(desde_este_dia);
	  hasta_dia_utc=mktime(hasta_este_dia);

	  if ($1<hasta_dia_utc && $1>desde_dia_utc) print $0 }
EOF
)
	awk "$awk_time" "$file_utctprh_bins" 	> "$file_utctprh_bins""trash"
	awk "$awk_time" "$file_delay"		 	> "$file_delay""trash"


generate_file () {
	awk '{if ($9>1500) print $0 }' $1 > aux.dat
	awk '{print $4,$2,$6,$7,$8,$9}'	aux.dat > $2
	rm aux.dat && rm $1
}


sin_square_analisis(){
	awk "$awk_time" $1	> $1"trash"
	paste $1"trash"  	"$file_utctprh_bins""trash" 	> join_herald_utctprh.dat
	paste $1"trash"  	"$file_delay""trash"			> join_herald_delay.dat	
	rm $1"trash"

	#---------------------------------------------------
}

sin_square_analisis "$file_sin_square"

filepath_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Sin_squared/"

herald_utctprh="$filepath_merged""$filename_sin_square""_utctprh.dat"
herald_delay="$filepath_merged""$filename_sin_square""_delay.dat"

generate_file join_herald_utctprh.dat "$herald_utctprh"
generate_file join_herald_delay.dat "$herald_delay"	

rm "$file_utctprh_bins""trash"
rm "$file_delay""trash"