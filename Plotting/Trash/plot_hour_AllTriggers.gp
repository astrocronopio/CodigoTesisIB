#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$	#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$	#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
##################################	##################################

set terminal qt 3  size 1200,750 enhanced font 'Verdana,26'

#filename="/home/ponci/Desktop/TesisIB/Coronel/CodigoTesisIB/Weather_code/AllTriggers/2019/weather_analysis/AllTriggers_S38_over_1EeV_hour_of_the_day.dat" 
filename="/home/ponci/Desktop/TesisIB/Coronel/CodigoTesisIB/Weather_code/AllTriggers/2019/weather_analysis/AllTriggers_1EeV_hour_of_the_day.dat" 

set autoscale
set key right bottom
unset title
set xtics 2; set xtics format '%h'

set lmargin at screen 0.20
set rmargin at screen 0.95

TOP= 0.98
DY = 0.29

set ytics 0.001

set multiplot
set offset 0,0,graph 0.05, graph 0.05
set xrange [-1:24]
set xlabel "Hora del día (GMT)"
set ylabel 'Residual' offset 1.2
set tmargin at screen TOP-2*DY
set bmargin at screen TOP-3*DY +0.06

plot filename  u 0:(($2-$1)*0.25/($3*224)) lc rgb 'blue' pt 7  ps 2 t  ''
replot 0 lw 2 dt 2 lc rgb  'black' t ''

##################################################
set xtics format ''
unset xlabel
#set ylabel 'ylabel 2' offset 0
set tmargin at screen TOP-0.1
set bmargin at screen TOP-2*DY +0.01

set autoscale
set yrange [0.2437:]
set title "Tasa de Eventos media por día"
set ylabel "Tasa [km^{-2}día^{-1}]"  offset -0.15
set xrange [-1:24]
set ytics 0.003
plot filename  u 0:($2*0.25/($3*224)):(sqrt($2)*0.25/($3*224)) w e  lc rgb 'blue' pt 7  ps 2 t  'Datos' ,\
 	 filename  u 0:($1*0.25/($3*224))  w lp lc rgb "black" lw 1.2  ps 0.8 pt 5  t  'Ajuste'


unset multiplot
