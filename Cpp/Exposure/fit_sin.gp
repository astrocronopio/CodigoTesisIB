pi=3.14159265359
f(x) = (a*cos((w*x*360/24 -b )*pi/180.0) +1.0)*c

a=0.0038
b=20
w=1
c=1.0

set auto 

#filepepe="../../../Hexagons/dnhex_sid_288.dat" #Este es la posta
filepepe="solar_2020_sol.txt"
title_plot="Frecuencia Solar"

#set  xrange [0:360]
set xtics 4
set xlabel "h' [hr]" offset 0,0.5


set terminal qt 1 enhanced font 'Times,26' size 1200,800 

set ytics 0.005

set ylabel "Peso de cada evento"

#plot "sideral_2019.txt" u ($1*360/288):2
set title title_plot offset 0,-0.8
plot filepepe u ($0*24/288):(1/$1 ) w lp pt 4 lc rgb 'red' notit
#pause(5)

#set arrow from 317,0.99 to 317,1.01, graph 1 nohead

fit f(x) filepepe u ($0*24/288):(1/$1 ) via a,b,c
replot f(x) dt 3  lw 2  lc rgb 'black'  tit "Ajuste: (a·cos(w·x-b) + 1)·c"

rep


# amplitud y fase
# plot de los heaxogonos
# inversa de los pesos

# pi=3.14159265359
# f1(x) = (a1*cos((w1*x -b1)*pi/180.0) + 1.0)*c1

# a1=0.005
# b1=300
# w1=1
# c1=2.

# set term png  23 enhanced font 'Helvetica,26' size 1100,750 
# set output "../../Update/report_5_22_05_2020/ajuste_pesos.png"
# replot

# set terminal qt 11 enhanced font 'Helvetica,26' size 1100,750 

# set ylabel "Hexagonos [10^{6}]"
# set ytics 0.01
# set yrange [2.01:]

# #plot "sideral_2019.txt" u ($1*360/288):2
# plot "sideral_2020.txt" u ($1):($3/5) notit
# #replot f(x)
# #pause(5)


# #set arrow from 317,2.02 to 317,2.06, graph 1 nohead

# fit f1(x) "sideral_2020.txt" u 1:($3/5) via a1,b1,c1
# rep f1(x) tit "Ajuste: a·cos(w·x-b) + c"

# set term png 33  enhanced font 'Helvetica,26' size 1100,750 
# set output "../../Update/report_5_22_05_2020/ajuste_hexagonos.png"
# replot

# set term qt


pause(-1)