
#Auxiliar functions
f(x) =  c0 +  c1*x +  c2*x**2	

f4(x)= c04 + c14*x + c24*x**2	
f5(x)= c05 + c15*x + c25*x**2	
f6(x)= c06 + c16*x + c26*x**2	
f7(x)= c07 + c17*x + c27*x**2


color0="dark-magenta"; color1="dark-turquoise"; color2="blue"; color3="red"
color4="magenta"

set xlabel "sin^2{/Symbol q}"
#==============================================================================================================================

filename= "../../Weather_code/AllTriggers/2017/weather_analysis/AllTriggers_cutted_time_S38_1EeV_all_sin2.dat"	
#==============================================================================================================================

#set terminal pngcairo size 1000,750 enhanced font 'Verdana,26'
set terminal qt 10 enhanced font 'Verdana,26' size 1000,750 

set key right top
first_title="a_P"

#set title "Parámetro ".first_title." para eventos mayores a 1 EeV"
set ylabel "a_P [hPa^{-1}]"

set autoscale

plot 			"parameter_weather.dat"		i 0			u ($0*0.15 + 0.075):1:2 	w yerror 	lc rgb "black"	pt 2   ps 4 	lw 2 t 'Aab A. et al.'
fit 	f(x) 	"parameter_weather.dat"		i 0			u ($0*0.15 + 0.075):1:2  	yerror  via c0, c1, c2
replot 	f(x)  	lc rgb "black"   				lw 2 t ''

#================================================================================================================================
#Todos los archivos

replot 		filename		u 1:($2):3  w yerror 	lc rgb '#77ac30'	pt 13  ps 4 lw 2 t 'Herald'
fit f7(x) 	filename		u 1:($2):3  yerror via c07, c17, c27
replot f7(x) lc rgb '#77ac30'		lw 2 t ''

#==============================================================================================================================
#==============================================================================================================================

set terminal qt 12 enhanced font 'Verdana,26' size 1000,750 

set autoscale
first_title="a_{/Symbol r}"
set ylabel "a_{/Symbol r} [kg^{-1}m^{3}]"

set key right bottom
#set title "Parámetro ".first_title." para eventos mayores a 1 EeV"

plot 			"parameter_weather.dat"		i 1			u ($0*0.15 + 0.075):1:2 	w yerror 	lc rgb "black"	pt 6   ps 4 	lw 2 t 'Aab A. et al.'
fit 	f(x) 	"parameter_weather.dat"		i 1			u ($0*0.15 + 0.075):1:2  	yerror  via c0, c1, c2
replot 	f(x)  	lc rgb "black"   				lw 2 t ''
#================================================================================================================================
#Todos los archivos
	
replot  	filename 	u 1:4:5  w yerror 	lc rgb '#77ac30'	pt 13  ps 4 lw 2 t 'Herald'
fit f7(x)  	filename 	u 1:4:5  yerror via c07, c17, c27
replot f7(x) lc rgb '#77ac30'		lw 2 t ''#

#==============================================================================================================================
#==============================================================================================================================

set terminal qt 13  enhanced font 'Verdana,26' size 1000,750

set autoscale
first_title="b_{/Symbol r}"
set ylabel "b_{/Symbol r} [kg^{-1}m^{3}]"

set key right bottom
#set title "Parámetro ".first_title." para eventos mayores a 1 EeV"

plot 			"parameter_weather.dat"		i 2			u ($0*0.15 + 0.075):1:2 	w yerror 	lc rgb "black"	pt 6   ps 4 	lw 2 t 'Aab A. et al.'
fit 	f(x) 	"parameter_weather.dat"		i 2			u ($0*0.15 + 0.075):1:2  	yerror  via c0, c1, c2
replot 	f(x)  	lc rgb "black"   				lw 2 t ''

#================================================================================================================================
#Todos los archivos

replot 		filename	u 1:6:7  w yerror 	lc rgb '#77ac30'	pt 13  ps 4 lw 2 t 'Herald'
fit f7(x) 	filename	u 1:6:7  yerror via c07, c17, c27
replot f7(x) lc rgb '#77ac30'		lw 2 t ''#

pause(-1)