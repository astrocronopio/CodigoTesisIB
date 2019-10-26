## This scripts allows the user to select data, creates a new file with the selected data. Each line has a comment of the command. 
## All the scripts should not be use at the same time. DO NOT FORGET TO COMMENT THE FUNCTION AFTER USE

#------------------------------------------------------------------------------------------------------------------------------------
#This scripts works on the actual auger data set structure (2019)  only
auger_file_simple_input="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Archive/Archive_v6r2p2.dat"
auger_file_simple_output="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/All_Energy/Herald.dat"

#$8		$3 		$4		$12		$13		$38		
#UTC 	The		phi 	S1000 	dS1000	Energy 	

awk '{if ($22>0 && $23>0 && $44!=0) print  $8,$3,$4,$12,$13,$38}' "$auger_file_simple_input" > "$auger_file_simple_output"
wc -l  "$auger_file_simple_output"

#------------------------------------------------------------------------------------------------------------------------------------

auger_file_5v_input="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Archive/ArchiveICRCnoBP.dat"
auger_file_5v_output="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/All_Energy/Old_Herald.dat"

#$8		$3 		$4		$12		$13		$39	
#UTC 	The		phi 	S1000 	dS1000	Energy 	

awk '{if ($22>0 && $23>0 && $44!=0) print  $8,$3,$4,$12,$13,$39}' "$auger_file_5v_input" > "$auger_file_5v_output"
wc -l  "$auger_file_5v_output"
