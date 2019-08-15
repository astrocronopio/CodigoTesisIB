## Hace gráfico de los coeficientes de clima en función del tiempo.
## 
set size 0.6,0.6
set term postscript eps enhanced color solid
#set grid
#set style fill pattern 2
set title ''
set ylabel '{/Symbol a}_P'
set output 'aPvstv2.3.eps'
set key top left
set xlabel ''
set xtics 2005,2
set mxtics 2
plot [2005:2016] -0.00109861+0.00007 w filledcurve y1=-0.00109861-0.00007 lc 1 fillstyle pattern 0.5 title '',-0.00153488+0.0001 w filledcurve y1=-0.00153488-0.0001 lc 3 fillstyle pattern 0.5 title '', 'aPvstv2' u (($1+$2)/2+0.5):7:8 w e pt 7 lc 1 title 'All E','aPvsta1v2' u (($1+$2)/2+0.5):5:6 w e pt 6 lc 3 title 'E > 1 EeV'
set ylabel '{/Symbol a}_{/Symbol r}'
set output 'arhovstv2.3.eps'
set key top left
#plot [2005:2016] 'arhovstv2' u (($1+$2)/2+0.5):7:8 w e pt 7 lc 1 title 'Fit Decay','arhovstv2' u (($1+$2)/2+0.5):9:10 w e pt 6 lc 3 title 'No fit Decay'
plot [2005:2016] -0.83+0.01 w filledcurve y1=-0.83-0.01 lc 1 fillstyle pattern 0.5 title '',-0.75+0.02 w filledcurve y1=-0.75-0.02 lc 3 fillstyle pattern 0.5 title '', 'arhovstv2' u (($1+$2)/2+0.5):7:8 w e pt 7 lc 1 title 'All E','arhovsta1v2' u (($1+$2)/2+0.5):5:6 w e pt 6 lc 3 title 'E > 1 EeV'
#'arhovstv2' u (($1+$2)/2+0.5):5:6 w e pt 5 lc 3 title '{/Symbol a}_P=-0.0011'
set ylabel '{/Symbol b}_{/Symbol r}'
set output 'brhovstv2.3.eps'
set key top left
plot [2005:2016] -0.24+0.01 w filledcurve y1=-0.24-0.01 lc 1 fillstyle pattern 0.5 title '',-0.21+0.02 w filledcurve y1=-0.21-0.02 lc 3 fillstyle pattern 0.5 title '','brhovstv2' u (($1+$2)/2+0.5):7:8 w e pt 7 lc 1 title 'All E','brhovsta1v2' u (($1+$2)/2+0.5):5:6 w e pt 6 lc 3 title 'E > 1 EeV'
set ylabel '{/Symbol a}_P'
set output 'aPvstv3.eps'
set key top left
f(x)=x>2009.67 && x<2012.67 ? -0.000923775+0.000119499 :1/0
g(x)=x>2012.67 && x<2015.67 ? -0.00143775+0.000123487 :1/0
plot [2009:2016] f(x)  w filledcurve y1=-0.000923775-0.000119499 lc 1 fillstyle solid 0.5 title '2009-2012',g(x) w filledcu y1=-0.00143775-0.000123487 lc 0 fillstyle solid 0.5 title '2012-2015','aPvst_last3yr' u 2:3:4 w e pt 7 lc 3 title ''
set ylabel '{/Symbol a}_{/Symbol r}'
set output 'arhovstv3.eps'
set key top left
f(x)=x>2009.67 && x<2012.67 ? -0.85067+0.0163071 :1/0
g(x)=x>2012.67 && x<2015.67 ? -0.734191+0.0177611 :1/0
plot [2009:2016] f(x)  w filledcurve y1=-0.85067-0.0163071 lc 1 fillstyle solid 0.5 title '2009-2012',g(x) w filledcu y1=-0.734191-0.0177611 lc 0 fillstyle solid 0.5 title '2012-2015','arhovst_last3yr' u 2:3:4 w e pt 7 lc 3 title ''
set ylabel '{/Symbol b}_{/Symbol r}'
set output 'brhovstv3.eps'
f(x)=x>2009.67 && x<2012.67 ? -0.228516+0.0172541 :1/0
g(x)=x>2012.67 && x<2015.67 ? -0.238719+0.0176439 :1/0
plot [2009:2016] f(x)  w filledcurve y1=-0.228516-0.0172541 lc 1 fillstyle solid 0.5 title '2009-2012',g(x) w filledcu y1=-0.238719-0.0176439 lc 0 fillstyle solid 0.5 title '2012-2015','brhovst_last3yr' u 2:3:4 w e pt 7 lc 3 title ''
