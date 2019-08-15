!! Genera archivo de hexágonos con entradas en cero cuando hay un \emph{bad period}.
c  reads hexagons every 5' from utchex5min and bad periods and set 
c   hexagons to zero in bad periods and writes in cleanhex5min
c		dimension iutcbadl(5000),iutcbadh(5000)
		integer iutcbadl(5000),iutcbadh(5000)
		common/cisbad/iutcbadl,iutcbadh,maxbad
		open(unit=3,file='BadPeriods.txt')
		open(unit=1,file='HexagonsMn_2004-2013-UTC.dat')
		open(unit=2,file='HexagonsMn_2004-2013-UTCnoBP.dat')

c  reads bad periods
	   i=1
 10	   read(3,*,end=11)iutcbadl(i),igps1,i1,i2,i3,i4,i5,i6,
     &   iutcbadh(i),igps2,j1,j2,j3,j4,j5,j6
	   i=i+1
	   goto 10
 11	   continue
	   maxbad=i-1

 20	   read(1,*,end=21)igps,iutc,xnhex,xnhex5
	   call isbad(iutc,igood)
	   if(igood.eq.0) then
	      	   write(2,*)igps,iutc,0,0
	    else
	          write(2,*)igps,iutc,xnhex,xnhex5
	   endif
		goto 20

 21	end

		subroutine isbad(iutc,igood)
c  assigns igood=0 to bad periods (=1 for good ones)
c        dimension iutcbadl(5000),iutcbadh(5000)
      integer iutcbadl(5000),iutcbadh(5000)
		common/cisbad/iutcbadl,iutcbadh,maxbad
		igood=1
		do i=1,maxbad
	   	if(iutc.lt.iutcbadl(i)) goto 10
	   	if(iutc.lt.iutcbadh(i)) then
c   if bad period.
	      	igood=0
	   	   goto 10
	   	endif
	 	enddo
 10	return 
		end
