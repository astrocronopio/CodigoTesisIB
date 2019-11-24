
#Auxiliar functions
f(x) =  c0 +  c1*x +  c2*x**2	

f4(x)= c04 + c14*x + c24*x**2	
f5(x)= c05 + c15*x + c25*x**2	
f6(x)= c06 + c16*x #+ c26*x**2	
f7(x)= c07 + c17*x #+ c27*x**2


color0="dark-magenta"; color1="dark-turquoise"; color2="blue"; color3="red"
color4="magenta"

set xlabel "sin^2{/Symbol q}"

#==============================================================================================================================

#set terminal pngcairo size 1000,750 enhanced font 'Verdana,26'
set terminal qt 0 enhanced font 'Verdana,26' size 1000,750 

set key left bottom samplen 2 spacing 0.8 width -2

first_title="a_P"
#set output imagen_first

set title "Parámetro ".first_title." para eventos mayores a 1 EeV"

set ylabel "a_P [ hPa^{-1}]"

set autoscale

set yrange [-0.007:]

#================================================================================================================================
#Todos los archivos
#set key horiz
#plot -0.0012 dt 5 lw 2 lc rgb '#7e2f8e' t  '{/Symbol q}<60^o'
#replot -0.0012 dt 3 lw 2 lc rgb 'dark-pink' t  '{/Symbol q}<60^o'

plot 			"../parameter_weather.dat"		i 0			u ($0*0.15 + 0.075):1:2 	w yerror 	lc rgb "black"	pt 2   ps 4 	lw 2 t 'Aab A. et al.'
fit 	f(x) 	"../parameter_weather.dat"		i 0			u ($0*0.15 + 0.075):1:2  	yerror  via c0, c1, c2
replot 	f(x)  	lc rgb "black"   				lw 2 t ''




replot "../../../HDD_weather/Herald_S38_S1000_expected/expected_above_1EeV_all_sin2.dat"					u 1:2:3 w yerror 	lc rgb '#7e2f8e'		pt 13  ps 4 lw 2 t '2005 a 2015'

replot "../../../HDD_weather_2019/Herald_S38_S1000_expected/expected_above_1EeV_all_sin2.dat"						u 1:2:3  w yerror 	lc rgb 'dark-pink'		pt 11  ps 4 lw 2 t '2005 a 2018'
fit f6(x) "../../../HDD_weather/Herald_S38_S1000_expected/expected_above_1EeV_all_sin2.dat"				u 1:2:3 yerror via c06, c16
fit f7(x) "../../../HDD_weather_2019/Herald_S38_S1000_expected/expected_above_1EeV_all_sin2.dat"				u 1:2:3 yerror via c07, c17

replot f6(x) lc rgb '#7e2f8e'			lw 1 t ''#
replot f7(x) lc rgb 'dark-pink'			lw 1 t ''#

															
#replot f6(x)-f(x)  lc rgb "red" t "Residual"

set terminal png size 1000,750 enhanced font 'Verdana,26'
set output "/home/ponci/Desktop/TesisIB/Coronel/TesisIB/IB_style/clima/Graphs/params/ap_ICRC_2019_above_1EeV_expected.png"
replot

#======================== ========================================================================================================
set terminal qt 2 enhanced font 'Verdana,26' size 1000,750 
set key vert
set autoscale
first_title="a_{/Symbol r}"

set ylabel "a_{/Symbol r} [kg^{-1}m^{3}]"

set key right bottom samplen 2  
set title "Parámetro ".first_title." para eventos mayores a 1 EeV"

#================================================================================================================================
#Todos los archivos
#plot -0.35 lw 2  dt 3 lc rgb '#7e2f8e' t  '{/Symbol q}<60^o'
#replot -0.32 dt 3 lw 2 lc rgb 'dark-pink' t  '{/Symbol q}<60^o'

