 Same as before but for the weather and hexagons data
#Original 					Weather histogram		Weather Avg Histogram per hour
#'utctprh.dat'  creates  'utctprhdr-bins.dat' and 'utctprhcavg-binsh.dat'

file_utctprh="/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh.dat" 						#Weather Data
file_utctprh_bins="/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh-bins-python.dat" 	#Weather Data in bins of a hour
file_utctprh_avg_bins="/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprhcavg-binsh.dat" 	#Weather Data of the average every hour

	python average_utctprh_bins.py "$file_utctprh" "$file_utctprh_bins" "$file_utctprh_avg_bins"

#----- OPCIONAL: for delay the density 2 hrs--------

file_delay="/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh-binsdelayrho.dat" 			#Weather Data delayed by two hours

	awk 'BEGIN
			{i=1}
			{	if(i>2)i=1;
				if(NR>2) print $1,t[i],$3,rho[i],$5,$6;
				t[i]=$2;
				rho[i]=$4;
				i++}' "$file_utctprh_bins"  > "$file_delay" 
#---------------------------------------------------

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
	awk "$awk_time" "$file_events"		 	> "$file_events""trash"
	awk "$awk_time" "$file_events_old"	 	> "$file_events_old""trash"
	awk "$awk_time" "$file_delay"		 	> "$file_delay""trash"

#---------------------------------------------------
# join the event data with the corresponding weather and hexagon one.
# Remember change the file according to your needs (delayed or current rho)
	
	paste "$file_events""trash"  	"$file_utctprh_bins""trash" 	> join_herald_utctprh.dat
	paste "$file_events_old""trash"	"$file_utctprh_bins""trash" 	> join_herald_old_utctprh.dat
	paste "$file_events""trash"  	"$file_delay""trash"			> join_herald_delay.dat
	paste "$file_events_old""trash"	"$file_delay""trash" 			> join_herald_old_delay.dat

	rm "$file_utctprh_bins""trash"
	rm "$file_events""trash"
	rm "$file_events_old""trash"
	rm "$file_delay""trash"

herald_utctprh="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/All_data/herald_utctprh.dat"
herald_old_utctprh="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/All_data/herald_old_utctprh.dat"
herald_delay="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/All_data/herald_delay.dat"
herald_old_delay="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/All_data/herald_old_delay.dat"


generate_file () {
	awk '{if ($9>1500) print $0 }' $1 > aux.dat
	awk '{print $4,$2,$6,$7,$8,$9}'	aux.dat > $2
	rm aux.dat && rm $1
}

generate_file join_herald_utctprh.dat "$herald_utctprh"
generate_file join_herald_old_utctprh.dat "$herald_old_utctprh"
generate_file join_herald_delay.dat "$herald_delay"			 
generate_file join_herald_old_delay.dat "$herald_old_delay"	