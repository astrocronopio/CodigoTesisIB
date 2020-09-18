!///////////////////////////////////////////////////////////////////////////////
!   Authors:     O. Taborda, S. Mollerach and E. Roulet
!   Institution: Centro Atómico Bariloche
!   Copyright:   It is for exclusive use inside the Pierre Auger Collaboration.
!                Distribution outside it is not allowed.
!///////////////////////////////////////////////////////////////////////////////
!!Calculates mean number of hexgons in sidereal, solar y anti-sidereal frequency.
!!
!!  compile: gfortran -c dnhex.f90
!!

MODULE dnhex
  IMPLICIT NONE
  INTEGER,PARAMETER,PRIVATE :: pr=kind(0.d0) !parametro que especifica la precisión deseada
  REAL(pr),PARAMETER,PRIVATE :: pi=4.0_pr*atan(1.0_pr)
CONTAINS

!//////////////////////////////////////////////////////////////////////////
! number of hexagons as a function of the zenith's right ascension 1 deg bins
!//////////////////////////////////////////////////////////////////////////
SUBROUTINE sidhex(utci,utcf,t5flag,infile,xnhexra)
  REAL(pr) ::  xnhexra(1:360),mnhra,raz
  REAL(pr) ::  t,p,r,rav,xnhex,xnhex5
  INTEGER :: ira,iutc,utci,utcf,t5flag,iw,ib,i,iutcref
  CHARACTER(*) :: infile
  
  iutcref=1104537600        !1/1/2005
  xnhexra=0.
  mnhra = 0.
  
  open(unit=10,file='dnhex.dat')
  open(unit=8,action='READ',file=infile)
  
51 read (8,*,end=50)iutc,t,p,r,rav,xnhex,xnhex5,iw,ib
  if(iutc.lt.utci.or.iutc.gt.utcf)goto 51 
  if(ib.eq.1.and.iw.lt.5) then
     raz = float(iutc-iutcref)/239.345_pr+31.4971_pr
     raz = mod(raz,360._pr)
     if(raz.lt.0.0_pr)raz=raz+360._pr
     ira = int(raz)+1
     
     if(t5flag.eq.1) then
        xnhexra(ira) = xnhexra(ira)+xnhex               ! only 6T5
     elseif(t5flag.eq.2) then
        xnhexra(ira)=xnhexra(ira)+xnhex5                ! 6T5 + 5T5pos
     elseif(t5flag.eq.3) then
        xnhexra(ira)=xnhexra(ira)+(3*xnhex5-xnhex)*0.5  ! 6T5 + 5T5pos+
     else
        xnhexra(ira)=xnhexra(ira)+(xnhex5-xnhex)*3./2   ! only 5T5pos
     endif
  endif
  goto 51
50 continue
  ! mean value
  mnhra = sum(xnhexra)/360.
  ! normalize to values around the mean value
  xnhexra = xnhexra/mnhra
  do i=1,360
     write(10,*)xnhexra(i)
  enddo
  close(8)
  close(10)
END SUBROUTINE sidhex
!//////////////////////////////////////////////////////////////////////////
! number of hexagons in solar time in 1 hr bins
!//////////////////////////////////////////////////////////////////////////
SUBROUTINE solarhex(utci,utcf,t5flag,infile,rnhexhr)
  REAL(pr) :: xnhexhr(24),rnhexhr(24),mnhhr
  REAL(pr) ::  t,p,r,rav,xnhex,xnhex5
  INTEGER :: utci,utcf,t5flag,i,iw,ib,iutc,iutc0,ihr
  CHARACTER(*) :: infile
  iutc0=1072915200
  xnhexhr=0.
  rnhexhr=0.
  mnhhr = 0.

  open(unit=10,file='dnhex.dat')
  open(unit=8,action='READ',file=infile)
    
