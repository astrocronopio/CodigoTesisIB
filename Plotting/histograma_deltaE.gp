set terminal qt 0 enhanced font 'Verdana,26' size 1000,800 
set key left

set title "Histograma {/Symbol D}E"
n=10000 #number of intervals
max=50. #max value
min=-50. #min value
width=0.02 #interval width
#function used to map a value to the intervals
hist(x,width)=width*floor(x/width)+width/2.0
set boxwidth width*0.5
#set style fill solid #0.5 # fill style

set ylabel "N_{bin}/N_{Total}"
set xlabel "(E_{2017} - E_{2019})/2 [EeV]"
set logscale y
set xrange [-0.5:0.5]
set format y "10^{%L}"
#set yrange [-0.0001: 0.021]
#count and plot
plot "../../AllTriggers/deltaE.dat" u (0.5*hist(($1),width)):(1.0/(7072964.0)) smooth freq w boxes lc rgb "blue" notitle

pause(-1)