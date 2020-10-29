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


rango2019=1546344000
rango2020=1577880000

energy_threshold="0"

#file_cmp="./Files_AllTriggers_Reference/output_threshold_0con_peso_v9.dat"
#file_cmp="../../Codigo_Taborda/ray_multfrq_8_04-0816_Eraw.dat"
file_cmp="/home/ponci/Desktop/TesisIB/Coronel/CodigoTesisIB/Cpp/Anisotropy/Files_Checking_Code(Ref._PC)/output_threshold_0sin_peso_v8_checkedEcor.dat"

file_input="./../Energy_Reconstruction/Files_PC_weather/AllTriggers_1_2.dat"
#file_input="../../../AllTriggers/S38_analisis/2019/AllTriggers_S38_over_1_2_EeV_2019.dat"
#file_input="../../../AllTriggers/Original_Energy/2019/AllTriggers_1_2_EeV_2019.dat"

#file_input="../../Codigo_Taborda/Herald080noBP5n6t5a4_pnop_04-310816_UncorCorE.dat"
folder="./Files_Checking_Code(Ref._PC)/"


mkdir "$folder"

sin_peso="sin_peso_v8_checked"
con_peso="con_peso_v10"

algoritmo="$sin_peso"
file_output="$folder""output_threshold_""$energy_threshold""$algoritmo""Ecor_my.dat"

g++-9 -g "$algoritmo".cpp -o "$algoritmo"

#### Exec ####

#"./""$algoritmo"  "$file_input" "$file_output" "$(($rango2014))" "$(($rango2020))" "$energy_threshold"

"./""$algoritmo"  "$file_input" "$file_output" "$(($rango2004))" "$(($rangoPC2017))" "$energy_threshold"

####
gnuplot -e "filename='$file_output'; filecmp='$file_cmp'"  plotting_anisotropy.gp


####

# file_sin="$folder""output_threshold_""$energy_threshold""$sin_peso"".dat"
# file_con="$folder""output_threshold_""$energy_threshold""$con_peso"".dat"

# gnuplot -e "file_sin='$file_sin'; file_con='$file_con'"  plotting_anisotropy_sin_con.gp

