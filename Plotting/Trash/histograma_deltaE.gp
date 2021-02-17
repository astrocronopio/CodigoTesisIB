set terminal qt 0 enhanced font 'times,26' size 1200,800 
set key left

#set title "Histograma {/Symbol D}E"
n=10000 #number of intervals
max=50. #max value
min=-50. #min value
width=0.2 #interval width
#function used to map a value to the intervals
hist(x,width)=width*floor(x/width)+width/2.0
set boxwidth width*0.5
#set style fill solid #0.5 # fill style

set ylabel "N_{bin}/N_{Total}"
set xlabel "(E_{2020} - E_{2019})/2 [EeV]"
#set logscale y
#set xrange [16:20]
#set format y "10^{%L}"
#set yrange [-0.0001: 0.021]
#count and plot
N = 1742235

filename = "../../AllTriggers/Energy_analisis/energia_2017_AllTriggers.dat"
#plot "../../Trash/ArchiveAllTriggers_merged_energy.dat" u (0.5*hist(($6),width)):(1.0/(N)) smooth freq w boxes lc rgb "blue" notitle

plot filename u (0.5*hist((log($1)),width)):(1.0/(N)) smooth freq w boxes lc rgb "blue" notitle

pause(-1)