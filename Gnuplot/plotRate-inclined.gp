#set term pngcairo enhanced size 800,500 font 'Helvetica,15'
set term pdfcairo enhanced font 'Helvetica,12'
set output 'plotRate-inclined_01012005_31122015.pdf'
set multiplot			#para generar varios gráficos en la misma pantalla
set size 1,0.5			#divide la pantalla en una grilla de 2x2
set xdata time
set timefmt "%s"
set format x "%m/%Y"
set xtics "1104537600",63072000
set ylabel 'Rate of events [day^{-1}km^{-2}]' font "Helvetica,12"
set grid
set origin 0.0,0.5
N=5/1.949
plot ["1104537600":"1451347200"] 'Inclined6080noBPa4-bin5d.dat' u 1:($2/$3*N) pt 7 ps 0.2 title "E > 4 EeV"
set origin 0.0,0.0
set xdata
set format x
set xtics 0,4
N=N*12*24
plot [0:24] 'Inclined6080noBPa4-binh.dat' u ($0+0.5):($1/$2*N):(sqrt($1)/$2*N) w e pt 7 ps 0.4 title ""
set size 1,1
#set origin 0.0,0.0
set xdata
set format x
unset multiplot
