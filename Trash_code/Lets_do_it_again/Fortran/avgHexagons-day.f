!! Calcula promedios de hexágonos. 
!!
		real num6T5,num5T5,hour6T5Avg(24)
		integer GPSTime,utcTime,status,date(9),hourCounter(24)
		open(unit=1,file='HexagonsMn_2004-2013-UTCnoBP.dat')
		open(unit=2,file='HexagonsAvg_2004-2013-hourday.dat')
		open(unit=3,file='utctprhcavg.dat')
		open(unit=4,file='avghexhour.dat')
		hour6T5Avg = 0
		hourCounter = 0
		  if(1.eq.1) goto 21
		i = 1
			do
				read (1,*,iostat=status)GPStime,utcTime,num6T5,num5T5
				if (status.ne.0) exit ! Exit on end of data file
				call gmtime(utcTime,date)
				hour6T5Avg(date(3)+1) = hour6T5Avg(date(3)+1)+ num6T5
				hourCounter(date(3)+1) = hourCounter(date(3)+1) + 1
			end do
		do while (i <= 24)
			write(2,*)i,hour6T5Avg(i)
			i = i + 1			
		end do

 21	  call avghex		

		end

		subroutine avghex
		real kk,num6T5,sum6T5(24,2)!,sum6T5(24)
		integer utcTime,status,date(9),ib,iw

		sum6T5 = 0.
			do
				read (3,*,iostat=status)utcTime,x1,x2,x3,x4,num6T5,x5,iw,ib
				if (status.ne.0) exit ! Exit on end of data file
				if (utcTime.ge.1104537600.and.utcTime.le.1370044800) then	!only counts events above 1104537600 (1/1/2005) and below 1370044800 (6/1/2013)
					if(ib.eq.1.and.iw.lt.4) then	!only sum hexagons that isn't in bad periods or bad weather
						call gmtime(utcTime,date)
						j = date(3) + 1 ! hour of the utcTime (0-23)
						m = date(2)	  ! minute of the utcTime (0-59)
c						sum6T5(date(3)+1) = sum6T5(date(3)+1)+ num6T5
						if (m.lt.30) then
							sum6T5(j,1) = sum6T5(j,1)+ num6T5
						else
							sum6T5(j,2) = sum6T5(j,2)+ num6T5
						endif
					endif
				endif
			end do
c		do i=1,24
c			write(4,*)i,sum6T5(i)		
c		end do

		do i=1,24
			do k=1,2
				kk=i-1.+k*0.5
				write(4,*)kk,sum6T5(i,k)
			enddo
		end do

		return
		end
