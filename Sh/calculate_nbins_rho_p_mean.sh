## Script que calcula la media de la temperatura y la densidad del archivo utctprh
## además de la cantidad de líneas del archivo

#El archivo
file_utctprh="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Another_way_around/Energy_above_1EeV/Sin_2/New/Herald__sector_1_weather.dat"

#Mean density
sumR=$(awk 'BEGIN {sum=0} {sum+=$4} END {print sum/NR}'  $file_utctprh) 
#Mean Pressure
sumP=$(awk 'BEGIN {sum=0} {sum+=$3} END {print sum/NR}'  $file_utctprh) 
#Number of lines
Total=$(awk 'BEGIN {counter=0} {counter=counter+1} END {print counter}'  $file_utctprh) 
#Sum of all events
Eventos=$(awk 'BEGIN {sum=0}{sum+=$2} END {print sum}' $file_utctprh)
#First entry in the utc column
initial_utc=$(head -n 1 $file_utctprh | awk '{print $1}')


#This format is for the MLE.c archive, which fits the parameters
echo
echo "const Double_t rho0 = "$sumR";" 
echo "const Double_t P0 ="$sumP";" 
echo

echo "////////////////////////////////////////////"
echo "const int nbins = "$Total";"
echo "const int initial_time= "$initial_utc";"

echo "const char* filename= \""$file_utctprh"\";" 
echo "////////////////////////////////////////////"
echo
echo

