## Chequeo de algunos "outliers" en el rate.
##
set size 1,1
#set term postscript eps enhanced color
set grid
set xdata time 
set timefmt "%s"
set format x "%d/%m/%y\n%H:%M"
set xlabel 'UTC'
set ylabel 'Number of Events'
set title ''
#set output 'checksOutliersNev.eps'
set key top right
plot ["1441584000":"1441843200"] 'outfile1.dat' u 1:2 w his lw 2 title '','../../datos_auger/BadPeriods_010104_310116.dat' u 1:(0) pt 10 ps 1.5 lc 3 title 'BP start','../../datos_auger/BadPeriods_010104_310116.dat' u 9:(0) pt 11 ps 1.5 lc 3 title 'BP end'
set term wxt 1
#set output 'checksOutliersNhex.eps'
set ylabel 'Number of Active Hexagons'
plot ["1441584000":"1441843200"] 'outfile1.dat' u 1:($6/5) w his lw 2 title '','../../datos_auger/BadPeriods_010104_310116.dat' u 1:(0) pt 10 ps 1.5 lc 3 title 'BP start','../../datos_auger/BadPeriods_010104_310116.dat' u 9:(0) pt 11 ps 1.5 lc 3 title 'BP end'
set size 1,1
set term wxt 0
