################################################
################################################
####    1- ($8)   UTC                       ####
####    2- ($4)   Phi                       ####
####    3- ($3)   Theta                     ####
####    4- ($14)  Ra                        ####
####    5- ($12)  S1000 sin corregir        ####
####    6- ($47)  S38                       ####
####    7- ($38)  Energy                    ####
####    8- ($43)  Tanks                     ####
####    9- ($37)  S1000 con correccion      ####
################################################
################################################



echo "filter_herald.sh"


#------------------------------------------------------------------------------------------------------------------------------------
echo "Este es el archivo que baje en el 2020"
       auger_file_simple_input="/home/ponci/Desktop/TesisIB/Coronel/Raw_files/AllTriggers/ArchiveAllTriggers_v6r2p2_311219.dat"
    auger_file_simple_output_1="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/Energy_Reconstruction/2019/AllTriggers_S38_over_1EeV_2019.dat"
  auger_file_simple_output_1_2="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/Energy_Reconstruction/2019/AllTriggers_S38_over_1_2_EeV_2019.dat"
  auger_file_simple_output_2_4="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/Energy_Reconstruction/2019/AllTriggers_S38_over_2_4_EeV_2019.dat"

#awk '{if ($2>2 && $22>0 && $23>0 && $48>0 && $43>5 && $44>0 && $38>=8) print  $8,$4,$3,$14,$12,$47,$38,$43, $37}' "$auger_file_simple_input" > "$auger_file_simple_output_theta"


echo "Para 1 EeV"
  #awk '{if ($2>2 && $22>0 && $23>0 && $48>0 && $43>5 && $44>0 && $37>0 && $12*$47/$37>=5.36  && $3<60 && $48==1 ) print  $8,$4,$3,$14,$12,$12*$47/$37,$38,$43, $37}' "$auger_file_simple_input" > "$auger_file_simple_output_1"
  #awk '{if ($2>2 && $22>0 && $23>0 && $48>0 && $43>=5 && $44>0 && $37>0 && $12*$47/$37>=5.36 && $3<60 && $48==1) print  $8,$4,$3,$14,$12,$12*$47/$37,$38,$43, $37}' "$auger_file_simple_input" > "$auger_file_simple_output_12"

echo "Entre 1 EeV y 2 EeV"
  awk '{if ($2>2 && $22>0 && $23>0 && $48>0 && $43>5 && $44>0 && $37>0 && $12*$47/$37>=5.36  && $12*$47/$37>=10.05 && $3<60 && $48==1) print  $8,$4,$3,$14,$12,$12*$47/$37,$38,$43, $37}' "$auger_file_simple_input" > "$auger_file_simple_output_1_2"

echo "Entre 2 EeV y 4 EeV"
  #awk '{if ($2>2 && $22>0 && $23>0 && $48>0 && $43>=5 && $44>0 && $37>0 && $12*$47/$37>=10.05 && $12*$47/$37>=19.66) print  $8,$4,$3,$14,$12,$12*$47/$37,$38,$43, $37}' "$auger_file_simple_input" > "$auger_file_simple_output_2_4"


################################################
################################################
####    1- ($8)   UTC                       ####
####    2- ($4)   Phi                       ####
####    3- ($3)   Theta                     ####
####    4- ($14)  Ra                        ####
####    5- ($12)  S1000 sin corregir        ####
####    6- ($47)  S38_w                     ####
####    7- ($38)  Energy_Reconstruction     ####
####    8- ($43)  Tanks                     ####
####    9- ($37)  S1000 con correccion      ####
################################################
################################################



#awk '{if ( $8>1388910508 && $2>2 && $22>0 && $23>0 && $48>0 && $43>5 && $44>0 && $12*$47/$37>=5.36 ) print  $8,$4,$3,$14,$12,$47,$38,$43, $37}' "$auger_file_simple_input" > "$auger_file_simple_output"



