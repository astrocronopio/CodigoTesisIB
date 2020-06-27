pi=3.14159265359
f(x) = (a*cos((x -b )*pi/180.0) +1.0 + c*cos((2*(x-d)*pi/180.0)))

a               = 0.00326806    #   +/- 0.001447     (44.27%)
b               = 19.5265       #   +/- 25.35        (129.8%)
c               = 0.00733071    #   +/- 0.001445     (19.71%)
d               = 336.52        #   +/- 5.659   





set terminal qt 1 enhanced font 'Times,26' size 1200,800 

set xran [:360]
set xtic 40
set key at 185, 0.993#center bottom
#set yti 0.002
set yr [0.985:1.01]

set xlabel "RA [^o]"
set ylabel "N_{bin} {/=30 /} N_{media}"

plot "bineado_RA_eventos.txt" u 1:2 w lp  lc rgb "blue" pt 6 ps 2 lw 2  tit "Sin pesos"
replot "bineado_RA_eventos.txt" u 1:2:(sqrt(2/$3)) w yerr  lc rgb "blue" pt 6 ps 0 lw 1.3  notit
fit f(x) "bineado_RA_eventos.txt" u 1:2:3 yerr via a,b,c,d

# replot 1 lc rgb "black"  lw 1 notit  


#fit f(x) "bineado_RA_eventos_pesos.txt" u 1:2 via a,b
#replot f(x) dt 3  lw 2  lc rgb 'black'  notit #"Ajuste: f(x)= a·cos(x-b) + 1"

pi=3.14159265359
#f1(x) = (a1*cos((x -b1 )*pi/180.0) +1.0)


#replot "bineado_RA_eventos.txt" u 1:2 w lp  lc rgb "red" pt 4 ps  2 lw 2 tit "Sin pesos"
#replot "bineado_RA_eventos.txt" u 1:2:(sqrt(2/$3)) w yerr lc rgb "red"  ps  0 lw 1.3 notit 


#fit f1(x) "bineado_RA_eventos.txt" u 1:2 via a1,b1
#replot f1(x) dt 3  lw 2  lc rgb 'black'  notit #"Ajuste: f(x)= a·cos(x-b) + 1"


# f3(x) = (0.0039*cos((x -335 )*pi/180.0) +1.0)
# replot f3(x) lw 3 dt 8  lc rgb "blue" tit "Rayleigh-Con"


# f2(x) = (0.0018*cos((x -289)*pi/180.0) +1.0)
# 
replot f(x) lw 1.5 dt 2 lc rgb "black" tit "Orden 2"



#replot "bineado_RA_eventos.txt" u 1:2 w lp  lc rgb "green" pt  6 ps  2 lw 2 tit "Con pesos - h"
