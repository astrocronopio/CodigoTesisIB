#Para calcular distintos archivos
rango2004=1072915200
rango2005=1104537600

rango2013=1388577600 #Nuevo piso
rango2017=1472688000

rango2019=1546344000
rango2020=1577880000

#Entre 1-2 EeV lo hacemos con todos los triggers
file_1_2="../../../AllTriggers/Original_Energy/2019/AllTriggers_1_2_EeV_2019.dat"
#./sin_peso_v3 "$file_1_2"  xx2019_AllTriggers_1_2_EeV.dat 			"$(($rango2013))" "$(($rango2020))"  
#./con_peso_v3 "$file_1_2"  xx2019_AllTriggers_1_2_EeV_peso.dat 		"$(($rango2013))" "$(($rango2020))"  

#Entre 2-4 EeV tambien con todos los triggers
file_2_4="../../../AllTriggers/Original_Energy/2019/AllTriggers_2_4_EeV_2019.dat"

#./sin_peso_v3 "$file_2_4"  xx2019_AllTriggers_2_4_EeV.dat			"$(($rango2013))" "$(($rango2019))"  	
#./con_peso_v3 "$file_2_4"  xx2019_AllTriggers_2_4_EeV_peso.dat		"$(($rango2013))" "$(($rango2019))"  	

#Para 4-8 con el main array
file_4_8="../../../Herald/Central/2019/Main_Array_4_8_EeV_2019.dat"

#./sin_peso_v3 "$file_4_8"  xx2019_Main_Array_4_8_EeV.dat			"$(($rango2013))" "$(($rango2019))" 
#./con_peso_v3 "$file_4_8"  xx2019_Main_Array_4_8_EeV_peso.dat		"$(($rango2013))" "$(($rango2019))"  		

#Para 8 y arriba con el main array
#file_8="../../../Herald/Central/2019/Main_Array_8EeV_2019.dat"
file_8="../../Herald080noBP5n6t5a4_pnop_04-310816_UncorCorE.dat"

./sin_peso_v5 "$file_8"  xx2019_Main_Array_8_EeV_04_17.dat			"$(($rango2004))" "$(($rango2017))"  
#./con_peso_v3 "$file_8"  xx2019_Main_Array_8_EeV_peso.dat			"$(($rango2013))" "$(($rango2019))"  

#######################################################3
# Extendi el rango de timepo

#Para 4-8 con el main array
file_4_8="../../../Herald/Central/2019/Main_Array_4_8_EeV_2019.dat"

#./sin_peso_v3 "$file_4_8"  xx2019_Main_Array_4_8_EeV_extended.dat 		"$(($rango2005))" "$(($rango2019))"  
#./con_peso_v3 "$file_4_8"  xx2019_Main_Array_4_8_EeV_peso_extended.dat 	"$(($rango2005))" "$(($rango2019))"  

#Para 8 y arriba con el main array
file_8="../../../Herald/Central/2019/Main_Array_8EeV_2019.dat"


#./sin_peso_v3 "$file_8"  xx2019_Main_Array_8_EeV_extended.dat      "$(($rango2005))" "$(($rango2019))"  
#./con_peso_v3 "$file_8"  xx2019_Main_Array_8_EeV_peso_extended.dat "$(($rango2005))" "$(($rango2019))"  


#######################################################3
# Para comparar con los resultados de Oscar
