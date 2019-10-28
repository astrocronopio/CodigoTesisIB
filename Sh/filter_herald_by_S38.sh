## This scripts allows the user to select data, creates a new file with the selected data. Each line has a comment of the command. 
## All the scripts should not be use at the same time. DO NOT FORGET TO COMMENT THE FUNCTION AFTER USE
echo "filter_herald_by_S38.sh"
#________________________________Energy below 1 EeV___________________________________

echo "This scripts works on the actual auger data set structure (2019) with the simplest data"
auger_file_energy_input='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Archive/Archive_v6r2p2.dat'
auger_file_energy_output='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_filter_by_S38/Herald_S38.dat'

#$8		$3 		$4		$12		$13		$38		
#UTC 	The		phi 	S1000 	dS1000	Energy 
awk '{if ($3<60.0 && $22!=0 && $23!=0 && $44!=0 && $43>5 && $12*$47/$37>=5.37 ) print  $8,$3,$4,$12,$13,$38}' "$auger_file_energy_input" > "$auger_file_energy_output"
wc -l  "$auger_file_energy_output"


#_________________________________Energy below 1 EeV__________________________________

echo "This scripts works on the old auger data set structure with the simplest data"
auger_file_5v_energy_input='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Archive/ArchiveICRCnoBP.dat'
auger_file_5v_energy_output='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_filter_by_S38/Herald_old_S38.dat'

#$8		$3 		$4		$12		$13		$39	
#UTC 	The		phi 	S1000 	dS1000	Energy 			para matchear weather
awk '{if ($3<60.0 && $22!=0 && $23!=0 && $44!=0 && $43>5 && $47>=5.37  ) print  $8,$3,$4,$12,$13,$39}' "$auger_file_5v_energy_input" > "$auger_file_5v_energy_output"
wc -l  "$auger_file_5v_energy_output"