#Para calcular distintos archivos
rango2004=1072915200
rango2005=1104537600
#rango2013=1372699409
rango2013=1388628499 #Nuevo piso
rango2017=1472688000
#rango2019=1577825634
rango2019=1550534100

#Entre 1-2 EeV lo hacemos con todos los triggers
file_1_2="../../../AllTriggers/Energy_Reconstruction/2019/AllTriggers_S38_over_1_2_EeV_2019_corr.dat"

#./sin_peso_v3 "$file_1_2"  corr_2019_AllTriggers_1_2_EeV.dat  				"$(($rango2013))" "$(($rango2019))"  
#./con_peso_v3 "$file_1_2"  corr_2019_AllTriggers_1_2_EeV_peso.dat   			"$(($rango2013))" "$(($rango2019))"  

#Entre 2-4 EeV tambien con todos los triggers
file_2_4="../../../AllTriggers/Energy_Reconstruction/2019/AllTriggers_S38_over_2_4_EeV_2019_corr.dat"

./sin_peso_v3 "$file_2_4"  corr2019_AllTriggers_2_4_EeV.dat	 		"$(($rango2013))" "$(($rango2019))"  	
./con_peso_v3 "$file_2_4"  corr2019_AllTriggers_2_4_EeV_peso.dat 		"$(($rango2013))" "$(($rango2019))"  	

#Para 4-8 con el main array
#file_4_8="../../../Herald/Central/2019/Main_Array_4_8_EeV_2019.dat"

	#./sin_peso_v3 "$file_4_8"  xx2019_Main_Array_4_8_EeV.dat			"$(($rango2013))" "$(($rango2019))" 
	#./con_peso_v3 "$file_4_8"  xx2019_Main_Array_4_8_EeV_peso.dat		"$(($rango2013))" "$(($rango2019))"  		

#Para 8 y arriba con el main array
#file_8="../../../Herald/Central/2019/Main_Array_8EeV_2019.dat"

	#./sin_peso_v3 "$file_8"  xx2019_Main_Array_8_EeV.dat				"$(($rango2013))" "$(($rango2019))"  
	#./con_peso_v3 "$file_8"  xx2019_Main_Array_8_EeV_peso.dat			"$(($rango2013))" "$(($rango2019))"  


