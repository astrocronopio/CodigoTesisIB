pi=3.14159265359
f(x) = (a*cos((w*x -b )*pi/180.0) +1.0)*c

a=0.0038
b=280
w=1
c=1



set terminal qt 1 enhanced font 'Times,26' size 1200,800 

set xran [:360]
set xtic 60

set xlabel "RA [^o]"
set ylabel "N_{bin} {/=30 /} N_{media}"

plot "bineado_RA_eventos.txt" u 1:2 w lp  lc rgb "red" pt 4 ps 1.2  notit


fit f(x) "bineado_RA_eventos.txt" u 1:2 via a,b
replot f(x) dt 3  lw 2  lc rgb 'black'  tit "Ajuste: (a·cos(w·x-b) + 1)·c"

