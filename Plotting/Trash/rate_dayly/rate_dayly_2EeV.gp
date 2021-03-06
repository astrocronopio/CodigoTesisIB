set xdata time 
set timefmt "%s"
set format x "%m/%Y"
set xtics "1104527600",47304000*1.8
set xlabel "Fecha"
set xrange [1101127600:1461346500]
set ytics 0.01
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#################################################################################################################################
#Done

set terminal png 3  size 1200,700 enhanced font 'Verdana,26'
set output  "/home/ponci/Desktop/TesisIB/Coronel/TesisIB/IB_style/clima/Graphs/rate_dayly/2EeV_ICRC_2015.png"
#set autoscale

#set autoscale	
set key right top horiz samplen 0.5
set yrange [0.01:0.08]
#set title "Tasa de Eventos media por día  2005-2015"
set ylabel "Tasa [km^{-2}día^{-1}]"  offset -0.15

plot "../../../HDD_weather/Herald_old/herald_old_above_2EeV_rate_day.dat" u 1:(2.566*$2/$4 > 0 ? 2.566*$2/$4 : 1/0 ):(sqrt($2)/$4) w e  lc rgb '#77ac30' pt 7  ps 1 t  'ICRC 2015' ,\
 	"../../../HDD_weather/Herald_old/herald_old_above_2EeV_rate_day.dat" u 1:(2.566*$3/$4)  w p lc rgb "black" lw 0.5   ps 0.5 pt 5  t  'Ajuste'




set terminal qt 3  size 1200,700 enhanced font 'Verdana,26'
replot
			
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#################################################################################################################################
set terminal png  2 size 1200,650 enhanced font 'Verdana,26'
set output  "/home/ponci/Desktop/TesisIB/Coronel/TesisIB/IB_style/clima/Graphs/rate_dayly/2EeV_ICRC_2019.png"
set key right bottom horiz	
#set yrange [0.13:]
set yrange [0.01:0.06]
#set xrange [1101127600:1561346500]
#set title "Tasa de Eventos media por día  2005-2015"
set ylabel "Tasa [km^{-2}día^{-1}]"  offset -0.15


plot "../../../HDD_weather/Herald/herald_above_2EeV_rate_day.dat" u 1:(2.566*0.5*$2/$4):(sqrt($2)/($4)) w e  lc rgb '#7e2f8e' pt 7  ps 1 t  'ICRC 2019' 
# replot "../../../HDD_weather/Herald/herald_above_2EeV_rate_day.dat" u 1:($3/($4)*2.566/2 )  w p lc rgb "black" lw 0.5   ps 0.5 pt 5  t  'Ajuste'

set terminal qt 2 size 1200,650 enhanced font 'Verdana,26'
replot

#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$

set terminal png 1  size 1200,650 enhanced font 'Verdana,26'
set output  "/home/ponci/Desktop/TesisIB/Coronel/TesisIB/IB_style/clima/Graphs/rate_dayly/2EeV_ICRC_2019_S38_S1000.png"


set title "Tasa de Eventos media por día  2005-2015"
set ylabel "Tasa [km^{-2}día^{-1}]"  offset -0.15


plot "../../../HDD_weather/Herald_S38_S1000_expected/expected_above_2EeV_rate_day.dat" u 1:((2.566*0.5*$2/$4)):(sqrt($2)/($4)) w e  lc rgb 'dark-pink' pt 7  ps 1 t  'Esperado' ,\
 "../../../HDD_weather/Herald_S38_S1000_expected/expected_above_2EeV_rate_day.dat" u 1:($3/($4)*2.566/2 )  w lp lc rgb "black" lw 0.5   ps 1 pt 5  t  'Ajuste'




set terminal qt 1 size 1200,650 enhanced font 'Verdana,26'
replot
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

pause(-1)
##############################################################################################################

