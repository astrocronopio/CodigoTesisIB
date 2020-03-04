echo "1 EeV con peso Oscar"

in_file="../../AllTriggers/AllTriggers_1EeV.dat"
out_file="AllTriggers_Oscar_data_file_Eraw_1EeV_hex_short_range.txt" 

	
	#./anisotropy_verificado_con_peso "$in_file" "$out_file" 

######################################################################
echo "1 EeV con peso Herald"

in_file="../../AllTriggers/AllTriggers_1EeV_herald.dat"
out_file="AllTriggers_Herald_data_file_Eraw_1EeV_hex_short_range.txt" 

	
	#./anisotropy_verificado_con_peso "$in_file" "$out_file" 


######################################################################
######################################################################
######################################################################
######################################################################
echo "1-2 EeV con peso Oscar"

in_file="../../AllTriggers/AllTriggers_1_2_EeV.dat"
out_file="AllTriggers_Oscar_data_file_Eraw_1_2_EeV_hex_short_range.txt" 

	
	#./anisotropy_verificado_con_peso "$in_file" "$out_file" 

######################################################################

echo "1-2 EeV con peso herald" #Este falta 

in_file="../../AllTriggers/AllTriggers_1_2_EeV_herald.dat"
out_file="AllTriggers_Herald_data_file_Eraw_1_2_EeV_hex_short_range.txt" 

	
	#./anisotropy_verificado_con_peso "$in_file" "$out_file" 


######################################################################
######################################################################
######################################################################
######################################################################

echo "8 EeV con peso herald"

in_file="../../AllTriggers/AllTriggers_8EeV_herald.dat"
out_file="AllTriggers_Herald_data_file_Eraw_8_EeV_hex_short_range.txt" 

	
	./anisotropy_verificado_con_peso "$in_file" "$out_file" 