file_utctprh="/home/ponci/Desktop/TesisIB/Taborda_Original/utctprh2.dat"


##
Eventos=$(awk 'BEGIN {sum=0}{ if($1> 1108161000 || $1< 1451606399) sum+=9} END {print sum}' $file_utctprh)
echo  $Eventos


#9668061
#9668052

