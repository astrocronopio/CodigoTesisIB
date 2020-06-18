set terminal qt 19 enhanced font 'Times,26' size 1200,800 
set key right bottom sample 0.3 horiz

set title "paper 2018 N=288" offset 0,-0.5
set xtics 60
set xrange [:360]
set ylabel "Weight" offset 1 
set xlabel "Right Ascension [^o]"

plot "../../Hexagons/hexagons_2018/dnhex_sidereal_288.dat" 		u ($0*360/288):1 w lp lc rgb "red" tit "Sid"
replot "../../Hexagons/hexagons_2018/dnhex_antisiderea_288.dat" u ($0*360/288):1 w lp lc rgb "blue" tit "Anti"
replot "../../Hexagons/hexagons_2018/dnhex_solar_288.dat"  		u ($0*360/288):1 w lp lc rgb "black" tit "Solar"
