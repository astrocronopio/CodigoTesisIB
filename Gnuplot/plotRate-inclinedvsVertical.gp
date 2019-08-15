#set term pngcairo size 800,500
#set output 'plotRate-inclinedvsVertical.png'
set multiplot			#para generar varios gráficos en la misma pantalla
set size 1,0.5			#divide la pantalla en una grilla de 2x2
set origin 0.0,0.0	#establece en cual de los espacios de la grilla creada irá el plot que le sigue
set xdata time
set timefmt "%Y%m%d"
set format x "%m/%Y"
set grid
plot 'HeraldData3EeV060_rate.dat' u 7:5:6 w e title "Vertical"
set origin 0.0,0.5
plot 'SDHASData4EeV6080_rate.dat' u 7:5:6 w e title "Inclined"
set size 1,1
set origin 0.0,0.0
set xdata
set format
unset multiplot
