set xdata time 
set timefmt "%s"
set format x "%m/%Y"
set xtics "1372680068",47304000*.5
set xlabel "Fecha"
set xrange [1372680068:1498521517 ]


#############P R E F A C T O R E S

set key left bottom horiz samplen 0.5
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#################################################################################################################################
set terminal png 3  size 1200,650 enhanced font 'Verdana,26'
set output  "/home/ponci/Desktop/TesisIB/Coronel/TesisIB/IB_style/Anisotropia/daily_rate_AllTriggers_oscar_1EeV.png"
	
set yrange [0.12:0.35]
set title "Tasa de Eventos media por día  Oscar"
set ylabel "Tasa [km^{-2}día^{-1}]"  offset -0.15


plot "../../../weather_code/AllTriggers/AllTriggers_1EeV_weather_nobp_rate_day.dat" u 1:(0.25>($2/$4) && ($2/$4) > 0.11 ? $2/($4)*2.566/2  :1/0 ):(sqrt($2)/($4)) w e  lc rgb 'blue' pt 7  ps 1 t  'Datos' ,\
 "../../../weather_code/AllTriggers/AllTriggers_1EeV_weather_nobp_rate_day.dat" u 1:(2.566*$3/($4*2) -0.0)  w p lc rgb "black" lw 0.5   ps 0.5 pt 5  t  'Ajuste'




set terminal qt 3 size 1200,650 enhanced font 'Verdana,26'
replot



#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#################################################################################################################################
set terminal png 4  size 1200,650 enhanced font 'Verdana,26'
set output  "/home/ponci/Desktop/TesisIB/Coronel/TesisIB/IB_style/Anisotropia/daily_rate_AllTriggers_herald_1EeV.png"

set yrange [0.12:0.35]
set title "Tasa de Eventos media por día  Herald"
set ylabel "Tasa [km^{-2}día^{-1}]"  offset -0.15


plot "../../../weather_code/AllTriggers/AllTriggers_1EeV_herald_weather_nobp_rate_day.dat" u 1:(0.21>($2/$4) && ($2/$4) >0.0 ? $2/($4)*2.566/2  :1/0 ):(sqrt($2)/($4)) w e  lc rgb 'dark-pink' pt 7  ps 1 t  'Datos' #,\
#"../../../weather_code/AllTriggers/AllTriggers_1EeV_herald_weather_nobp_rate_day.dat" u 1:($3/($4)*2.566/2 )  w lp lc rgb "black" lw 0.5   ps 0.5 pt 5  t  'Ajuste'


set terminal qt 4 size 1200,650 enhanced font 'Verdana,26'
replot

pause(-1)