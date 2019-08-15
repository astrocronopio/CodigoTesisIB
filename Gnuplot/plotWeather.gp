## Plots T, P y $\rho$
set term postscript eps enhanced color dashed 'Helvetica,17'
set size 1,0.7
set xlabel 'Number of days'
set ylabel '{/Symbol r} [kg.m^{-3}]'
set mytics 2
set ytics 0,0.04
set output 'rho_30d.eps'
plot [0:30][0.96:1.19] '../../datos_auger/pnrhovst_jan2015.dat' u 1:3 w l lw 2 title 'summer','../../datos_auger/pnrhovst_win2014.dat' u 1:3 w l lc 3 lt 2 lw 2 title 'winter'
set ylabel 'P [hPa]'
set ytics auto
set output 'pres_30d.eps'
plot [0:30] '../../datos_auger/pnrhovst_jan2015.dat' u 1:2 w l lw 2 title 'summer','../../datos_auger/pnrhovst_win2014.dat' u 1:2 w l lc 3 lt 2 lw 2 title 'winter'
set xdata time
set timefmt "%s"
set format x "%m/%Y"
set xtics "1104537600",63072000
set xlabel ''
set ylabel 'P_d [hPa]'
set ytics 0,10
set output 'presvst.eps'
plot ["1104537600":"1451347200"] '../../datos_auger/pnrhovstd.dat' u 1:2 pt 7 ps 0.3 title ''
set ylabel '{/Symbol r}_d [kg.m^{-3}]'
set ytics 0,0.04
set output 'rhovst.eps'
plot ["1104537600":"1451347200"] '../../datos_auger/pnrhovstd.dat' u 1:3 pt 7 ps 0.3 title ''
set size 1,1
set origin 0.0,0.0
set xdata
set format x
