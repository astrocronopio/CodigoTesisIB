
# file_input="../../Codigo_Taborda/Herald080noBP5n6t5a4_pnop_04-310816_UncorCorE.dat"
# folder="./Files_PC_weather/"

file_input="../../../AllTriggers/Original_Energy/2019/AllTriggers_2019.dat"
folder="./Files_AllTriggers_Wide_Range/"


fileout="$folder""AllTriggers_1_2.dat"
mkdir "$folder"

algoritmo="merged_v3_energy_reconst"
# algoritmo="merged_v5_pc_file_energy"

g++-9 -g "$algoritmo".cpp -o "$algoritmo"

""./"""$algoritmo"  "$file_input"  "$fileout"

#!Solo para checkear delta E !
# gnuplot -e "filename='test.data'" plot_pc_energy.gp