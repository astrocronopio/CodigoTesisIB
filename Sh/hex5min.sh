## Script con el procedimiento usado para generar archivo utctprh
##
#zcat HexagonsMn*.out.gz | awk 'BEGIN{n=0 ; m6t5=0; m5t5=0}{n++ ;m6t5=m6t5+$2 ;m5t5=m5t5+$3;  if(n == 5){ print $1+30+315964800 , m6t5 ,m5t5; m6t5=0 ; m5t5=0; n=0}} ' > utchex5min
zcat HexagonsMn*.out.gz | awk 'BEGIN{n=0 ; m6t5=0; m5t5=0}{n++ ;m6t5=m6t5+$2 ;m5t5=m5t5+$3;  if(n == 5){ print $1+30+315964800 , m6t5 ,m5t5; m6t5=0 ; m5t5=0; n=0}} ' > utchex5min
# merge file with weather data before start of CLF (from LL) with later one
cat wllbclf.dat wclf_CLF_withLL_filled.dat > weather.dat
# fill holes in weather and include hexagons 
# ojo que el badPeriods.txt no tenga lineas en blanco extras al final
f77 -o utctprh utctprh.f
./utctprh
# writes iutc,ti(i),p,rho(i),rhoav,xnhex,xnhex5,iw,igood
