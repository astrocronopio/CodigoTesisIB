## Script que calcula la media de la temperatura y la densidad del archivo utctprh
## además de la cantidad de líneas del archivo

#El archivo
file_utctprh="/home/ponci/Desktop/TesisIB/Coronel/PC_Weather_paper/Herald/HeraldWeather060noBPdr6t5v3.dat"
#file_utctprh=$1
#file_fit=$2

##Mean density
#sumR=$(awk 'BEGIN {sum=0} {sum+=$4} END {print sum/NR}'  $file_utctprh) 
##Mean Pressure
#sumP=$(awk 'BEGIN {sum=0} {sum+=$3} END {print sum/NR}'  $file_utctprh) 
##Number of lines
#Total=$(awk 'BEGIN {counter=0} {counter=counter+1} END {print counter}'  $file_utctprh) 
##Sum of all events
Eventos=$(awk 'BEGIN {sum=0}{ if ($3<mktime("2018 12 31 23 59 59") && $3>mktime("2004 12 31 23 59 59")) sum+=1;} END {print sum}' $file_utctprh)
##First entry in the utc column
##initial_utc=$(head -n 1 $file_utctprh | awk '{print $1}')

sumE=$(awk 'BEGIN {sum=0} { if ($3<mktime("2018 12 31 23 59 59") && $3>mktime("2004 12 31 23 59 59")) sum+=$8;} END {print sum/NR}'  $file_utctprh) 
echo "$sumE"
echo "$Eventos"
##This format is for the MLE.c archive, which fits the parameters
#echo "
#
##include \"TMinuit.h\"
##include <stdlib.h>
##include <stdio.h>
##include <math.h>
#
#const Double_t rho0 = "$sumR";
#const Double_t P0 ="$sumP";
#
#////////////////////////////////////////////
#const int nbins = "$Total";
#const int initial_time= "$initial_utc";
#const char* filename= \""$file_utctprh"\"; 
#////////////////////////////////////////////
#
#const char* output_file=\"/$file_fit\";"  |  cat - ../Cpp/cuerpo_MLE.txt  > MLE.c
#
#root MLE.c
#


