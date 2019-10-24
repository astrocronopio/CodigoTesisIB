## Script que calcula la media de la temperatura y la densidad del archivo utctprh

#file_utctprh="/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh.dat" 						#Weather Data
file_utctprh="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/All_data/herald_old_delay.dat"

##
sumR=$(awk 'BEGIN {sum=0} {sum+=$4} END {print sum/NR}'  $file_utctprh) 
sumP=$(awk 'BEGIN {sum=0} {sum+=$3} END {print sum/NR}'  $file_utctprh) 
Total=$(awk 'BEGIN {counter=0} {counter=counter+1} END {print counter}'  $file_utctprh) 
initial_utc=$(head -n 1 $file_utctprh | awk '{print $1}')

#awk '{print $7,$5/'$sum',$6/'$sum' }' utctprh-date.dat > utctprh-dateNorm.dat
#awk '{print '$sumT','$sumR', 'Total' }' "$file_utctprh" > tmp.dat
#echo $initial_utc
printf $file_utctprh"\nRho="$sumR"\nPressure="$sumP"\nTotal:"$Total"\nInitial Time:"$initial_utc > tmp.dat
