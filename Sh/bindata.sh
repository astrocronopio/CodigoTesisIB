## Script que en el antiguo método se usaba para rebinear de bines de 1 hora a bines de 1 día.
##
#awk 'BEGIN{i=0; n=0 ; ne=0; dne=0}{i++ ;ne+=$2/$5 ;n+=$3/$5; dne+=$4/$5;  if(i == 24){ print $6, ne/i, n/i, dne/i; n=0 ; ne=0; dne=0; i=0}}' fitmod.dat > fitmodday1.dat
#awk 'BEGIN{i=0; n=0 ; ne=0; dne=0}{i++ ;ne+=$2 ;n+=$3; h6+=$5;  if(i == 24){ print $6, ne/h6, n/h6,sqrt(n)/h6; n=0 ; ne=0; h6=0; i=0}}' fitmodno.dat > fitmodnod.dat
#awk 'BEGIN{i=0; n=0 ; ne=0; dne=0}{i++ ;ne+=$2 ;n+=$3; dne+=$4;  if(i == 720){ print $1, ne/i, n/i, dne/i; n=0 ; ne=0; dne=0; i=0}}' fitmod2.dat > fitmodmonth2.dat
#awk 'BEGIN{i=0; n=0 ; ne=0; dne=0}{i++ ;n+=$2; h6+=$6;  if(i == 24){if(h6!=0) print $1, n/h6,sqrt(n)/h6; n=0; h6=0; i=0}}' HeraldData060weathernooutliers.dat > HeraldData060weathernooutliersd.dat
#awk 'BEGIN{bin=0;pbin=0; n=0 ; ne=0; dne=0}{bin=int(($1-1104537600)/(3600*24));if(bin != pbin){ print t, ne/h6, n/h6,sqrt(n)/h6; n=0 ; ne=0; h6=0};t=$6;ne+=$2 ;n+=$3; h6+=$5;pbin=bin}' fitmod.dat > fitmodd.dat
#awk 'BEGIN{bin=0;pbin=0; n=0 ; ne=0; dne=0}{bin=int(($1-1072915500)/(3600*24));if(bin != pbin && h6!=0){ print t , n/h6,sqrt(n)/h6; n=0 ; h6=0};t=($1-1072915500)/(3600*24);n+=$2; h6+=$6;pbin=bin}END{print t , n/h6,sqrt(n)/h6}' HeraldICRCweather060a1-bin2.dat > HeraldICRCweather060a1-bin2d.dat
#awk 'BEGIN{bin=0;pbin=0; n=0 ; ne=0; dne=0}{bin=int(($1-1072915500)/(3600*24));if(bin != pbin && h6!=0){ print t , n/h6,sqrt(n)/h6; n=0 ; h6=0};t=1072915500+(bin+0.5)*3600*24;n+=$2; h6+=$6;pbin=bin}END{print t , n/h6,sqrt(n)/h6}' HeraldData060weatherdrno.dat > HeraldData060weatherdrnod.dat

#awk 'BEGIN{bin=0;pbin=0; n=0 ; ne=0; n0=0}{bin=int(($1-1104537600)/(3600*24));if(bin != pbin){if(n0>12)print t,n,ne,h6/24; n=0 ; h6=0; ne=0;n0=0};t=1104537600+(bin+0.5)*3600*24;n+=$3;ne+=$2; h6+=$5;n0++;pbin=bin}END{print t,n,ne,h6/24}' outfile2.dat > fitmodd_test.dat
awk 'BEGIN{bin=0;pbin=0; n=0 ; ne=0; n0=0}{bin=int(($1-1072915200)/(3600*24));if(bin != pbin){if(n0>12)print t,n,h6/24; n=0 ; h6=0;n0=0};t=1072915200+(bin+0.5)*3600*24;n+=$2; h6+=$3;if($3!=0)n0++;pbin=bin}END{print t,n,h6/24}' Herald060noBPa1-bin_wca1.dat > Herald060noBPa1-bind_wca1v2.dat
