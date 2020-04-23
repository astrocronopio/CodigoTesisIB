echo "1 EeV sin peso Oscar"

in_file="../../AllTriggers/AllTriggers_1EeV.dat"
out_file="AllTriggers_Oscar_data_file_Eraw_1EeV_short_range.txt" 

	
	#./anisotropy_verificado_sin_peso_v2 "$in_file" "$out_file" 

######################################################################
echo "1 EeV sin peso herald"

in_file="../../AllTriggers/AllTriggers_1EeV_herald.dat"
out_file="AllTriggers_Herald_data_file_Eraw_1EeV_short_range.txt" 

	
	#./anisotropy_verificado_sin_peso_v2 "$in_file" "$out_file" 


######################################################################
######################################################################
######################################################################
######################################################################


in_file="../../AllTriggers/AllTriggers_1_2_EeV.dat"
out_file="AllTriggers_Oscar_data_file_Eraw_1_2_EeV_short_range.txt" 

	
	#./anisotropy_verificado_sin_peso "$in_file" "$out_file" 

######################################################################
echo "1-2 EeV sin peso herald" #Este falta 

in_file="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/Original_Energy/2019/AllTriggers_1_2_EeV_2019.dat"
out_file="AllTriggers_2019_data_file_Eraw_1_2_EeV_short_range.txt" 

	
	./anisotropy_verificado_sin_peso_v2 "$in_file" "$out_file" 


######################################################################
######################################################################
######################################################################
######################################################################

echo "8 EeV sin peso herald"

in_file="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/Original_Energy/2019/AllTriggers_8EeV_2019.dat"
out_file="AllTriggers_2019_data_file_Eraw_8_EeV.txt" 

	
	./anisotropy_verificado_sin_peso_v2 "$in_file" "$out_file" 