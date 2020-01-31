## Script que calcula la media de la temperatura y la densidad del archivo utctprh
## además de la cantidad de líneas del archivo

#El archivo
file_utctprh="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Herald/Herald_weather.dat"
file_old="/home/ponci/Desktop/TesisIB/Coronel/PC_Weather_paper/Herald/HeraldWeather060noBPdr6t5v3.dat"
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
#Eventos=$(awk 'BEGIN {sum=0}{ if ($1<mktime("2015 12 31 23 59 59") && $1>mktime("2004 12 31 23 59 59")) sum+=1;} END {print sum}' $file_utctprh)
##First entry in the utc column
##initial_utc=$(head -n 1 $file_utctprh | awk '{print $1}')

#sumE=$(awk 'BEGIN {sum=0; count=0;} { if ($1<mktime("2015 12 31 23 59 59") && $1>mktime("2004 12 31 23 59 59")) sum+=$3; count+=1} END {print sum/count}'  $file_utctprh) 
#sumE_old=$(awk 'BEGIN {sum=0; count=0;} { if ($3<mktime("2015 12 31 23 59 59") && $3>mktime("2004 12 31 23 59 59")&& $14<3) sum+=$10; count+=1} END {print sum/count}'  $file_old) 
#sumE_old=$(awk 'BEGIN {sum=0; count=0;} { if ($1<mktime("2015 12 31 23 59 59") && $1>mktime("2004 12 31 23 59 59")) sum+=$3; count+=1} END {print sum/count}'  $file_old) 
awk '{ if ($3<mktime("2015 12 31 23 59 59") && $3>mktime("2004 12 31 23 59 59") && $10>=1 && $14<3) print $10}'  "$file_old" > energia_2015_old.dat
#exp=$(awk 'BEGIN {sum=0} { if ($1<mktime("2018 12 31 23 59 59") && $1>mktime("2004 12 31 23 59 59")) sum+=$7*0.2;} END {print 4.59*sum}'  $file_exp)
#echo "$sumE_old"
#echo "$sumE"
#echo "$Eventos"


#echo "$exp"


#awk '{ if ($1<mktime("2018 12 31 23 59 59") && $1>mktime("2004 12 31 23 59 59")) print $3}'  "$file_utctprh" > energia_2018_new.dat
#awk '{ if ($1<mktime("2015 12 31 23 59 59") && $1>mktime("2004 12 31 23 59 59")) print $3}'  "$file_old" 	 > energia_2015_old.dat
#awk '{ if ($1<mktime("2015 12 31 23 59 59") && $1>mktime("2004 12 31 23 59 59")) print $3}'  "$file_utctprh" > energia_2015_new.dat

sumE0=$(awk 'BEGIN {sum=0;count=0;} {sum+=$1;count+=1} END {print sum/NR}'  energia_2015_old.dat) 
echo "Energia 2005-2015 por encima de 1 EeV old $sumE0"

sumE1=$(awk 'BEGIN {sum=0;count=0;} {sum+=$1;count+=1} END {print sum/NR}'  energia_2015_new.dat) 
echo "Energia 2005-2015 por encima de 1 EeV new $sumE1"

sumE2=$(awk 'BEGIN {sum=0;count=0;} {sum+=$1;count+=1} END {print sum/count}'  energia_2018_new.dat) 
echo "Energia 2005-2018 por encima de 1 EeV new $sumE2"


#2005-2009    0.99999
#2005-2012	  1.0662
#2012-2015	  1.10533
#2015-2018	  1.13704

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


