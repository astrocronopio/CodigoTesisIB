## Dibuja tasa de eventos por hora del día
## Incluye grafico comparando ajustes con $\rho$ retrasado 2 hrs o no
##
#set multiplot			#para generar varios gráficos en la misma pantalla
#set size 1,0.5			#divide la pantalla en una grilla de 2x1
#set origin 0.0,0.5	#establece en cual de los espacios de la grilla creada irá el plot que le sigue"
#set grid
#plot 'fitmodnewbsummerhour.dat' u 1:($3/$5):($4/$5) w e title 'Summer', 'fitmodnewbwinterhour.dat' u 1:($3/$5):($4/$5) w e title 'Winter'
#set origin 0.0,0.0

set key top left spacing 1.3
set term postscript eps enhanced color 'Helvetica,17'
#set output 'cuvsdlrhoa1_01012005_31122015_loc.eps'
set output 'dailymoda1_01012005_31122015_loc.eps'
set title ''
set xlabel 'Hour of the day (Local Time)'
set ylabel 'Rate of events [day^{-1}km^{-2}]'
set size 1,0.7
set xtics 0,4
#N=60*24/1.949    #constante para poner unidades de rate en day^-1km^-2
#plot [:24] 'fitmodhour.dat' u ($1-0.5):($3/$5*N):($4/$5*N) w e title 'Data', 'fitmodhour.dat' u ($1-0.5):($2/$5*N) title 'Fit current {/Symbol r},reduced {/Symbol c}^2=5.6' lc 0, 'fitmoddrhour.dat' u ($1-0.5):($2/$5*N) title 'Fit delayed {/Symbol r}, reduced {/Symbol c}^2=1.2'
N=5/1.949
plot [0:24] 'fitmoddrhoura1_01012005_31122015_loc.dat' u ($0+0.5):($2/$4*N*24):($3/$4*N*24) w e pt 7 ps 1  title 'Data', 'fitmodhoura1_01012005_31122015_loc.dat' u ($0+0.5):($1/$4*N*24) w lp pt 8 ps 1 lc 0 lt 3 title 'Fit'
#plot [0:24] 'fitmoddrhoura1_01012005_31122015_loc.dat' u ($0+0.5):($2/$4*N*24):($3/$4*N*24) w e pt 7 ps 1  title 'Data', '' u ($0+0.5):($1/$4*N*24) w lp pt 5 ps 1 lc 0 lt 1 title 'Expected with 2 hr delay','fitmodhoura1_01012005_31122015_loc.dat' u ($0+0.5):($1/$4*N*24) w lp pt 8 ps 1 lc 0 lt 3 title 'Expected without delay'
set term wxt 0

#plot 'fitmodsummerhour.dat' u 1:($3/$5):($4/$5) w e title 'Data summer', 'fitmodsummerhour.dat' u 1:($2/$5) title 'Fit current rho' lc 0, 'fitmodwinterhour.dat' u 1:($3/$5):($4/$5) w e title 'Data winter','fitmodwinterhour.dat' u 1:($2/$5) title 'Fit current rho' lc 0
#plot 'fitmodnewbsummerhour.dat' u 1:($3/$5):($4/$5) w e title 'Summer Data', 'fitmodnewbsummerhour.dat' u 1:($2/$5) title 'Fit summer b0', 'fitmodsummerhour.dat' u 1:($2/$5) title 'Fit summer brho', 'fitmodnewbwinterhour.dat' u 1:($3/$5):($4/$5) w e title 'Winter Data', 'fitmodnewbwinterhour.dat' u 1:($2/$5) title 'Fit winter b0','fitmodwinterhour.dat' u 1:($2/$5) title 'Fit winter brho' lc 0
#set term wxt 2
#set title "Delayed rho"
#plot 'fitmodnewbdlayrhosummerhour.dat' u 1:($3/$5):($4/$5) w e title 'Summer Data', 'fitmodnewbdlayrhosummerhour.dat' u 1:($2/$5) title 'Fit summer b0', 'fitmoddlayrhosummerhour.dat' u 1:($2/$5) title 'Fit summer brho', 'fitmodnewbdlayrhowinterhour.dat' u 1:($3/$5):($4/$5) w e title 'Winter Data', 'fitmodnewbdlayrhowinterhour.dat' u 1:($2/$5) title 'Fit winter b0','fitmoddlayrhowinterhour.dat' u 1:($2/$5) title 'Fit winter brho' lc 0
#set term wxt 3
#set title ''
#plot 'fitmodnewbsummerhour.dat' u 1:($3/$5):($4/$5) w e title 'Summer Data', 'fitmodnewbsummerhour.dat' u 1:($2/$5) title 'Fit summer b0','fitmodnewbdlayrhosummerhour.dat' u 1:($2/$5) title 'Fit summer b0 rho delayed','fitmodnewbwinterhour.dat' u 1:($3/$5):($4/$5) w e title 'Winter Data','fitmodnewbwinterhour.dat' u 1:($2/$5) title 'Fit winter b0','fitmodnewbdlayrhowinterhour.dat' u 1:($2/$5) title 'Fit winter b0 rho delayed' lc 0

#plot 'fitmodsummerhour.dat' u 1:($3/$5):($4/$5) w e title 'Summer Data', 'fitmodsummerhour.dat' u 1:($2/$5) title 'Fit summer', 'fitmodwinterhour.dat' u 1:($3/$5):($4/$5) w e title 'Winter Data', 'fitmodwinterhour.dat' u 1:($2/$5) title 'Fit winter'
#set size 1,1
#set origin 0.0,0.0
#unset multiplot
