!!!
! gfortran -I obj/ ray_multifreq.f90
!
MODULE globalvars
  USE globalconsts
  IMPLICIT NONE
  INTEGER,PARAMETER :: pr = sp
  REAL(pr),PARAMETER :: pi = pi_s
  REAL(pr),PARAMETER :: d2r = pi/180.
  REAL(pr),ALLOCATABLE :: dnhex(:)
  REAL(pr) :: Emin(7)=(/0.125,0.25,0.5,1.,2.,4.,8./)
  REAL(pr),PARAMETER :: rho0 = 1.06,P0 = 862.0,Bb = 1.03
CONTAINS
END MODULE globalvars

PROGRAM ray_multifreq
  USE globalvars
  INTEGER :: utci,utcf
  INTEGER,PARAMETER :: nf = 400
  REAL(pr) :: freq,a,b,sumaN,rtilde,pha,prtilde,r99r
  
  open(unit=3,file='ray_multfrq_8_04-0816_Eraw.dat')

  utci = 1072915200
  utcf = 1472688000!1496275200

  DO i=1,nf     
     
     freq = 363.25 + i*4._pr/nf !366.25
     call rayleigh(utci,utcf,freq,a,b,sumaN)
     a = 2.*a/sumaN
     b = 2.*b/sumaN
     pha = atan(b/a)
     if(a.lt.0.)pha = pha+pi
     if(a.gt.0..and.b.lt.0.)pha = pha+2.*pi

     rtilde = sqrt(a**2+b**2)
     prtilde = exp(-sumaN*rtilde**2/4.)
     sigma = sqrt(2./sumaN)
     sgmra = sigma/rtilde
     r99r=sqrt(4.*log(100.)/sumaN)

     write(3,*)freq,a,b,sigma,rtilde,prtilde,pha/d2r,sgmra/d2r,r99r
  ENDDO
END PROGRAM ray_multifreq

!///////////////////////////////////////////////////////////////////
SUBROUTINE rayleigh(utci,utcf,freq,a,b,sumaN)
  USE globalvars
  IMPLICIT NONE
  INTEGER, INTENT(in) :: utci,utcf
  REAL(pr),INTENT(in) :: freq
  REAL(pr),INTENT(out) :: a,b,sumaN
  INTEGER :: bin,binid,nval,UTC,utc0,unt,gps,iscor,t5,nh,i,ie,nbin
  INTEGER :: iw,ftr,iutcref
  REAL(pr) :: Dec,Ra,Eraw,Ecor,Theta,Phi,p,r,rav,r99r
  REAL(pr) :: hrs,peso,arg,pha,rtilde,prtilde,sigma,sgmra
  REAL(pr) :: E,energy,phitilt,sec,x,aP,arho,brho,pow,E05,eff,En
  REAL(pr) :: AugId,S1000_obs,raz,fas,sin2
  REAL*8 :: rp,rm
  CHARACTER(30) :: dS1000_obs
  

  open(unit=2,file='Herald080noBP5n6t5a4_pnop_04-310816_UncorCorE.dat')
  
!  call calc_hex(utci,utcf,freq)
  
  phitilt = -30.*d2r
  utc0 = 1072915200
  iutcref = 1104537600   !1/1/2005 00:00:00
  nbin = 7
  binid = 0
  iscor = 1
  
  fas=freq/365.25
  
  !  DO bin=6,6!nbin
  bin = 7
     nval=0
     a = 0.
     b = 0.
     sumaN = 0.
     rewind(unit=2)
     
     ! skips header line
     read(2,*)

40   read (2,*,end=41)AugId,Dec,Ra,Eraw,Ecor,UTC,Theta,Phi,t5,ftr
     
     if(UTC.lt.utci.or.UTC.gt.utcf.or.Theta.gt.80)goto 40 !1496275200 

     energy = Eraw
     !if(iscor.eq.0)energy = Eraw

     binid = 0

     if(energy.ge.Emin(4).and.energy.lt.Emin(5))binid=4
     if(energy.ge.Emin(5).and.energy.lt.Emin(6))binid=5
     if(energy.ge.Emin(6).and.energy.lt.Emin(7))binid=6
     if(energy.ge.Emin(7))binid=7
          
     if (binid.eq.bin) then 

        !///// calculates the hour of the given frequency
        hrs=(float(UTC-utc0)/3600.0 + 31.4971*24/360)*fas
        nh=mod(int(hrs),24)+1

!        peso = 1./(dnhex(nh)*eff)
        peso = 1!./dnhex(nh)

        if(iscor.eq.0)peso = 1.
        nval = nval + 1
        sumaN = sumaN + peso

        !///////////// calculates the right ascension of zenith//////////////
        raz=float(UTC-iutcref)/239.345+31.4971
        raz=mod(raz,360.)
        if(raz.lt.0.0)raz=raz+360.

        arg = hrs/24.*2.*pi + (Ra-raz)*d2r 
        a = a + cos(arg)*peso
        b = b + sin(arg)*peso
     end if
     goto 40
41   continue
!  ENDDO
  close(unit=2)
END SUBROUTINE rayleigh
!////////////////////////////////////////////////////////////////////////////

SUBROUTINE calc_hex(utci,utcf,freq)
  USE globalvars  
  REAL(pr) :: xnhexhr(24),rnhexhr(24),mnhhr
  REAL(pr) :: nhexap(24),nhexarho(24),nhexbrho(24)
  INTEGER :: ihr,iutc,utci,utcf
  
  iutc0 = 1072915200
  xnhexhr = 0.
  rnhexhr = 0.
  mnhhr = 0.
  fas = freq/365.25

  if(.not.allocated(dnhex)) allocate(dnhex(24))
  
  open(unit=8,file='../Weather/utctprh_05032020.dat')
  
61 read (8,*,end=60)iutc,t,p,r,rav,xnhex,xnhex5,iw,ib

  if(iutc.lt.utci.or.iutc.gt.utcf)goto 61
  if(iw.lt.5.and.ib.eq.1) then
     !---- hexagons for the freq
     ihr = mod(int((dfloat(iutc-iutc0)/3600.+31.4971*24/360)*fas),24)+1
     xnhexhr(ihr)=xnhexhr(ihr)+(3*xnhex5-xnhex)*0.5          ! 6T5 + 5T5pos+

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
     dnhex(i)=rnhexhr(i)/mnhhr
!     write(6,*)dnhex(i)
  enddo
  close(8)
END SUBROUTINE calc_hex
