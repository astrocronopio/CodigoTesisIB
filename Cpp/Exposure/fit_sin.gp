pi=3.14159265359
f(x) = a*cos((w*x -b )*2*pi/180.0) + c

a=0.01
b=300
w=1
c=1.0

set auto 

set  xrange [0:360]
set xtics 45
set xlabel "RA [^o]" offset 0,0.5

set terminal qt 1 enhanced font 'Helvetica,26' size 1100,750 

set ytics 0.005

set ylabel "Pesos Hexagonos"

#plot "sideral_2019.txt" u ($1*360/288):2
plot "./sideral_2020.txt" u ($1*360/288):2 notit
replot f(x) tit "Ajuste: a·cos(w·x-b) + c"
#pause(5)

set arrow from 317,0.99 to 317,1.01, graph 1 nohead

fit f(x) "sideral_2020.txt" u ($1*360/288):2 via a,b,w,c
rep


# amplitud y fase
# plot de los heaxogonos
# inversa de los pesos

pi=3.14159265359
f1(x) = a1*cos((w1*x -b1)*2*pi/180.0 ) + c1

a1=0.01
b1=300
w1=1.01
c1=2.05

set term png  23 enhanced font 'Helvetica,26' size 1100,750 
set output "../../Update/report_5_22_05_2020/ajuste_pesos.png"
replot

set terminal qt 11 enhanced font 'Helvetica,26' size 1100,750 

set ylabel "Hexagonos [10^{6}]"
set ytics 0.01
set yrange [2.01:]

#plot "sideral_2019.txt" u ($1*360/288):2
plot "sideral_2020.txt" u ($1*360/288):($3/5) notit
#replot f(x)
#pause(5)


set arrow from 317,2.02 to 317,2.06, graph 1 nohead

fit f1(x) "sideral_2020.txt" u ($1*360/288):($3/5) via a1,w1,c1,b1
rep f1(x) tit "Ajuste: a·cos(w·x-b) + c"

set term png 33  enhanced font 'Helvetica,26' size 1100,750 
set output "../../Update/report_5_22_05_2020/ajuste_hexagonos.png"
replot

set term qt