set terminal qt 0 enhanced font 'times,26' size 1200,800 

plot "test_rayleigh_5" u 1:5 w lp t "re-re"
replot "test_rayleigh_5" u 1:9 w l notit

replot "test_rayleigh" u 1:5 w lp t "semestre pasado"
replot "test_rayleigh" u 1:9 w l notit