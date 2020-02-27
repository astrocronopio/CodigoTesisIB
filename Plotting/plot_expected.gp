
set terminal png  1 size 1200,750 enhanced font 'Verdana,26'
set output  "/home/ponci/Desktop/TesisIB/Coronel/TesisIB/IB_style/clima/Graphs/1EeV_ICRC_2019_S38_S1000.png"

set autoscale
set key right bottom

set xtics 2

set lmargin at screen 0.20
set rmargin at screen 0.95

TOP= 0.98
DY = 0.29
#set ytics 0.001

#set yrange [-0.003:0.0025]

set multiplot
set offset 0,0,graph 0.05, graph 0.05
set xrange [-1:24]
set xlabel "Hora del día (Hora Local)"
set ylabel "Tasa [km^{-2}día^{-1}]"  offset 0, 1.999
set ytics 0.003
set tmargin at screen TOP-1.7*DY
set bmargin at screen TOP-3*DY +0.06

plot "../HDD_weather/Herald_S38_S1000_expected/expected_above_1EeV_hour_of_the_day.dat" u 0:(2.566*24*$2/($4)):(2.566*24*sqrt($2)/($4)) w e lc rgb "dark-red" pt 7  ps 2 t  '',\
	 "../HDD_weather/Herald_S38_S1000_expected/expected_above_1EeV_hour_of_the_day.dat" u 0:(2.566*24*$1/($4)) w lp lc rgb "black" lw 1.2  ps 0.8 pt 5  t  ''


###########################################
set xtics format ''
unset xlabel
#set ylabel 'ylabel 2' offset 0
set tmargin at screen TOP -0.1
set bmargin at screen TOP-1.5*DY +0.01
set ytics 0.003
#set yrange [0.165:0.183]
set title "Tasa de Eventos media por día  2005-2015 (1 EeV)"
unset ylabel
set xrange [-1:24]

plot "../HDD_weather/Herald_S38_w_S1000/S38_w_S1000_above_1EeV_hour_of_the_day.dat" u 0:(2.566*24*$2/($4)):(2.566*24*sqrt($2)/($4)) w e lc rgb "dark-green" pt 7  ps 2 t  'ICRC 2019',\
 	 "../HDD_weather/Herald_S38_w_S1000/S38_w_S1000_above_1EeV_hour_of_the_day.dat" u 0:(-0.001+2.566*24*$1/($4)) w lp lc rgb "black" lw 1.2  ps 0.8 pt 5  t  ''

unset multiplot


set terminal qt 1 
set multiplot
replot
unset multiplot

#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
set terminal png  2 size 1200,750 enhanced font 'Verdana,26'
set output  "/home/ponci/Desktop/TesisIB/Coronel/TesisIB/IB_style/clima/Graphs/2EeV_ICRC_2019_S38_S1000_expected.png"

set autoscale
set key right bottom

set xtics format '%h'
set xtics 2

set lmargin at screen 0.20
set rmargin at screen 0.95

TOP= 0.98
DY = 0.29
#set ytics 0.003

#set yrange [-0.003:0.0025]
unset title	
set multiplot
set offset 0,0,graph 0.05, graph 0.05
set xrange [-1:24]
set xlabel "Hora del día (Hora Local)"
set ylabel "Tasa [km^{-2}día^{-1}]"  offset 0, 1.999
set ytics 0.001
set tmargin at screen TOP-1.7*DY
set bmargin at screen TOP-3*DY +0.06

plot "../HDD_weather/Herald_S38_S1000_expected/expected_above_2EeV_hour_of_the_day.dat" u 0:(0.004+2.566*24*$2/($4)):(2.566*24*sqrt($2)/($4)) w e lc rgb "dark-red" pt 7  ps 2 t  '',\
 "../HDD_weather/Herald_S38_S1000_expected/expected_above_2EeV_hour_of_the_day.dat" u 0:(0.004+2.566*24*$1/($4)) w lp lc rgb "black" lw 1.2  ps 0.8 pt 5  t  ''


###########################################
set xtics format ''
unset xlabel
#set ylabel 'ylabel 2' offset 0
set tmargin at screen TOP -0.1
set bmargin at screen TOP-1.5*DY +0.01
set ytics 0.001
#set yrange [0.165:0.183]
set title "Tasa de Eventos media por día  2005-2015 (2 EeV)"
unset ylabel
set xrange [-1:24]

plot "../HDD_weather/Herald/herald_above_2EeV_hour_of_the_day.dat" u 0:(0.004+2.566*24*$2/($4)):(2.566*24*sqrt($2)/($4)) w e lc rgb "dark-green" pt 7  ps 2 t  'ICRC 2019',\
 	"../HDD_weather/Herald/herald_above_2EeV_hour_of_the_day.dat" u 0:(0.004+2.566*24*$1/($4)) w lp lc rgb "black" lw 1.2  ps 0.8 pt 5  t  ''

unset multiplot


set terminal qt 2 
set multiplot
replot
unset multiplot


#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

set terminal png 3 size 1200,750 enhanced font 'Verdana,26'
set output  "/home/ponci/Desktop/TesisIB/Coronel/TesisIB/IB_style/clima/Graphs/0EeV_ICRC_2019_S38_S1000_expected.png"

set autoscale
set key right bottom

set xtics 2
set xtics format '%h'

set lmargin at screen 0.20
set rmargin at screen 0.95

TOP= 0.98
DY = 0.29
#set ytics 0.001

#set yrange [-0.003:0.0025]
unset title	
set multiplot
set offset 0,0,graph 0.05, graph 0.05
set xrange [-1:24]
set xlabel "Hora del día (Hora Local)"
set ylabel "Tasa [km^{-2}día^{-1}]"  offset 0, 1.999
set ytics 0.003
set tmargin at screen TOP-1.7*DY
set bmargin at screen TOP-3*DY +0.1

plot "../HDD_weather/Herald_S38_S1000_expected/expected_above_0EeV_hour_of_the_day.dat" u 0:(0+2.566*24*$2/($4)):(2.566*24*sqrt($2)/($4)) w e lc rgb "dark-red" pt 7  ps 2 t  '',\
 "../HDD_weather/Herald_S38_S1000_expected/expected_above_0EeV_hour_of_the_day.dat" u 0:(0+2.566*24*$1/($4)) w lp lc rgb "black" lw 1.2  ps 0.8 pt 5  t  ''


###########################################
set xtics format ''
unset xlabel
#set ylabel 'ylabel 2' offset 0
set tmargin at screen TOP -0.1
set bmargin at screen TOP-1.5*DY +0.01
set ytics 0.003
#set yrange [0.165:0.183]
set title "Tasa de Eventos media por día  2005-2015 (S38)"
unset ylabel
set xrange [-1:24]

plot "../HDD_weather/Herald_S38_S1000/S38_S1000_above_0EeV_hour_of_the_day.dat" u 0:(2.566*24*$2/($4)):(2.566*24*sqrt($2)/($4)) w e lc rgb "dark-green" pt 7  ps 2 t  'ICRC 2019-S38',\
 "../HDD_weather/Herald_S38_S1000/S38_S1000_above_0EeV_hour_of_the_day.dat" u 0:(2.566*24*$1/($4)) w lp lc rgb "black" lw 1.2  ps 0.8 pt 5  t  ''

unset multiplot


set terminal qt 3
set multiplot
replot
unset multiplot


pause(-1)