!! Agrega columna al archivo de hexágonos que indica si está en un \emph{bad period} o no.
!!
		dimension iutcbadl(5000),iutcbadh(5000)
		common/cisbad/iutcbadl,iutcbadh,maxbad
c	implicit double precision(a-z)
		open(unit=1,file='HexagonsMn_2014.out')
		open(unit=2,file='HexagonsMn_2014BP.out')
	open(unit=4,file='../../datos_auger/BadPeriods_010104_311214.txt')

c  reads bad periods
	   i=0
 40	i=i+1
		read(4,*,end=41)iutcbadl(i),igps1,i1,i2,i3,i4,i5,i6,
     &   iutcbadh(i),igps2,j1,j2,j3,j4,j5,j6
	   goto 40
 41	continue
	   maxbad=i    !  number of bad periods

 90	read(1,*,end=11)gps,h6,h5,h4
		iutc = gps + 315964800 + 60
		call isbad(iutc,igood)
		write(2,*)gps,h6,h5,h4,igood
		goto 90

 11	end

		subroutine isbad(iutc,igood)
c  assigns igood=0 to bad periods (=1 for good ones)
		dimension iutcbadl(5000),iutcbadh(5000)
		common/cisbad/iutcbadl,iutcbadh,maxbad
		igood=1
		do i=1,maxbad
			if(iutc.lt.iutcbadl(i)) goto 50
			if(iutc.lt.iutcbadh(i)) then
c     if bad period.
				igood=0
				goto 50
			endif
		enddo
 50	return 
		end
