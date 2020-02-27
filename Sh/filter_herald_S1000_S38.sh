## This scripts allows the user to select data, creates a new file with the selected data. Each line has a comment of the command. 
## All the scripts should not be use at the same time. DO NOT FORGET TO COMMENT THE FUNCTION AFTER USE
echo "S38_S1000"

#------------------------------------------------------------------------------------------------------------------------------------
echo "This scripts works on the actual auger data set structure (2019)  only"
auger_file_simple_input="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Archive/Archive_v6r2p2.dat"
auger_file_simple_output_theta="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/All_Energy/Herald_s1000_s38.dat"
#$8			 $3 	 $12        $37(con weather) $47	
#UTC 		The	 	S1000 		S1000	 		 S38
#awk '{if ($2>2 && $22>0 && $23>0 && $43>5 && $44>0 && $3<=60 && $12*$47/$37>=5.37 ) print  $8,$3, $12*$47/$37, $38}' "$auger_file_simple_input" > "$auger_file_simple_output_theta"
#wc -l  "$auger_file_simple_output_theta"

utctprh="/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh_delay.dat"
outfile="../../Merged_Herald_Weather/Herald_S38_S1000//Herald_weather_s1000_s38.dat"
outfilenobp="../../Merged_Herald_Weather/Herald_S38_S1000/Herald_weather_s1000_s38_nobp.dat"

../Cpp/merged_herald_weather_s1000_s38  "$auger_file_simple_output_theta"   "$utctprh"  "$outfile"
#outfile << utc< << the << S38 << Energy << p << rho << rhod << iw << ib


awk '{if ($8<4  && $9==1) print $1,$2,$3,$4,$5,$6,$7}' "$outfile" > "$outfilenobp"
#rm "$outfile"


echo "S38_w_S1000"


#------------------------------------------------------------------------------------------------------------------------------------
echo "This scripts works on the actual auger data set structure (2019)  only"
auger_file_simple_input="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Archive/Archive_v6r2p2.dat"
auger_file_simple_output_theta="/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/All_Energy/Herald_s1000_s38_w.dat"
#$8			 $3 	 $12        $37(con weather) $47	
#UTC 		The	 	S1000 		dS1000	 		 S38
#awk '{if ($2>2 && $22>0 && $23>0 && $43>5 && $44>0 && $3<=60 && $47>=5.37 ) print  $8,$3, $47, $38}' "$auger_file_simple_input" > "$auger_file_simple_output_theta"
#wc -l  "$auger_file_simple_output_theta"

utctprh="/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh_delay.dat"
outfile="../../Merged_Herald_Weather/Herald_S38_w_S1000//Herald_weather_s1000_s38_w.dat"
outfilenobp="../../Merged_Herald_Weather/Herald_S38_w_S1000/Herald_weather_s1000_s38_w_nobp.dat"

../Cpp/merged_herald_weather_s1000_s38  "$auger_file_simple_output_theta"   "$utctprh"  "$outfile"
#outfile << utc< << the << S38 << Energy << p << rho << rhod << iw << ib


awk '{if ($8<4  && $9==1) print $1,$2,$3,$4,$5,$6,$7}' "$outfile" > "$outfilenobp"
#rm "$outfile"
