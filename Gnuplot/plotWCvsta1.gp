## Hace gráfico de los coeficientes de clima en función del tiempo.
## 
set size 0.6,0.6
set term postscript eps enhanced color solid
#set grid
#set style fill pattern 2
set title ''
set key top left
set xlabel ''
set xtics 2005,2
set mxtics 2
set style fill solid 0.3 border 
set boxwidth 3
set ylabel '{/Symbol a}_P'
set output 'aPvsta1v3.eps'
plot [2009:2016] 'aPvsta1v2' u ($1==2009?($1+$2+1.34)/2:1/0):($5-$6):($5-$6):($5+$6):($5+$6) with candlesticks title '2009-2012','' u ($1==2012?($1+$2+1.34)/2:1/0):($5-$6):($5-$6):($5+$6):($5+$6) with candlesticks lc 0 title '2012-2015','aPvsta1_last3yr' u 2:3:4 w e pt 7 lc 3 title ''
set ylabel '{/Symbol a}_{/Symbol r}'
set output 'arhovsta1v3.eps'
set key top left
plot [2009:2016] 'arhovsta1v2' u ($1==2009?($1+$2+1.34)/2:1/0):($5-$6):($5-$6):($5+$6):($5+$6) with candlesticks title '2009-2012','' u ($1==2012?($1+$2+1.34)/2:1/0):($5-$6):($5-$6):($5+$6):($5+$6) with candlesticks lc 0 title '2012-2015','arhovsta1_last3yr' u 2:3:4 w e pt 7 lc 3 title ''
set ylabel '{/Symbol b}_{/Symbol r}'
set output 'brhovsta1v3.eps'
plot [2009:2016] 'brhovsta1v2' u ($1==2009?($1+$2+1.34)/2:1/0):($5-$6):($5-$6):($5+$6):($5+$6) with candlesticks title '2009-2012','' u ($1==2012?($1+$2+1.34)/2:1/0):($5-$6):($5-$6):($5+$6):($5+$6) with candlesticks lc 0 title '2012-2015','brhovsta1_last3yr' u 2:3:4 w e pt 7 lc 3 title ''
