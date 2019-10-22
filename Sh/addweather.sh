## Script para agregar info de clima correspondiente a cada evento de un archivo.
##

# $1 	$2		$3		$4		$5		$6		$7 		$8		$9
# utc 	T 		P 		rho		rho_av	6T5 	5T5		iw		Bad Period
weather_file='/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh.dat'

#$8		$3 		$4		$12		$13		$39	
#UTC 	The		phi 	S1000 	dS1000	Energy 	
herald_file='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Herald_filter_by_energy_above_1EeV.dat'

herald_weather_files='/home/ponci/Desktop/TesisIB/Coronel/herald_weather_simple.dat'


#___For Herald_simple_modified
# the utc time is the first column, and the first time is

awk '{bin=int(($1-1072915500)/300); utc=1072915500 +300*bin; print utc,$0}' "$herald_file" > tmp.dat

join tmp.dat "$weather_file" | awk '{print $2,$3,$4,$5,$7,$8,$9,$10,$11,$12}' > "$herald_weather_files"
