
#====================# 
##					##
##		Intro		##		
##					##
#====================# 
#Si todo sale bien, si bajo mi carpeta en cualquier computadora con este script debería recuperar todo lo que ya hice antes
#solo deberia cambiar donde esta ubicado el proyecto

project="/home/ponci/Desktop/TesisIB/Coronel/"

#44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444

#====================# 
##					##
##		Paso 1		##		
##					##
#====================# 

#Primero hagamos el filtro del weather que es más fácil, ya no tiene que tener las columnas que no uso
#tiene que tener la estructura utc,temp,pres,rho,rho24,hex6T5,d5T5,iw,bp

#------------------------------------------------------------------------------------------------------
					new_weather="$project""Weather/"
					#bash ./Sh/utctprh_counter_script.sh "$project" "$new_weather" && echo "done with $new_weather "
					
					old_weather="$project""PC_Weather_paper/Weather/"
					#bash ./Sh/utctprh_counter_script.sh "$project" "$old_weather" && echo "done with $old_weather "
#------------------------------------------------------------------------------------------------------

#En cada carpeta genera los archivos
#  Original 					  Weather histogram				  Weather histogram DELAYED
#'utctprh.dat'  				 'utctprhdr-bins.dat' 			'utctprhdr-binsdelayrho.dat' 

#44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444

#====================# 
##					##
##		Paso 2		##		
##					##
#====================# 

#Tenemos que agarrar el archivo del herald y limpiarlo segun  el clasico  "you should throw again the event"  del herald
#Ahora los nuevo archivos van a tener la forma
#UTC 	The		phi 	S1000 	dS1000	Energy 	
#------------------------------------------------------------------------------------------------------
					#bash ./Sh/filter_herald.sh "$project"
#------------------------------------------------------------------------------------------------------

#44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444

#====================# 
##					##
##		Paso 3		##		
##					##
#====================# 


#Ahora vamos a asignar a cada evento del herald el clima que le corresponde                         #Tengo mis dudas si usar o no el delayed
#Luego de unir los dos archivos, voy a filtrar todos los eventos que cayeron en un mal clima  (flags de iw y ib)

#El archivo antes de filtrar tiene la forma
# 1			2		3		4			5			6			7			8		9			10			11			12			13		14
# UTC  >>	The	 >>	phi >> 	S1000 >> 	dS1000 >>	Energy >> iutc << " "<< t <<" "<< p << " "<<rho <<" "<< rhod <<" "<< iw <<" "<< ib << h6 


#Luego de filtrar tiene la siguiente forma
# 1			2		3		4			5			6		
# UTC  >>	The	 >>	phi >> 	S1000 >> 	dS1000 >>	Energy 
#ya filtrados con the<60 y con energía mayor a 1 EeV

#Tengo que elegir con que archivo de clima lo hago con el nuevo o con el viejo 

#------------------------------------------------------------------------------------------------------
					#bash ./Sh/filter_herald_by_bad_period.sh  "$project" "$old_weather"
#------------------------------------------------------------------------------------------------------

#44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444

#====================# 
##					##
##		Paso 4		##		
##					##
#====================# 

#Ahora si podemos hacer el bineado de los archivos que obtuvimos en el paso anterior, como queremos trabajar en bines separados por sin^2(theta) tenemos que separarlos para hacer todo.
#Aunque necesito es rate global para luego tener el fit y ver si estoy haciendo bien las cosas. Así que este paso se va a dividir en dos: en el total y en dividir por secante

 bash ./Sh/Events_Counter_Files/creates_sin_2_files_and_merges_by_hour.sh  "$project"