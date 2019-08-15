## Script para eliminar las columnas obsoletas de Energy $5 Site Theta Phi $16 $17 y sus errores
## $18 $19, Dominance ratio $26, 
##

cat /home/ponci/Desktop/TesisLicenciaturaBalseiro/Trabajo_de_Coronel/Herald/Archive_v6r2p2.dat | tr -s ' ' | cut -d ' ' -f -25,27- > temp.dat
cat temp.dat | tr -s ' ' | cut -d ' ' -f -15,18- > temp1.dat
cat temp1.dat | tr -s ' ' | cut -d ' ' -f -4,6- > /home/ponci/Desktop/TesisLicenciaturaBalseiro/Trabajo_de_Coronel/Herald/Herald_modified.dat
rm temp.dat
rm temp1.dat