!! Genera archivo utctprh en bines de 1 hora.
!!
		integer n,i,counter,status,lsup,binWidth,UTC
		integer date(9),hourCounter(24)
		real drho(24),drhomax(24), drhomin(24)
c		open(unit=1,file='utctprhcavg.dat')
		open(unit=1,file='../../datos_auger/utctprhdr_aida.dat')
		open(unit=2,file='utctprhdr-bins.dat')
c		open(unit=2,file='tmp5.dat')
		open(unit=3,file='utctprhcavg-binsh.dat')
		binWidth = 3600!86400		
		n = 12!288					!numero de elementos en un bin = binWidth/300 
		nbin = 96480!87672!3652				!numero de bines entre 1/1/2004 (1072915201) y 1/1/2014 (1388534400) de acuerdo a binWidth
		do i=1,nbin
			counter = 0
			avgtemp = 0.
			avgpres = 0.
			avgrho = 0.
			avgrhod = 0.
			shex6T5 = 0.
c			avgrm= 0.
c			lsup = 1072915200 + binWidth*i
			do while (counter < n)
c			read (1,*,iostat=status)UTC,temp,pres,rho,rhod,hex6T5,x1,iw
c     &	,ibp,rm
			read (1,*,iostat=status)UTC,temp,pres,rho,rhod,hex6T5,x1,iw
     &		,ibp
				if (status.ne.0) exit ! Exit on end of data file
					avgtemp = avgtemp + temp
					avgpres = avgpres + pres
					avgrho = avgrho + rho
					avgrhod = avgrhod + rhod
c					avgrm = avgrm + rm
					if(ibp.eq.1.and.iw.lt.4) shex6T5 = shex6T5 + hex6T5	!count hex. only if no bad period and no bad weather 
					counter = counter + 1
			end do
				avgtemp = avgtemp/counter
				avgpres = avgpres/counter
				avgrho = avgrho/counter
				avgrhod = avgrhod/counter
				shex6T5 = shex6T5/counter
		write(2,*) UTC-binWidth/2,avgtemp,avgpres,avgrho,avgrhod,shex6T5
c			write(2,*) UTC,avgtemp,avgpres,avgrho,avgrhod,shex6T5,avgrm
		end do

c		call counthday
		end

		subroutine counthday
		real avgtemp(24,2),avgpres(24,2),avgrho(24,2)
		real avgrhod(24,2),shex6T5(24,2),kk
		integer counter(24,2),UTC,date(9)

		counter = 0
		avgtemp = 0.
		avgpres = 0.
		avgrho = 0.
		avgrhod = 0.
		shex6T5 = 0.
		rewind(unit=1)

 30	read (1,*,end=31) UTC,temp,pres,rho,rhod,hex6T5,x1,iw,ibp
		call gmtime(UTC,date)
		j = date(3) + 1  ! hour of the utc (0-23)
		m = date(2)		  ! minute of the utc (0-59)
		k = 1
		if (UTC.lt.1104537600) goto 30	!counts events above 1104537600 (1/1/2005)
		if (UTC.gt.1370044800) goto 30	!counts events below 1370044800 (1/6/2013)
		if (m.gt.30) k = 2
		avgtemp(j,k)=avgtemp(j,k)+temp
		avgpres(j,k)=avgpres(j,k)+pres
		avgrho(j,k)=avgrho(j,k)+rho
		avgrhod(j,k)=avgrhod(j,k)+rhod
		if(ibp.eq.1.and.iw.lt.4) shex6T5(j,k)=shex6T5(j,k)+hex6T5
		counter(j,k)=counter(j,k)+1
		goto 30
 31	continue
		do i=1,24
			do k=1,2
				kk=i-1+k*0.5
				at=avgtemp(j,k)/counter(j,k)
				ap=avgpres(j,k)/counter(j,k)
				ar=avgrho(j,k)/counter(j,k)
				ard=avgrhod(j,k)/counter(j,k)
				write(3,*)kk,at,ap,ar,ard,shex6T5(j,k),counter(j,k)
		  enddo
		enddo
		return
		end
