
#Auxiliar functions
f(x) =  c0 +  c1*x +  c2*x**2	

f4(x)= c04 + c14*x + c24*x**2	
f5(x)= c05 + c15*x + c25*x**2	
f6(x)= c06 + c16*x + c26*x**2	
f7(x)= c07 + c17*x + c27*x**2

color0="dark-magenta"; color1="dark-pink"; color2="blue"; color3="red"
color4="magenta"

set xlabel "sin^2{/Symbol q}"

#==============================================================================================================================

#set terminal pngcairo size 1000,750 enhanced font 'Verdana,26'
set terminal qt 0 enhanced font 'Verdana,26' size 1000,750 

set key left bottom
first_title="a_P"
#set output imagen_first

set title "Parámetro ".first_title." S38 no corregido (1 EeV)"

set ylabel "a_P [hPa^{-1}]"

set autoscale

set yrange [-0.0075:]

plot 			"../parameter_weather.dat"		i 0			u ($0*0.15 + 0.075):1:2 	w yerror 	lc rgb "black"	pt 2   ps 4 	lw 2 t 'Aab A. et al'
fit 	f(x) 	"../parameter_weather.dat"		i 0			u ($0*0.15 + 0.075):1:2  	yerror  via c0, c1, c2
replot 	f(x)  	lc rgb "black"   				lw 2 t ''

#================================================================================================================================
#Todos los archivos

replot "../../../HDD_weather/Herald_S38_S1000_expected/expected_above_1EeV_all_sin2.dat"					u 1:($2+0.00085*0):3 w yerror 	lc rgb  "dark-pink"		pt 13  ps 4 lw 2 t 'S38 - ICRC 2019'
fit f7(x) "../../../HDD_weather/Herald_S38_S1000_expected/expected_above_1EeV_all_sin2.dat"					u 1:($2+0.00085*0):3 yerror via c07, c17, c27
replot f7(x) 																		lc rgb  "dark-pink"			lw 2 t ''#
															
set terminal png size 1000,750 enhanced font 'Verdana,26'
set output "/home/ponci/Desktop/TesisIB/Coronel/TesisIB/IB_style/clima/Graphs/params//ap_ICRC_2019_expected_above_1EeV.png"
replot

#======================== ========================================================================================================
set terminal qt 2 enhanced font 'Verdana,26' size 1000,750 

set autoscale
first_title="a_{/Symbol r}"

set ylabel "a_{/Symbol r} [kg^{-1}m^{3}]"

set key right bottom
set title "Parámetro ".first_title." S38 no corregido (1 EeV)"

plot 			"../parameter_weather.dat"		i 1			u ($0*0.15 + 0.075):1:2 	w yerror 	lc rgb "black"	pt 6   ps 4 	lw 2 t 'Aab A. et al'
fit 	f(x) 	"../parameter_weather.dat"		i 1			u ($0*0.15 + 0.075):1:2  	yerror  via c0, c1, c2
replot 	f(x)  	lc rgb "black"   				lw 2 t ''
#================================================================================================================================
#Todos los archivos


replot 		"../../../HDD_weather/Herald_S38_S1000_expected/expected_above_1EeV_all_sin2.dat"					u 1:($4-0.099*0):5 w yerror 	lc rgb  "dark-pink"		pt 13  ps 4 lw 2 t 'S38 - ICRC 2019'
fit f7(x) "../../../HDD_weather/Herald_S38_S1000_expected/expected_above_1EeV_all_sin2.dat"				u 1:($4-0.099*0):5 yerror via c07, c17, c27
replot f7(x) 																		lc rgb  "dark-pink"			lw 2 t ''#
	

			
#replot f6(x)-f(x)  lc rgb "red" t "Residual"

set terminal png size 1000,750 enhanced font 'Verdana,26'
set output "/home/ponci/Desktop/TesisIB/Coronel/TesisIB/IB_style/clima/Graphs/params//arho_ICRC_2019_expected_above_1EeV.png"
replot

#================================================================================================================================

set terminal qt 3  enhanced font 'Verdana,26' size 1000,750

set autoscale
first_title="b_{/Symbol r}"

set ylabel "b_{/Symbol r} [kg^{-1}m^{3}]"

set key right bottom
set title "Parámetro ".first_title." S38 no corregido (1 EeV)"

plot 			"../parameter_weather.dat"		i 2			u ($0*0.15 + 0.075):1:2 	w yerror 	lc rgb "black"	pt 6   ps 4 	lw 2 t 'Aab A. et al'
fit 	f(x) 	"../parameter_weather.dat"		i 2			u ($0*0.15 + 0.075):1:2  	yerror  via c0, c1, c2
replot 	f(x)  	lc rgb "black"   				lw 2 t ''

#================================================================================================================================
#Todos los archivos

replot "../../../HDD_weather/Herald_S38_S1000_expected/expected_above_1EeV_all_sin2.dat"				u 1:6:7 w yerror 	lc rgb  "dark-pink"		pt 13  ps 4 lw 2 t 'S38 - ICRC 2019'
fit f7(x) "../../../HDD_weather/Herald_S38_S1000_expected/expected_above_1EeV_all_sin2.dat"				u 1:6:7  yerror via c07, c17, c27
replot f7(x) 																		lc rgb  "dark-pink"			lw 2 t ''#
	

set terminal png size 1000,750 enhanced font 'Verdana,26'
set output "/home/ponci/Desktop/TesisIB/Coronel/TesisIB/IB_style/clima/Graphs/params//brho_ICRC_2019_expected_above_1EeV.png"
replot

#================================================================================================================================
pause(-1)