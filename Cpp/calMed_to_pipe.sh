## Script que calcula la media de la temperatura y la densidad del archivo utctprh

file_utctprh="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector3merged.dat"				#Weather Data
#file_utctprh=$1

##
sumR=$(awk 'BEGIN {sum=0} {sum+=$4} END {print sum/NR}'  $file_utctprh) 
sumP=$(awk 'BEGIN {sum=0} {sum+=$3} END {print sum/NR}'  $file_utctprh) 
Total=$(awk 'BEGIN {counter=0} {counter=counter+1} END {print counter}'  $file_utctprh) 
initial_utc=$(head -n 1 $file_utctprh | awk '{print $1}')

echo $file_utctprh $sumR  $sumP  $Total  $initial_utc
