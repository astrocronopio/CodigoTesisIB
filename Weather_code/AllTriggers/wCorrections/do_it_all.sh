make clean
make all

                path="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/Original_Energy/2019/AllTriggers_1EeV_2019.dat"
      		path_fit="../2019/weather_analysis/AllTriggers_1EeV_all_sin2.dat"
path_hour_of_the_day="../2019/weather_analysis/AllTriggers_1EeV_hour_of_the_day.dat"
  path_hour_expected="../2019/weather_analysis/AllTriggers_1EeV_rate_hour.dat"
  path_rate_expected="../2019/weather_analysis/AllTriggers_1EeV_rate_day.dat" 




./wCorrectionsv3_main $1 1 "$path" "$path_fit"  "$path_hour_of_the_day" "$path_hour_expected" "$path_rate_expected"
./wCorrectionsv3_main $1 2 "$path" "$path_fit"  "$path_hour_of_the_day" "$path_hour_expected" "$path_rate_expected"
./wCorrectionsv3_main $1 3 "$path" "$path_fit"  "$path_hour_of_the_day" "$path_hour_expected" "$path_rate_expected"
./wCorrectionsv3_main $1 4 "$path" "$path_fit"  "$path_hour_of_the_day" "$path_hour_expected" "$path_rate_expected"
./wCorrectionsv3_main $1 5 "$path" "$path_fit"  "$path_hour_of_the_day" "$path_hour_expected" "$path_rate_expected"

./wCorrectionsv3_main $1 "$path" "$path_fit"  "$path_hour_of_the_day" "$path_hour_expected" "$path_rate_expected"

./wCorrectionsv3_main "$path" "$path_fit"  "$path_hour_of_the_day" "$path_hour_expected" "$path_rate_expected"