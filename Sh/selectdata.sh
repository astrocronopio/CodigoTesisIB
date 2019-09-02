 ## This scripts allows the user to select data, creates a new file with the selected data. Each line has a comment of the command. 
## All the scripts should not be use at the same time. DO NOT FORGET TO COMMENT THE FUNCTION AFTER USE

#The next lines where made by Oscar Taborda
#awk '{if ($1>1104537601 && $1<1220227200) print $0}' HeraldData060_bins.dat > HeraldData060_bins2008.dat
#awk '{pi=atan2(0, -1);if(1/cos($1*pi/180)>1.0 && 1/cos($1*pi/180)<=1.2 ) print $0}' HeraldData1EeV060noiw4.dat > HeraldData1EeVsec1.dat
#awk '{if ($1>1104537601) print $0}' HeraldData1EeV060noiw4_bins.dat > HeraldData1EeV060noiw4_binsgt2004.dat
#awk '{pi=atan2(0, -1);binid=(1/cos($1*pi/180)-1)/0.2; print $0,int(binid)}' HeraldData060noiw4.dat > HeraldDatasecnoiw4.dat
#awk '{if ($4>3.0) print}' HeraldData060noiw4.dat > HeraldData3EeV060noiw4.dat


#Next ones made by Evelyn Coronel

##All data is below 60 the for the weather paper, because of the effective path the CR has in the atmosphere

#___________________________________DONE_____________________________
#This scripts works in the old data set (2004-2015, weather paper). It takes the 
#utc data  phi rho dec rad S1000 dS1000 and energy   

#awk '{print $2,$3,$4,$5,$7,$8,$9,$10,$11,$12}'  file_input > file output
file_input='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Archives/ArchiveICRCnoBP.dat'
file_output='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Old_Herald_modified.dat'

#$8		$12		$13		$14		$15		$38			$39
#UTC 	S1000 	dS1000 	Ra 		Dec 	NaN 		CIC Energy

#awk '{print $8,$12,$13,$14,$15,$38,$39}' "$file_input" > "$file_output"

#_________________________________________________________________

#awk '{if ($8<1174353408 && $8> 1142817408 && $12<10E5) print $8,$12}' "$file_input" > "$file_output"

#____________________________________DONE____________________________
#This scripts works on the actual auger data set structure (2019) 
auger_file_input='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Archives/Archive_v6r2p2.dat'
auger_file_output='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Herald_modified.dat'

#$8		$3 		$4		$12		$13		$14		$15		$22	 		$23 			$38			$43		 	$44   	$48
#UTC 	The		phi 	S1000 	dS1000	RA 		Dec 	Criteria	Reconstruction	Energy 		Neighbours 	Flag 	Bad Period
#awk '{if ($3<60 && $22!=0 && $23!=0 && $44!=0 && $48==0) print  $8,$3,$4,$12,$13,$14,$15,$38,$43,$48}' "$auger_file_input" > "$auger_file_output"

#___________________________________________________________________

#This scripts works on the actual auger data set structure (2019) with the simplest data
auger_file_simple_input='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Archives/Archive_v6r2p2.dat'
auger_file_simple_output='/home/ponci/Desktop/TesisIB/Coronel/Herald/Central/Modified/Herald_simple_modified.dat'

#$8		$3 		$4		$12		$13		$38	
#UTC 	The		phi 	S1000 	dS1000	Energy 		
#awk '{if ($3<60 && $22!=0 && $23!=0 && $44!=0 && $48==0 && $43==6) print  $8,$3,$4,$12,$13,$38}' "$auger_file_simple_input" > "$auger_file_simple_output"

#_____________________________________________________________________

# $1 	$2		$3		$4		$5		$6		$7 		$8		$9
# utc 	T 		P 		rho		rho_av	6T5 	5T5		iw		Bad Period
weather_file='/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh.dat'
weather_file_no_bp='/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh_without_badperiod_no_iw.dat'

#awk '{if ($8!=4 && $9==1) print $1, $2, $3, $4, $5, $6, $7, $8}' "$weather_file"  > "$weather_file_no_bp"