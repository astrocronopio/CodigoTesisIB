

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
rangoLSA2018=1538352000
rango2019=1546344000
rango2020=1577880000

energy_threshold="0"

# file_cmp="../Anisotropy/Files_AllTriggers_Reference/output_threshold_0con_peso_v9.dat"
# file_input="./../Energy_Reconstruction/Files_AllTriggers_Wide_Range/AllTriggers_1_2.dat"
file_input="../../../AllTriggers/Original_Energy/2019/AllTriggers_1_2_EeV_2019.dat"

#####################################################################################3
folder="./Files_AllTriggers_0-5_1_EeV/"

mkdir "$folder"

sin_peso="sin_peso_v9"
con_peso="con_peso_v11"

algoritmo="$con_peso"
file_output="$folder""output_threshold_""$energy_threshold""$algoritmo"".dat"

g++-9 -g "$algoritmo".cpp -o "$algoritmo"

#### Exec ####

"./""$algoritmo"  "$file_input" "$file_output" "$(($rango2014))" "$(($rango2020))" "$energy_threshold"
# gnuplot -e "filename='$file_output'; filecmp='$file_cmp'"  plotting_anisotropy.gp

# exit