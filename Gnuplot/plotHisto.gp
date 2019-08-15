## Dibuja histograma con escala logaritmica en el eje y; se deben ajustar los rangos del plot para asegurarse que no hayan bines del histograma en cero
##
n1 = 35695
n2 = 40462
n3 = 42775
h1 = 726.618
h2 = 1078.58
h3 = 1124.87
n2p = 3.*h2*n1/(4.*h1)
n3p = 3.*h3*n1/(4.*h1)
bwi = 0.1
bin(x,bw)=16.+(int((log10(x)+18-16)/bw)+0.5)*bw
#set table
#set output 'tfile1'
#plot [17.5:19] 'HeraldWeather060noBPdr6t5.dat' u (bin($10,bwi)):($3>1122854400&& $3<=1249084800?1./n1:0) s f 
#set output 'tfile2'
#plot [17.5:19] 'HeraldWeather060noBPdr6t5.dat' u (bin($10,bwi)):($3>1249084800 && $3<=1343779200?1/n2p:0) s f 
#set output 'tfile3'
#plot [17.5:19] 'HeraldWeather060noBPdr6t5.dat' u (bin($10,bwi)):($3>1343779200 && $3<=1438387200?1/n3p:0) s f 
#unset table
set size 0.6,0.6
set term postscript eps enhanced color solid
set output 'histoE.eps'
set ytics 0,1
set xlabel 'log(E)'
set ylabel 'Nev/Nev(E>3EeV)'
plot [17:20] 'tfile1' u 1:2 w his lw 2 title '2005-2009','tfile2' u 1:2 w his lw 2 lc 0 title '2009-2012','tfile3' u 1:2 w his lw 2 lc 3 title '2012-2015'
set log y
set ytics auto
set output 'histoElog.eps'
plot [17.3:19.5] 'tfile1' u 1:2 w his lw 2 title '2005-2009','tfile2' u 1:2 w his lw 2 lc 0 title '2009-2012','tfile3' u 1:2 w his lw 2 lc 3 title '2012-2015'


