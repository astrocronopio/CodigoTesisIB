## Dibuja tasa de eventos por hora del día
## Incluye grafico comparando ajustes con $\rho$ retrasado 2 hrs o no
## Incluye plot con residuos
#
set term postscript eps enhanced color dashed 'Helvetica,17'
set output 'cuvsdlrhoa1_01012005_31122015_wres.eps'
set rmargin 3
unset xtics
set key top left spacing 1.3

set multiplot
set size 1,0.65
set origin 0,0.35
set tmargin 2
set bmargin 0
N=5/1.949
set ytics 0.003 font ",18"
set ylabel 'Rate of events [day^{-1}km^{-2}]'
plot [0:24] 'fitmoddrhoura1_01012005_31122015_loc.dat' u ($0+0.5):($2/$4*N*24):($3/$4*N*24) w e pt 7 ps 1  title 'Data', '' u ($0+0.5):($1/$4*N*24) w lp pt 5 ps 1 lc 0 lt 1 title 'Expected with 2 hr delay','fitmodhoura1_01012005_31122015_loc.dat' u ($0+0.5):($1/$4*N*24) w lp pt 8 ps 1 lc 0 lt 3 title 'Expected without delay'
set size 1,0.35
set origin 0.0,0.0
set tmargin 0
unset bmargin 
set xtics 0,4
set mxtics 4
set xlabel 'Hour of the day (Local Time)'
set ylabel 'Residuals'
set ytics 0.003
plot [0:24][-0.005:0.005] 'fitmoddrhoura1_01012005_31122015_loc.dat' u ($0+0.4):(($2-$1)/$4*N*24):($3/$4*N*24) w e pt 5 ps 1 lc 0 title '','fitmodhoura1_01012005_31122015_loc.dat' u ($0+0.6):(($2-$1)/$4*N*24):($3/$4*N*24) w e title ''  pt 8 ps 1.3 lc 0 lt 1,0 title '' lt 0,'fitmoddrhoura1_01012005_31122015_loc.dat' u ($0+0.4):(($2-$1)/$4*N*24):($3/$4*N*24) w l lc 0 lt 1 title '','fitmodhoura1_01012005_31122015_loc.dat' u ($0+0.6):(($2-$1)/$4*N*24):($3/$4*N*24) w l title '' lc 0 lt 3,0 title '' lt 0
unset multiplot

