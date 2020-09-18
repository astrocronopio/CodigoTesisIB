#Para calcular distintos archivos
rango2004=1072915200
rango2005=1104537600

rango2013=1388577600 #Nuevo piso
#rango2015=1451566800
rango2017=1472688000  
rangofina=1496275200 #PAra 8 EeV

rango2019=1546344000
rango2020=1577880000

# file_cmp=

# energy_threshold="1"

# folder=
# file_in=
# file_out=


#file_1_2="../Energy_Reconstruction/file_para_params"

# file_8="../../Codigo_Taborda/Herald080noBP5n6t5a4_pnop_04-310816_UncorCorE.dat"
# folder="./Files_Checking/"


#file_output="$folder""test_rayleigh_oscar_dataset_over_8EeV.dat"
# file_output="$folder""xx2019_Main_Array_8_EeV_04_17.dat"
energy_threshold="1"
#file_cmp="../../Codigo_Taborda/ray_multfrq_8_04-0816_Eraw.dat"
file_cmp="test_rayleigh"
#./sin_peso_v8_checked    "$file_8"  "$file_output"		"$(($rango2004))" "$(($rangofina))"  


 file_1_2="../../../AllTriggers/Original_Energy/2019/AllTriggers_1_2_EeV_2019.dat"
 folder="Filter_File_by_Energy/"
 file_output="$folder""output.dat"
 mkdir "$folder"


# file_1_2="../../../AllTriggers/Energy_Reconstruction/2"
folder1="Filter_File_by_Energy_Reference/"
file_cmp="$folder1""output.dat"
#mkdir "$folder"

./con_peso_v8EeV  "$file_1_2"    "$file_output"	 "$(($rango2013))" "$(($rango2020))"  "$energy_threshold"

gnuplot -e "filename='$file_output'; filecmp='$file_cmp'"  plotting_test.gp