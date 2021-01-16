
#Para calcular distintos archivos
rango2004=1072915200 
rango2005=1104537600

rango2015=1451566800
rangomid2014=1420113404 #Para archivos de old herald / Pc weather

rangomid2013=1372680068
rango2014=1388577600 #Nuevo piso para AllTriggers

rango2017=1472688000 #

rangoPC2017=1496275200 
#importante, este es el final de PC,
#que lo uso de referencia
rangoLSA2018=1538332000
rango2019=1546344000
rango2020=1577880000

energy_threshold="0"

#Under 4 EeV
# file_input="../../../../Herald060noBP6t5a025_010104-310818.dat"

# #Over 4 EeV
file_input="../../../../Herald080noBP5n6t5a4_010104-310818.dat"

folder="2020_paper/"

mkdir "$folder"

sin_peso="sin_peso_v9"
con_peso="con_peso_v11"

algoritmo="$con_peso"
file_output="$folder""output_threshold_""$energy_threshold""$algoritmo"".dat"

g++-9 -g "$algoritmo".cpp -o "$algoritmo"

#### Exec ####

"./""$algoritmo"  "$file_input" "$file_output" "$(($rango2004))" "$(($rangoLSA2018))" "$energy_threshold"

