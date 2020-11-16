set terminal qt 0 enhanced font 'times,26' size 1200,800 

set key right

set ylabel "Amplitud" 
set xlabel "Frecuencia [ciclos/año]"

set xran [:]

plot filename u 1:5 w l ls 3  lc rgb 'red'  t "Actual"
replot filename u 1:9 w l notit lc rgb 'red'  lw 0.9


# plot filename u 1:5 w lp t "Actual" lc rgb 'red'  pt 7 ps 0.9  lw 1.2
# replot filename u 1:9 w l notit lc rgb 'red' 

replot filecmp u 1:5 w l t "Referencia" ls 3  lc rgb 'blue' lw 1.5 
replot filecmp u 1:9 w l notit lc rgb 'blue'
replot "./Files_AllTriggers_Reference/asi_seria_sin_corr.dat" u 1:5 w l t "Referencia" ls 3  lc rgb 'orange' lw 1.5 

pause(-1)