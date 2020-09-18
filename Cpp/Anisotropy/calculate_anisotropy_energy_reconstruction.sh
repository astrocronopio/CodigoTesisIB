#Para calcular distintos archivos
rango2004=1072915200
rango2005=1104537600

rango2013=1388577600 #Nuevo piso
#rango2015=1451566800
rango2017=1472688000  #PAra 8 EeV

rango2019=1546344000
rango2020=1577880000

#file_1_2="../Energy_Reconstruction/file_para_params"

file_8="../../Codigo_Taborda/Herald080noBP5n6t5a4_pnop_04-310816_UncorCorE.dat"
folder="./Files_Checking/"
mkdir "$folder"

#file_output="$folder""test_rayleigh_oscar_dataset_over_8EeV.dat"
file_output="./xx2019_Main_Array_8_EeV_04_17.dat"
energy_threshold="8"
file_cmp="../../Codigo_Taborda/ray_multfrq_8_04-0816_Eraw.dat"

./sin_peso_v8_checked    "$file_8"  "$file_output"		"$(($rango2004))" "$(($rango2017))"  

#./con_peso_v8EeV  "$file_8"    "$file_output"	 "$(($rango2004))" "$(($rango2017))"  "$energy_threshold"

gnuplot -e "filename='$file_output'; filecmp='$file_cmp'"  plotting_test.gp