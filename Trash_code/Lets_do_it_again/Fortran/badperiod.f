c
      integer status1,status2,iutcb,iutce,iutci,iutcf,iutc
      open(unit=1,file='HeraldData060weathergt2004.dat')
      open(unit=2,file='BadPeriods.txt')
      open(unit=3,file='Bininbp.dat')
      
      do
         read (1,*,iostat=status1)iutc,y1,y2,y3,y4,y5
			if (status1.ne.0) exit ! Exit on end of data file
         iutcb = iutc - 1800
         iutce = iutc + 1800
         rewind(unit=2)
c         do
 20      read (2,*,end=10)iutci,x2,x3,x4,x5,x6,x7,x8,iutcf
c            if (status2.ne.0) exit
            if (iutce.ge.iutci.and.iutcb.lt.iutci) then
               write(3,*) iutc,y1,y2,y3,y4,y5,iutci,iutcf,iutcb,iutce
            elseif (iutce.gt.iutcf.and.iutcb.le.iutcf) then
               write(3,*) iutc,y1,y2,y3,y4,y5,iutci,iutcf,iutcb,iutce
            elseif (iutce.le.iutcf.and.iutcb.ge.iutci) then
               write(3,*) iutc,y1,y2,y3,y4,y5,iutci,iutcf,iutcb,iutce
            endif
            goto 20
c         end do
 10         continue
      end do

      end
