set terminal qt 0 enhanced font 'Verdana,26' size 1000,800 
set key right top

set title "paper 2016 N=360" offset 0,-0.5
set xtics 60
set xrange [:360]
set ylabel "Weight" offset 1 
set xlabel "Right Ascension [^o]"

plot "../../Hexagons/dnhex_sid_360.dat" u 0:1 w lp tit "Sid"
replot "../../Hexagons/dnhex_anti_360.dat" u 0:1 w lp tit "Anti"
replot "../../Hexagons/dnhex_solar_360.dat"  u 0:1 w lp tit "Solar"

set terminal qt 1 enhanced font 'Verdana,26' size 1000,800 
set key right top

set title "paper 2016 N=288" offset 0,-0.5
set xtics 60
set xrange [:360]
set ylabel "Weight" offset 1 
set xlabel "Right Ascension [^o]"

plot "../../Hexagons/dnhex_sid_288.dat" u 0:1 w lp tit "Sid"
replot "../../Hexagons/dnhex_anti_288.dat" u 0:1 w lp tit "Anti"
replot "../../Hexagons/dnhex_solar_288.dat"  u 0:1 w lp tit "Solar"


set terminal qt 2 enhanced font 'Verdana,26' size 1000,800 
set key right top

set title "paper 2016 N=24" offset 0,-0.5
set xtics 6
set xrange [:25]
set ylabel "Weight" offset 1 
set xlabel "Right Ascension [^o]"

plot "../../Hexagons/dnhex_sid_24.dat" u 0:1 w lp tit "Sid"
replot "../../Hexagons/dnhex_anti_24.dat" u 0:1 w lp tit "Anti"
replot "../../Hexagons/dnhex_solar_24.dat"  u 0:1 w lp tit "Solar"


set terminal qt 3 enhanced font 'Verdana,26' size 1000,800 
set key left bottom horiz


set title "paper 2016, paper 2018 N=24" offset 0,-0.5
set xtics 6
set xrange [:25]
set ylabel "Weight" offset 1 
set xlabel "Right Ascension [^o]"

plot "../../Hexagons/hexagons_2018/dnhex_sidereal_24.dat" u 0:1 w lp tit "Sid-18"
replot "../../Hexagons/hexagons_2018/dnhex_antisiderea_24.dat" u 0:1 w lp tit "Anti-18"
replot "../../Hexagons/hexagons_2018/dnhex_solar_24.dat"  u 0:1 w lp tit "Solar-18"


replot "../../Hexagons/dnhex_sid_24.dat" u 0:1 w lp tit "Sid-16"
replot "../../Hexagons/dnhex_anti_24.dat" u 0:1 w lp tit "Anti-16"
replot "../../Hexagons/dnhex_solar_24.dat"  u 0:1 w lp tit "Solar-16"



set terminal qt 4 enhanced font 'Verdana,26' size 1200,800 
set key right bottom  s 0.5

set title "paper 2018, my thesis N=24" offset 0,-0.5
set xtics 60
set xrange [:360]
set ylabel "Weight" offset 1 
set xlabel "Right Ascension [^o]"

plot "../../Hexagons/hexagons_2018/dnhex_sidereal_24.dat" 		u ($0*360/24):1 w lp pt 1 ps 3 tit "Sid-18"
replot "../../Hexagons/hexagons_2018/dnhex_antisiderea_24.dat" 	u ($0*360/24):1 w lp pt 2 ps 3 tit "Anti-18"
replot "../../Hexagons/hexagons_2018/dnhex_solar_24.dat"  		u ($0*360/24):1 w lp pt 3 ps 3 tit "Solar-18"


replot "../Cpp/Exposure/data_files/sideral_24.txt" u ($0*360/24):2 w lp pt 4 ps 3 tit "Sid-Thesis"
replot "../Cpp/Exposure/data_files/anti_24.txt" 	u ($0*360/24):2 w lp pt 8 ps 3 tit "Anti-Thesis"
replot "../Cpp/Exposure/data_files/solar_24.txt"  	u ($0*360/24):2 w lp pt 6 ps 3 tit "Solar-Thesis"




set terminal qt 5 enhanced font 'Verdana,26' size 1200,800 
set key left bottom  s 0.5

set xtics 60
set xrange [:360]
set title "Diff:  my thesis minus paper 2018 " offset 0,-0.5
set ylabel "Weight Error %" offset 1 
set xlabel "Right Ascension [^o]"

plot "../Cpp/Exposure/data_files/sideral_360.txt" u 0:(($2-$3)*100/$3) w lp notit 




set terminal qt 6 enhanced font 'Verdana,26' size 1200,800 
set key right top  s 0.5

set title "paper 2018, my thesis N=24" offset 0,-0.5
set xtics 60
set xrange [:360]
set ylabel "Weight" offset 1 
set xlabel "Right Ascension [^o]"

