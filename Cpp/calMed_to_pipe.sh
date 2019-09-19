## Script que calcula la media de la temperatura y la densidad del archivo utctprh

file_utctprh="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Sin_squared_all_energy/Herald_old_simple_modified_sector1_bins_delay.dat"					#Weather Data
#file_utctprh=$1

##
sumR=$(awk 'BEGIN {sum=0} {sum+=$4} END {print sum/NR}'  $file_utctprh) 
sumP=$(awk 'BEGIN {sum=0} {sum+=$3} END {print sum/NR}'  $file_utctprh) 
Total=$(awk 'BEGIN {counter=0} {counter=counter+1} END {print counter}'  $file_utctprh) 
initial_utc=$(head -n 1 $file_utctprh | awk '{print $1}')

echo $file_utctprh $sumR  $sumP  $Total  $initial_utc
