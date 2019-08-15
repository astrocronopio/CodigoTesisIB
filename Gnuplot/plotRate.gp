## Generates plot of the rate before and after correction of energy
## by the weather effects
##
set term postscript eps enhanced color 'Helvetica,17'
set output 'Ratea2_main_01012005_31122015_UncorCorE.eps'
set multiplot			
set size 1,0.5
set origin 0.0,0.0
set xdata time
set timefmt "%s"
set format x "%m/%Y"
set xtics "1104537600",63072000
set ytics 0.014,0.004
#set grid
N=5/1.949
set ylabel 'Rate of events [day^{-1}km^{-2}]' font "Helvetica,15"
set title "Corrected Energy" font "Helvetica Bold,15"
plot ["1104537600":"1451347200"][:0.03] 'Herald060noBPa2-bin5d_wca1.dat' u 1:($2/$3*N/10) pt 7 ps 0.4 title ""
set origin 0.0,0.5
set title "Uncorrected Energy" font "Helvetica Bold,15"
plot ["1104537600":"1451347200"][:0.03] 'Herald060noBPa2-bin5d_nowc.dat' u 1:($2/$3*N/10) pt 7 ps 0.4 title ""
set size 1,1
set origin 0.0,0.0
set xdata
set format x 
unset multiplot
