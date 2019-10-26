## This scripts allows the user to select data, creates a new file with the selected data. Each line has a comment of the command. 
## All the scripts should not be use at the same time. DO NOT FORGET TO COMMENT THE FUNCTION AFTER USE

##All data is below 60 the for the weather paper, because of the effective path the CR has in the atmosphere

#___________________________________DONE_____________________________
#This scripts works in the old data set (2004-2015, weather paper). It takes the 
#utc data  phi rho dec rad S1000 dS1000 and energy   

#awk '{print $2,$3,$4,$5,$7,$8,$9,$10,$11,$12}'  file_input > file output
file_input='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Archives/ArchiveICRCnoBP.dat'
file_output='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Old_Herald_modified.dat'

#$8		$12		$13		$14		$15		$38			$39
#UTC 	S1000 	dS1000 	Ra 		Dec 	NaN 		CIC Energy

#awk '{print $8,$12,$13,$14,$15,$38,$39}' "$file_input" > "$file_output"

#_________________________________________________________________

#awk '{if ($8<1174353408 && $8> 1142817408 && $12<10E5) print $8,$12}' "$file_input" > "$file_output"

#____________________________________DONE____________________________
#This scripts works on the actual auger data set structure (2019) 
auger_file_input='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Archives/Archive_v6r2p2.dat'
auger_file_output='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Herald_modified.dat'

#$8		$3 		$4		$12		$13		$14		$15		$22	 		$23 			$38			$43		 	$44   	$48
#UTC 	The		phi 	S1000 	dS1000	RA 		Dec 	Criteria	Reconstruction	Energy 		Neighbours 	Flag 	Bad Period
#awk '{if ($3<60 && $22!=0 && $23!=0 && $44!=0 && $48==0) print  $8,$3,$4,$12,$13,$14,$15,$38,$43,$48}' "$auger_file_input" > "$auger_file_output"

#_____________________________________________________________________

# $1 	$2		$3		$4		$5		$6		$7 		$8		$9			$10			$11`			$12
# utc 	T 		P 		rho		rho_av	6T5 	5T5		iw		Bad Period	Humedad		rho_hum			rho_av,hum
weather_file='/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh.dat'
weather_file_no_bp='/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh_without_badperiod_no_iw.dat'

#awk '{if ($8!=4 && $9==1) print $1, $2, $3, $4, $5, $6, $7, $10, $11, $12}' "$weather_file"  > "$weather_file_no_bp"

#___________________________________________________________________

#This scripts works on the actual auger data set structure (2019) with the simplest data
auger_file_simple_input='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Archive/Archive_v6r2p2.dat'
auger_file_simple_output='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Herald_simple_modified.dat'

#$8		$3 		$4		$12		$13		$38		
#UTC 	The		phi 	S1000 	dS1000	Energy 	
#awk '{if ($3<60 && $22!=0 && $23!=0 && $44!=0 && $43>=5) print  $8,$3,$4,$12,$13,$38}' "$auger_file_simple_input" > "$auger_file_simple_output"

#___________________________________________________________________

#This scripts works on the old auger data set structure with the simplest data
auger_file_5v_input='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Archive/ArchiveICRCnoBP.dat'
auger_file_5v_output='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Herald_old_simple_modified.dat'

#$8		$3 		$4		$12		$13		$39	
#UTC 	The		phi 	S1000 	dS1000	Energy 			para matchear weather
#awk '{if ($3<60 && $22!=0 && $23!=0 && $44!=0 && $43>=5) print  $8,$3,$4,$12,$13,$39}' "$auger_file_5v_input" > "$auger_file_5v_output"


#________________________________Energy below 1 EeV___________________________________

#This scripts works on the actual auger data set structure (2019) with the simplest data
auger_file_energy_input='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Archive/Archive_v6r2p2.dat'
auger_file_energy_output='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Herald_energy_modified.dat'

#$8		$3 		$4		$12		$13		$38		
#UTC 	The		phi 	S1000 	dS1000	Energy 	
awk '{if ($3<60 && $22!=0 && $23!=0 && $44!=0 && $43>=5 && $38>1 ) print  $8,$3,$4,$12,$13,$38}' "$auger_file_energy_input" > "$auger_file_energy_output"

#_________________________________Energy below 1 EeV__________________________________

#This scripts works on the old auger data set structure with the simplest data
auger_file_5v_energy_input='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Archive/ArchiveICRCnoBP.dat'
auger_file_5v_energy_output='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Herald_old_energy_modified.dat'

#$8		$3 		$4		$12		$13		$39	
#UTC 	The		phi 	S1000 	dS1000	Energy 			para matchear weather
awk '{if ($3<60 && $22!=0 && $23!=0 && $44!=0 && $43>=5 && $39>1 ) print  $8,$3,$4,$12,$13,$39}' "$auger_file_5v_energy_input" > "$auger_file_5v_energy_output"

#I just dont know what to do
