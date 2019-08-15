## Script que en el viejo método de cálculo de los coeficientes de clima se usa para unir los eventos por hora con los correspondientes datos de clima.
##

#join HeraldData060_bins.dat HexagonsAvg_2004-2013-monthly.dat | awk '{if ($4!=0) print $1,$2,$3,$4,$2/$4,$3/$4,strftime("%Y%m%d",$1)}' > HeraldData060_rate.dat
#join SDHASData2EeV6080_bins-day.dat HexagonsAvg_2004-2013-hourday.dat | awk '{print $1,$2,$3,$4,$2/$4,$3/$4}' > SDHASData2EeV6080_rate-day.dat
#join utctprh_bins.dat HexagonsAvg_2004-2013-hour.dat  | awk '{ print $1,$2,$3,$4,$5,$7}' > utctprh_bins2.dat
join HeraldData4EeV060noiw4-bins.dat utctprhcavg-bins.dat | awk '{ print $1,$2,$5,$6,$7,$8}' > HeraldData4EeV060weathergt2004.dat
#join HeraldData060noiw4_binsgt2004.dat utctprh3_bins.dat | awk '{ print $1,$2,$5,$6,$9,$8}' > HeraldData060weathergt2004rmax.dat
#join HeraldData060noiw4-bins-day.dat avghexhour.dat | awk '{print $1,$2,$3,$4,$2/$4,$3/$4}' > HeraldData060noiw4-rate-day.dat
