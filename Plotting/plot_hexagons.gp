set terminal qt 0 enhanced font 'Verdana,26' size 1000,800 
set key right top

set title "Sidereal Frequency N=288" offset 0,-0.5
set xtics 60
set xrange [:360]
set ylabel "Weight" offset 1 
set xlabel "Right Ascension [^o]"
#plot "../Cpp/Exposure/sideral_288.txt" u ($1*360/288):2  w lp tit "Thesis"
#replot "../../Hexagons/hexagons_2018/dnhex_sidereal_288.dat" u ($0*360/288):1 w lp tit "Paper"

set terminal qt 1 enhanced font 'Verdana,26' size 1000,800 
set key right top

set title "Sidereal Frequency N=360" offset 0,-0.5
set xtics 60
set xrange [:360]
set ylabel "Weight" offset 1 
set xlabel "Right Ascension [^o]"
plot "../Cpp/Exposure/sideral_360.txt" u ($1*360/360):2  w lp tit "Thesis"
replot "../../Hexagons/hexagons_2018/dnhex_sidereal_360.dat" u ($0*360/360):1 w lp tit "Paper"


set terminal qt 2 enhanced font 'Verdana,26' size 1000,800 
set key right top

mod(x,y) =  x - int(x/y)*y => 0?  x - int(x/y)*y  : x - int(x/y)*y  +y

set title "Sidereal Frequency N=24" offset 0,-0.5
set xtics 60
set xrange [:360]
set ylabel "Weight" offset 1 
set xlabel "Right Ascension [^o]"
plot "../Cpp/Exposure/sideral_24.txt" u ($1*360/24):2  w lp tit "Thesis"
replot "../../Hexagons/hexagons_2018/dnhex_sidereal_24.dat" u ($0*360/24):1 w lp tit "Paper"

########################
########################
########################
########################

pause(-1)

set terminal qt 3 enhanced font 'Verdana,26' size 1000,800 
set key right top

set title "Anti-Sidereal Frequency (N=288)y" offset 0,-0.5
set xtics 60
set xrange [:360]
set ylabel "Weight" offset 1 
set xlabel "Right Ascension [^o]"
plot "../Cpp/Exposure/anti_288.txt" u ($1*360/288):2  w lp tit "Thesis"
replot "../../Hexagons/hexagons_2018/dnhex_antisiderea_288.dat" u ($0*360/288):1 w lp tit "Paper"


set terminal qt 4 enhanced font 'Verdana,26' size 1000,800 
set key right top

set title "Anti-Sidereal Frequency (N=24)" offset 0,-0.5
#set xtics 60
#set xrange [:360]
set ylabel "Weight" offset 1 
#set xlabel "Local Hour [hr]"
plot "../Cpp/Exposure/anti_24.txt" u ($1*360/24):2 w lp tit "Thesis" 
replot "../../Hexagons/hexagons_2018/dnhex_antisiderea_24.dat" u ($0*360/24):1 w lp tit "Paper" 



set terminal qt 5 enhanced font 'Verdana,26' size 1000,800 
set key right top

set title "Anti-Sidereal Frequency (N=360)y" offset 0,-0.5
set xtics 60
set xrange [:360]
set ylabel "Weight" offset 1 
set xlabel "Right Ascension [^o]"
plot "../Cpp/Exposure/anti_360.txt" u ($1*360/360):2  w lp tit "Thesis"
replot "../../Hexagons/hexagons_2018/dnhex_antisiderea_360.dat" u ($0*360/360):1 w lp tit "Paper"


set terminal qt 6 enhanced font 'Verdana,26' size 1000,800 
set key right top

set title "Anti-Sidereal Frequency (N=24)" offset 0,-0.5
#set xtics 60
#set xrange [:360]
set ylabel "Weight" offset 1 
#set xlabel "Local Hour [hr]"
plot "../Cpp/Exposure/anti_24.txt" u ($1*360/24):2 w lp tit "Thesis" 
replot "../../Hexagons/hexagons_2018/dnhex_antisiderea_24.dat" u ($0*360/24):1 w lp tit "Paper" 

########################
########################
########################
########################

set terminal qt 3 enhanced font 'Verdana,26' size 1000,800 
set key right top

set title "Solar Frequency (N=288)y" offset 0,-0.5
set xtics 3
set xrange [:24.1]
set ylabel "Weight" offset 1 
set xlabel "Local Hour [hr]"
plot "../Cpp/Exposure/solar_288.txt" u ($1*24/288):2  w lp tit "Thesis"
replot "../../Hexagons/hexagons_2018/dnhex_solar_288.dat" u ($0*24/288):1 w lp tit "Paper"


set terminal qt 4 enhanced font 'Verdana,26' size 1000,800 
set key right top

set title "Solar Frequency (N=24)" offset 0,-0.5
set xtics 3
set xrange [:24.1]

set ylabel "Weight" offset 1 
#set xlabel "Local Hour [hr]"
plot "../Cpp/Exposure/solar_24.txt" u ($1*24/24):2 w lp tit "Thesis" 
replot "../../Hexagons/hexagons_2018/dnhex_solar_24.dat" u ($0*24/24):1 w lp tit "Paper" 



set terminal qt 5 enhanced font 'Verdana,26' size 1000,800 
set key right top

set title "Solar Frequency (N=360)" offset 0,-0.5
set xtics 60
set xrange [:360]
set ylabel "Weight" offset 1 
set xlabel "Right Ascension [^o]"
plot "../Cpp/Exposure/solar_360.txt" u ($1*360/360):($2>1 ? $2: 1/0)  w lp tit "Thesis"
replot "../../Hexagons/hexagons_2018/dnhex_solar_360.dat" u ($0*360/360):($1>1 ? $1: 1/0) w lp tit "Paper"
