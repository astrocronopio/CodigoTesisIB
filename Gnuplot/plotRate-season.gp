## Plot rate as a function of time 
#
set size 1,0.7
set term postscript eps enhanced color 'Helvetica,18'
#set grid
set ylabel 'Rate of events [day^{-1}km^{-2}]'
N=5/1.949
set title ''
set output 'seasonalmoda1_main_01012005_31122015_cuth_2days.eps'
set key top right
set xlabel ''
set xdata time 
set timefmt "%s"
set format x "%m/%Y"
set xtics "1104537600",63072000
plot ["1104537600":"1451347200"][0.1:0.24] 'fitmoddrda1_01012004_31122015_2days.dat' u 1:($2/$4*N/2):(sqrt($2)/$4*N/2) w e pt 7 ps 0.5 title '','' u 1:($3/$4*N/2) pt 7 ps 0.4 lc 0 title '' 
