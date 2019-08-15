#set multiplot			#para generar varios gráficos en la misma pantalla
#set size 1,0.5			#divide la pantalla en una grilla de 2x1
#set origin 0.0,0.5	#establece en cual de los espacios de la grilla creada irá el plot que le sigue"
set grid
#plot 'fitmodnewbsummerhour.dat' u 1:($3/$5):($4/$5) w e title 'Summer', 'fitmodnewbwinterhour.dat' u 1:($3/$5):($4/$5) w e title 'Winter'
#set origin 0.0,0.0

#set key outside top
set term wxt 1
set title "Sec 1"
plot 'fitmodsec1hour.dat' u 1:($3/$5):($4/$5) w e title 'Summer Data', 'fitmodsec1hour.dat' u 1:($2/$5) title 'Fit' lc 0
set term wxt 2
set title "Sec 2"
plot 'fitmodsec2hour.dat' u 1:($3/$5):($4/$5) w e title 'Summer Data', 'fitmodsec2hour.dat' u 1:($2/$5) title 'Fit' lc 0
set term wxt 3
set title "Sec 3"
plot 'fitmodsec3hour.dat' u 1:($3/$5):($4/$5) w e title 'Summer Data', 'fitmodsec3hour.dat' u 1:($2/$5) title 'Fit' lc 0
set term wxt 4
set title "Sec 4"
plot 'fitmodsec4hour.dat' u 1:($3/$5):($4/$5) w e title 'Summer Data', 'fitmodsec4hour.dat' u 1:($2/$5) title 'Fit' lc 0
set term wxt 5
set title "Sec 5"
plot 'fitmodsec5hour.dat' u 1:($3/$5):($4/$5) w e title 'Summer Data', 'fitmodsec5hour.dat' u 1:($2/$5) title 'Fit' lc 0

#set size 1,1
#set origin 0.0,0.0
#unset multiplot
