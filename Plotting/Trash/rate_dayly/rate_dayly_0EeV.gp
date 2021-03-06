set xdata time 
set timefmt "%s"
set format x "%m/%Y"
set xtics "1104527600",47304000*1.8
set xlabel "Fecha"
set xrange [1101127600:1461346500]

set key horiz samplen 0.5
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#################################################################################################################################
set terminal png 3  size 1200,650 enhanced font 'Verdana,26'
set output  "/home/ponci/Desktop/TesisIB/Coronel/TesisIB/IB_style/clima/Graphs/rate_dayly/0EeV_ICRC_2019_S38.png"
	
set yrange [0.12:]
set title "Tasa de Eventos media por día  2005-2015"
set ylabel "Tasa [km^{-2}día^{-1}]"  offset -0.15


plot "../../../HDD_weather/Herald_S38/S38_above_0EeV_rate_day.dat" u 1:(0.155>($2/$4) && ($2/$4) >0.11 ? $2/($4)*2.566/2  :1/0 ):(sqrt($2)/($4)) w e  lc rgb 'blue' pt 7  ps 1 t  'S38' ,\
 "../../../HDD_weather/Herald_S38/S38_above_0EeV_rate_day.dat" u 1:(2.566*$3/($4*2))  w p lc rgb "black" lw 0.5   ps 0.5 pt 5  t  'Ajuste'




set terminal qt 3 size 1200,650 enhanced font 'Verdana,26'
replot


#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#################################################################################################################################
set terminal png 4  size 1200,650 enhanced font 'Verdana,26'
set output  "/home/ponci/Desktop/TesisIB/Coronel/TesisIB/IB_style/clima/Graphs/rate_dayly/0EeV_ICRC_2019_S38_w_S1000.png"

set yrange [0.13:]
set title "Tasa de Eventos media por día  2005-2015"
set ylabel "Tasa [km^{-2}día^{-1}]"  offset -0.15


plot "../../../HDD_weather/Herald_S38_w_S1000/S38_w_S1000_above_0EeV_rate_day.dat" u 1:(0.155>($2/$4) && ($2/$4) >0.11 ? $2/($4)*2.566/2  :1/0 ):(sqrt($2)/($4)) w e  lc rgb 'dark-pink' pt 7  ps 1 t  'S38_w' ,\
"../../../HDD_weather/Herald_S38_w_S1000/S38_w_S1000_above_0EeV_rate_day.dat" u 1:($3/($4)*2.566/2 )  w lp lc rgb "black" lw 0.5   ps 0.5 pt 5  t  'Ajuste'


set terminal qt 4 size 1200,650 enhanced font 'Verdana,26'
replot

pause(-1)


##############################################################################################################

