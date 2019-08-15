## Script para agregar info de clima correspondiente a cada evento de un archivo.
##
awk '{bin=int(($3-1072915500)/300); utc=1072915500+300*bin; print utc,$0}' HeraldData060.dat > tmp.dat
join tmp.dat utctprh.dat | awk '{print $2,$3,$4,$5,$7,$8,$9,$10,$11,$12}' > HeraldData060weather.dat
