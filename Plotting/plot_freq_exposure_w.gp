set terminal qt  2 size 1500,750 enhanced font 'Verdana,26'

set tit "Pesos de las frecuencias Sidérea y Solar"

set ylabel "w_i = ({/Symbol D}n)^{-1}"

set xlabel "Hora Sidérea"

set xti 3

set yti 0.025

set yrange [0.95:1.05]

set key right bottom horizontal 

plot "../Cpp/exposure_for_t_sideral_every_5min.txt"  u (($1*5.0)/60.0):(1/$2)  w lp lw 1.8 dt 2 ps 0.5 pt 6 lc rgb "red"  tit " T: 365.256"

#set terminal qt  3 size 1000,750 enhanced font 'Verdana,26' 

#set tit "Frecuencia Solar"
replot "../Cpp/exposure_for_t_non_sideral_every_5min.txt"  u (($1*5.0)/60.0):(1/$2)  w lp lw 1.8 dt 3 ps 0.5 pt 4 lc rgb "blue" tit " T: 365.25"
replot 1 lw 0.52 lc rgb "black"   notit


pause(-1)