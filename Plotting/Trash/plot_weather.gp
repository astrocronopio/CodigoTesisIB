file_utcprh="../../Weather/utctprh_bins.dat" 
file_24="../../Weather/utctprh_24_total.dat"

output_pressure="/home/ponci/Desktop/TesisIB/Coronel/TesisIB/IB_style/clima/Graphs/presion.png"
output_density_hourly="/home/ponci/Desktop/TesisIB/Coronel/TesisIB/IB_style/clima/Graphs/clima/densidad_media_diaria.png"
output_density_dayly="/home/ponci/Desktop/TesisIB/Coronel/TesisIB/IB_style/clima/Graphs/clima/densidad_diaria.png"
output_density_hod="/home/ponci/Desktop/TesisIB/Coronel/TesisIB/IB_style/clima/Graphs/clima/densidad_hod.png"
output_area="/home/ponci/Desktop/TesisIB/Coronel/TesisIB/IB_style/clima/Graphs/clima/area.png"


#-------------------------------------Densidad media por hora del día--------------------------
	set terminal qt 8 enhanced font 'Verdana,26' size 1200,750 
	
	set title "Densidad media del aire por hora del día"
	set ylabel "Densidad [kgm^{-3}]"
	set xlabel "Hora del día GMT"
	set xtics 2
	set xrange [-1:25]
	plot  file_24 u 1:4 w lp ps 3 pt 3  lc rgb 'dark-green' t '' , 1.05447 dt 2 lw 2 lc rgb 'black'  t 'Promedio de 2005 a 2018' 
	#-------------------------------------
	
	set terminal png size 1200,750 enhanced font 'Verdana,26'
	set output output_density_hod
	replot

pause(-1)
set autoscale
set xdata time 
set timefmt "%s"
set format x "%m/%Y"
set xtics "1104527600",94608000
set xlabel "Fecha"
set xrange [1101127600:1546214400]

#-------------------------------------Presion--------------------------------------------------
	set terminal qt 1 enhanced font 'Verdana,26' size 1200,750 
	
	set title "Presión media del aire por hora"
	set ylabel "Presión [hPa]"
	
	plot file_utcprh u 1:3  every 3 t '' lc rgb 'dark-green',  861.777 dt 2 lw 2 lc rgb 'black'  t 'Promedio de 2005 a 2018' 
	#----------------------------------------------------------------------------------------------
	set terminal png size 1200,750 enhanced font 'Verdana,26'
	set output output_pressure
	replot
#-------------------------------------Densidad-------------------------------------------------
	set terminal qt 2 enhanced font 'Verdana,26' size 1200,750 
	
	set ylabel "Densidad [kgm^{-3}]"
	set title "Densidad media del aire por hora"
	
	plot file_utcprh u 1:4  every 3 t '' lc rgb 'dark-green', 1.05547 dt 2 lw 2 lc rgb 'black'  t 'Promedio de 2005 a 2018' 
	#-----------------------------------
	
	set terminal png size 1200,750 enhanced font 'Verdana,26'
	set output output_density_hourly
	replot

#-------------------------------------Densidad media por día-----------------------------------
	set terminal qt 3 enhanced font 'Verdana,26' size 1200,750 
	
	set title "Densidad  media del aire por día"
	set ylabel "Densidad [kgm^{-3}]"
	
	plot  file_utcprh u 1:5  every 3 lc rgb 'dark-green' t '' , 1.05547 dt 2 lw 2 lc rgb 'black'  t 'Promedio de 2005 a 2018' 
	#-------------------------------------
	
	set terminal png size 1200,750 enhanced font 'Verdana,26'
	set output output_density_dayly
	replot

#--------------------------------------Area--------------------------------------------------------
	set terminal qt 4 enhanced font 'Verdana,26' size 1200,750 
	
	set key left top
	set title "Área activa del observatorio"
	set ylabel "Área [km^2]"
	set xrange [1072918861:1546214400]
	
	plot file_utcprh u 1:($6/2.566 > 0 ? $6/2.566 : 1/0)  every 3 t '' lc rgb 'dark-green',  690/2.566  dt 2 lw 2 lc rgb 'black' t 'Mínima área considerada' 
	
	#---------------------------------------
	set terminal png size 1200,750 enhanced font 'Verdana,26'
	set output output_area
	replot


pause(-1)