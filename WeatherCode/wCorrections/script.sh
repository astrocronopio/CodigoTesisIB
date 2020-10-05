#Para calcular distintos archivos
rango2004=1072915200
rango2005=1104537600

rangomid2014=1420113404 #Para archivos de old herald / Pc weather
rango2013_bad=1372680068

rango2013=1388577600 #Nuevo piso
rango2015=1451566800
rango2017=1472688000

rango2019=1546344000
rango2020=1577880000


path="/home/ponci/Desktop/TesisIB/Coronel/AllTriggers/S38_analisis/2019/AllTriggers_S38_over_1EeV_2019_merged.dat"
#path="/home/ponci/Desktop/TesisIB/Coronel/Weather_PC/Herald/HeraldWeather060noBPdr6t5v3.dat"

folder="./Files_AllTriggers/"
energy_threshold="0"

mkdir "$folder"
path_fit="$folder"""$energy_threshold"EeV_all_sin2.dat"
path_hour_of_the_day="$folder"""$energy_threshold"EeV_hour_of_the_day.dat"
path_hour_expected="$folder"""$energy_threshold"EeV_rate_hour.dat"
path_rate_expected="$folder"""$energy_threshold"EeV_rate_day.dat" 
 

utci="$rango2013"
utcf="$rango2020"

make clean
make all


./wCorrectionsv4_main "$energy_threshold" 1 "$path" "$path_fit"  "$path_hour_of_the_day" "$path_hour_expected" "$path_rate_expected" "$utci" "$utcf"
./wCorrectionsv4_main "$energy_threshold" 2 "$path" "$path_fit"  "$path_hour_of_the_day" "$path_hour_expected" "$path_rate_expected" "$utci" "$utcf"
./wCorrectionsv4_main "$energy_threshold" 3 "$path" "$path_fit"  "$path_hour_of_the_day" "$path_hour_expected" "$path_rate_expected" "$utci" "$utcf"
./wCorrectionsv4_main "$energy_threshold" 4 "$path" "$path_fit"  "$path_hour_of_the_day" "$path_hour_expected" "$path_rate_expected" "$utci" "$utcf"
./wCorrectionsv4_main "$energy_threshold" 5 "$path" "$path_fit"  "$path_hour_of_the_day" "$path_hour_expected" "$path_rate_expected" "$utci" "$utcf"

./wCorrectionsv4_main "$energy_threshold"   "$path" "$path_fit"  "$path_hour_of_the_day" "$path_hour_expected" "$path_rate_expected" "$utci" "$utcf"


gnuplot -e "filename='$path_fit'"             plot_weather_params.gp
gnuplot -e "filename='$path_rate_expected'"   plot_rate_daily.gp
gnuplot -e "filename='$path_hour_of_the_day'" plot_rate_hour_24.gp
