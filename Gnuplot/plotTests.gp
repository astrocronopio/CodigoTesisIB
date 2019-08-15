set multiplot			#para generar varios gráficos en la misma pantalla
set size 1,0.3			#divide la pantalla en una grilla de 2x1
set grid
N=24*60/1.949
set title ''
set origin 0,0
set xlabel 'UTC'
set ylabel 'Rate'
plot 'outliers.dat' u 1:($2/$6):(sqrt($2)/$6) w e title '' lc rgb 'blue'
#set title '4 EeV'
set origin 0.0,0.3
set xlabel ''
set ylabel 'N Hexagons'
plot 'outliers.dat' u 1:6 title '' lc rgb 'blue'
#set title '3 EeV'
set origin 0.0,0.6
set ylabel 'N events'
set xlabel ''
plot 'outliers.dat' u 1:2 title '' lc rgb 'blue'
set size 1,1
set origin 0.0,0.0
unset multiplot
