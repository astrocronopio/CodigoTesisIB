
file_name="../../AllTriggers/S38_analisis/2019/AllTriggers_S38_over_1EeV_2019.dat"
tail  $file_name
sumE0=$(awk 'BEGIN {sum=0;count=0;} {if ($1>1388577600 && $1<1577880000) sum+=$7;count+=1} END {print sum/count}'  $file_name) 
lines=$(awk 'BEGIN {sum=0;count=0;} {if ($1>1388577600 && $1<1577880000) sum+=$7;count+=1} END {print count}'  $file_name) 
echo "Energia Media $sumE0, $lines " 
