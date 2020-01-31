file_utctprh="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Herald/Herald_weather_noBP.dat"
file_old="/home/ponci/Desktop/TesisIB/Coronel/PC_Weather_paper/Herald/HeraldWeather060noBPdr6t5v3.dat"


#awk '{ if ($3<mktime("2015 12 31 23 59 59") && $3>mktime("2004 12 31 23 59 59") && $10>=1 && $14<3) print $10}'  "$file_old" > energia_2015_old.dat
#awk '{ if ($1<mktime("2018 12 31 23 59 59") && $1>mktime("2004 12 31 23 59 59")) print $3}'  "$file_utctprh" > energia_2018_new.dat
#awk '{ if ($1<mktime("2015 12 31 23 59 59") && $1>mktime("2004 12 31 23 59 59")) print $3}'  "$file_utctprh" > energia_2015_new.dat

sumE0=$(awk 'BEGIN {sum=0;count=0;} {sum+=$1;count+=1} END {print sum/NR}'  energia_2015_old.dat) 
echo "Energia 2005-2015 por encima de 1 EeV ICRC 2015 $sumE0"

sumE1=$(awk 'BEGIN {sum=0;count=0;} {sum+=$1;count+=1} END {print sum/NR}'  energia_2015_new.dat) 
echo "Energia 2005-2015 por encima de 1 EeV ICRC 2019 $sumE1"

sumE2=$(awk 'BEGIN {sum=0;count=0;} {sum+=$1;count+=1} END {print sum/count}'  energia_2018_new.dat) 
echo "Energia 2005-2018 por encima de 1 EeV ICRC 2019 $sumE2"


file_S38="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Herald_S38/Herald_S38_weather_noBP.dat"

awk '{ if ($1<mktime("2018 12 31 23 59 59") && $1>mktime("2004 12 31 23 59 59")) print $3}'  "$file_S38" > energia_2018_s38_new.dat
awk '{ if ($1<mktime("2015 12 31 23 59 59") && $1>mktime("2004 12 31 23 59 59")) print $3}'  "$file_S38" > energia_2015_s38_new.dat

sumE3=$(awk 'BEGIN {sum=0;count=0;} {sum+=$1;count+=1} END {print sum/NR}'  energia_2015_s38_new.dat) 
echo "Energia 2005-2015 por encima de 5.37 VEM  ICRC 2019 $sumE3"

sumE4=$(awk 'BEGIN {sum=0;count=0;} {sum+=$1;count+=1} END {print sum/count}'  energia_2018_s38_new.dat) 
echo "Energia 2005-2018 por encima de 5.37 VEM  ICRC 2019 $sumE4"