make clean
make all

                path="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/Energy_Reconstruction/2019/AllTriggers_S38_over_1EeV_2019_merged.dat"
      		path_fit="/home/ponci/Desktop/TesisIB/Coronel/CodigoTesisIB/Weather_code/AllTriggers/2019/weather_analysis/AllTriggers_S38_over_1EeV_all_sin2.dat"
path_hour_of_the_day="/home/ponci/Desktop/TesisIB/Coronel/CodigoTesisIB/Weather_code/AllTriggers/2019/weather_analysis/AllTriggers_S38_over_1EeV_hour_of_the_day.dat"
  path_hour_expected="/home/ponci/Desktop/TesisIB/Coronel/CodigoTesisIB/Weather_code/AllTriggers/2019/weather_analysis/AllTriggers_S38_over_1EeV_rate_hour.dat"
  path_rate_expected="/home/ponci/Desktop/TesisIB/Coronel/CodigoTesisIB/Weather_code/AllTriggers/2019/weather_analysis/AllTriggers_S38_over_1EeV_rate_day.dat" 

  utci=1388628499
  utcf=1550534100


energy_threshold=0


./wCorrectionsv4_main "$energy_threshold" 1 "$path" "$path_fit"  "$path_hour_of_the_day" "$path_hour_expected" "$path_rate_expected" "$utci" "$utcf"
./wCorrectionsv4_main "$energy_threshold" 2 "$path" "$path_fit"  "$path_hour_of_the_day" "$path_hour_expected" "$path_rate_expected" "$utci" "$utcf"
./wCorrectionsv4_main "$energy_threshold" 3 "$path" "$path_fit"  "$path_hour_of_the_day" "$path_hour_expected" "$path_rate_expected" "$utci" "$utcf"
./wCorrectionsv4_main "$energy_threshold" 4 "$path" "$path_fit"  "$path_hour_of_the_day" "$path_hour_expected" "$path_rate_expected" "$utci" "$utcf"
./wCorrectionsv4_main "$energy_threshold" 5 "$path" "$path_fit"  "$path_hour_of_the_day" "$path_hour_expected" "$path_rate_expected" "$utci" "$utcf"

./wCorrectionsv4_main "$energy_threshold"   "$path" "$path_fit"  "$path_hour_of_the_day" "$path_hour_expected" "$path_rate_expected" "$utci" "$utcf"
./wCorrectionsv4_main 					    "$path" "$path_fit"  "$path_hour_of_the_day" "$path_hour_expected" "$path_rate_expected" "$utci" "$utcf"