plot "../../Hexagons/hexagons_2018/dnhex_sidereal_24.dat" 		u ($0*360/24):1 w lp lw 3 pt 1 ps 3 tit "Sid-18"
replot "../../Hexagons/hexagons_2018/dnhex_sidereal_alternative_24.dat" 	u ($0*360/24):1 w lp lw 1.5 pt 2 ps 3 tit "Sid-18 Altern."
replot "../../Hexagons/hexagons_2018/dnhex_sidereal_alternative_24.dat" 	u ($0*360/24):2 w lp lw 3 dt 2 pt 3 ps 1.5 tit "Sid-18 Altern.+75^o"




set terminal qt 7 enhanced font 'Verdana,26' size 1000,800 
set key right bottom sample 0.3 horiz

set title "Solar Frequency (N=360)" offset 0,-0.5
set xtics 60
set xrange [:360]
set ylabel "Weight" offset 1 
set xlabel "Right Ascension [^o]"
plot "../Cpp/Exposure/data_files/solar_360.txt" u ($1*360/360):($2>1 ? $2: 1/0)  w lp lw 1.5 pt 3 ps 1.5  tit "Thesis"
replot "../../Hexagons/hexagons_2018/dnhex_solar_360.dat" u ($0*360/360):($1>1 ? $1: 1/0) w lp  lw 1.5 pt 4 ps 1.5 tit "Paper"


set terminal qt 8 enhanced font 'Verdana,26' size 1000,800 
set key right bottom sample 0.3 horiz

set title "My thesis N=288" offset 0,-0.5
set xtics 60
set xrange [:360]
set ylabel "Weight" offset 1 
set xlabel "Right Ascension [^o]"

plot "../Cpp/Exposure/data_files/sideral_288.txt" 	u ($0*360/288):2 w lp tit "Sid"
replot "../Cpp/Exposure/data_files/anti_288.txt" 	u ($0*360/288):2 w lp tit "Anti"
replot "../Cpp/Exposure/data_files/solar_288.txt"  u ($0*360/288):2 w lp tit "Solar"


set terminal qt 9 enhanced font 'Verdana,26' size 1000,800 
set key right bottom sample 0.3 horiz

set title "paper 2018 N=288" offset 0,-0.5
set xtics 60
set xrange [:360]
set ylabel "Weight" offset 1 
set xlabel "Right Ascension [^o]"

plot "../../Hexagons/hexagons_2018/dnhex_sidereal_288.dat" 		u ($0*360/288):1 w lp tit "Sid"
replot "../../Hexagons/hexagons_2018/dnhex_antisiderea_288.dat" u ($0*360/288):1 w lp tit "Anti"
replot "../../Hexagons/hexagons_2018/dnhex_solar_288.dat"  		u ($0*360/288):1 w lp tit "Solar"


set terminal qt 10 enhanced font 'Verdana,26' size 1000,800 
set key left  bottom sample 0.3 horiz

set title "paper 2018, my thesis anti N=288" offset 0,-0.5
set xtics 60
set xrange [:360]
set ylabel "Weight" offset 1 
set xlabel "Right Ascension [^o]"

plot "../../Hexagons/hexagons_2018/dnhex_antisiderea_288.dat" u ($0*360/288):1 w lp tit "Anti-18"
replot "../Cpp/Exposure/data_files/anti_288.txt" 	u ($0*360/288):2 w lp tit "Anti-The"



set terminal qt 11 enhanced font 'Verdana,26' size 1000,800 
set key left  bottom sample 0.3 horiz

set title "paper 2018, my thesis solar N=288" offset 0,-0.5
set xtics 60
set xrange [:360]
set ylabel "Weight" offset 1 
set xlabel "Right Ascension [^o]"

plot "../../Hexagons/hexagons_2018/dnhex_solar_288.dat" u ($0*360/288):1 w lp tit "Solar-18"
replot "../Cpp/Exposure/data_files/solar_288.txt" 	u ($0*360/288):2 w lp tit "Solar-The"




set terminal qt 12 enhanced font 'Verdana,26' size 1200,800 
set key left bottom  s 0.5

set xtics 60
set xrange [:360]
set title "Diff:  my thesis minus paper 2018, solar N=288 " offset 0,-0.5
set ylabel "Weight Error %" offset 1 
set xlabel "Right Ascension [^o]"

plot "../Cpp/Exposure/data_files/solar_288.txt" u ($0*360/288):(($2-$3)*100/$3) w lp notit 



set terminal qt 13 enhanced font 'Verdana,26' size 1200,800 
set key left bottom  s 0.5

set xtics 60
set xrange [:360]
set title "Diff:  my thesis minus paper 2018, anti N=288 " offset 0,-0.5
set ylabel "Weight Error %" offset 1 
set xlabel "Right Ascension [^o]"

plot "../Cpp/Exposure/data_files/anti_288.txt" u ($0*360/288):(($2-$3)*100/$3) w lp notit 



set terminal qt 14 enhanced font 'Verdana,26' size 1200,800 
set key left bottom  s 0.5

set xtics 60
set xrange [:360]
set title "Diff:  my thesis minus paper 2018, sid N=288 " offset 0,-0.5
set ylabel "Weight Error %" offset 1 
set xlabel "Right Ascension [^o]"

plot "../Cpp/Exposure/data_files/sideral_288.txt" u ($0*360/288):(($2-$3)*100/$3) w lp notit 