61 read (8,*,end=60)iutc,t,p,r,rav,xnhex,xnhex5,iw,ib
  if(iutc.lt.utci.or.iutc.gt.utcf)goto 61 
  if(iw.lt.5.and.ib.eq.1) then
     !---- hexagons for solar freq
     ihr=mod(int(dfloat(iutc-iutc0)/3600.+21.),24)+1

     if(t5flag.eq.1) then
        xnhexhr(ihr)=xnhexhr(ihr)+xnhex                ! only 6T5
     elseif(t5flag.eq.2) then
        xnhexhr(ihr)=xnhexhr(ihr)+xnhex5               ! 6T5 + 5T5pos
     elseif(t5flag.eq.3) then
        xnhexhr(ihr)=xnhexhr(ihr)+(3*xnhex5-xnhex)*0.5  ! 6T5 + 5T5pos+
     else
        xnhexhr(ihr)=xnhexhr(ihr)+(xnhex5-xnhex)*3./2  ! only 5T5pos
     endif
     if(xnhexhr(ihr).gt.1.d6) then
        rnhexhr(ihr)=rnhexhr(ihr)+xnhexhr(ihr)/1.d6
        xnhexhr(ihr)=0.d0
     endif
  endif
  goto 61
60 continue
  do i=1,24
     rnhexhr(i)=rnhexhr(i)+xnhexhr(i)/1.d6
     mnhhr = mnhhr + rnhexhr(i)/24.
  enddo
  do i=1,24
     rnhexhr(i)=rnhexhr(i)/mnhhr
     write(10,*)rnhexhr(i)
  enddo
  close(8)
  close(10)
END SUBROUTINE solarhex
!//////////////////////////////////////////////////////////////////////////
! number of hexagons in anti-sidereal time in 1 hr bins
!//////////////////////////////////////////////////////////////////////////
SUBROUTINE antisidhex(utci,utcf,t5flag,infile,rnhexhr)
  REAL(pr) :: xnhexhr(24),rnhexhr(24),mnhhr
  REAL(pr) ::  t,p,r,rav,xnhex,xnhex5,fas
  INTEGER :: ihr,iutc,utci,utcf,t5flag,i,iw,ib,iutc0
  CHARACTER(*) :: infile
  iutc0 = 1072915200
  xnhexhr = 0.
  rnhexhr = 0.
  mnhhr = 0.
  fas = 364.25/365.25         !  antisid/solar
  
  open(unit=10,file='dnhex.dat')
  open(unit=8,action='READ',file=infile)

61 read (8,*,end=60)iutc,t,p,r,rav,xnhex,xnhex5,iw,ib
  if(iutc.lt.utci.or.iutc.gt.utcf)goto 61
  if(iw.lt.5.and.ib.eq.1) then
     !---- hexagons for antisidereal freq
     ihr = mod(int((dfloat(iutc-iutc0)/3600.+21.)*fas),24)+1

          if(t5flag.eq.1) then
             xnhexhr(ihr) = xnhexhr(ihr)+xnhex                ! only 6T5
          elseif(t5flag.eq.2) then
             xnhexhr(ihr)=xnhexhr(ihr)+xnhex5               ! 6T5 + 5T5pos
          elseif(t5flag.eq.3) then
             xnhexhr(ihr)=xnhexhr(ihr)+(3*xnhex5-xnhex)*0.5  ! 6T5 + 5T5pos+
          else
             xnhexhr(ihr)=xnhexhr(ihr)+(xnhex5-xnhex)*3./2  ! only 5T5pos
          endif
     if(xnhexhr(ihr).gt.1.d6) then
        rnhexhr(ihr) = rnhexhr(ihr)+xnhexhr(ihr)/1.d6
        xnhexhr(ihr) = 0.d0
     endif
  endif
  goto 61
60 continue
  do i=1,24
     rnhexhr(i)=rnhexhr(i)+xnhexhr(i)/1.d6
     mnhhr = mnhhr + rnhexhr(i)/24.
  enddo
  do i=1,24
     rnhexhr(i)=rnhexhr(i)/mnhhr
     write(10,*)rnhexhr(i)
  enddo
  close(8)
  close(10)
END SUBROUTINE antisidhex

END MODULE dnhex
