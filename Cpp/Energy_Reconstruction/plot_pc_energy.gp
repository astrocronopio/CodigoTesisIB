set xdata time 
set timefmt "%s"
set format x "%m/%Y"
set xtics 1.5*47304000
set xlabel "Fecha"

set terminal qt 1 enhanced  size 1200,750  font 'Arial,26'

set ylabel "Ecor - (my)Ecor  [%]"

plot filename u 1:(200*($3-$4)/($3+$4)) every 100 notit
replot filename u 1:(0) every 500 w l lw 3 notit

set terminal qt 2 enhanced  size 1200,750  font 'Arial,26'
set ylabel "Eraw/(my)Ecor "

plot filename u 1:($6/$4) every 100 notit


# set terminal qt 3 enhanced  size 1200,750  font 'Arial,26'
# plot filename u 1:7 every 100 tit "Cannon"
# replot filename u 1:8 every 100 tit "Mine"
# replot filename u 1:(1) every 1000 w l lw 3 notit



set terminal qt 4 enhanced  size 1200,750  font 'Arial,26'
set ylabel "factor - (my)factor [%]"

plot filename u 1:(200*($7-$8)/($7+$8)) every 100 notit 
replot filename u 1:(0) every 1000 w l lw 3 notit


# set terminal qt 5 enhanced  size 1200,750  font 'Arial,26'

# set ylabel "factor - (my)factor [%]"

# plot filename u 1:(200*($6-$5)/($6+$5)) notit


set terminal qt 3 enhanced  size 1200,750  font 'Arial,26'

plot filename u 1:7 t "fact"
replot filename u 1:8 t "(my)fact"

pause(-1)