pi=3.14159265359
f(x) = (a*cos((x -b )*pi/180.0) +1.0)

# a=0.0038
# b=280
# w=1
# c=1



set terminal qt 1 enhanced font 'Times,26' size 1200,800 

set xran [:360]
set xtic 40
set key left top
set yti 0.002
set yr [:1.010]

set xlabel "RA [^o]"
set ylabel "N_{bin} {/=30 /} N_{media}"

plot "bineado_RA_eventos_pesos.txt" u 1:2 w lp  lc rgb "blue" pt 6 ps 2 lw 2  tit "Sin pesos"


fit f(x) "bineado_RA_eventos_pesos.txt" u 1:2 via a,b
#replot f(x) dt 3  lw 2  lc rgb 'black'  notit #"Ajuste: f(x)= a·cos(x-b) + 1"

pi=3.14159265359
f1(x) = (a1*cos((x -b1 )*pi/180.0) +1.0)


replot "bineado_RA_eventos.txt" u 1:2 w lp  lc rgb "red" pt 4 ps  2 lw 2 tit "Con pesos"


fit f1(x) "bineado_RA_eventos.txt" u 1:2 via a1,b1
#replot f1(x) dt 3  lw 2  lc rgb 'black'  notit #"Ajuste: f(x)= a·cos(x-b) + 1"

f2(x) = (0.0061*cos((x -251 )*pi/180.0) +1.0)
replot f2(x) lw 3 tit "Rayleigh-Sin"


f3(x) = (0.0038*cos((x -288 )*pi/180.0) +1.0)
replot f3(x) lw 3 tit "Rayleigh-Con"
