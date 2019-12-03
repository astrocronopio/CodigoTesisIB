## Script que calcula la media de la temperatura y la densidad del archivo utctprh
## además de la cantidad de líneas del archivo

#El archivo
file_utctprh="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Herald/Herald_weather_noBP.dat"
file_exp="/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh.dat"
#file_utctprh=$1
#file_fit=$2

##Mean density
#sumR=$(awk 'BEGIN {sum=0} {sum+=$4} END {print sum/NR}'  $file_utctprh) 
##Mean Pressure
#sumP=$(awk 'BEGIN {sum=0} {sum+=$3} END {print sum/NR}'  $file_utctprh) 
##Number of lines
#Total=$(awk 'BEGIN {counter=0} {counter=counter+1} END {print counter}'  $file_utctprh) 
##Sum of all events
Eventos=$(awk 'BEGIN {sum=0}{ if ($1<mktime("2018 12 31 23 59 59") && $1>mktime("2004 12 31 23 59 59")) sum+=1;} END {print sum}' $file_utctprh)
##First entry in the utc column
##initial_utc=$(head -n 1 $file_utctprh | awk '{print $1}')

sumE=$(awk 'BEGIN {sum=0; count=0;} { if ($1<mktime("2018 12 31 23 59 59") && $1>mktime("2004 12 31 23 59 59")) sum+=$3; count+=1} END {print sum/count}'  $file_utctprh) 

exp=$(awk 'BEGIN {sum=0} { if ($1<mktime("2018 12 31 23 59 59") && $1>mktime("2004 12 31 23 59 59")) sum+=$7*0.2;} END {print 4.59*sum}'  $file_exp)
echo "$sumE"
echo "$Eventos"


echo "$exp"


#awk '{ if ($1<mktime("2015 12 31 23 59 59") && $1>mktime("2004 12 31 23 59 59")) print $3}'  "$file_utctprh" > energia_2015.dat
#awk '{ if ($1<mktime("2018 12 31 23 59 59") && $1>mktime("2004 12 31 23 59 59")) print $3}'  "$file_utctprh" > energia_2018.dat


sumE1=$(awk 'BEGIN {sum=0} {sum+=$1;} END {print sum/NR}'  energia_2018.dat) 
echo "$sumE1"

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


