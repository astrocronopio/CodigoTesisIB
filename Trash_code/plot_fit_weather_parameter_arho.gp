##Plotea los fiteos! Esto está organizado así

#________Para Sin_squared
# above_1EeV/Herald_old_energy_modified_sector1_bins_delay.dat 	
# above_1EeV/Herald_old_energy_modified_sector1_bins_utctprh.dat 	
# above_1EeV/Herald_energy_modified_sector1_bins_delay.dat 	
# above_1EeV/Herald_energy_modified_sector1_bins_utctprh.dat 	

# all_energy/Herald_old_simple_modified_sector1_bins_delay.dat 	
# all_energy/Herald_old_simple_modified_sector1_bins_utctprh.dat 	
# all_energy/Herald_simple_modified_sector1_bins_delay.dat 	
# all_energy/Herald_simple_modified_sector1_bins_utctprh.dat 	.

#_________Para sec
#above_1EeV/Herald_old_energy_modified_sector1_bins_delay.dat 	
#above_1EeV/Herald_old_energy_modified_sector1_bins_utctprh.dat 	
#above_1EeV/Herald_energy_modified_sector1_bins_delay.dat 	
#above_1EeV/Herald_energy_modified_sector1_bins_utctprh.dat 	


#Auxiliar functions
f(x) = c0 + c1*x + c2*x**2	

f0(x)= c00 + c10*x + c20*x**2	
f1(x)= c01 + c11*x + c21*x**2	
f2(x)= c02 + c12*x + c22*x**2	
f3(x)= c03 + c13*x + c23*x**2	

f4(x)= c04 + c14*x + c24*x**2	
f5(x)= c05 + c15*x + c25*x**2	
f6(x)= c06 + c16*x + c26*x**2	
f7(x)= c07 + c17*x + c27*x**2	


#________________________Ap_fit_sin______________________________

#___Energy_above_1_EeV
set terminal qt 0 size 1200,900 enhanced font 'Verdana,26'
set grid 
set xrange [0:0.75]
set ylabel '{/Symbol a}_{/Symbol r}(hPa^{-1})'
set xlabel "sin^{2}{/Symbol q}"

set title "Parameter {/Symbol a}_{/Symbol r} during 2005-2011 for  E> 1 EeV"
set key right bottom

#colors=("red", "black", "green", "violet")


color0="dark-magenta"; color1="dark-turquoise"; color2="blue"; color3="red"
plot 	"arhofit_sin.dat" index 0 u 1:2:3 w yerr lc rgb color0	pt 6   ps 4 lw 2 	t "Old Data with delay"			
replot 	"arhofit_sin.dat" index 1 u 1:2:3 w yerr lc rgb color1	pt 11  ps 4 lw 2	t "Old Data without delay"		
replot 	"arhofit_sin.dat" index 2 u 1:2:3 w yerr lc rgb color2	pt 13  ps 4 lw 2	t "New Data with delay"			
replot 	"arhofit_sin.dat" index 3 u 1:2:3 w yerr lc rgb color3	pt 4   ps 4 lw 2	t "New Data without delay"

fit f0(x) "arhofit_sin.dat" index 0 u 1:2:3 via c00, c10, c20
fit f1(x) "arhofit_sin.dat" index 1 u 1:2:3 via c01, c11, c21
fit f2(x) "arhofit_sin.dat" index 2 u 1:2:3 via c02, c12, c22
fit f3(x) "arhofit_sin.dat" index 3 u 1:2:3 via c03, c13, c23

replot 	f0(x)lc rgb color0 	lw 1	t ""			
replot 	f1(x)lc rgb color1	lw 1	t ""		
replot 	f2(x)lc rgb color2	lw 1	t ""			
replot 	f3(x)lc rgb color3	lw 1	t ""

set output 'introduction.png'
#___All____Energy
set terminal qt 1 size 1200,900 enhanced font 'Verdana,26'

set title "Parameter {/Symbol a}_{/Symbol r} during 2005-2011 for all the events"
set key left top

plot 	"arhofit_sin.dat" index 4 u 1:2:3 w yerr lc rgb color0	pt 6   ps 4 lw 2	t "Old Data with delay"			
replot 	"arhofit_sin.dat" index 5 u 1:2:3 w yerr lc rgb color1	pt 11  ps 4 lw 2	t "Old Data without delay"		
replot 	"arhofit_sin.dat" index 6 u 1:2:3 w yerr lc rgb color2	pt 13  ps 4 lw 2	t "New Data with delay"			
replot 	"arhofit_sin.dat" index 7 u 1:2:3 w yerr lc rgb color3	pt 4   ps 4 lw 2	t "New Data without delay"

fit f4(x) "arhofit_sin.dat" index 4 u 1:2:3 via c04, c14, c24
fit f5(x) "arhofit_sin.dat" index 5 u 1:2:3 via c05, c15, c25
fit f6(x) "arhofit_sin.dat" index 6 u 1:2:3 via c06, c16, c26
fit f7(x) "arhofit_sin.dat" index 7 u 1:2:3 via c07, c17, c27

replot 	f4(x)lc rgb color0	lw 1	t ""			
replot 	f5(x)lc rgb color1	lw 1	t ""		
replot 	f6(x)lc rgb color2	lw 1	t ""			
replot 	f7(x)lc rgb color3	lw 1	t ""

pause(0)