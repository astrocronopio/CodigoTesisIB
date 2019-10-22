file_herald="../../Merged_Herald_Weather/Another_way_around/Herald_weather.dat"

file_output="../../Merged_Herald_Weather/Another_way_around/Herald_weather_no_badperiods.dat"

awk '{if ($13==1) print $1, $2, $3, $4, $5, $6}' "$file_herald" > "$file_output"


file_herald="../../Merged_Herald_Weather/Another_way_around/Old_herald_weather.dat"

file_output="../../Merged_Herald_Weather/Another_way_around/Old_herald_weather_no_badperiods.dat"

awk '{if ($13==1) print $1, $2, $3, $4, $5, $6}' "$file_herald" > "$file_output"

file_herald="../../Merged_Herald_Weather/Another_way_around/Herald_weather_S38.dat"
file_output="../../Merged_Herald_Weather/Another_way_around/Herald_weather_S38_no_badperiods.dat"

awk '{if ($13==1) print $1, $2, $3, $4, $5, $6}' "$file_herald" > "$file_output"


file_herald="../../Merged_Herald_Weather/Another_way_around/Old_herald_weather_S38.dat"
file_output="../../Merged_Herald_Weather/Another_way_around/Old_herald_weather_S38_no_badperiods.dat"

awk '{if ($13==1) print $1, $2, $3, $4, $5, $6}' "$file_herald" > "$file_output"

