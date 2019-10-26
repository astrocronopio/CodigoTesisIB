!!		Bucles para recorrer los datos de hexagonos dividiendo en bines de
!!		tiempo y calculando el promedio de celdas 6T5 y 5T5 para cada bin. 
!!	  Finalmente se almacenan los promedios de la apertura (num celdas 6T5 
!!		por 4.590 km2 sr)
		integer n,i,counter,status,linf,lsup,GPStime,binWidth,UTC
		real avg6T5,avg5T5,num6T5,num5T5
c		open(unit=1,file='HexagonsMn_2004-2013-UTCnoBP.dat')
		open(unit=1,file='HexagonsMn_2004-2013-UTCnoBP.dat')
		open(unit=2,file='HexagonsAvg_2004-2013-monthly.dat')
		n = 43200!1440					!numero de elementos en un bin
		binWidth = 2592000!86400		
		nbin = 121!3288				!numero de bines	entre 1/1/2004 (1072915201) y 1/1/2014 (1388534400) de acuerdo a binWidth
		do i=1,nbin
			j = 1
			counter = 0
			avg6T5 = 0
			avg5T5 = 0
c			lsup = 756950414 + binWidth*i
			lsup = 1072915201 + binWidth*i
			do while (counter < n)
				read (1,*,iostat=status)GPStime,UTC,num6T5,num5T5
				if (status.ne.0) exit ! Exit on end of data file
					avg6T5 = avg6T5 + num6T5
					avg5T5 = avg5T5 + num5T5
					counter = counter + 1
			end do
c				avg6T5 = avg6T5/counter
c				avg5T5 = avg5T5/counter
			write(2,*) lsup,avg6T5,avg6T5*4.590,counter
		end do
		end		
