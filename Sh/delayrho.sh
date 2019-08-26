## Script para reemplazar valor de $\rho$ en el archivo utctprh por el valor que tiene 2 horas antes.
##
awk 'BEGIN{i=1}{if(i>2)i=1;if(NR>2)print $1,t[i],$3,rho[i],$5,$6;t[i]=$2;rho[i]=$4;i++}' utctprhcavg-bins.dat > utctprhcavg-binsdr.dat
