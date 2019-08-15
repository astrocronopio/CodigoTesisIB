## Grafico de hexagonos en función de t
set term postscript eps enhanced color dashed 'Helvetica,17'
set size 1,0.7
set xdata time
set timefmt "%s"
set format x "%m/%Y"
set xtics "1041379200",63072000
set xlabel ''
set ylabel '# Active hexagons'
set output 'hexvst_mainv2.eps'
#plot ["1104537600":"1451347200"] '../../datos_auger/hexvstd_main.dat' u 1:2 pt 7 ps 0.3 title '',100 lw 2 lt 2 lc 0 title ''
set arrow 2 from "1104537600",graph(0,0) to "1104537600",graph(1,1) nohead lw 1
plot [:"1451347200"] '../../datos_auger/hexvstd_main.dat' u 1:2 pt 7 ps 0.3 title '',100 lw 2 lt 2 lc 0 title ''
set size 1,1
set origin 0.0,0.0
set xdata
set format x 
