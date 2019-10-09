generate_file () { 
	awk '{if ($10>2000) print $0 }' $1  >aux 
				#utc events  T  P  Rho Rho_av 
	awk '{print $5,  $2,$7,  $8,$9,$10}' aux	> $2 
	rm $1 && rm aux 
} 
 
Merged_Herald_Weather () { 
	python eventCounter.py  $1  $2 
 
	awk '{if ($1<mktime("2011 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }' $2 > events_time.dat 
	awk '{if ($1<mktime("2011 12 31 23 59 59") && $1>mktime("2005 01 01 00 00 00")) print $0 }' $3 > delay_time.dat 
 
	paste events_time.dat	delay_time.dat	> events_delay.dat  
	rm events_time.dat && rm delay_time.dat	 
	generate_file events_delay.dat 	$4 
} 
 
file_delay="/home/ponci/Desktop/TesisIB/Coronel/Weather/utctprh-binsdelayrho.dat" 




file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector1.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector1_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector1merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector2.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector2_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector2merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector3.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector3_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector3merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector4.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector4_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector4merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector5.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector5_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector5merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector1.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector1_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector1merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector2.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector2_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector2merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector3.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector3_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector3merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector4.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector4_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector4merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector5.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector5_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector5merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/New/Herald_S38_sector1.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/New/Herald_S38_sector1_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/New/Herald_S38_sector1merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/New/Herald_S38_sector2.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/New/Herald_S38_sector2_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/New/Herald_S38_sector2merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/New/Herald_S38_sector3.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/New/Herald_S38_sector3_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/New/Herald_S38_sector3merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/New/Herald_S38_sector4.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/New/Herald_S38_sector4_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/New/Herald_S38_sector4merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/New/Herald_S38_sector5.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/New/Herald_S38_sector5_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/New/Herald_S38_sector5merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/Old/Herald_old_S38_sector1.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/Old/Herald_old_S38_sector1_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/Old/Herald_old_S38_sector1merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/Old/Herald_old_S38_sector2.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/Old/Herald_old_S38_sector2_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/Old/Herald_old_S38_sector2merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/Old/Herald_old_S38_sector3.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/Old/Herald_old_S38_sector3_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/Old/Herald_old_S38_sector3merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/Old/Herald_old_S38_sector4.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/Old/Herald_old_S38_sector4_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/Old/Herald_old_S38_sector4merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/Old/Herald_old_S38_sector5.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/Old/Herald_old_S38_sector5_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Sin_squared/Old/Herald_old_S38_sector5merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector1.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector1_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector1merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector2.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector2_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector2merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector3.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector3_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector3merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector4.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector4_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector4merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector5.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector5_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/New/Herald_filter_by_energy_above_1EeV_sector5merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector1.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector1_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector1merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector2.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector2_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector2merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector3.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector3_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector3merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector4.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector4_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector4merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector5.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector5_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_above_1EeV/Up_to_2019/Sin_squared/Old/Old_Herald_filter_by_energy_above_1EeV_sector5merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/New/Herald_S38_sector1.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/New/Herald_S38_sector1_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/New/Herald_S38_sector1merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/New/Herald_S38_sector2.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/New/Herald_S38_sector2_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/New/Herald_S38_sector2merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/New/Herald_S38_sector3.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/New/Herald_S38_sector3_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/New/Herald_S38_sector3merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/New/Herald_S38_sector4.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/New/Herald_S38_sector4_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/New/Herald_S38_sector4merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/New/Herald_S38_sector5.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/New/Herald_S38_sector5_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/New/Herald_S38_sector5merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/Old/Herald_old_S38_sector1.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/Old/Herald_old_S38_sector1_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/Old/Herald_old_S38_sector1merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/Old/Herald_old_S38_sector2.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/Old/Herald_old_S38_sector2_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/Old/Herald_old_S38_sector2merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/Old/Herald_old_S38_sector3.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/Old/Herald_old_S38_sector3_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/Old/Herald_old_S38_sector3merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/Old/Herald_old_S38_sector4.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/Old/Herald_old_S38_sector4_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/Old/Herald_old_S38_sector4merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 



file_auger="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/Old/Herald_old_S38_sector5.dat" 
 file_events="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/Old/Herald_old_S38_sector5_bins.dat" 
 file_merged="/home/ponci/Desktop/TesisIB/Coronel/Merged_Herald_Weather/Energy_filter_by_S38/Up_to_2019/Sin_squared/Old/Herald_old_S38_sector5merged.dat" 
Merged_Herald_Weather "$file_auger" "$file_events"  "$file_delay"  "$file_merged" 

