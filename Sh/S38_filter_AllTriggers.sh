################################################
################################################
####    1- ($8)   UTC                       ####
####    2- ($4)   Phi                       ####
####    3- ($3)   Theta                     ####
####    4- ($14)  Ra                        ####
####    5- ($12)  S1000 sin corregir        ####
####    6- ($47)  S38_w                     ####
####    7- ($38)/($38)  Energy              ####
####    8- ($43)  Tanks                     ####
####    9- ($37)  S1000 con correccion      ####
################################################
################################################



echo "2019 data s38"


#------------------------------------------------------------------------------------------------------------------------------------
auger_file_simple_input="/home/ponci/Desktop/TesisIB/Coronel/Raw_files/AllTriggers/ArchiveAllTriggers_v6r2p2_311219.dat"
auger_file_simple_output="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/Energy_Reconstruction/2019/AllTriggers_S38_over_1EeV_cutted.dat"

#1372699409 && $8<=1496267276  

awk '{if ( $8>1388910508 && $2>2 && $22>0 && $23>0 && $48>0 && $43>5 && $44>0 && $37>0 && $12*$47/$37>=5.37 ) print  $8,$4,$3,$14,$12,$47,$38,$43, $37}' "$auger_file_simple_input" > "$auger_file_simple_output"
