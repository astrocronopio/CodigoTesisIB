#set term pdfcairo enhanced dashed font 'Helvetica,15'
#set term pngcairo enhanced dashed font 'Helvetica,15'
set term postscript eps enhanced color dashed 'Helvetica,18'
set size 0.7,0.7
set output 'UncorCorSvstheta2015_mainv4.eps'
set ylabel 'S_{0}/S'
set xlabel '{/Symbol q} [deg]'
set style fill transparent solid 0.30 noborder
#set style circle radius 0.3
#plot [0:60] 'UncorCorE2015.dat' u 2:($4>=3?$6/$5:1/0) w circles title '',1 lc 0 lt 1 lw 2 title '','UncorCorS_cont90.dat' u ($0==0?$1-2.5:$1+2.5):2 w l lc 0 lt 0 lw 4 title '','' u ($0==0?$1-2.5:$1+2.5):3 w l lc 0 lt 0 lw 4 title '90%','UncorCorS_cont68.dat' u ($0==0?$1-2.5:$1+2.5):2 w l lc 0 lt 1 lw 3 title '','' u ($0==0?$1-2.5:$1+2.5):3 w l lc 0 lt 1 lw 2 title '68%'
plot [0:60] 'UncorCorE2015.dat' u 2:($4>=3?$6/$5:1/0) pt 7 ps 0.2 title '',1 lc 0 lt 1 lw 2 title '','UncorCorS_cont90.dat' u ($0==0?$1-2.5:$1+2.5):2 w l lc 0 lt 3 lw 4 title '','' u ($0==0?$1-2.5:$1+2.5):3 w l lc 0 lt 3 lw 4 title '90%','UncorCorS_cont68.dat' u ($0==0?$1-2.5:$1+2.5):2 w l lc 0 lt 1 lw 4 title '','' u ($0==0?$1-2.5:$1+2.5):3 w l lc 0 lt 1 lw 4 title '68%'
#plot [0:60] 'UncorCorE2015.dat' u 2:($4>=3?$6/$5:1/0) pt 7 ps 0.2 title '',1 lc 0 lt 1 lw 2 title '','UncorCorS_cont90.dat' u ($0==0?$1-2.5:$1+2.5):2:3 w filledcu fc 9 title '90%','UncorCorS_cont68.dat' u ($0==0?$1-2.5:$1+2.5):2:3 w filledcu fc 0 title '68%'
