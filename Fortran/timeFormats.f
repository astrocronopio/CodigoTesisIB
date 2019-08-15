!! Contiene subrutina para convertir GPS a UTC teniendo en cuenta los leap seconds.
!!
		real num6T5,num5T5
		integer GPSTime,utcTime,status
		open(unit=1,file='gpshex5min')
		open(unit=2,file='utchex5min2')
			do
				read (1,*,iostat=status)GPStime,num6T5,num5T5
				if (status.ne.0) exit ! Exit on end of data file
				call gps2utc(GPStime,utcTime)
c				write(2,*)GPStime,utcTime,num6T5,num5T5
				write(2,*)utcTime,num6T5,num5T5
			end do
		end

c Define GPS leap seconds
		subroutine getleaps(leaps)
			integer leaps(16)
c	      getleaps = (/ 46828800,78364801,109900802,173059203,252028804, 
c     &	315187205,346723206,393984007,425520008,457056009,504489610,
c     &	551750411, 599184012, 820108813, 914803214, 1025136015 /)
			leaps(1) = 46828800
			leaps(2) = 78364801
			leaps(3) = 109900802
			leaps(4) = 173059203
			leaps(5) = 252028804
			leaps(6) = 315187205
			leaps(7) = 346723206
			leaps(8) = 393984007
			leaps(9) = 425520008
			leaps(10) = 457056009
			leaps(11) = 504489610
			leaps(12) = 551750411
			leaps(13) = 599184012
			leaps(14) = 820108813
			leaps(15) = 914803214
			leaps(16) = 1025136015
      return
   	end

c Test to see if a GPS second is a leap second
		subroutine isleap(gpsTime,risLeap)
			logical risLeap
			integer gpsTime
			integer leaps(16)
      	risLeap = .false.
      	call getleaps(leaps)
      	lenLeaps = size(leaps)
			i = 1
			do while (i <= lenLeaps)
         	if (gpsTime == leaps(i)) risLeap = .true.
         	i= i + 1
			end do      
      return
		end

c Count number of leap seconds that have passed
		subroutine countleaps(gpsTime,dirFlag, nleaps)
			integer nleaps,gpsTime,leaps(16),lenLeaps,i
			character*7 dirFlag
			call getleaps(leaps)
			lenLeaps = size(leaps)
			nleaps = 0  ! number of leap seconds prior to gpsTime
			i = 1
			do while (i <= lenLeaps)
				if (lge('utc2gps', dirFlag)) then 
				   if (gpsTime >= leaps(i) - i) nleaps = nleaps + 1				   
				 else if (lge('gps2utc', dirFlag)) then
				   if (gpsTime >= leaps(i)) nleaps = nleaps + 1
				 else 
				   print*, "ERROR: Invalid Flag!"				
				end if
				i = i + 1
			end do
			return
		end

c Convert UTC Time to GPS Time
c		subroutine unix2gps(unixTime,gpsTime){
c			 Add offset in seconds
c			if (fmod(unixTime, 1) != 0) {
c				unixTime = unixTime - 0.5;
c				isLeap = 1;
c			} else {
c				$isLeap = 0;
c			}
c			$gpsTime = $unixTime - 315964800;
c			$nleaps = countleaps($gpsTime, 'utc2gps');
c			$gpsTime = $gpsTime + $nleaps + $isLeap;
c			return
c		end

c	Convert GPS Time to UTC Time
		subroutine gps2utc(gpsTime,utcTime)
			integer gpsTime,nleaps,utcTime
c			 Add offset in seconds
		  utcTime = gpsTime + 315964800
		  call countleaps(gpsTime, 'gps2utc',nleaps)
		  utcTime = utcTime - nleaps
		  return
		end
