set terminal qt 0 enhanced font 'Verdana,26' size 1000,800 
set key right top

set title "Sidereal Frequency" offset 0,-0.5
set xtics 60
set xrange [:360]
set ylabel "Weight" offset 1 
set xlabel "Right Ascension [^o]"
plot "../Cpp/Exposure/sideral.txt" u 1:2  w lp tit "Thesis"
replot "../../Hexagons/dnhex_sideral.dat" u 0:1 w lp tit "Paper"

pause(-1)
set terminal qt 1 enhanced font 'Verdana,26' size 1000,800 
set key right bottom

set title "Solar Frequency" offset 0,-0.5
set xtics 3
set xrange [:24]
set ylabel "Weight" offset 1 
set xlabel "Local Hour [hr]"
plot "../Cpp/Exposure/solar.txt" u 1:2 w lp tit "Thesis" 
replot "../../Hexagons/dnhex_solar.dat" u 0:1 w lp tit "Paper" 


