!! Genera archivo con número de eventos por bin de 1 hora dividiendo en verano o invierno o también en periodos con luna llena o nueva.
!!
		integer n,j,i,status,linf,lsup,GPStime,UTC,binWidth
		real zenith,azimut,energy,interval
		parameter(nbin = 82536)		!number of bins since 01/01/2004 00:00:00 UTC (1072915200) until 06/01/2013 00:00:00 UTC (1370044800) 
c		parameter(nbin = 121)
		integer binlist(nbin)
c		open(unit=1,file='HeraldData060weathergt2004.dat')
		open(unit=1,file='HeraldData060weatherdrno.dat')
		open(unit=3,file='HeraldData060weatherwinter.dat')
		open(unit=4,file='HeraldData060weathersummer.dat')
		open(unit=7,file='HeraldData060noiw4-bins-sum.dat')
		open(unit=8,file='HeraldData060noiw4-bins-aut.dat')
		open(unit=9,file='HeraldData060noiw4-bins-win.dat')
		open(unit=10,file='HeraldData060noiw4-bins-spr.dat')

c		call selsumorwin(0)
c		call selsumorwin(1)
		call selmoon()
c		do i=0,3
c			call selseasons(i)
c		enddo
		end	

c	select from binned file the summer or winter bins 
		subroutine selsumorwin(iflag)
		integer iflag		! iflag=0 select summer, iflag=1 select winter
		integer UTC,status,date(9)
		rewind(unit=1)
		do
  20		read (1,*,iostat=status)UTC,x2,x3,x4,x5,x6
			if (status.ne.0) exit	 ! Exit on end of data file
			call gmtime(UTC,date)
			mon = date(5)  		! month of the UTC (0-11)
			day = date(4)			! day of the UTC	(1-31)
			
			if(iflag.eq.1) then
c		counts only events in winter (21 march to 21 sept)
				if(mon.lt.2.or.mon.gt.8) goto 20
				if(mon.eq.2.and.day.lt.21) goto 20
				if(mon.eq.8.and.day.ge.21) goto 20
			write(3,*)UTC,x2,x3,x4,x5,x6
			elseif(iflag.eq.0) then
c		counts only events in summer (21 sept to 21 march)
				if(mon.gt.2.and.mon.lt.8) goto 20
				if(mon.eq.2.and.day.ge.21) goto 20
				if(mon.eq.8.and.day.lt.21) goto 20
			write(4,*)UTC,x2,x3,x4,x5,x6
			endif
		enddo
		return
		end

c	select from binned file the full moon and new moon bins 
		subroutine selmoon()
c		integer iflag		! iflag=0 select summer, iflag=1 select winter
		integer UTC,status,fmoon(120),i2
		open(unit=11,file='HeraldData060weatherdrnofmoon.dat')
		open(unit=12,file='HeraldData060weatherdrnonmoon.dat')
		rewind(unit=1)
c		utcmin = 1104537600
		utcfmoon = 1412765443 !luna llena del 08/10/2014 10:50:43 UTC
		msinod = 2551440 ! mes sinódico 29d 12h 44m
		fmoonev = 0
		nmoonev = 0
		do i=120,1,-1
			fmoon(i) = utcfmoon - (121-i)*msinod
		end do
		do
			read (1,*,iostat=status)UTC,i2,x3,x4,x5,x6
			if (status.ne.0) exit	 ! Exit on end of data file
			ind = int((UTC-fmoon(1))/msinod) + 1
			if(ind.lt.0) cycle
			sevend = 7*24*3600
			if(abs(UTC-fmoon(ind)).le.sevend.or.abs(UTC-fmoon(ind+1)).le.
     &sevend) then
				write(11,*)UTC,i2,x3,x4,x5,x6
			else
				write(12,*)UTC,i2,x3,x4,x5,x6
			end if
		enddo
		close(11)
		close(12)
		return
		end

c	select from binned file four three-month seasons
		subroutine selseasons(iflag)
		integer iflag		! 
		integer UTC,status,date(9)
		rewind(unit=2)
		do
  20			read (1,*,iostat=status)UTC,nev,dnev
			if (status.ne.0) exit	 ! Exit on end of data file
			call gmtime(UTC,date)
			mon = date(5)  		! month of the UTC (0-11)
			day = date(4)			! day of the UTC	(1-31)
			
			if(iflag.eq.0) then
c		counts events between 1 dec - 1 mar
				if(mon.lt.11.and.mon.gt.2) goto 20
				if(mon.eq.2.and.day.gt.1) goto 20
c				if(mon.eq.11.and.day.ge.21) goto 20
			write(7,*)UTC,nev,dnev
			elseif(iflag.eq.1) then
c		counts events between 2 mar - 31 may
				if(mon.lt.2.or.mon.gt.4) goto 20
				if(mon.eq.2.and.day.lt.2) goto 20
c				if(mon.eq.4.and.day.lt.21) goto 20
			write(8,*)UTC,nev,dnev
			elseif(iflag.eq.2) then
c		counts events between 1 jun - 30 aug
				if(mon.lt.5.or.mon.gt.7) goto 20
				if(mon.eq.7.and.day.gt.30) goto 20
c				if(mon.eq.4.and.day.lt.21) goto 20
			write(9,*)UTC,nev,dnev
			elseif(iflag.eq.3) then
c		counts events between 31 aug - 30 nov
				if(mon.lt.7.or.mon.gt.10) goto 20
				if(mon.eq.7.and.day.lt.31) goto 20
c				if(mon.eq.4.and.day.lt.21) goto 20
			write(10,*)UTC,nev,dnev
			endif
		enddo
		return
		end
