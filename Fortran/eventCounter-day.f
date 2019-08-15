!! Contiene diferentes subrutinas para contar número de eventos y hexágonos por hora del día y dividiendo en verano o invierno.
!!
		real kk,zenith,azimut,energy
		integer GPSTime,utcTime,status,date(9),hourCounter(24,2)!,hourCounter(24)
		open(unit=1,file='HeraldData6EeV060noiw4.dat')
		open(unit=2,file='HeraldData6EeV060noiw4-binsh.dat')
		open(unit=3,file='fitmodnmoon.dat')
		open(unit=4,file='fitmodnmoonhour.dat')
		open(unit=10,file='fitmoddrsummerhour.dat')
		open(unit=11,file='fitmoddrwinterhour.dat')
		open(unit=12,file='HeraldData6EeV060weathergt2004.dat')
		open(unit=13,file='data6EeV060sh.dat')
		open(unit=14,file='data6EeV060wh.dat')
		open(unit=15,file='data6EeV060h.dat')
		hourCounter = 0
			do
				read (1,*,iostat=status)zenith,azimut,utcTime,energy!,GPStime
				if (status.ne.0) exit ! Exit on end of data file
				if (utcTime.ge.1104537600) then	!only counts events above 1104537600 (1/1/2005)
					call gmtime(utcTime,date)
					j = date(3) + 1  ! hour of the utcTime (0-23)
					m = date(2)		  ! minute of the utcTime (0-59)
c					hourCounter(j) = hourCounter(j) + 1
					if (m.lt.30) then
						hourCounter(j,1) = hourCounter(j,1) + 1
					else
						hourCounter(j,2) = hourCounter(j,2) + 1
					endif
				endif
			end do

c		do i=1,24
c			write(2,*)i,hourCounter(i),sqrt(float(hourCounter(i)))
c		end do

		do i=1,24
			do k=1,2
				kk=i-1+k*0.5
		write(2,*)kk,hourCounter(i,k),sqrt(float(hourCounter(i,k)))
		  enddo
		end do

		call modelcounter
c		call modelcounterseason(0,10)
c		call modelcounterseason(1,11)
c		call counterseason(0,13)
c		call counterseason(1,14)
c		call counterseason(2,15)
		end

		subroutine modelcounter
		dimension avgmu(24),avgni(24),avgdni(24),sumh6(24)
		integer date(9),counter(24)
		integer stat,utcTime
		real mu,ni,dni
		avgmu = 0.
		avgni = 0.
		avgdni = 0.
		sumh6 = 0.
		counter = 0
		do
			read(3,*,iostat=stat) utcTime,mu,ni,dni,h6
			if (stat.ne.0) exit	  ! Exit on end of data file
			call gmtime(utcTime,date)
			j = date(3) + 1		  ! hour of the utcTime (0-23)
			avgmu(j) = avgmu(j) + mu
			avgni(j) = avgni(j) + ni
			sumh6(j) = sumh6(j) + h6
		end do
		do i=1,24
			write(4,*)i,avgmu(i),avgni(i),sqrt(avgni(i)),sumh6(i)
		enddo
		return
		end

		subroutine modelcounterseason(iflag,iunit)
		dimension avgmu(24),avgni(24),avgdni(24),sumh6(24)
		integer date(9),counter(24)
		integer stat,utcTime,iflag,iunit
		real mu,ni,dni
		avgmu = 0.
		avgni = 0.
		avgdni = 0.
		sumh6 = 0.
		counter = 0
		rewind(unit=3)
 20		read(3,*,end=21) utcTime,mu,ni,dni,h6
			call gmtime(utcTime,date)
			j = date(3) + 1     ! hour of the utcTime (1-24)
			mon = date(5)  		! month of the UTC (0-11)
			day = date(4)			! day of the UTC	(1-31)
			
			if(iflag.eq.1) then
c		counts only events in winter (21 march to 21 sept)
				if(mon.lt.2.or.mon.gt.8) goto 20
				if(mon.eq.2.and.day.lt.21) goto 20
				if(mon.eq.8.and.day.ge.21) goto 20
			elseif(iflag.eq.0) then
c		counts only events in summer (21 sept to 21 march)
				if(mon.gt.2.and.mon.lt.8) goto 20
				if(mon.eq.2.and.day.ge.21) goto 20
				if(mon.eq.8.and.day.lt.21) goto 20
			endif
				avgmu(j) = avgmu(j) + mu
				avgni(j) = avgni(j) + ni
				sumh6(j) = sumh6(j) + h6
			goto 20
 21		continue
		do i=1,24
			write(iunit,*)i,avgmu(i),avgni(i),sqrt(avgni(i)),sumh6(i)
		enddo
		return
		end

c     count the number of events per hour day taking only those 
c     events that lies in the same epoch (iflag)
		subroutine counterseason(iflag,iunit)
		dimension avgni(24),sumh6(24)
		integer date(9)
		integer utcTime,iflag,iunit
		real ni
		avgni = 0.
		sumh6 = 0.
		counter = 0
		rewind(unit=12)
 30		read(12,*,end=41) utcTime,ni,x1,x2,x3,h6
			call gmtime(utcTime,date)
			j = date(3) + 1     ! hour of the utcTime (1-24)
			mon = date(5)  		! month of the UTC (0-11)
			day = date(4)			! day of the UTC	(1-31)
			
			if(iflag.eq.1) then
c		counts only events in winter (21 march to 21 sept)
				if(mon.lt.2.or.mon.gt.8) goto 30
				if(mon.eq.2.and.day.lt.21) goto 30
				if(mon.eq.8.and.day.ge.21) goto 30
			elseif(iflag.eq.0) then
c		counts only events in summer (21 sept to 21 march)
				if(mon.gt.2.and.mon.lt.8) goto 30
				if(mon.eq.2.and.day.ge.21) goto 30
				if(mon.eq.8.and.day.lt.21) goto 30
			endif
			avgni(j) = avgni(j) + ni
			sumh6(j) = sumh6(j) + h6
			goto 30
 41		continue
		do i=1,24
			write(iunit,*)i,avgni(i),sqrt(avgni(i)),sumh6(i)
		enddo
		return
		end