set terminal qt 15 enhanced font 'Verdana,26' size 1000,800 
set key left  bottom sample 0.3 horiz

set title "paper 2018, my thesis sid N=288" offset 0,-0.5
set xtics 60
set xrange [:360]
set ylabel "Weight" offset 1 
set xlabel "Right Ascension [^o]"

plot "../../Hexagons/hexagons_2018/dnhex_sidereal_288.dat" u ($0*360/288):1 w lp tit "Solar-18"
replot "../Cpp/Exposure/data_files/sideral_288.txt" 	u ($0*360/288):2 w lp tit "Solar-The"




set terminal png 16 enhanced font 'Times,26' size 1200,800 
set output "../Cpp/Anisotropy/Report/weigth2013-2019.png"
set key left bottom sample 0.5 vert

set title "2013-2019" offset 0,-0.5
set xtics 4
set xrange [:24.1]
set ylabel "Weight" offset 1 
set xlabel "Local Hour [hr]"

plot 	"../Cpp/Exposure/data_files/sideral_2019_report_on_anisotropy_288.txt" 		u ($0*24/288):2 w lp pt 4 ps 1.5 lc rgb 'red'   tit "Sid" ,\
	 	"../Cpp/Exposure/data_files/anti_2019_report_on_anisotropy_288.txt"	 		u ($0*24/288):2 w lp pt 6 ps 1.5 lc rgb 'blue'  tit "Anti" ,\
	 	"../Cpp/Exposure/data_files/solar_2019_report_on_anisotropy_288.txt"  		u ($0*24/288):2 w lp pt 8 ps 1.5 lc rgb 'black' tit "Solar"

set terminal qt 16 enhanced font 'Times,26' size 1200,800 
replot




set terminal png 17 enhanced font 'Times,26' size 1200,800 
set output "../Cpp/Anisotropy/Report/weigth2005-2019.png"
set key left bottom sample 0.5 vert

set title "2005-2019" offset 0,-0.5
set xtics 4
set xrange [:24.1]
set ylabel "Weight" offset 1 
set xlabel "Local Hour [hr]"

plot 	"../Cpp/Exposure/data_files/sideral_2019_report_on_anisotropy_288extended.txt" 		u ($0*24/288):2 w lp pt 4 ps 1.5 lc rgb 'red'   tit "Sid" ,\
	 	"../Cpp/Exposure/data_files/anti_2019_report_on_anisotropy_288extended.txt"	 		u ($0*24/288):2 w lp pt 6 ps 1.5 lc rgb 'blue'  tit "Anti" ,\
	 	"../Cpp/Exposure/data_files/solar_2019_report_on_anisotropy_288extended.txt"  		u ($0*24/288):2 w lp pt 8 ps 1.5 lc rgb 'black' tit "Solar"

set terminal qt 17 enhanced font 'Times,26' size 1200,800 
replot

set terminal png 18 enhanced font 'Times,26' size 1200,800 
set output "../Cpp/Anisotropy/Report/weigth2004-2017.png"
set key left bottom sample 0.5 vert

set title "2004-2017" offset 0,-0.5
set xtics 4
set xrange [:24.1]
set ylabel "Weight" offset 1 
set xlabel "Local Hour [hr]"

plot 	"../Cpp/Exposure/data_files/sideral_2019_report_on_anisotropy_288_2004_2017.txt" 		u ($0*24/288):2 w lp pt 4 ps 1.5 lc rgb 'red'     tit "Sid" ,\
	 	"../Cpp/Exposure/data_files/anti_2019_report_on_anisotropy_288_2004_2017.txt"	 		u ($0*24/288):2 w lp pt 6 ps 1.5 lc rgb 'blue'    tit "Anti" ,\
	 	"../Cpp/Exposure/data_files/solar_2019_report_on_anisotropy_288_2004_2017.txt"  		u ($0*24/288):2 w lp pt 8 ps 1.5 lc rgb 'black'   tit "Solar"

set terminal qt 18 enhanced font 'Times,26' size 1200,800 
replot



set terminal png 19 enhanced font 'Times,26' size 1200,800 
set output "weigth2014-2019_jan.png"
set key left bottom sample 0.5 vert

set title "Jan 2014 - Jan 2019" offset 0,-0.5
set xtics 4
set xrange [:24.1]
set ylabel "Weight" offset 1 
set xlabel "Local Hour [hr]"

plot 	"../Cpp/Exposure/sideral_2019_report_on_anisotropy_288_2013_2019_1.txt" 		u ($0*24/288):2 w lp pt 4 ps 1.5 lc rgb 'red'     tit "Sid" ,\
	 	"../Cpp/Exposure/anti_2019_report_on_anisotropy_288_2013_2019.txt"	 		u ($0*24/288):2 w lp pt 6 ps 1.5 lc rgb 'blue'    tit "Anti" ,\
	 	"../Cpp/Exposure/solar_2019_report_on_anisotropy_288_2013_2019.txt"  		u ($0*24/288):2 w lp pt 8 ps 1.5 lc rgb 'black'   tit "Solar"

set terminal qt 19 enhanced font 'Times,26' size 1200,800 
replot
