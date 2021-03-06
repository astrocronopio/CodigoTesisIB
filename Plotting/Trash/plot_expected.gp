#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
set terminal qt  2 size 1000,750 enhanced font 'Verdana,26'
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
set xlabel "Hora del día (GMT)"
set ylabel "Tasa [km^{-2}día^{-1}]"  offset 1.2, 3.5
set ytics 0.001
set tmargin at screen TOP-1.7*DY
set bmargin at screen TOP-3*DY +0.06
set yrange [0.037:]
a=0.03921978
fit a "../../HDD_weather/Herald_S38_S1000_expected/expected_above_2EeV_hour_of_the_day.dat" u 0:(0.000+2.566*24*$2/($4)):(2.566*24*sqrt($2)/($4)) yerr via a 
plot "../../HDD_weather/Herald_S38_S1000_expected/expected_above_2EeV_hour_of_the_day.dat" u 0:(0.000+2.566*24*$2/($4)):(2.566*24*sqrt($2)/($4)) w e lc rgb "dark-red" pt 7  ps 2 t  'Este trabajo, {/Symbol c}^2_{/Symbol n} = 1.45',  a dt 2 lw 2 lc rgb 'black'  t ''#,\
 #"../../HDD_weather/Herald_S38_S1000_expected/expected_above_2EeV_hour_of_the_day.dat" u 0:(0.000+2.566*24*$1/($4)) w lp lc rgb "black" lw 1.2  ps 0.8 pt 5  t  ''


###########################################
set xtics format ''
unset xlabel
#set ylabel 'ylabel 2' offset 0
set tmargin at screen TOP -0.1
set bmargin at screen TOP-1.5*DY +0.01
set ytics 0.001
#set yrange [0.165:0.183]
#set title "2005-2015 (2 EeV)"
unset ylabel
set xrange [-1:24]
set yrange [0.037:]

a=0.03921978
fit a  "../../HDD_weather/Herald/herald_above_2EeV_hour_of_the_day.dat" u 0:(0.000+2.566*24*$2/($4)):(2.566*24*sqrt($2)/($4)) yerr via a
plot "../../HDD_weather/Herald/herald_above_2EeV_hour_of_the_day.dat" u 0:(0.000+2.566*24*$2/($4)):(2.566*24*sqrt($2)/($4)) w e lc rgb "dark-green" pt 7  ps 2 t  'ICRC 2019, {/Symbol c}^2_{/Symbol n} = 1.29', a dt 2 lw 2 lc rgb 'black'  t ''#,\
 #	"../../HDD_weather/Herald/herald_above_2EeV_hour_of_the_day.dat" u 0:(0.000+2.566*24*$1/($4)) w lp lc rgb "black" lw 1.2  ps 0.8 pt 5  t  ''

unset multiplot


#set terminal qt 2 
#set multiplot
#replot
#unset multiplot

#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
set terminal qt  12 size 1000,750 enhanced font 'Verdana,26'
set output  "/home/ponci/Desktop/TesisIB/Coronel/TesisIB/IB_style/clima/Graphs/2EeV_ICRC_2019_S38_S1000_expected_05_18.png"

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
set xlabel "Hora del día (GMT)"
set ylabel "Tasa [km^{-2}día^{-1}]"  offset 1.2, 3.5
#set ytics 0.001
set tmargin at screen TOP-1.7*DY
set bmargin at screen TOP-3*DY +0.06


set yrange [0.037:]
a=0.03921978
fit a "../../HDD_weather_2019/Herald_S38_S1000_expected/expected_above_2EeV_hour_of_the_day.dat" u 0:(0.000+2.566*24*$2/($4)):(2.566*24*sqrt($2)/($4))  yerr via a
plot "../../HDD_weather_2019/Herald_S38_S1000_expected/expected_above_2EeV_hour_of_the_day.dat" u 0:(0.000+2.566*24*$2/($4)):(2.566*24*sqrt($2)/($4)) w e lc rgb "dark-red" pt 7  ps 2 t  'Este trabajo, {/Symbol c}^2_{/Symbol n} = 1.75',  a dt 2 lw 2 lc rgb 'black'  t '' #,\
 #"../../HDD_weather_2019/Herald_S38_S1000_expected/expected_above_2EeV_hour_of_the_day.dat" u 0:(0.000+2.566*24*$1/($4)) w lp lc rgb "black" lw 1.2  ps 0.8 pt 5  t  ''


###########################################
set xtics format ''
unset xlabel
#set ylabel 'ylabel 2' offset 0
set tmargin at screen TOP -0.1
set bmargin at screen TOP-1.5*DY +0.01
#set ytics 0.001
#set yrange [0.165:0.183]
#set title "2005-2018 (2 EeV)"
unset ylabel
set xrange [-1:24]

#set label  "xD" at 0.1,0.8
a=0.0388
fit a "../../HDD_weather_2019/Herald_S38_S1000_expected/expected_above_2EeV_hour_of_the_day.dat" u 0:(0.000+2.566*24*$2/($4)):(2.566*24*sqrt($2)/($4))  yerr via a
plot "../../HDD_weather_2019/Herald/herald_above_2EeV_hour_of_the_day.dat" u 0:(0.000+2.566*24*$2/($4)):(2.566*24*sqrt($2)/($4)) w e lc rgb "dark-green" pt 7  ps 2 t  'ICRC 2019, {/Symbol c}^2_{/Symbol n} = 1.31',  a-0.0005 dt 2 lw 2 lc rgb 'black'  t '' #,\
 	#"../../HDD_weather_2019/Herald/herald_above_2EeV_hour_of_the_day.dat" u 0:(0.000+2.566*24*$1/($4)) w lp lc rgb "black" lw 1.2  ps 0.8 pt 5  t  ''

unset multiplot


#set terminal qt 12 size 1000,750 enhanced font 'Verdana,26'
#set multiplot
#replot
#unset multiplot

pause(-1)