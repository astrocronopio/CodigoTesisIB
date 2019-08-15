set multiplot			#para generar varios gráficos en la misma pantalla
set size 1,0.3			#divide la pantalla en una grilla de 2x2
set origin 0.0,0.0	#establece en cual de los espacios de la grilla creada irá el plot que le sigue
set grid
plot 'SDHASData4EeV6080_rate-day.dat' u 1:5:6 w e title "E > 4 EeV"
set origin 0.0,0.3
plot 'SDHASData2EeV6080_rate-day.dat' u 1:5:6 w e title "E > 2 EeV"
set origin 0.0,0.6
plot 'SDHASData6080_rate-day.dat' u 1:5:6 w e title "All Data"
set size 1,1
set origin 0.0,0.0
unset multiplot
