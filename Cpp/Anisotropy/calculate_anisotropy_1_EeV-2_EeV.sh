#Para calcular distintos archivos
rango2004=1072915200
rango2005=1104537600

rango2013=1388577600 #Nuevo piso
rango2017=1472688000

rango2019=1546344000
rango2020=1577880000

#Entre 1-2 EeV lo hacemos con todos los triggers
file_1_2="../../../AllTriggers/Original_Energy/2019/AllTriggers_1_2_EeV_2019.dat"
#./sin_peso_v6 "$file_1_2"  pure_2019_AllTriggers_1_2_EeV.dat 			"$(($rango2013))" "$(($rango2020))"  
#./con_peso_v6_RA_pure	 "$file_1_2"  pure_2019_AllTriggers_1_2_EeV_peso.dat 		"$(($rango2013))" "$(($rango2020))"  
./con_peso_v6_RA_pure	 "$file_1_2"  test_rayleigh 		"$(($rango2013))" "$(($rango2020))"  
