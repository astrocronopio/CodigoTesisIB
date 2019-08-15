## Scripts varios para seleccionar datos de acuerdo a algún criterio.
##
#awk '{if ($1>1104537601 && $1<1220227200) print $0}' HeraldData060_bins.dat > HeraldData060_bins2008.dat
#awk '{pi=atan2(0, -1);if(1/cos($1*pi/180)>1.0 && 1/cos($1*pi/180)<=1.2 ) print $0}' HeraldData1EeV060noiw4.dat > HeraldData1EeVsec1.dat
#awk '{if ($1>1104537601) print $0}' HeraldData1EeV060noiw4_bins.dat > HeraldData1EeV060noiw4_binsgt2004.dat
#awk '{pi=atan2(0, -1);binid=(1/cos($1*pi/180)-1)/0.2; print $0,int(binid)}' HeraldData060noiw4.dat > HeraldDatasecnoiw4.dat
awk '{if ($4>3.0) print}' HeraldData060noiw4.dat > HeraldData3EeV060noiw4.dat
