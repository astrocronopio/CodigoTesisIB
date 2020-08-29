################################################
################################################
####    1- ($8)   UTC                       ####
####    2- ($4)   Phi                       ####
####    3- ($3)   Theta                     ####
####    4- ($14)  Ra                        ####
####    5- ($12)  S1000 sin corregir        ####
####    6- ($47)  S38_w                     ####
####    7- ($38)  Energy                    ####
####    8- ($43)  Tanks                     ####
####    9- ($37)  S1000 con correccion      ####
################################################
################################################



echo "filter_herald.sh"


#------------------------------------------------------------------------------------------------------------------------------------
echo "Este es el archivo que baje en el 2020"
       auger_file_simple_input="/home/ponci/Desktop/TesisIB/Coronel/Raw_files/AllTriggers/ArchiveAllTriggers_v6r2p2_311219.dat"
    auger_file_simple_output_1="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/Original_Energy/2019/AllTriggers_1EeV_2019.dat"
  auger_file_simple_output_1_2="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/Original_Energy/2019/AllTriggers_1_2_EeV_2019.dat"
 auger_file_simple_output_1_2_50="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/Original_Energy/2019/AllTriggers_1_2_EeV_2019_50.dat"
  auger_file_simple_output_2_4="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/Original_Energy/2019/AllTriggers_2_4_EeV_2019.dat"
  auger_file_simple_output_2="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/Original_Energy/2019/AllTriggers_2_EeV_2019.dat"
  
  auger_file_simple_output_4_8="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/Original_Energy/2019/AllTriggers_4_8_EeV_2019.dat"
auger_file_simple_output_theta="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/Original_Energy/2019/AllTriggers_8EeV_2019.dat"
#1372699409 && $8<=1496267276  



echo "Entre 0.5 EeV y 1 EeV"
  auger_output="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/Original_Energy/2019/AllTriggers_0-5_1_EeV_2019.dat"

  awk '{if ($2>2 && $22>0 && $23>0 && $48>0 && $43>5 && $44>0 && $38>=0.5 && $38<1 && $3<60) print  $8,$4,$3,$14,$12,$47,$38,$43, $37}' "$auger_file_simple_input" > "$auger_output"

echo "Entre 0.25 EeV y 0.5 EeV"
  auger_output="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/Original_Energy/2019/AllTriggers_0-25_0-5_EeV_2019.dat"

  awk '{if ($2>2 && $22>0 && $23>0 && $48>0 && $43>5 && $44>0 && $38>=0.25 && $38<0.5 && $3<60) print  $8,$4,$3,$14,$12,$47,$38,$43, $37}' "$auger_file_simple_input" > "$auger_output"


echo "Para 8 EeV"
  #awk '{if ($2>2 && $22>0 && $23>0 && $48>0 && $43>5 && $44>0 && $38>=8) print  $8,$4,$3,$14,$12,$47,$38,$43, $37}' "$auger_file_simple_input" > "$auger_file_simple_output_theta"

echo "Para 1 EeV"
  #awk '{if ($2>2 && $22>0 && $23>0 && $48>0 && $43>5 && $44>0 && $38>=1) print  $8,$4,$3,$14,$12,$47,$38,$43, $37}' "$auger_file_simple_input" > "$auger_file_simple_output_1"

echo "Entre 4 EeV y 8 EeV"
  #awk '{if ($2>2 && $22>0 && $23>0 && $48>0 && $43>5 && $44>0 && $38>=4 && $38<8) print  $8,$4,$3,$14,$12,$47,$38,$43, $37}' "$auger_file_simple_input" > "$auger_file_simple_output_4_8"

echo "Entre 1 EeV y 2 EeV"
#  awk '{if ($2>2 && $22>0 && $23>0 && $48>0 && $43>5 && $44>0 && $38>=1 && $38<2 && $3<60) print  $8,$4,$3,$14,$12,$47,$38,$43, $37}' "$auger_file_simple_input" > "$auger_file_simple_output_1_2"
  #awk '{if ($2>2 && $22>0 && $23>0 && $48>0 && $43>5 && $44>0 && $38>=1 && $38<2 && $3<50) print  $8,$4,$3,$14,$12,$47,$38,$43, $37}' "$auger_file_simple_input" > "$auger_file_simple_output_1_2_50"

echo "Entre 2 EeV y 4 EeV"
  #awk '{if ($2>2 && $22>0 && $23>0 && $48>0 && $43>=5 && $44>0 && $38>=2 && $38<4) print  $8,$4,$3,$14,$12,$47,$38,$43, $37}' "$auger_file_simple_input" > "$auger_file_simple_output_2_4"

echo "Arriba 2 eev"
#  awk '{if ($2>2 && $22>0 && $23>0 && $48>0 && $43>=5 && $44>0 && $38>=2 && $8<1577880000 && $8>1388577600) print  $8,$4,$3,$14,$12,$47,$38,$43, $37}' "$auger_file_simple_input" > "$auger_file_simple_output_2"



echo "old oscar: antes de la nueva reconstrucción"
###################################################################
       auger_file_5v_input="/home/ponci/Desktop/TesisIB/Coronel/Raw_files/AllTriggers/ArchiveAllTriggers_Oscar.dat"
    auger_file_5v_output_1="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/Original_Energy/2017/AllTriggers_1EeV_2017.dat"
  auger_file_5v_output_1_2="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/Original_Energy/2017/AllTriggers_1_2_EeV_2017.dat"
  auger_file_5v_output_2_4="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/Original_Energy/2017/AllTriggers_2_4_EeV_2017.dat"
  auger_file_5v_output_4_8="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/Original_Energy/2017/AllTriggers_4_8_EeV_2017.dat"
auger_file_5v_output_theta="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/Original_Energy/2017/AllTriggers_8EeV_2017.dat"


echo "Para 8 EeV"
  #awk '{if ($2 >2 && $22>0 && $23>0 && $48>0 && $43>=5 && $44>0 && $39>=8) print   $8,$4,$3,$14,$12,$47,$39,$43, $37}' "$auger_file_5v_input" > "$auger_file_5v_output_theta"

echo "Para 1 EeV"
  #awk '{if ($2 >2 && $22>0 && $23>0 && $48>0 && $43>5 && $44>0 && $39>=1) print   $8,$4,$3,$14,$12,$47,$39,$43, $37}' "$auger_file_5v_input" > "$auger_file_5v_output_1"

echo "Entre 4 EeV y 8 EeV"
  #awk '{if ($2>2  && $22>0 && $23>0 && $48>0 && $43>=5 && $44>0 && $39>=4 && $39<8) print  $8,$4,$3,$14,$12,$47,$38,$43, $37}' "$auger_file_5v_input" > "$auger_file_5v_output_4_8"

echo "Entre 1 EeV y 2 EeV"
  #awk '{if ($2 >2 && $22>0 && $23>0 && $48>0 && $43>5 && $44>0 && $39>=1 && $39<2) print   $8,$4,$3,$14,$12,$47,$39,$43, $37}' "$auger_file_5v_input" > "$auger_file_5v_output_1_2"

echo "Entre 2 EeV y 4 EeV"
  #awk '{if ($2 >2 && $22>0 && $23>0 && $48>0 && $43>5 && $44>0 && $39>=2 ) print   $8,$4,$3,$14,$12,$47,$39,$43, $37}' "$auger_file_5v_input" > "$auger_file_5v_output_2_4"



