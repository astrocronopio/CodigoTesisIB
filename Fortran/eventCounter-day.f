!! Contiene diferentes subrutinas para contar número de eventos y hexágonos por hora del día y dividiendo en verano o invierno.
!!
		real kk,zenith,azimut,energy
		integer GPSTime,utcTime,status,date(9),hourCounter(24,2)!,hourCounter(24)

		open(unit=3,file='')
		open(unit=4,file='fitmodnmoonhour.dat')
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