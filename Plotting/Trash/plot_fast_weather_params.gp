
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

filename= "/home/ponci/Desktop/TesisIB/Coronel/CodigoTesisIB/Weather_code/AllTriggers/2019/weather_analysis/AllTriggers_S38_over_1EeV_all_sin2.dat"
#==============================================================================================================================

#set terminal pngcairo size 1200,750 enhanced font 'Helvetica,26'
set terminal qt 10 enhanced font 'Helvetica,26' size 1200,750 

set key right top
first_title="a_P"

#set title "Parámetro ".first_title." para eventos mayores a 1 EeV"
set ylabel "a_P [hPa^{-1}]"

set autoscale

plot 			"parameter_weather.dat"		i 0			u ($0*0.15 + 0.075):1:2 	w yerror 	lc rgb "black"	pt 2   ps 4 	lw 2 t 'Aab A. et al.'
fit 	f(x) 	"parameter_weather.dat"		i 0			u ($0*0.15 + 0.075):1:2  	yerror  via c0, c1, c2
replot 	f(x)  	lc rgb "black"   		lw 2 t ''

#================================================================================================================================
#Todos los archivos

replot 		filename		u 1:($2):3  w yerror 	lc rgb 'dark-pink'	pt 13  ps 4 lw 2 t 'Herald'
fit f7(x) 	filename		u 1:($2):3  yerror via c07, c17, c27
replot f7(x) lc rgb 'dark-pink'		lw 2 t ''

#==============================================================================================================================
#==============================================================================================================================

set terminal qt 12 enhanced font 'Helvetica,26' size 1200,750 

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
	
replot  	filename 	u 1:4:5  w yerror 	lc rgb 'dark-pink'	pt 13  ps 4 lw 2 t 'Herald'
fit f5(x)  	filename 	u 1:4:5  yerror via c05, c15, c25
replot f5(x) lc rgb 'dark-pink'		lw 2 t ''#

#==============================================================================================================================
#==============================================================================================================================

set terminal qt 13  enhanced font 'Helvetica,26' size 1200,750

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

replot 		filename	u 1:6:7  w yerror 	lc rgb 'dark-pink'	pt 13  ps 4 lw 2 t 'Herald'
fit f6(x) 	filename	u 1:6:7  yerror via c06, c16, c26
replot f6(x) lc rgb 'dark-pink'		lw 2 t ''#

pause(-1)