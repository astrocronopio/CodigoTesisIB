set terminal qt 0 enhanced font 'times,26' size 1200,800 

plot filename u 1:5 w lp t "Actual"
replot filename u 1:9 w l notit

replot filecmp u 1:5 w lp t "Referencia"
replot filecmp u 1:9 w l notit

pause(-1)