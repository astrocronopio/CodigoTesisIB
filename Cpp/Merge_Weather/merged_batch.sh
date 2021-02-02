algoritmo="./merged_v2_general"
g++-9 -g "$algoritmo".cpp -o "$algoritmo"

path="/home/ponci/Desktop/TesisIB/Coronel/CodigoTesisIB/Cpp/Energy_Reconstruction/Files_AllTriggers_Wide_Range/AllTriggers_1_2.dat"
 out="/home/ponci/Desktop/TesisIB/Coronel/CodigoTesisIB/Cpp/Energy_Reconstruction/Files_AllTriggers_Wide_Range/AllTriggers_1_2_merged.dat"

 ./merged_v2_general "$path" "$out"
