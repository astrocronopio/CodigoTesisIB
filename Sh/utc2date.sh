## Script que anexa una columna con "yyyymmdd" a un archivo cuya primera columna es un UTC.
##
cat ~/Desktop/TesisLicenciaturaBalseiro/Trabajo_de_Coronel/Weather_uis/utctprh.dat | awk '{ print $0,strftime("%Y%m%d",$1)}' >  ~/Desktop/TesisLicenciaturaBalseiro/Trabajo_de_Coronel/Weather_uis/utctprh-date.dat