plot "../../../HDD_weather/Herald_S38_S1000_expected/expected_above_1EeV_all_sin2.dat"				u 1:4:5 w yerror 	lc rgb '#7e2f8e'		pt 13  ps 4 lw 2 t '2005 a 2015'
replot "../../../HDD_weather_2019/Herald_S38_S1000_expected/expected_above_1EeV_all_sin2.dat"				u 1:4:5  w yerror 	lc rgb 'dark-pink'		pt 11  ps 4 lw 2 t '2005 a 2018'
fit f6(x) "../../../HDD_weather/Herald_S38_S1000_expected/expected_above_1EeV_all_sin2.dat"				u 1:4:5 yerror via c06, c16
fit f7(x) "../../../HDD_weather_2019/Herald_S38_S1000_expected/expected_above_1EeV_all_sin2.dat"				u 1:4:5 yerror via c07, c17
#replot f7(x) 			
replot f6(x) lc rgb '#7e2f8e'			lw 1 t ''#
replot f7(x) lc rgb 'dark-pink'			lw 1 t ''#

	
replot 			"../parameter_weather.dat"		i 1			u ($0*0.15 + 0.075):1:2 	w yerror 	lc rgb "black"	pt 6   ps 4 	lw 2 t 'Aab A. et al.'
fit 	f(x) 	"../parameter_weather.dat"		i 1			u ($0*0.15 + 0.075):1:2  	yerror  via c0, c1, c2
replot 	f(x)  	lc rgb "black"   				lw 2 t ''

			
#replot f6(x)-f(x)  lc rgb "red" t "Residual"

set terminal png size 1000,750 enhanced font 'Verdana,26'
set output "/home/ponci/Desktop/TesisIB/Coronel/TesisIB/IB_style/clima/Graphs/params/arho_ICRC_2019_above_1EeV_expected.png"
replot

#================================================================================================================================

set terminal qt 3  enhanced font 'Verdana,26' size 1000,750
set key vert
set autoscale
first_title="b_{/Symbol r}"

set ylabel "b_{/Symbol r} [kg^{-1}m^{3}]"

set key right bottom height 0 
set title "Parámetro ".first_title." para eventos mayores a 1 EeV"

#================================================================================================================================
#Todos los archivos
#plot -0.15 dt 3 lw 2 lc rgb '#7e2f8e' t  '{/Symbol q}<60^o'
#replot -0.16 dt 3 lw 2 lc rgb 'dark-pink' t  '{/Symbol q}<60^o'

plot "../../../HDD_weather/Herald_S38_S1000_expected/expected_above_1EeV_all_sin2.dat"				u 1:6:7 w yerror 	lc rgb '#7e2f8e'		pt 13  ps 4 lw 2 t '2005 a 2015'
replot "../../../HDD_weather_2019/Herald_S38_S1000_expected/expected_above_1EeV_all_sin2.dat"				u 1:6:7  w yerror 	lc rgb 'dark-pink'		pt 11  ps 4 lw 2 t '2005 a 2018'
fit f6(x) "../../../HDD_weather/Herald_S38_S1000_expected/expected_above_1EeV_all_sin2.dat"				u 1:6:7  yerror via c06, c16
fit f7(x) "../../../HDD_weather_2019/Herald_S38_S1000_expected/expected_above_1EeV_all_sin2.dat"				u 1:6:7  yerror via c07, c17

replot f6(x) lc rgb '#7e2f8e'			lw 1 t ''#
replot f7(x) lc rgb 'dark-pink'			lw 1 t ''#

#replot f7(x) 																		lc rgb '#7e2f8e'			lw 2 t ''#


replot 			"../parameter_weather.dat"		i 2			u ($0*0.15 + 0.075):1:2 	w yerror 	lc rgb "black"	pt 6   ps 4 	lw 2 t 'Aab A. et al.'
fit 	f(x) 	"../parameter_weather.dat"		i 2			u ($0*0.15 + 0.075):1:2  	yerror  via c0, c1, c2
replot 	f(x)  	lc rgb "black"   				lw 2 t ''
	

#replot f6(x)-f(x)  lc rgb "red" t "Residual"

set terminal png size 1000,750 enhanced font 'Verdana,26'
set output "/home/ponci/Desktop/TesisIB/Coronel/TesisIB/IB_style/clima/Graphs/params/brho_ICRC_2019_above_1EeV_expected.png"
replot

pause(-1)