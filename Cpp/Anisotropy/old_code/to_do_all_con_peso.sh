echo "1 EeV con peso Oscar"

in_file="../../../AllTriggers/AllTriggers_1EeV.dat"
out_file="AllTriggers_Oscar_data_file_Eraw_1EeV_hex.txt" 

	
	#./anisotropy_verificado_con_peso_v2 "$in_file" "$out_file" 

######################################################################
echo "1 EeV con peso Herald"

in_file="../../../AllTriggers/Original_Energy/2019/AllTriggers_1EeV_2019.dat"
out_file="AllTriggers_2019_data_file_Eraw_1EeV_hex.txt" 

	
	#./anisotropy_verificado_con_peso_v2 "$in_file" "$out_file" 


######################################################################
######################################################################
######################################################################
######################################################################
echo "1-2 EeV con peso Oscar"

in_file="../../AllTriggers/AllTriggers_1_2_EeV.dat"
out_file="AllTriggers_Oscar_data_file_Eraw_1_2_EeV_hex.txt" 

	
	#./anisotropy_verificado_con_peso "$in_file" "$out_file" 

######################################################################

echo "1-2 EeV con peso herald" #Este falta 

in_file="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/Original_Energy/2019/AllTriggers_1_2_EeV_2019.dat"
out_file="AllTriggers_2019_data_file_Eraw_1_2_EeV_hex.txt" 

	
	#./anisotropy_verificado_con_peso_v2 "$in_file" "$out_file" 

######################################################################

echo "2-4 EeV con peso herald" #Este falta 

in_file="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/Original_Energy/2019/AllTriggers_2_4_EeV_2019.dat"
out_file="AllTriggers_2019_data_file_Eraw_2_4_EeV_hex.txt" 

	
	#./anisotropy_verificado_con_peso_v2 "$in_file" "$out_file" 

######################################################################
######################################################################
######################################################################
######################################################################

echo "8 EeV con peso herald"

in_file="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/Original_Energy/2019/AllTriggers_8EeV_2019.dat"
out_file="AllTriggers_2019_data_file_Eraw_8_EeV_hex.txt" 

	
	./anisotropy_verificado_con_peso_v2 "$in_file" "$out_file" 