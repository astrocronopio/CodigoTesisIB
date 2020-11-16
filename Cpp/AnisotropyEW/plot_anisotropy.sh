
# folder="./Files_AllTriggers_0-25_0-5_EeV/"
# file_input="../../../AllTriggers/Original_Energy/2019/AllTriggers_0-25_0-5_EeV_2019.dat"

folder="./Files_AllTriggers_0-5_1_EeV/"
file_input="../../../AllTriggers/Original_Energy/2019/AllTriggers_0-5_1_EeV_2019.dat"

# folder="./Files_AllTriggers_1_2_EeV/"
# file_input="../../../AllTriggers/Original_Energy/2019/AllTriggers_1_2_EeV_2019.dat"

energy_threshold="0"
EW="EW_v2"
EW_2="EW_v2_seg_arm"

file_output_1="$folder""output_threshold_""$energy_threshold""$EW"".dat"
file_output_2="$folder""output_threshold_""$energy_threshold""$EW_2"".dat"


gnuplot -e "filename='$file_output_1'; filecmp='$file_output_2'"  plot_anisotropy.gp
