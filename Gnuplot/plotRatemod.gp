## Hace el gráfico de la tasa por hexágono como función del tiempo y como función de la hora del día.
##
set size 1,0.7
set term postscript eps enhanced color 'Helvetica,18'
#set grid
set ylabel 'Rate of events [day^{-1}km^{-2}]'
N=5/1.949
set title ''
set output 'seasonalmoda1_main_01012005_31122015_cuth_2days.eps'
set key top right
#set xlabel 'Days since 01/01/2005'
#set xtics 0,500
#plot [0:][:1] 'fitmoddrd_01012004_31072015.dat' u (($1-1104537600)/86400):($2/$4*N):(sqrt($2)/$4*N) w e pt 7 ps 0.5 title 'Data','fitmoddrd_01012004_31072015.dat' u (($1-1104537600)/86400):($3/$4*N) pt 5 ps 0.5 lc 3 title 'Fit' 
set xlabel ''
set xdata time 
set timefmt "%s"
set format x "%m/%Y"
set xtics "1104537600",63072000
#set arrow 1 from "1230768000",graph(0,0) to "1230768000",graph(1,1) nohead lw 2
#set arrow 2 from "1325376000",graph(0,0) to "1325376000",graph(1,1) nohead lw 2
#plot ["1104537600":] 'fitmoddrd_01012004_31072015.dat' u 1:($2/$4*N):(sqrt($2)/$4*N) w e pt 7 ps 0.5 title ''
#plot ["1104537600":"1451347200"] 'Herald060noBPa1-bind_wca1.dat' u 1:($2/$3*N) pt 7 ps 0.3 title 'cor','Herald060noBPa1-bind_nowc.dat' u 1:($2/$3*N) pt 7 ps 0.2 lc 3 title 'no cor'
#:(sqrt($2)/$3*N) w e
#plot ["1104537600":"1451347200"][0.1:0.24] 'fitmoddrda1_01012004_31122015.dat' u 1:($2/$4*N):(sqrt($2)/$4*N) w e pt 7 ps 0.5 lc rgbcolor "red" title '','' u 1:($3/$4*N) pt 7 ps 0.3 lc 0 title '' 
plot ["1104537600":"1451347200"][0.1:0.24] 'fitmoddrda1_01012004_31122015_2days.dat' u 1:($2/$4*N/2):(sqrt($2)/$4*N/2) w e pt 7 ps 0.5 title '','' u 1:($3/$4*N/2) pt 7 ps 0.4 lc 0 title '' 
#unset arrow
set output 'dailymoddra1_main_01012005_31122015.eps'
set key top left
#set size 0.7,0.7
set xdata
set format x
set xtics 0,4
set xlabel 'Hour of the day (UTC)'
plot [:24] 'fitmoddrhoura1_01012005_31122015.dat' u ($0+0.5):($2/$4*N*24):($3/$4*N*24) w e pt 7 ps 0.8  title '', '' u ($0+0.5):($1/$4*N*24) title '' pt 7 ps 0.8 lc 0
#plot [:24] 'fitmoddrhour_01012005_31072015.dat' u ($0+0.5):($2/$4*N*24):($3/$4*N*24) w e pt 5 ps 0.8  title 'Data', 'fitmoddrhour_01012005_31072015.dat' u ($0+0.5):($1/$4*N*24) title 'delay' pt 7 ps 0.8 lc 3,'fitmodhour_01012005_31072015.dat' u ($0+0.5):($1/$4*N*24) title 'no delay'  ps 0.8 lc 0
#plot [:24] 'outfile3.dat' u ($0+0.5):($2/$4*N*24):($3/$4*N*24) w e pt 5 ps 0.8  title 'Data', 'outfile3_asymp.dat' u ($0+0.5):($1/$4*N*24) title 'Asymptotic fit' pt 7 ps 0.8 lc 3,'outfile3.dat' u ($0+0.5):($1/$4*N*24) title 'multi-fit' pt 10 ps 0.8 lc 0
pause -1
set size 1,1
set term wxt 0



#====================== PREVIOUS METHOD =========================================================================
#set multiplot			#para generar varios gráficos en la misma pantalla
#set size 1,0.6			#divide la pantalla en una grilla de 2x1
#set origin 0.0,0.5	#establece en cual de los espacios de la grilla creada irá el plot que le sigue"
#set term postscript eps enhanced color
#set grid
#set xlabel 'Number of days since 01/01/2005'
#set ylabel 'Rate of events [day^{-1}km^{-2}]'
#N=24*60/1.949
#set title ''
#set output 'seasonalmod.eps'
#set origin 0.0,0.0
#set key top right
#plot [:3100][0:1] 'fitmodd.dat' u 1:($3*N):($4*N) w e title 'Data', 'fitmodd.dat' u 1:($2*N) title 'fit' pt 5 ps 0.5 lc 3
#set output 'dailymod.eps'
#set xlabel 'Hour of the day (UTC)'
#set key top left
#set origin 0.0,0.5
#plot [:24] 'fitmodhour.dat' u ($1-0.5):($3/$5*N):($4/$5*N) w e title 'Data', 'fitmodhour.dat' u ($1-0.5):($2/$5*N) title 'fit' pt 5 ps 0.5 lc 3
#plot 'fitmodhour.dat' u 1:($3/$5):($4/$5) w e title 'Data', 'fitmodhour.dat' u 1:($2/$5) title 'fit brho', 'fitmodhournewb.dat' u 1:($2/$5) title 'fit b0b1'
#set size 1,1
#set origin 0.0,0.0
#set term wxt 0
#unset multiplot
