set xdata time 
set timefmt "%s"
set format x "%m/%Y"
set xtics "1372680068",0.73*47304000
set xlabel "Fecha"
#set xrange [1372680068:1577880000]


#filename="/home/ponci/Desktop/TesisIB/Coronel/CodigoTesisIB/Weather_code/AllTriggers/2019/weather_analysis/AllTriggers_S38_over_1EeV_rate.dat" 

#############P R E F A C T O R E S
#2.566 tiene en cuenta que los hexagonos está por 5 y los km2 por hexagono

set key left top horiz samplen 0.5
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#################################################################################################################################
set terminal qt 3  size 1100,750 enhanced font 'Times,26'
#set output  "/home/ponci/Desktop/TesisIB/Coronel/TesisIB/IB_style/Anisotropia/daily_rate_AllTriggers_oscar_1EeV.png"
	
#set yrange [0.0:0.12]
#set title "Tasa de Eventos media por día  Oscar"
set ylabel "Tasa [km^{-2}día^{-1}]"  offset -0.15

# plot filename u 1:(  $2/($4*1.949) < 6 ? $2/($4*1.949) : 1/0 ):(sqrt($2)/($4)) w e  lc rgb 'blue' pt 7  ps 1 t  'Datos' ,\
# 	 filename u 1:( $3/($4*1.949))  w p lc rgb "black" lw 0.5   ps 0.5 pt 5  t  'Ajuste'

plot filename u 1:(2.566*$2/($4)):(2.566*sqrt($2)/($4)) w e  lc rgb 'blue' pt 7  ps 1 t  'Datos' ,\
	 filename u 1:(2.566*$3/($4))  w p lc rgb "black" lw 0.5   ps 0.5 pt 5  t  'Ajuste'

pause(-1)