set term postscript eps enhanced color 'Helvetica,17'
set output 'Rateha2_main_01012005_31122015_UncorCorEv2_loc.eps'
N=12*24*5/1.949
fit a 'Herald060noBPa2-binh_wca1.dat' u ($0+0.5):($1/$2*N):(sqrt($1)/$2*N) via a
fit b 'Herald060noBPa2-binh_nowc.dat' u ($0+0.5):($1/$2*N):(sqrt($1)/$2*N) via b
set multiplot			#para generar varios gráficos en la misma pantalla
set size 1,0.5
#set grid
set ytics 0.041,0.001
set mytics 2
set ylabel 'Rate of events [day^{-1}km^{-2}]' font "Helvetica,15"
set xtics 0,4
set origin 0.0,0.5
set title "Uncorrected Energy" font "Helvetica Bold,15"
plot [0:24][0.042:0.046] 'Herald060noBPa2-binh_nowc.dat' u ($0<3?24+$0-3+0.5:$0-3+0.5):($1/$2*N):(sqrt($1)/$2*N) w e pt 7 title "",b lt 0 lw 4 lc 0 title ''
set origin 0.0,0.0
set title "Corrected Energy" font "Helvetica Bold,15"
set xlabel 'Hour of the day (Local Time)'
plot [0:24][0.042:0.046] 'Herald060noBPa2-binh_wca1.dat' u ($0<3?24+$0-3+0.5:$0-3+0.5):($1/$2*N):(sqrt($1)/$2*N) w e pt 7 title "",a lt 0 lw 4 lc 0 title ''
set size 1,1
unset multiplot
