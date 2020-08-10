#Para calcular distintos archivos
rango2004=1072915200
rango2005=1104537600

rango2013=1388577600 #Nuevo piso
rango2017=1472688000

rango2019=1546344000
rango2020=1577880000

#Entre 1-2 EeV lo hacemos con todos los triggers
file_1_2="../../../AllTriggers/Energy_Reconstruction/2019/AllTriggers_S38_over_1_2_EeV_2019_corr.dat"

#../Anisotropy/sin_peso_v3 "$file_1_2"  corr_2019_AllTriggers_1_2_EeV.dat  				"$(($rango2013))" "$(($rango2020))"  
../Anisotropy/con_peso_v3 "$file_1_2"  corr_2019_AllTriggers_1_2_EeV_peso.dat   			"$(($rango2013))" "$(($rango2020))"  
