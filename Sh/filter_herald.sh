## This scripts allows the user to select data, creates a new file with the selected data. Each line has a comment of the command. 
## All the scripts should not be use at the same time. DO NOT FORGET TO COMMENT THE FUNCTION AFTER USE



echo "filter_herald.sh"


#------------------------------------------------------------------------------------------------------------------------------------
echo "This scripts works on the actual auger data set structure (2019)  only"
auger_file_simple_input="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Archive/Archive_v6r2p2.dat"
auger_file_simple_output="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/All_Energy/Herald.dat"
auger_file_simple_output_theta="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Herald_1EeV_theta60.dat"

#$8			$4	  $3 		$14		$15 	$12		$13		$38		
#UTC 		phi  The	 	Ra 		Dec 	S1000 	dS1000	Energy 	

##awk '{if ($2>2 && $22>0 && $23>0 && $43>5 && $44>0) print  $8,$3,$4,$12,$13,$38}' "$auger_file_simple_input" > "$auger_file_simple_output"
#awk '{if ($2>2 && $22>0 && $23>0 && $43>5 && $44>0 && $38>=1 && $3<=60) print  $8,$4,$3,$12,$13,$38}' "$auger_file_simple_input" > "$auger_file_simple_output_theta"
awk '{if ($2>2 && $22>0 && $23>0 && $43>5 && $44>0 && $38>=1 && $3<=60) print  $8,$3,$38}' "$auger_file_simple_input" > "$auger_file_simple_output_theta"

#wc -l  "$auger_file_simple_output"
wc -l  "$auger_file_simple_output_theta"


#------------------------------------------------------------------------------------------------------------------------------------

echo "old"

auger_file_5v_input="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Archive/ArchiveICRCnoBP.dat"
auger_file_5v_output="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/All_Energy/Old_Herald.dat"
auger_file_5v_output_theta="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Old_herald_1EeV_theta60.dat"

#$8		$4	 $3 		$12		$13		$39	
#UTC 	phi The	 	S1000 	dS1000	Energy 	

##awk '{if ($2 >2 && $22>0 && $23>0 && $43>5 && $44>0) print  $8,$3,$4,$12,$13,$39}' "$auger_file_5v_input" > "$auger_file_5v_output"
##awk '{if ($2 >2 && $22>0 && $23>0 && $43>5 && $44>0 && $39>=1 && $3<=60) print  $8,$4,$3s,$12,$13,$39}' "$auger_file_5v_input" > "$auger_file_5v_output_theta"
awk '{if ($2 >2 && $22>0 && $23>0 && $43>5 && $44>0 && $39>=1 && $3<=60) print  $8,$3,$39}' "$auger_file_5v_input" > "$auger_file_5v_output_theta"
#wc -l  "$auger_file_5v_output"
wc -l  "$auger_file_5v_output_theta"


