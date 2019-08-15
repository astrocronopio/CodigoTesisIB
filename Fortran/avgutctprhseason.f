!! Genera archivo utctprh en bines de 1 hora y dividiendo en verano e invierno.
!!
		integer n,i,counter,status,lsup,binWidth,UTC
		integer date(9),hourCounter(24)
		real drho(24),drhomax(24), drhomin(24)
		open(unit=1,file='utctprhcavg.dat')
		open(unit=2,file='utctprhcavg-bins.dat')
		open(unit=3,file='utctprhcavg-bins-winter.dat')
		open(unit=4,file='utctprhcavg-bins-summer.dat')
		open(unit=7,file='utctprhcavg-bins-sum.dat')
		open(unit=8,file='utctprhcavg-bins-aut.dat')
		open(unit=9,file='utctprhcavg-bins-win.dat')
		open(unit=10,file='utctprhcavg-bins-spr.dat')
c		open(unit=3,file='utctprh3_bins-day.dat')
		binWidth = 3600!86400		
		n = 12!288					!numero de elementos en un bin = binWidth/300 
		nbin = 87672!3652				!numero de bines entre 1/1/2004 (1072915201) y 1/1/2014 (1388534400) de acuerdo a binWidth
		do i=1,nbin
			counter = 0
			avgtemp = 0.
			avgpres = 0.
			avgrho = 0.
			avgrhod = 0.
			avghex6T5 = 0.
			avgrm= 0.
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

				if(ibp.eq.1.and.iw.lt.4) avghex6T5 = avghex6T5 + hex6T5	!count hex. only if no bad period and no bad weather 
				counter = counter + 1
		end do
				avgtemp = avgtemp/counter
				avgpres = avgpres/counter
				avgrho = avgrho/counter
				avgrhod = avgrhod/counter
c				avgrm = avgrm/counter
		write(2,*)UTC-binWidth/2,avgtemp,avgpres,avgrho,avgrhod,avghex6T5
c			write(2,*) UTC,avgtemp,avgpres,avgrho,avgrhod,avghex6T5,avgrm
		end do
	
		call remsumorwin(0)
		call remsumorwin(1)

		do i=0,3
			call selseasons(i)
		enddo

		rewind(unit=1)
		hourCounter = 0
		drho = 0.
		drhomin = 0.
		drhomax = 0.
		j = 0
			do
				read (1,*,iostat=status)UTC,temp,pres,rho,rhod
				if (status.ne.0) exit ! Exit on end of data file
				call gmtime(UTC,date)
				j = date(3)+1
				drho(j) = drho(j) + (rho-rhod)
				if (drhomin(j).gt.rho-rhod) drhomin(j)=rho-rhod
				if (drhomax(j).lt.rho-rhod) drhomax(j)=rho-rhod
				hourCounter(j) = hourCounter(j) + 1
			end do
		do i=1,24
c			write(3,*)i,drho(i)/float(hourCounter(i))
c     &			,drhomin(i),drhomax(i)	
		end do
		end

c	removes from binned file the summer or winter bins 
		subroutine remsumorwin(iflag)
		integer iflag		! iflag=0 removes winter, iflag=1 removes summer
		integer UTC,status,date(9)
		rewind(unit=2)
		do
  20			read (2,*,iostat=status)UTC,x1,x2,x3,x4,x5
			if (status.ne.0) exit	 ! Exit on end of data file
			call gmtime(UTC,date)
			mon = date(5)  		! month of the UTC (0-11)
			day = date(4)			! day of the UTC	(1-31)
			
			if(iflag.eq.1) then
c		counts only events in winter (21 march to 21 sept)
				if(mon.lt.2.or.mon.gt.8) goto 20
				if(mon.eq.2.and.day.lt.21) goto 20
				if(mon.eq.8.and.day.ge.21) goto 20
			write(3,*)UTC,x1,x2,x3,x4,x5
			elseif(iflag.eq.0) then
c		counts only events in summer (21 sept to 21 march)
				if(mon.gt.2.and.mon.lt.8) goto 20
				if(mon.eq.2.and.day.ge.21) goto 20
				if(mon.eq.8.and.day.lt.21) goto 20
			write(4,*)UTC,x1,x2,x3,x4,x5
			endif
		enddo
		return
		end		

c	select from binned file four three-month seasons
		subroutine selseasons(iflag)
		integer iflag		! 
		integer UTC,status,date(9)
		rewind(unit=2)
		do
  20			read (2,*,iostat=status)UTC,x1,x2,x3,x4,x5
			if (status.ne.0) exit	 ! Exit on end of data file
			call gmtime(UTC,date)
			mon = date(5)  		! month of the UTC (0-11)
			day = date(4)			! day of the UTC	(1-31)
			
			if(iflag.eq.0) then
c		counts events between 1 dec - 1 mar
				if(mon.lt.11.and.mon.gt.2) goto 20
				if(mon.eq.2.and.day.gt.1) goto 20
c				if(mon.eq.11.and.day.ge.21) goto 20
			write(7,*)UTC,x1,x2,x3,x4,x5
			elseif(iflag.eq.1) then
c		counts events between 2 mar - 31 may
				if(mon.lt.2.or.mon.gt.4) goto 20
				if(mon.eq.2.and.day.lt.2) goto 20
c				if(mon.eq.4.and.day.lt.21) goto 20
			write(8,*)UTC,x1,x2,x3,x4,x5
			elseif(iflag.eq.2) then
c		counts events between 1 jun - 30 aug
				if(mon.lt.5.or.mon.gt.7) goto 20
				if(mon.eq.7.and.day.gt.30) goto 20
c				if(mon.eq.4.and.day.lt.21) goto 20
			write(9,*)UTC,x1,x2,x3,x4,x5
			elseif(iflag.eq.3) then
c		counts events between 31 aug - 30 nov
				if(mon.lt.7.or.mon.gt.10) goto 20
				if(mon.eq.7.and.day.lt.31) goto 20
c				if(mon.eq.4.and.day.lt.21) goto 20
			write(10,*)UTC,x1,x2,x3,x4,x5
			endif
		enddo
		return
		end
