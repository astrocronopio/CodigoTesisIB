## Script que calcula la media de la temperatura y la densidad del archivo utctprh
##
sumT=$(awk 'BEGIN {sum=0} {sum+=$2} END {print sum/NR}' utctprhcavg-bins.dat) 
sumR=$(awk 'BEGIN {sum=0} {sum+=$4} END {print sum/NR}' utctprhcavg-bins.dat) 
#awk '{print $7,$5/'$sum',$6/'$sum' }' utctprh-date.dat > utctprh-dateNorm.dat
awk '{print $1,$2/'$sumT',$4/'$sumR' }' utctprhcavg-bins.dat > tmp.dat

