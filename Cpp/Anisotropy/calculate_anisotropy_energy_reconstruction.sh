#Para calcular distintos archivos
rango2004=1072915200
rango2005=1104537600

rango2013=1388577600 #Nuevo piso
rango2017=1472688000

rango2019=1546344000
rango2020=1577880000

file_1_2="../Energy_Reconstruction/test_5"

./con_peso_v6_RA_pure  "$file_1_2"    test_rayleigh_5	 "$(($rango2013))" "$(($rango2020))"  