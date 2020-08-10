set terminal png  1 size 1200,750 enhanced font 'Verdana,26'
set output  "/home/ponci/Desktop/TesisIB/Coronel/TesisIB/IB_style/clima/Graphs/rate_hour_of_the_day/2EeV_ICRC_2015_old_herald.png"

set autoscale
set key left top

set xtics 2; set xtics format '%h'

set lmargin at screen 0.20
set rmargin at screen 0.95

TOP= 0.98
DY = 0.29
set ytics 0.0015

set yrange [-0.003:0.0025]

set multiplot
set offset 0,0,graph 0.05, graph 0.05
set xrange [-1:24]
set xlabel "Hora del día (GMT)"
set ylabel 'Residual' offset 1.2
set tmargin at screen TOP-2*DY
set bmargin at screen TOP-3*DY +0.06

plot "../../../HDD_weather/Herald_old/herald_old_above_2EeV_hour_of_the_day.dat" u 0:(2.566*24*($2-$1)/($4)) lc rgb '#77ac30' pt 7  ps 2 t  '' 
replot 0 lw 2 dt 2 lc rgb  'black' t ''

###########################################
set xtics format ''
unset xlabel
#set ylabel 'ylabel 2' offset 0
set tmargin at screen TOP -0.1
set bmargin at screen TOP-2*DY +0.01
set ytics 0.001
set autoscale
#set yrange [0.0415:0.0459]
#set title "Tasa de Eventos media por día  2005-2015 (2EeV)"
set ylabel "Tasa [km^{-2}día^{-1}]"  offset -0.15
set xrange [-1:24]

plot "../../../HDD_weather/Herald_old/herald_old_above_2EeV_hour_of_the_day.dat" u 0:(0.00+2.566*24*$2/($4)):(2.566*24*sqrt($2)/($4)) w e lc rgb '#77ac30' pt 7  ps 2 t  'ICRC 2015'
replot "../../../HDD_weather/Herald_old/herald_old_above_2EeV_hour_of_the_day.dat" u 0:(0.00+2.566*24*$1/($4)) w lp lc rgb "black" lw 1.2  ps 0.8 pt 5  t  'Ajuste'

unset multiplot


set terminal qt 1 size 1200,750 enhanced font 'Verdana,26'
set multiplot
replot
unset multiplot


#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

#################################################################################################################################
set terminal png  2 size 1200,750 enhanced font 'Verdana,26'
set output  "/home/ponci/Desktop/TesisIB/Coronel/TesisIB/IB_style/clima/Graphs/rate_hour_of_the_day/2EeV_ICRC_2019_herald.png"
unset title
set autoscale
set key right top

set xtics 2; set xtics format '%h'

set lmargin at screen 0.20
set rmargin at screen 0.95

TOP= 0.98
DY = 0.29
set ytics 0.0015

set yrange [-0.003:0.0025]

set multiplot
set offset 0,0,graph 0.05, graph 0.05
set xrange [-1:24]
set xlabel "Hora del día (GMT)"
set ylabel 'Residual' offset 1.2
set tmargin at screen TOP-2*DY
set bmargin at screen TOP-3*DY +0.06

plot "../../../HDD_weather/Herald/herald_above_2EeV_hour_of_the_day.dat" u 0:(2.566*24*($2-$1)/($4)) pt 7  ps 2 t  ''
replot 0 lw 2 dt 2 lc rgb  'black' t ''

##############################################
set xtics format ''
unset xlabel
#set ylabel 'ylabel 2' offset 0
set tmargin at screen TOP -0.1
set bmargin at screen TOP-2*DY +0.01
set ytics 0.001
#set yrange [0.037:0.041]
set autoscale
#set title "Tasa de Eventos media por día  2005-2015 (2EeV)"
set ylabel "Tasa [km^{-2}día^{-1}]"  offset 0.9
set xrange [-1:24]

plot "../../../HDD_weather/Herald/herald_above_2EeV_hour_of_the_day.dat" u 0:(0.00+2.566*24*$2/($4)):(2.566*24*sqrt($2)/($4)) w e  pt 7  ps 2 t  'ICRC 2019'
replot "../../../HDD_weather/Herald/herald_above_2EeV_hour_of_the_day.dat" u 0:(0.00+2.566*24*$1/($4))  w lp lc rgb "black" lw 1.2  ps 0.8 pt 5  t  'Ajuste'

unset multiplot

set terminal qt 2 size 1200,750 enhanced font 'Verdana,26'
set multiplot
replot
unset multiplot

#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
pause(-1)
##############################################################################################################

