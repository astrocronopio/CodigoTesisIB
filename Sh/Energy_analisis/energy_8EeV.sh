
echo "filter_herald.sh"


#------------------------------------------------------------------------------------------------------------------------------------
echo "This scripts works on the actual auger data set structure (2019)  only"
auger_file_simple_input="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Archive/Archive_v6r2p2.dat"
auger_file_simple_output_theta="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Herald_8EeV.dat"
#awk '{if ($2>2 && $22>0 && $23>0 && $43>=5 && $44>0 && $38>=8) print  $8,$4,$3,$14,$12,$13,$38,$43}' "$auger_file_simple_input" > "$auger_file_simple_output_theta"

echo "old"
###################################################################
auger_file_5v_input="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Archive/ArchiveICRCnoBP.dat"
auger_file_5v_output_theta="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Old_herald_8EeV.dat"

#awk '{if ($2 >2 && $22>0 && $23>0 && $43>=5 && $44>0 && $39>=8) print   $8,$4,$3,$14,$12,$13,$39,$43}' "$auger_file_5v_input" > "$auger_file_5v_output_theta"
																		#utc >> phi>>the >> ra>>x3>>x4>>Energy>>tanks 

echo "old oscar"
###################################################################
auger_file_5v_input="/home/ponci/Desktop/TesisIB/Coronel/PC_Weather_paper/Herald/HeraldWeather060noBPdr6t5v3.dat"
auger_file_5v_output_theta="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Energy_above_1EeV/Old_herald_8EeV_oscar.dat"

awk '{if ($10>8) print   $3, $4, $5, $7, $8, $9, $10, 5 ,$11, $12, $13, $14}' "$auger_file_5v_input" > "$auger_file_5v_output_theta"
