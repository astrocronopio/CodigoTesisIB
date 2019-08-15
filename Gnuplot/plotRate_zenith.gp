## Hace el gráfico de la tasa para bines de zenith.
##
set size 0.7,0.7
set term postscript eps enhanced color
set grid
set ylabel 'Rate of events [day^{-1}km^{-2}]'
N=5/1.949
set title ''
set output 'seasonalmod3860_main_01012005_31072015.eps'
set key top right
#set xlabel 'Days since 01/01/2005'
#set xtics 0,500
#plot [0:] 'fitmoddrd3860.dat' u (($1-1104537600)/86400):($2/$4*N):(sqrt($2)/$4*N) w e pt 7 ps 0.5 title 'Data','fitmoddrd3860.dat' u (($1-1104537600)/86400):($3/$4*N) pt 5 ps 0.5 lc 3 title 'Fit'
set xdata time 
set timefmt "%s"
set format x "%m/%Y"
set xlabel 'UTC'
set xtics "1104537600",63072000
plot ["1104537600":] 'fitmoddrd3860.dat' u 1:($2/$4*N):(sqrt($2)/$4*N) w e pt 7 ps 0.5 title 'Data','fitmoddrd3860.dat' u 1:($3/$4*N) pt 7 ps 0.3 lc 3 title 'Fit' 
set output 'dailymod3860_main_01012005_31072015.eps'
set key top left
set size 0.7,0.7
set xdata
set format x
set xtics 0,4
set xlabel 'Hour of the day (UTC)'
plot [:24] 'fitmoddrhour3860.dat' u ($0+0.5):($2/$4*N*24):($3/$4*N*24) w e pt 5 ps 0.7  title 'Data', 'fitmoddrhour3860.dat' u ($0+0.5):($1/$4*N*24) title 'delay' lc 3,'fitmodhour3860.dat' u ($0+0.5):($1/$4*N*24) title 'no delay'  lc 0
set size 1,1
set term wxt 0
