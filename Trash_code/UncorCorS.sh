## Script para generar archivo con datos para graficar contorno de 90\% 
## de la razon S0/S
#
# agrega id a cada bin en zenith
awk 'BEGIN{bw=5}{if($4>=1){bid=int($2/bw)+1;print $0,bid,$6/$5}}' UncorCorE2015.dat > x
# ordena ascendentemente por la columna 8 (asegurarse que LC_ALL=POSIX)
sort -g -k8 x > xx
# Lee dos veces el archivo 'xx': en la primera lectura [cuando NR(número de registros leidos en total) = FNR(numero de registro del archivo actual)]
# cuenta el número de elementos en cada bin y en la segunda selecciona los limites del  5% y el 95% de los datos de cada bin
awk 'BEGIN{
		bw=5;
		nb=int(60/bw)+1;
		bin[nb];
		count[nb];
		min[nb];
		max[nb];
		p=0.16
			}
		{
			if(NR==FNR)
			{bin[$7]++}
		
			else{	
				count[$7]++;
				if(count[$7]==int(bin[$7]*p))min[$7]=$8;
					if(count[$7]==int(bin[$7]*(1-p)))
						max[$7]=$8
			}
		}
	END{
		for(i=1;i<nb;i++) print (i-0.5)*bw,min[i],max[i]}' xx xx > UncorCorS_cont68.dat
rm x xx
