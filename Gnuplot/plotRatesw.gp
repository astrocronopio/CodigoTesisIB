#set multiplot			#para generar varios gráficos en la misma pantalla
#set size 1,0.5			#divide la pantalla en una grilla de 2x1
#set origin 0.0,0.5	#establece en cual de los espacios de la grilla creada irá el plot que le sigue"
set grid
#plot 'fitmodnewbsummerhour.dat' u 1:($3/$5):($4/$5) w e title 'Summer', 'fitmodnewbwinterhour.dat' u 1:($3/$5):($4/$5) w e title 'Winter'
#set origin 0.0,0.0

set key top left spacing 1.3
set term postscript eps enhanced color
set output 'winsumgf.eps'
set title ''
set xlabel 'Hour of the day (UTC)'
set ylabel 'Rate of events [day^{-1}km^{-2}]'
set size 0.8,0.8
N=60*24/1.949    #constante para poner unidades de rate en day^-1km^-2
plot [:24] 'fitmodsummerhour.dat' u ($1-0.5):($3/$5*N):($4/$5*N) w e title 'Summer data', 'fitmodsummerhour.dat' u ($1-0.5):($2/$5*N) title 'Summer global fit' lc 3 pt 5 ps 0.5,'fitmodwinterhour.dat' u ($1-0.5):($3/$5*N):($4/$5*N) w e title 'Winter data' lt 1 lc 2, 'fitmodwinterhour.dat' u ($1-0.5):($2/$5*N) title 'Winter global fit' lc 0 pt 7 ps 0.5
set output 'winsumgfdr.eps'
plot [:24] 'fitmoddrsummerhour.dat' u ($1-0.5):($3/$5*N):($4/$5*N) w e title 'Summer data', 'fitmoddrsummerhour.dat' u ($1-0.5):($2/$5*N) title 'Summer fit' lc 3 pt 5 ps 0.5,'fitmoddrwinterhour.dat' u ($1-0.5):($3/$5*N):($4/$5*N) w e title 'Winter data' lt 1 lc 2, 'fitmoddrwinterhour.dat' u ($1-0.5):($2/$5*N) title 'Winter fit' lc 0 pt 7 ps 0.5
set term wxt 0
