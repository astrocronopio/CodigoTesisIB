#Para calcular distintos archivos
rango2004=1072915200
rango2005=1104537600

rango2015=1451566800
rangomid2014=1420113404 #Para archivos de old herald / Pc weather
rango2013_bad=1372680068
rango2013=1388577600 #Nuevo piso
rango2017=1472688000

rango2019=1546344000
rango2020=1577880000



file_input="../../../AllTriggers/Original_Energy/2019/AllTriggers_2019_merged.dat"
folder="./Files_AllTriggers_Wide_Range/"
fileout="$folder""AllTriggers_1_2.dat"
mkdir "$folder"

algoritmo="merged_v6_minimal_energy_reconst"
g++-9 -g "$algoritmo".cpp -o "$algoritmo"

""./"""$algoritmo"  "$file_input"  "$fileout"

#!Solo para checkear delta E !
gnuplot -e "filename='test.data'" plot_pc_energy.gp