## Describe los pasos a seguir para obtener archivo con número de eventos e info de clima en bines de una hora.
##
# Run program that splits dataset in bins of 1 hour counting the number of events in each bin
gfortran eventCounter.f -o eventCounter.out
./eventCounter.out
# Same as before but for the weather and hexagons data
gfortran avgutctprh.f -o avgutctprh.out
./avgutctprh.out
#----- OPCIONAL: for delay the density 2 hrs--------
./delayrho.sh
#---------------------------------------------------
# join the event data with the corresponding weather and hexagon one.
# Remember change the file according to your needs (delayed or current rho)
./joinData.sh
# Remove outliers 1333310000 < UTC < 1333490000 (anomalous low rate in this period)
awk '{if($1<1333310000 || $1>1333490000) print}' HeraldData060weathergt2004.dat > HeraldData060weatherno.dat
