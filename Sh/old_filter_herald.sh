## This scripts allows the user to select data, creates a new file with the selected data. Each line has a comment of the command. 
## All the scripts should not be use at the same time. DO NOT FORGET TO COMMENT THE FUNCTION AFTER USE
# 118.1

#___________________________________________________________________

#This scripts works on the actual auger data set structure (2019) with the simplest data
auger_file_simple_input='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Archive/Archive_v6r2p2.dat'
auger_file_simple_output='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/All_Energy/Herald.dat'

#$8		$3 		$4		$12		$13		$38		
#UTC 	The		phi 	S1000 	dS1000	Energy 	

#awk '{if ($3<60.0 && $22!=0 && $23!=0 && $44!=0 && $43>5) print  $8,$3,$4,$12,$13,$38}' "$auger_file_simple_input" > "$auger_file_simple_output"
awk '{print  $8,$3,$4,$12,$13,$38}' "$auger_file_simple_input" > "$auger_file_simple_output"

#___________________________________________________________________

#This scripts works on the old auger data set structure with the simplest data
auger_file_5v_input='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Archive/ArchiveICRCnoBP.dat'
auger_file_5v_output='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/All_Energy/Old_Herald.dat'

#$8		$3 		$4		$12		$13		$39	
#UTC 	The		phi 	S1000 	dS1000	Energy 			para matchear weather

#awk '{if ($3<60.0 && $22!=0 && $23!=0 && $44!=0 && $43>5) print  $8,$3,$4,$12,$13,$39}' "$auger_file_5v_input" > "$auger_file_5v_output"
awk '{print  $8,$3,$4,$12,$13,$39}' "$auger_file_5v_input" > "$auger_file_5v_output"


#_______________________________________________________________________________________
#________________________________Energy above 1 EeV___________________________________

#This scripts works on the actual auger data set structure (2019) with the simplest data
auger_file_energy_input='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Archive/Archive_v6r2p2.dat'
auger_file_energy_output='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Herald_filter_by_energy_above_1EeV.dat'

#awk '{if ($3<60.0 && $22!=0 && $23!=0 && $44!=0 && $43>=5 && $38>=1.0) print  $8,$3,$4,$12,$13,$38}' "$auger_file_energy_input" > "$auger_file_energy_output"
awk '{if ($3<60.0 && $22!=0 && $23!=0 && $44!=0  && $38>=1.0) print  $8,$3,$4,$12,$13,$38}' "$auger_file_energy_input" > "$auger_file_energy_output"


#_________________________________Energy below 1 EeV__________________________________

#This scripts works on the old auger data set structure with the simplest data
auger_file_5v_energy_input='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Archive/ArchiveICRCnoBP.dat'
auger_file_5v_energy_output='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Old_Herald_filter_by_energy_above_1EeV.dat'

#awk '{if ($3<60.0 && $22!=0 && $23!=0 && $44!=0 && $43>=5 && $39>=1.0) print  $8,$3,$4,$12,$13,$39}' "$auger_file_5v_energy_input" > "$auger_file_5v_energy_output"
awk '{if ($3<60.0 && $22>0 && $23>0  && $44>0  && $39>=1.0) print  $8,$3,$4,$12,$13,$39}' "$auger_file_5v_energy_input" > "$auger_file_5v_energy_output"

#23 no es
#22 tampoco 
## 1 196 865