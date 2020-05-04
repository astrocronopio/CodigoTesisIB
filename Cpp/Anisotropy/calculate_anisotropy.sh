#Para calcular distintos archivos
rango2004=1072915200
rango2005=1104537600
rango2013=1372699409
rango2017=1472688000
rango2019=1577825634


#Entre 1-2 EeV lo hacemos con todos los triggers
file_1_2="../../../AllTriggers/Original_Energy/2019/AllTriggers_1_2_EeV_2019.dat"

	#./sin_peso_v2 "$file_1_2"  x2019_AllTriggers_1_2_EeV.dat			"$(($rango2013))" "$(($rango2019))"  
	./con_peso_v3 "$file_1_2"  x2019_AllTriggers_1_2_EeV_peso.dat 	"$(($rango2013))" "$(($rango2019))"  sideral2013-2019.dat

#Entre 2-4 EeV tambien con todos los triggers
file_2_4="../../../AllTriggers/Original_Energy/2019/AllTriggers_2_4_EeV_2019.dat"

	#./sin_peso_v2 "$file_2_4"  x2019_AllTriggers_2_4_EeV.dat			"$(($rango2013))" "$(($rango2019))"  	
	./con_peso_v3 "$file_2_4"  x2019_AllTriggers_2_4_EeV_peso.dat	"$(($rango2013))" "$(($rango2019))"  	

#Para 4-8 con el main array
file_4_8="../../../Herald/Central/2019/Main_Array_4_8_EeV_2019.dat"

	#./sin_peso_v2 "$file_4_8"  x2019_Main_Array_4_8_EeV.dat			"$(($rango2013))" "$(($rango2019))"  
	./con_peso_v3 "$file_4_8"  x2019_Main_Array_4_8_EeV_peso.dat		"$(($rango2013))" "$(($rango2019))"  		

#Para 8 y arriba con el main array
file_8="../../../Herald/Central/2019/Main_Array_8EeV_2019.dat"

	#./sin_peso_v2 "$file_8"  x2019_Main_Array_8_EeV.dat				"$(($rango2013))" "$(($rango2019))"  
	./con_peso_v3 "$file_8"  x2019_Main_Array_8_EeV_peso.dat			"$(($rango2013))" "$(($rango2019))"  

#######################################################3
# Extendi el rango de timepo

#Para 4-8 con el main array
file_4_8="../../../Herald/Central/2019/Main_Array_4_8_EeV_2019.dat"

	#./sin_peso_v2 "$file_4_8"  x2019_Main_Array_4_8_EeV_extended.dat 		"$(($rango2005))" "$(($rango2019))"  
	./con_peso_v3 "$file_4_8"  x2019_Main_Array_4_8_EeV_peso_extended.dat 	"$(($rango2005))" "$(($rango2019))"  

#Para 8 y arriba con el main array
file_8="../../../Herald/Central/2019/Main_Array_8EeV_2019.dat"

	#./sin_peso_v2 "$file_8"  x2019_Main_Array_8_EeV_extended.dat      "$(($rango2005))" "$(($rango2019))"  
	./con_peso_v3 "$file_8"  x2019_Main_Array_8_EeV_peso_extended.dat "$(($rango2005))" "$(($rango2019))"  


#######################################################3
# Para comparar con los resultados de Oscar
