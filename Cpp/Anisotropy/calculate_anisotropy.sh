#Para calcular distintos archivos


#Entre 1-2 EeV lo hacemos con todos los triggers
file_1_2="../../../AllTriggers/Original_Energy/2019/AllTriggers_1_2_EeV_2019.dat"

	#./sin_peso_v2 "$file_1_2"  2019_AllTriggers_1_2_EeV.dat
	#./con_peso_v2 "$file_1_2"  2019_AllTriggers_1_2_EeV_peso.dat

#Entre 2-4 EeV tambien con todos los triggers
file_2_4="../../../AllTriggers/Original_Energy/2019/AllTriggers_2_4_EeV_2019.dat"

	#./sin_peso_v2 "$file_2_4"  2019_AllTriggers_2_4_EeV.dat
	#./con_peso_v2 "$file_2_4"  2019_AllTriggers_2_4_EeV_peso.dat


#Para 4-8 con el main array
file_4_8="../../../Herald/Central/2019/Main_Array_4_8_EeV_2019.dat"

	#./sin_peso_v2 "$file_4_8"  2019_Main_Array_4_8_EeV.dat
	#./con_peso_v2 "$file_4_8"  2019_Main_Array_4_8_EeV_peso.dat



#Para 8 y arriba con el main array
file_8="../../../Herald/Central/2019/Main_Array_8EeV_2019.dat"

	#./sin_peso_v2 "$file_8"  2019_Main_Array_8_EeV.dat
	#./con_peso_v2 "$file_8"  2019_Main_Array_8_EeV_peso.dat


#######################################################3
# Extendi el rango de timepo

#Para 4-8 con el main array
file_4_8="../../../Herald/Central/2019/Main_Array_4_8_EeV_2019.dat"

	./sin_peso_v2 "$file_4_8"  2019_Main_Array_4_8_EeV_extended.dat
	./con_peso_v2 "$file_4_8"  2019_Main_Array_4_8_EeV_peso_extended.dat



#Para 8 y arriba con el main array
file_8="../../../Herald/Central/2019/Main_Array_8EeV_2019.dat"

	./sin_peso_v2 "$file_8"  2019_Main_Array_8_EeV_extended.dat
	./con_peso_v2 "$file_8"  2019_Main_Array_8_EeV_peso_extended.dat
