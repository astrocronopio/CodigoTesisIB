file_S38="../../../HDD_weather_2019/Herald_S38/S38_above_0EeV_hour_of_the_day.dat"
output_S38="../../../TesisIB/IB_style/clima/Graphs/rate_hour_of_the_day/0EeV_ICRC_2019_S38_05_18.png"

file_S38_w_S1000="../../../HDD_weather_2019/Herald_S38_w_S1000/S38_w_S1000_above_0EeV_hour_of_the_day.dat"
output_S38_w_S1000="../../../TesisIB/IB_style/clima/Graphs/rate_hour_of_the_day/0EeV_ICRC_2019_S38_w_S1000_05_19.png"

title_png="Tasa de Eventos media por día  2005-2019" 


################################################################################################################################
set terminal png 3  size 1200,750 enhanced font 'Verdana,26'
set output  output_S38
set autoscale
set key right bottom
unset title

set lmargin at screen 0.20
set rmargin at screen 0.95

TOP= 0.98
DY = 0.29
set ytics 0.0015

set yrange [-0.003:0.0025]

set multiplot
set offset 0,0,graph 0.05, graph 0.05

set xlabel "Hora del día (GMT)"; set xrange [-1:24] ; set xtics 2; set xtics format '%h'
set ylabel 'Residual' offset 1.2
set tmargin at screen TOP-2*DY
set bmargin at screen TOP-3*DY +0.06

plot file_S38 u 0:(2.566*24*($2-$1)/($4)) lc rgb 'blue' pt 7  ps 2 t  '', 0 lw 2 dt 2 lc rgb  'black' t ''

##################################################
set xtics format ''
unset xlabel
#set ylabel 'ylabel 2' offset 0
set tmargin at screen TOP -0.1
set bmargin at screen TOP-2*DY +0.01
set ytics 0.002
set autoscale
#set yrange [0.1699:0.181]
set title title_png
set ylabel "Tasa [km^{-2}día^{-1}]"  offset -0.15
set xrange [-1:24]

plot file_S38 u 0:(2.566*24*$2/($4)):(2.566*24*sqrt($2)/($4)) w e  lc rgb 'blue' pt 7  ps 2 t  'S38' ,\
 	 file_S38 u 0:(2.566*24*$1/($4))  w lp lc rgb "black" lw 1.2  ps 0.8 pt 5  t  'Ajuste'

unset multiplot

set terminal qt 3 
set multiplot
replot
unset multiplot

pause(-1)

#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#################################################################################################################################

#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

set terminal png 5  size 1200,750 enhanced font 'Verdana,26'
set output  output_S38_w_S1000
set autoscale
set key right bottom
unset title

set lmargin at screen 0.20 ; set rmargin at screen 0.95

TOP= 0.98
DY = 0.29
set ytics 0.0015

set yrange [-0.003:0.0025]

set multiplot
set offset 0,0,graph 0.05, graph 0.05

set xlabel "Hora del día (GMT)"; set xrange [-1:24] ; set xtics 2; set xtics format '%h'
set ylabel 'Residual' offset 1.2
set tmargin at screen TOP-2*DY ; set bmargin at screen TOP-3*DY +0.06

plot file_S38_w_S1000 u 0:(2.566*24*($2-$1)/($4)) lc rgb 'dark-pink' pt 7  ps 2 t  '', 0 lw 2 dt 2 lc rgb  'black' t ''

##################################################
set xtics format ''
unset xlabel
#set ylabel 'ylabel 2' offset 0
set tmargin at screen TOP -0.1
set bmargin at screen TOP-2*DY +0.01
set ytics 0.002
set autoscale
#set yrange [0.1699:0.181]
set title title_png
set ylabel "Tasa [km^{-2}día^{-1}]"  offset -0.15


plot file_S38_w_S1000 u 0:(2.566*24*$2/($4)):(2.566*24*sqrt($2)/($4)) w e  lc rgb 'dark-pink' pt 7  ps 2 t  'S38_w' ,\
 	 file_S38_w_S1000 u 0:(2.566*24*$1/($4))  w lp lc rgb "black" lw 1.2  ps 0.8 pt 5  t  'Ajuste'


unset multiplot

set terminal qt 5 
set multiplot
replot
unset multiplot

#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$
pause(-1)
##############################################################################################################

