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

file_cmp="../Anisotropy/Files_AllTriggers_Reference/output_threshold_0con_peso_v9.dat"

#file_cmp="../../Codigo_Taborda/ray_multfrq_8_04-0816_Eraw.dat"
#file_cmp="/home/ponci/Desktop/TesisIB/Coronel/CodigoTesisIB/Cpp/Anisotropy/Files_Checking_Code(Ref._PC)/output_threshold_0sin_peso_v8_checkedEcor.dat"

#file_input="./../Energy_Reconstruction/Files_PC_weather/AllTriggers_1_2.dat"
#file_input="../../../AllTriggers/S38_analisis/2019/AllTriggers_S38_over_1_2_EeV_2019.dat"
#file_input="../../Codigo_Taborda/Herald080noBP5n6t5a4_pnop_04-310816_UncorCorE.dat"

#####################################################################################3
folder="./Files_AllTriggers_0-25_0-5_EeV/"
file_input="../../../AllTriggers/Original_Energy/2019/AllTriggers_0-25_0-5_EeV_2019.dat"

mkdir "$folder"
EW="EW_v3"
EW_2="EW_v2_seg_arm"
algoritmo="$EW"
file_output="$folder""output_threshold_""$energy_threshold""$algoritmo"".dat"

g++-9 -g "$algoritmo".cpp -o "$algoritmo"

#### Exec ####

"./""$algoritmo"  "$file_input" "$file_output" "$(($rango2014))" "$(($rango2020))" "$energy_threshold"
# gnuplot -e "filename='$file_output'; filecmp='$file_cmp'"  plotting_anisotropy.gp

exit
#####################################################################################3

folder="./Files_AllTriggers_0-5_1_EeV/"
file_input="../../../AllTriggers/Original_Energy/2019/AllTriggers_0-5_1_EeV_2019.dat"


mkdir "$folder"
EW="EW_v3"
EW_2="EW_v2_seg_arm"
algoritmo="$EW"
file_output="$folder""output_threshold_""$energy_threshold""$algoritmo"".dat"

g++-9 -g "$algoritmo".cpp -o "$algoritmo"

#### Exec ####

"./""$algoritmo"  "$file_input" "$file_output" "$(($rango2014))" "$(($rango2020))" "$energy_threshold"
# gnuplot -e "filename='$file_output'; filecmp='$file_cmp'"  plotting_anisotropy.gp
exit
#####################################################################################3
folder="./Files_AllTriggers_1_2_EeV/"
file_input="../../../AllTriggers/Original_Energy/2019/AllTriggers_1_2_EeV_2019.dat"

# file_input="../../../../Herald060noBP6t5a025_010104-310818.dat"
# folder="2020_paper/"

mkdir "$folder"
EW="EW_v3"
EW_2="EW_v2_seg_arm"
algoritmo="$EW"
file_output="$folder""output_threshold_""$energy_threshold""$algoritmo"".dat"

g++-9 -g "$algoritmo".cpp -o "$algoritmo"

#### Exec ####

"./""$algoritmo"  "$file_input" "$file_output" "$(($rango2014))" "$(($rango2020))" "$energy_threshold"

#"./""$algoritmo"  "$file_input" "$file_output" "$(($rango2004))" "$(($rangoPC2017))" "$energy_threshold"

#"./""$algoritmo"  "$file_input" "$file_output" "$(($rango2004))" "$(($rangoLSA2018))" "$energy_threshold"

# gnuplot -e "filename='$file_output'; filecmp='$file_cmp'"  plotting_anisotropy.gp
