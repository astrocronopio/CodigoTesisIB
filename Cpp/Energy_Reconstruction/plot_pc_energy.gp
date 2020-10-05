set xdata time 
set timefmt "%s"
set format x "%m/%Y"
set xtics 1.5*47304000
set xlabel "Fecha"

set terminal qt 1 enhanced  size 1200,750  font 'Arial,26'

set ylabel "Ecor - (my)Ecor  [%]"

plot filename u 1:(200*($3-$4)/($3+$4)) notit
replot filename u 1:(0) notit


# set terminal qt 2 enhanced  size 1200,750  font 'Arial,26'

# set ylabel "factor - (my)factor [%]"

# plot filename u 1:(200*($6-$5)/($6+$5)) notit


# set terminal qt 3 enhanced  size 1200,750  font 'Arial,26'

# plot filename u 1:6 t "fact"
# replot filename u 1:5 t "(my)fact"

pause(-1)