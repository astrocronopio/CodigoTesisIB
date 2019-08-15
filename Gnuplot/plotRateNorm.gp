set xdata time
set timefmt "%Y%m%d"
set format x "%m/%Y"
set grid
#plot 'HeraldData3EeV060_rateNorm.dat' u 1:2:3 w e title "E > 3 EeV",'HeraldData1EeV060_rateNorm.dat' u 1:2:3 w e title "E > 1 EeV",'HeraldData060_rateNorm.dat' u 1:2:3 w e title "All"
plot 'HeraldData3EeV060_rateNorm.dat' u 1:2:3 w e title "E > 3 EeV",'utctprh-dateNorm.dat' u 1:2 title "Density"
set xdata
set format x
