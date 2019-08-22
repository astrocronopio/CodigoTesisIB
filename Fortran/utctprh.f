!! Genera archivo \emph{utctprh.dat}
!!
!!  reads hexagons every five minutes (utchex5min) and weather data from
!!   weather.dat (CLF filled with LL). It is interpolated 
!!  for less than 2 hs (iw=1), and for bigger holes replaces rho data by 
!!  the one 24 hs before, and P is interpolated (iw=4). 
!!  Average rho is for previous 24 hs. (288 is 24*12= \#5' in 1 day)
!! include bad period flag at the end 
	dimension iutcbadl(5000),iutcbadh(5000),rho(288),ti(288)
	common/cisbad/iutcbadl,iutcbadh,maxbad
c	implicit double precision(a-z)
      open(unit=1,file='weather.dat')
      open(unit=2,file='utchex5min')
      open(unit=3,file='utctprh2.dat')
	open(unit=4,file='BadPeriods.txt')

c  reads bad periods
	   i=0
 40	   i=i+1
	  read(4,*,end=41)iutcbadl(i),igps1,i1,i2,i3,i4,i5,i6,
     &   iutcbadh(i),igps2,j1,j2,j3,j4,j5,j6
	   goto 40
 41	   continue
	   maxbad=i    !  number of bad periods

 90	format(i10,1x,6(e11.5,1x),2(i1,1x))

c  first hexagon line
	read(2,*)iutch,xnhex,xnhex5
c   read weather info until matching begining of available hexagon info
 30	read(1,*)iutc,ti(1),x1,x2,x3,x4,x5,p,iw 
	if(iutc.lt.iutch) goto 30

c  reads first day
	   do i=1,288
	      if(i.gt.1) then
      read(1,*)iutc,ti(i),x1,x2,x3,x4,x5,p,iw
      read(2,*)iutch,xnhex,xnhex5
	endif
	rho(i)=0.348*p/(ti(i)+273.)  !  to save last 24 hs of data
 	call isbad(iutc,igood)
	   rhoav=rho(i)
      write(3,90)iutc,ti(i),p,rho(i),rhoav,xnhex,xnhex5,iw,igood
	enddo

c	calculate rhoav for the first day
		rhoav = 0.
		do k=1,288
			rhoav=rhoav+rho(k)
		enddo
		rhoav = rhoav/288.

c  reads days after first
	nhdatflag=1   !  becomes 0 when hexagon info finishes
	i=1
 10   read(1,*,end=11)iutc,t,x1,x2,x3,x4,x5,p,iw
      if(nhdatflag.eq.1) read(2,*,end=15)iutch,xnhex,xnhex5
c  check that both utc are within 5' (hexagons and weather)
      if(nhdatflag.eq.1.and.abs(iutc-iutch).gt.300)then
	 write(6,*)'ojo',iutc,iutch
	 stop
	 endif
	goto 14
c set nhdatflag=0 when hexagon info finishes
 15	nhdatflag=0
	xnhex=0.
	xnhex5=0.
 14	call isbad(iutc,igood)
	   if(iw.lt.3)then
	rhoi=0.348*p/(t+273.)
	else
c  if no weather info for more than 2 hs, writes previous day data
	   rhoi=rho(i)
	   t=ti(i)
	endif
	   rhoav=rhoav+(rhoi-rho(i))/288.
c values 24 hs before
	   rho(i)=rhoi
	   ti(i)=t
      write(3,90)iutc,t,p,rhoi,rhoav,xnhex,xnhex5,iw,igood
	i=i+1
	if(i.eq.289) i=1
      goto 10
 11	end


	subroutine isbad(iutc,igood)
c  assigns igood=0 to bad periods (=1 for good ones)
        dimension iutcbadl(5000),iutcbadh(5000)
	common/cisbad/iutcbadl,iutcbadh,maxbad
	igood=1
	do i=1,maxbad
	   if(iutc.lt.iutcbadl(i)) goto 50
	   if(iutc.lt.iutcbadh(i)) then
c   if bad period.
	      igood=0
	      goto 50
	   endif
	 enddo
 50	return 
	  end
