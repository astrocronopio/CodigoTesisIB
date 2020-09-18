!///////////////////////////////////////////////////////////////////////////////
!   Authors:     O. Taborda, S. Mollerach and E. Roulet
!   Institution: Centro Atómico Bariloche
!   Copyright:   It is for exclusive use inside the Pierre Auger Collaboration.
!                Distribution outside it is not allowed.
!///////////////////////////////////////////////////////////////////////////////
!!! Calculate dipole and quadrupole components for the 1500m array using Rayleigh 
!!! analysis. Works in simple and double precision just changing
!!! the variable 'pr' in the module globalvars
!
! 	compile with:	
!        gfortran dip-quad_rayleigh.f90 dipcl.o dnhex.o
!///////////////////////////////////////////////////////////////////////////////
!     variables globales a usar en el programa 
MODULE globalvars
  IMPLICIT NONE
  INTEGER,PARAMETER :: pr = kind(0.e0) ! desired precision
  REAL(pr),PARAMETER :: pi = 4.0_pr*atan(1.0_pr) 
  REAL(pr),PARAMETER :: d2r = pi/180.
  REAL(pr),PARAMETER :: rho0 = 1.06,P0 = 862.0,Bb = 1.03
  REAL(pr),PARAMETER :: bw = 1.
  REAL*8,ALLOCATABLE :: dnhexra(:)
  REAL(pr) :: Emin(4)=(/4.,8.,16.,32./)
  CHARACTER(200) :: datafile,hexfile

CONTAINS
END MODULE globalvars
      
PROGRAM dipquad_rayleigh
  USE globalvars
  INTEGER size,utci,utcf,bine,is5t5,meth,freq
  REAL(pr) :: zmax,zmin
  CHARACTER(10) :: itime,ftime
  CHARACTER(2) :: idd,fdd,imm,fmm
  CHARACTER(4) :: iyy,fyy
  CHARACTER(80) :: command

  INTERFACE
     SUBROUTINE dipoleSolar(iscor,freq,utci_opt,utcf,zmin_opt,zmax,is5t5_opt,bine)
       USE globalvars
       USE dnhex
       INTEGER :: iscor,freq,utcf,bine
       REAL(pr) :: zmax
       INTEGER(pr),OPTIONAL :: utci_opt,is5t5_opt
       REAL(pr),OPTIONAL :: zmin_opt
     END SUBROUTINE dipoleSolar

     SUBROUTINE dipoleRA(iscor,utci_opt,utcf,zmin_opt,zmax,is5t5_opt,bine,outfmt)
       USE globalvars
       USE dipcl
       INTEGER :: iscor,utcf,bine,outfmt
       REAL(pr) :: zmax
       INTEGER(pr),OPTIONAL :: utci_opt,is5t5_opt
       REAL(pr),OPTIONAL :: zmin_opt
     END SUBROUTINE dipoleRA

     SUBROUTINE dipolepquadRA(utci_opt,utcf,zmin_opt,zmax,is5t5_opt,bine,outfmt)
       USE globalvars
       INTEGER :: utcf,bine,outfmt
       REAL(pr) :: zmax
       INTEGER(pr),OPTIONAL :: utci_opt,is5t5_opt
       REAL(pr),OPTIONAL :: zmin_opt
     END SUBROUTINE dipolepquadRA

     SUBROUTINE dipoleEW(ifrec,utci_opt,utcf,zmin_opt,zmax,is5t5_opt,bine)
       USE globalvars
       USE dipcl
       INTEGER :: iscor,utcf,bine
       REAL(pr) :: zmax
       INTEGER(pr),OPTIONAL :: utci_opt,is5t5_opt
       REAL(pr),OPTIONAL :: zmin_opt
     END SUBROUTINE dipoleEW
  END INTERFACE

  num_args = command_argument_count() ! get the number of args passed
  if(num_args.ne.2)stop "USAGE: ./a.out data_file utctprh_file"
  call get_command_argument(1,datafile)
  call get_command_argument(2,hexfile)

1  write(6,*)'Sidereal: 1  Solar: 2  Antisidereal: 3 ?'
  read(5,*)freq
  if(freq.ne.1.and.freq.ne.2.and.freq.ne.3) then
     write(6,*)"******The only options are 1 2 or 3********"
     goto 1
  endif

  if(freq.eq.1) then
2     write(6,*)'Dipole: 1  Dipole+quadrupole: 2  East-West: 3 ?'
     read(5,*)meth
     if(meth.ne.1.and.meth.ne.2.and.meth.ne.3) then
        write(6,*)"******The only options are 1 2 or 3********"
        goto 2
     endif
  else
     meth = 4
  endif
     
3  write(6,*)'6T5: 0  6+5T5pos+: 1 ?'
  read(5,*)is5t5
  if(is5t5.ne.0.and.is5t5.ne.1)then
     write(6,*)"*****The only options are 0 or 1*****"
     goto 3
  endif
  

4  write(6,*)'N bins: 2 or 4 ?'
  read(5,*)bine
  if(bine.ne.2.and.bine.ne.4)then
     write(6,*)"*****The only options are 2 or 4*****"
     goto 4
  endif

5  write(6,*)'minimum zenith (zmin) angle'
  read(5,*)zmin
  if(zmin.lt.0)then
     write(6,*)"*****minimum zentih is 0*****"
     goto 5
  endif

6  write(6,*)'maximum zenith (zmax) angle'
  read(5,*)zmax
  if(zmax.gt.80.or.zmax.lt.zmin)then
     write(6,*)"*****zmax must be in the range [zmin,80]*****"
     goto 6
  endif
  
  write(6,*)'First day included [mm,dd,yyyy]'
  read(5,*)imm,idd,iyy
  itime = trim(imm) //"/"// trim(idd)//'/' // trim(iyy)
  
  write(6,*)'Last day included [mm,dd,yyyy]'
  read(5,*)fmm,fdd,fyy
  ftime = trim(fmm) //"/"// trim(fdd)//'/' // trim(fyy)

  command = "date -u +%s --date='"//trim(itime)//"' > tmpdummy.xx"
  call system(command)
  command = "date -u +%s --date='"//trim(ftime)//"' >> tmpdummy.xx"
  call system(command)
  open(unit=9,action='READ',file='tmpdummy.xx')
  read(9,*)utci
  read(9,*)utcf
  close(unit=9)
  call system("rm tmpdummy.xx")

  freq = freq-2 ! 0 Solar, 1 Antisid

  open(unit=2,file=datafile)

  select case (meth)
  case (1)
     call dipoleRA(iscor=1,utci_opt=utci,utcf=utcf,zmin_opt=zmin,zmax=zmax,is5t5_opt=is5t5,bine=bine,outfmt=1)  ! if arg = 0 raw energy | corrected energy otherwise
  case (2)
     call dipolepquadRA(utcf=utcf,zmin_opt=zmin,zmax=zmax,is5t5_opt=is5t5,bine=bine,outfmt=1)
  case (3)
     call dipoleEW(ifrec=0,utci_opt=utci,utcf=utcf,zmax=zmax,is5t5_opt=is5t5,bine=bine)  ! if arg = 0 sidereal freq | solar freq otherwise
  case (4)
     call dipoleSolar(iscor=1,freq=freq,utci_opt=utci,utcf=utcf,zmax=zmax,is5t5_opt=is5t5,bine=bine) ! if arg1 = 0 raw energy | corrected energy otherwise
  end select
  
END PROGRAM dipquad_rayleigh

!//////////////////////////////////////////////////////////////////////////////////////
! calculates the dipole components using rayleigh analysis
  SUBROUTINE dipoleRA(iscor,utci_opt,utcf,zmin_opt,zmax,is5t5_opt,bine,outfmt)
    USE globalvars
    USE dipcl
    USE dnhex
    IMPLICIT NONE
    INTEGER :: iscor,utcf,bine,outfmt
    REAL(pr) :: zmax
    INTEGER(pr),OPTIONAL :: utci_opt,is5t5_opt
    REAL(pr),OPTIONAL :: zmin_opt
    REAL(pr),DIMENSION(4) :: a,b,aphi,bphi
    REAL(pr) :: avg(10)
    REAL(pr) :: rtilde,dper,dz,decd,rd,rtilde2,prtilde,prtilde2,rad,rad2
    REAL(pr) :: sgmdper,sgmdz,promdec,promzen,zmin
    REAL(pr) :: r99,sgmrd,sgmra,sgmdec,sumaN,c,d,E,atan02pi
    REAL*8 :: rp,rm,drp,drm,ddecp,ddecm
    INTEGER :: nbin,iunit,i,nval,size,utci,is5t5

    utci = 0
    zmin = 0._pr
    is5t5 = 0

    if(present(utci_opt))utci = utci_opt
    if(present(zmin_opt))zmin = zmin_opt
    if(present(is5t5_opt))is5t5 = is5t5_opt

    
!    hexfile = '../datos_auger/utctprhdrc_010104_070518.dat'
    size = int(360.1/bw)
    allocate(dnhexra(size))
    
    if(is5t5.eq.0) then
       call sidhex(utci,utcf,1,trim(hexfile),dnhexra)
    else
       call sidhex(utci,utcf,3,trim(hexfile),dnhexra)
    endif
 
    do i=1,bine
! Estimate dipole amplitude, Ra and dec using Rayleigh analysis
       call rayleighcoeffs(i,a,b,aphi,bphi,nval,sumaN,iscor,utci,utcf,zmin,zmax,is5t5,bine)
       call funcavgs(i,avg,iscor,utci,utcf,zmin,zmax,is5t5,bine)
                     
       promdec = avg(1)
       promzen = avg(5)
       rad = atan02pi(a(1),b(1))
       rad2 = atan02pi(a(2),b(2))
       rad2 = 0.5*rad2
       rtilde = sqrt(a(1)**2+b(1)**2)
       rtilde2 = sqrt(a(2)**2+b(2)**2)
       prtilde = exp(-sumaN*rtilde**2/4)
       prtilde2 = exp(-sumaN*rtilde2**2/4)
       dper = rtilde/promdec
       dz = bphi(1)/cos(-35.2*d2r)/promzen
       decd = atan(dz/dper)
       rd = sqrt(dz**2+dper**2)
       r99 = sqrt(4.*log(100.)/sumaN)
       
   ! Error propagation
       sgmrd = sqrt(2./sumaN)*1./rd*sqrt(dper**2/promdec**2+dz**2&
            /cos(-35.2*d2r)**2/promzen**2)
       
       sgmra = sqrt(2./sumaN)/rtilde
       
       sgmdec = sqrt(2./sumaN)/rd**2*sqrt(dz**2/promdec**2+dper**2&
            /cos(-35.2*d2r)**2/promzen**2)

       sgmdz = sqrt(2./sumaN)/cos(-35.2*d2r)/promzen
       sgmdper = sqrt(2./sumaN)/promdec
       
! Asymmetric error estimates for the amp of the first harmonic, the total dipole
! amplitude and the declination
       call ampcl(dble(rtilde),sqrt(2.d0/sumaN),rp,rm)
       call amptotcl(dble(dper),dble(dz),dble(sgmdper),dble(sgmdz),drp,drm)
       call deccl(dble(rd),dble(decd)/d2r,dble(sgmdper),dble(sgmdz),ddecp,ddecm)
       
       select case (i)
       case (1)
          E=(Emin(1)+Emin(2))/2
       case (2)
          E=(Emin(2)+Emin(3))/2
       case (3)
          E=(Emin(3)+Emin(4))/2
       case (4)
          E=(Emin(4)+2*Emin(4))/2
       end select

       if(outfmt.eq.1) then
          iunit = 6
          write(iunit,*)"------------------------------------------"

          if(i.lt.4) then
             write(iunit,'(a,F4.1,a,F4.1,a)')' E      = [',Emin(i),'-',Emin(i+1),']'
          else
             write(iunit,'(a,F4.1)')' E      > ',Emin(i)
          endif
          write(iunit,*)'N      =',nval!,sumaN
          write(iunit,*)'a1     =',a(1)
          write(iunit,*)'b1     =',b(1)
          write(iunit,*)'sgm    =',sqrt(2./sumaN)
          write(iunit,*)'r1     =',real(rtilde),'+',real(rp),'-',real(rm)
          write(iunit,*)'p(>r1) =',prtilde
          write(iunit,*)'r99    =',r99
          write(iunit,*)'aphi1  =',aphi(1)
          write(iunit,*)'bphi1  =',bphi(1)
          write(iunit,*)'Dz     =',real(dz),'+/-',real(sgmdz)
          write(iunit,*)'Dper   =',real(dper),'+',real(rp)/promdec,'-',real(rm)/promdec
          write(iunit,*)'D      =',real(rd),'+',real(drp),'-',real(drm)
          write(iunit,*)'dec    =',real(decd)/d2r,'+',real(ddecp),'-',real(ddecm)
          write(iunit,*)'ra     =',rad/d2r,'+/-',sgmra/d2r
       else       
          write(6,*)E,utci,utcf,rtilde,sqrt(2./sumaN),rad/d2r,sgmra/d2r,nval,r99,prtilde
       endif       
    enddo
    return
  END SUBROUTINE dipoleRA
!===========================================================================
!     calculates the dipole and quadrupole components using rayleigh analysis
  SUBROUTINE dipolepquadRA(utci_opt,utcf,zmin_opt,zmax,is5t5_opt,bine,outfmt)
    USE globalvars
    USE dnhex
    INTEGER :: utcf,bine,outfmt
    REAL(pr) :: zmax
    INTEGER(pr),OPTIONAL :: utci_opt,is5t5_opt
    REAL(pr),OPTIONAL :: zmin_opt
    REAL(pr) :: a(4),b(4),aphi(4),bphi(4),avg(10)
    REAL(pr) :: aNS(2),bNS(2),avgNS(4),sumaNNS(2)
    REAL(pr) :: dper,dz,decd,rd,phiN,phiS,rN,rS,prN,prS,c,d,sumaN,atan02pi
    REAL(pr) :: K,P,zmin
    REAL(pr) :: Qxx,Qyy,Qzz,Qxy,Qxz,Qyz
    INTEGER :: nvalNS(2),size,utci,iseff,is5t5

    utci = 0
    zmin = 0._pr
    is5t5 = 0
    if(present(utci_opt))utci = utci_opt
    if(present(zmin_opt))zmin = zmin_opt
    if(present(is5t5_opt))is5t5 = is5t5_opt

    size = int(360.1/bw)
    allocate(dnhexra(size))
    if(is5t5.eq.0) then
       call sidhex(utci,utcf,1,trim(hexfile),dnhexra)
    else
       call sidhex(utci,utcf,3,trim(hexfile),dnhexra)
    endif
   
    d0 = -35.2*d2r
    
    do i=1,bine
       ! Calculates 1st and 2nd harmonics and relevant averages
       call rayleighcoeffs(i,a,b,aphi,bphi,nval,sumaN,1,utci,utcf,zmin,zmax,is5t5,bine)
       call funcavgs(i,avg,1,utci,utcf,zmin,zmax,is5t5,bine)
       call rayleighcoeffsNS(i,aNS,bNS,nvalNS,sumaNNS,utci,utcf,zmin,zmax,is5t5,bine)
       call funcavgsNS(i,avgNS,utci,utcf,zmin,zmax,is5t5,bine)

       ! Amplitudes for 1st and 2nd harmonics and P(>r)
       rtilde = sqrt(a(1)**2+b(1)**2)
       rtilde2 = sqrt(a(2)**2+b(2)**2)
       prtilde = exp(-sumaN*rtilde**2/4)
       prtilde2 = exp(-sumaN*rtilde2**2/4)

       a1=1/cos(d0)/avg(5)*(bphi(1)+4*aphi(2)*tan(d0)*avg(6)/avg(7))
       a2=sin(d0)*avg(8)
       a3=1./8.*(3*avg(7)-2)*(1-3*sin(d0)**2)
       a4=-8./3.*aphi(2)/cos(d0)**2/avg(7)

       dz=a1/(1-a1*a2-a3*a4)
       Qzz=a4/(1-a1*a2-a3*a4)

       K=1.!+dz*avg(9)+0.25*(2-3*avg(4))*Qzz
       P=1./(avgNS(3)*avgNS(2)-avgNS(1)*avgNS(4))

       dx=(aNS(2)*avgNS(2)-aNS(1)*avgNS(4))*P
       dy=(bNS(2)*avgNS(2)-bNS(1)*avgNS(4))*P
       Qxz=-(aNS(2)*avgNS(1)-aNS(1)*avgNS(3))*P
       Qyz=-(bNS(2)*avgNS(1)-bNS(1)*avgNS(3))*P

       Qxx=0.5*(4*a(2)*K/avg(4)-Qzz)
       Qyy=-(Qxx+Qzz)
       Qxy=2*b(2)*K/avg(4)


       phiN = atan02pi(aNS(1),bNS(1))
       phiS = atan02pi(aNS(2),bNS(2))
       rN = sqrt(aNS(1)**2+bNS(1)**2)
       rS = sqrt(aNS(2)**2+bNS(2)**2)
       prN = exp(-sumaNNS(1)*rN**2/4)
       prS = exp(-sumaNNS(2)*rS**2/4)
       rad = atan(dy/dx)
       dper = sqrt(dx**2+dz**2)
       decd = atan(dz/dper)
       rd = sqrt(dz**2+dper**2)

       !		error estimates

       vardz=(1./(cos(d0)*avg(5)))**2*(1+(4*tan(d0)*avg(6)/avg(7))**2)*2./sumaN
       sgmdz = sqrt(vardz)

       varQzz=((Qzz**2*a2/(cos(d0)*avg(5)*a4))**2+(4./(3*cos(d0)**2&
            *avg(7)*a4)*(3*sin(d0)*avg(6)*a2*Qzz**2/avg(5)-8*a3*Qzz**2&
            -2*Qzz))**2)*2./sumaN
       sgmQzz = sqrt(varQzz)

       varQxx=8*K**2/avg(4)**2/sumaN + 0.25*((2.-3*avg(4))&
            *a(2)/avg(4)-1)**2*varQzz+4*a(2)**2*avg(9)**2*vardz/avg(4)**2
       sgmQxx = sqrt(varQxx)

       varQxy=8*K**2/avg(4)**2/sumaN !+ 4*b(2)**2*avg(9)**2*vardz&
       !            /avg(4)**2+0.25*b(2)**2*(2.-3*avg(4))**2*varQzz/avg(4)**2
       sgmQxy = sqrt(varQxy)
       
       vardx=P**2*(avgNS(2)**2/sumaNNS(2)+avgNS(4)**2/sumaNNS(1))*2.
       sgmdx = sqrt(vardx)

       varQxz=P**2*(avgNS(1)**2/sumaNNS(2)+avgNS(3)**2/sumaNNS(1))*2.
       sgmQxz = sqrt(varQxz)

       ! covariance dx-Qxz and dz-Qzz
       covdxQxz = -P*P*2.*(avgNS(3)*avgNS(4)/sumaNNS(1)+avgNS(1)*avgNS(2)/sumaNNS(2))
       covdzQzz = -32./3*tan(d0)*avg(6)/(avg(5)*(avg(7))**2*(cos(d0))**3)*2./sumaN
       ! correlation coeff
       corrdxQxz = covdxQxz/sgmdx/sgmQxz
       corrdzQzz = covdzQzz/sgmdz/sgmQzz


       select case (i)
       case (1)
          E=(Emin(1)+Emin(2))/2
       case (2)
          E=(Emin(2)+Emin(3))/2
       case (3)
          E=(Emin(3)+Emin(4))/2
       case (4)
          E=(Emin(4)+2*Emin(4))/2
       end select

       iunit = 6
       if(outfmt.eq.0) then
          write(iunit,*)E,dx,sgmdx,dy,sgmdx,dz,sgmdz,Qxx,sgmQxx,Qyy,sgmQxx,Qzz,sgmQzz,Qxy,sgmQxy&
               ,Qxz,sgmQxz,Qyz,sgmQxz
       else
!!$       iunit = 6
          write(iunit,*)"------------------------------------------"
          if(i.lt.4) then
             write(iunit,'(a,F4.1,a,F4.1,a)')' E      = [',Emin(i),' -',Emin(i+1),']'
          else
             write(iunit,'(a,F4.1)')' E      > ',Emin(i)
          endif
          write(iunit,*)"====== Rayleigh coefficients ============="
          write(iunit,*)'N      =',nval
          write(iunit,*)'a1     =',a(1)
          write(iunit,*)'b1     =',b(1)
          write(iunit,*)'a2     =',a(2)
          write(iunit,*)'b2     =',b(2)
          write(iunit,*)'sgm    =',sqrt(2./sumaN)
          write(iunit,*)'p(>r1) =',prtilde
          write(iunit,*)'p(>r2) =',prtilde2
          write(iunit,*)'aphi1  =',aphi(1)
          write(iunit,*)'bphi1  =',bphi(1)
          write(iunit,*)'aphi2  =',aphi(2)
          write(iunit,*)'bphi2  =',bphi(2)
          write(iunit,*)'N_N    =',nvalNS(1)
          write(iunit,*)'a1_N   =',aNS(1)
          write(iunit,*)'b1_N   =',bNS(1)
          write(iunit,*)'sgm_N  =',sqrt(2./sumaNNS(1))
          write(iunit,*)'N_S    =',nvalNS(2)
          write(iunit,*)'a1_S   =',aNS(2)
          write(iunit,*)'b1_S   =',bNS(2)
          write(iunit,*)'sgm_S  =',sqrt(2./sumaNNS(2))
          write(iunit,*)"====== Dipole and quadrupole ============="
          write(iunit,*)'Dx     =',real(dx),'+/-',real(sgmdx)
          write(iunit,*)'Dy     =',real(dy),'+/-',real(sgmdx)
          write(iunit,*)'Dz     =',real(dz),'+/-',real(sgmdz)
          write(iunit,*)'Qxx    =',real(Qxx),'+/-',real(sgmQxx)
          write(iunit,*)'Qyy    =',real(Qyy),'+/-',real(sgmQxx)
          write(iunit,*)'Qzz    =',real(Qzz),'+/-',real(sgmQzz)
          write(iunit,*)'Qxy    =',real(Qxy),'+/-',real(sgmQxy)
          write(iunit,*)'Qxz    =',real(Qxz),'+/-',real(sgmQxz)
          write(iunit,*)'Qyz    =',real(Qyz),'+/-',real(sgmQxz)
          write(iunit,*)'Corr_dxQxz   =',corrdxQxz
          write(iunit,*)'Corr_dzQzz   =',corrdzQzz
       endif
    enddo
    return
  END SUBROUTINE dipolepquadRA
!------------------------------------------------------------------------------
! calculates the dipole components using East-West method
  SUBROUTINE dipoleEW(ifrec,utci_opt,utcf,zmin_opt,zmax,is5t5_opt,bine)
    USE globalvars
    USE dipcl
    INTEGER :: iscor,utcf,bine
    REAL(pr) :: zmax
    INTEGER(pr),OPTIONAL :: utci_opt,is5t5_opt
    REAL(pr),OPTIONAL :: zmin_opt
    REAL(pr) :: aew,bew,avg(10),promsint,promcosd
    REAL(pr) :: rad,rtilde,dper,dz,decd,rd,atan02pi,zmin
    REAL*8 :: rp,rm
    INTEGER :: ifrec,utci,is5t5
    ! //// optional arguments
    utci = 0
    zmin = 0._pr
    is5t5 = 0
    if(present(utci_opt))utci = utci_opt
    if(present(zmin_opt))zmin = zmin_opt
    if(present(is5t5_opt))is5t5 = is5t5_opt
    
    do i=1,bine
       ! Estimate dipole amplitude and phase using East-West method
       call East_West(i,aew,bew,promsint,promcosd,nval,ifrec,utci,utcf,zmin,zmax,is5t5,bine)
       rtilde = sqrt(aew**2 + bew**2)
       rad = atan02pi(aew,bew) + 0.5*pi
       if(rad.gt.2.*pi) rad = rad - 2.*pi
       dper = 0.5*pi*rtilde/promsint
       prtilde=exp(-rtilde**2*nval/4.)
       
       !////////////// error estimates
       sigray = sqrt(2./nval)
       if(sigray.le.rtilde) sgmrad2=asin(sigray/rtilde)
       if(sigray.gt.rtilde) sgmrad2=pi
       sgmrad = sigray/rtilde
       sgmdper = sigray*0.5*pi/promsint
       rray = rtilde*pi*promcosd/(2*promsint)
       sigma = sigray*pi*promcosd/(2*promsint)
       r99 = sqrt(4.*log(100.)/nval)*pi*promcosd/(2*promsint)

       !asymmetric errors 
       call ampcl(dble(rray),dble(sigma),rp,rm)
       
       select case (i)
       case (1)
          E=(Emin(1)+Emin(2))/2
       case (2)
          E=(Emin(2)+Emin(3))/2
       case (3)
          E=(Emin(3)+Emin(4))/2
       case (4)
          E=(Emin(4)+2*Emin(4))/2
       end select
       write(6,*)E,rray,sigma,rad/d2r,sgmrad/d2r,r99,nval,prtilde,dper,real(rp/promcosd),real(rm/promcosd)
    enddo
    return
  END SUBROUTINE dipoleEW
!///////////////////////////////////////////////////////////////////////////
! calculates amplitud and phase of modulation in solar or anti-sid frequency
!     iscor = 0 --------> no weights 
!     iscor != 0 -------> use weigths 
!     freq = 0 ------->  use solar freq, antisidereal freq otherwise
  SUBROUTINE dipoleSolar(iscor,freq,utci_opt,utcf,zmin_opt,zmax,is5t5_opt,bine)
    USE globalvars
    USE dipcl
    USE dnhex
    IMPLICIT NONE
    INTEGER :: iscor,freq,utcf,bine
    REAL(pr) :: zmax
    INTEGER :: bin,binid,nval,UTC,utc0,unt,gps,t5,nh,i,ie,nbin
    INTEGER :: iw,ind,ftr,iunit,utci,is5t5
    REAL(pr) :: Dec,Ra,Eraw,Ecor,Theta,Phi,p,r,rav,r99r,Egeo,zmin
    REAL(pr) :: a,b,sumaN,hrs,peso,arg,rad,rtilde,prtilde,sigma,sgmra
    REAL(pr) :: E,energy,phitilt,sec,x,aP,arho,brho,pow,E05,eff,En
    REAL(pr) :: AugId,S1000_obs,Stot,raz,fas,sin2
    REAL*8 :: dnhexhr(24)
    REAL(pr) :: dnwhr(24,57),dnwshr(24,7)
    REAL(pr) :: kAlphaP(5), kAlphaRho(5),kBetaRho(5)
    REAL*8 :: rp,rm
    CHARACTER(30) :: dS1000_obs

    !//// optional parameters
    INTEGER(pr),OPTIONAL :: utci_opt,is5t5_opt
    REAL(pr),OPTIONAL :: zmin_opt
    utci = 0
    zmin = 0._pr
    is5t5 = 0

    if(present(utci_opt))utci = utci_opt
    if(present(zmin_opt))zmin = zmin_opt
    if(present(is5t5_opt))is5t5 = is5t5_opt

!    hexfile = '../datos_auger/utctprhdrc_010104_070518.dat'
    if(is5t5.eq.0) then
       if(freq.eq.0) then
          call solarhex(utci,utcf,1,hexfile,dnhexhr)
       else
          call antisidhex(utci,utcf,1,hexfile,dnhexhr)
       endif
    else
       if(freq.eq.0) then
          call solarhex(utci,utcf,3,hexfile,dnhexhr)
       else
          call antisidhex(utci,utcf,3,hexfile,dnhexhr)
       endif
    endif
    
    t5 = 0
    phitilt = -30.*d2r
    utc0 = 1072915200
    nbin = 4
    binid = 0
    fas = 1.0_pr
    if(freq.ne.0)fas=364.25/365.25         !  antisid/solar
    
    DO bin=1,bine
       nval=0
       a = 0.
       b = 0.
       sumaN = 0.
       rewind(unit=2)
       read(2,*)

40       read (2,*,end=41)AugId,Dec,Ra,Ecor,UTC,Theta,Phi,t5,ftr
       

       if(UTC.lt.utci.or.UTC.gt.utcf)goto 40 
       if(Theta.lt.zmin.or.Theta.gt.zmax)goto 40 
       if(is5t5.eq.0.and.t5.eq.5)goto 40 
       
       energy = Ecor

       binid = 0
       if(bine.eq.4) then
          if(energy.ge.Emin(1).and.energy.lt.Emin(2))binid=1
          if(energy.ge.Emin(2).and.energy.lt.Emin(3))binid=2
          if(energy.ge.Emin(3).and.energy.lt.Emin(4))binid=3
          if(energy.ge.Emin(4))binid=4
       elseif(bine.eq.2) then
          if(energy.ge.Emin(1).and.energy.lt.Emin(2))binid=1
          if(energy.ge.Emin(2))binid=2
       endif
       !----- calculates the hour of the day
       hrs=(float(UTC-utc0)/3600.0 + 21.)*fas
       nh=mod(int(hrs),24)+1
       
       if (binid.eq.bin) then ! only includes data on the current bin
          peso = 1./dnhexhr(nh)
          
          if(iscor.eq.0)peso = 1.
          nval = nval + 1
          sumaN = sumaN + peso
          !				arg=(hrs+21.)/24.0*2.0*pi
          arg = hrs/24.*2.*pi
          a = a + cos(arg)*peso
          b = b + sin(arg)*peso
       end if
       goto 40
41     continue
       a = 2.*a/sumaN
       b = 2.*b/sumaN
       rad=atan(b/a)
       if(a.lt.0.)rad=rad+pi
       if(a.gt.0..and.b.lt.0.)rad=rad+2.*pi
       rtilde = sqrt(a**2+b**2)
       prtilde = exp(-sumaN*rtilde**2/4.)
       sigma = sqrt(2./sumaN)
       sgmra = sigma/rtilde
       r99r=sqrt(4.*log(100.)/sumaN)
       
       call ampcl(dble(rtilde),dble(sigma),rp,rm)
       
       select case (bin)
       case (1)
          E=(Emin(1)+Emin(2))/2
       case (2)
          E=(Emin(2)+Emin(3))/2
       case (3)
          E=(Emin(3)+Emin(4))/2
       case (4)
          E=(Emin(4)+2*Emin(4))/2
       end select
 !=======  write data ====================================================
       if(freq.eq.0) then
          write(6,*)E,a,b,sigma,rtilde,real(rp),real(rm),prtilde,rad/d2r,sgmra/d2r,r99r,nval
       else
          write(6,*)E,a,b,sigma,rtilde,real(rp),real(rm),prtilde,rad/d2r,sgmra/d2r,r99r,nval
       end if
    ENDDO
    return
  END SUBROUTINE dipoleSolar
!///////////////////////////////////////////////////////////////////////////
!	Computes the estimated harmonic coefficients for an energy bin
!     iscor = 0 --------> no weights 
!     iscor != 0 -------> use weigths 
  SUBROUTINE rayleighcoeffs(bin,a,b,aphi,bphi,nval,sumaN,iscor,utci,utcf,zmin,zmax,is5t5,bine)
    USE globalvars
    INTEGER :: is5t5,utci,utcf,bine
    REAL(pr) :: zmin,zmax
    INTEGER :: bin,binid,nval,UTC,t5,iscor,ftr
    INTEGER*8 :: AugId
    REAL(pr) :: Dec,Ra,Ra0,energy,Theta,Phi,Ecor
    REAL(pr),DIMENSION(4) :: a,b,aphi,bphi
    REAL(pr) :: sumaN,raz
    CHARACTER(30) :: dS1000_obs
    phitilt = -30.*d2r
    iutcref = 1104537600   !1/1/2005 00:00:00
    nval = 0
    a = 0.
    b = 0.
    sumaN = 0.
    aphi = 0.
    bphi = 0.
    
    rewind(unit=2)
    read (2,*)
40    read (2,*,end=41)AugId,Dec,Ra,Ecor,UTC,Theta,Phi,t5,ftr
    
    if(UTC.lt.utci.or.UTC.gt.utcf)goto 40 
    if(Theta.le.zmin.or.Theta.gt.zmax)goto 40 
    if(is5t5.eq.0.and.t5.eq.5)goto 40
    
    energy = Ecor
    
    binid = 0

    if(bine.eq.4) then
       if(energy.ge.Emin(1).and.energy.lt.Emin(2))binid=1
       if(energy.ge.Emin(2).and.energy.lt.Emin(3))binid=2
       if(energy.ge.Emin(3).and.energy.lt.Emin(4))binid=3
       if(energy.ge.Emin(4))binid=4
    elseif(bine.eq.2) then
       if(energy.ge.Emin(1).and.energy.lt.Emin(2))binid=1
       if(energy.ge.Emin(2))binid=2
    endif
    
    if (binid.eq.bin) then    ! only includes data on the current bin
       
       !///////////// calculates the right ascension of zenith//////////////
       raz=float(UTC-iutcref)/239.345+31.4971
       raz=mod(raz,360.)
       if(raz.lt.0.0)raz=raz+360.
       ira=int(raz/bw)+1

       peso = 1./dnhexra(ira)&
            /(1.+0.003*tan(Theta*d2r)*cos(Phi*d2r-phitilt))

       if(iscor.eq.0) peso = 1.
              
       nval = nval + 1
       sumaN = sumaN + peso
       a(1) = a(1) + cos(Ra*d2r)*peso
       b(1) = b(1) + sin(Ra*d2r)*peso
       a(2) = a(2) + cos(2*Ra*d2r)*peso
       b(2) = b(2) + sin(2*Ra*d2r)*peso
       
       aphi(1) = aphi(1) + cos(Phi*d2r)*peso
       bphi(1) = bphi(1) + sin(Phi*d2r)*peso
       aphi(2) = aphi(2) + cos(2*Phi*d2r)*peso
       bphi(2) = bphi(2) + sin(2*Phi*d2r)*peso
    end if
    goto 40
41  continue
    a(1) = 2.*a(1)/sumaN
    a(2) = 2.*a(2)/sumaN

    b(1) = 2.*b(1)/sumaN
    b(2) = 2.*b(2)/sumaN
  
    aphi(1) = 2.*aphi(1)/sumaN
    aphi(2) = 2.*aphi(2)/sumaN
    bphi(1) = 2.*bphi(1)/sumaN
    bphi(2) = 2.*bphi(2)/sumaN
    return
  END SUBROUTINE rayleighcoeffs
!////////////////////////////////////////////////////////////////////////////////
!	Computes the estimated first harmonic coefficients for an energy bin 
!  separating northern and southern events
  SUBROUTINE rayleighcoeffsNS(bin,a,b,nval,sumaN,utci,utcf,zmin,zmax,is5t5,bine)
    USE globalvars
    INTEGER :: bin,binid,UTC,nval(2),utci,utcf,is5t5,bine
    REAL(pr) :: Dec,Ra,Ra0,energy,Theta,Phi,zmin,zmax
    REAL(pr) :: a(2),b(2)
    REAL(pr) :: sumaN(2)
    phitilt = -30.*d2r
    iutcref = 1104537600   !1/1/2005
    nval=0
    a = 0.
    b = 0.
    sumaN = 0.
    rewind(unit=2)
    read (2,*)
40    read (2,*,end=41)AugId,Dec,Ra,Ecor,UTC,Theta,Phi,t5,ftr
    
    if(UTC.lt.utci.or.UTC.gt.utcf)goto 40 
    if(Theta.le.zmin.or.Theta.gt.zmax)goto 40 
    if(is5t5.eq.0.and.t5.eq.5)goto 40
    
    raz=float(UTC-iutcref)/239.345+31.4971
    raz=mod(raz,360.)
    if(raz.lt.0.0)raz=raz+360.
    ira=int(raz/bw)+1
    
    energy = Ecor
    if(iscor.eq.0) energy = Eraw
    
    binid = 0
    if(bine.eq.4) then
       if(energy.ge.Emin(1).and.energy.lt.Emin(2))binid=1
       if(energy.ge.Emin(2).and.energy.lt.Emin(3))binid=2
       if(energy.ge.Emin(3).and.energy.lt.Emin(4))binid=3
       if(energy.ge.Emin(4))binid=4
    elseif(bine.eq.2) then
       if(energy.ge.Emin(1).and.energy.lt.Emin(2))binid=1
       if(energy.ge.Emin(2))binid=2
    endif
    
    if (binid.eq.bin) then    ! only includes data on the current bin
       peso = 1./dnhexra(ira) &
            /(1.+0.003*tan(Theta*d2r)*cos(Phi*d2r-phitilt))
       if(iscor.eq.0) peso = 1.
       
       if(Dec.ge.0.) then
          nval(1) = nval(1) + 1
          sumaN(1) = sumaN(1) + peso
          a(1) = a(1) + cos(Ra*d2r)*peso
          b(1) = b(1) + sin(Ra*d2r)*peso
       else if(Dec.lt.0.) then
          nval(2) = nval(2) + 1
          sumaN(2) = sumaN(2) + peso
          a(2) = a(2) + cos(Ra*d2r)*peso
          b(2) = b(2) + sin(Ra*d2r)*peso
       end if
    end if
    goto 40
41  continue
    a(1) = 2.*a(1)/sumaN(1)
    a(2) = 2.*a(2)/sumaN(2)
    b(1) = 2.*b(1)/sumaN(1)
    b(2) = 2.*b(2)/sumaN(2)
    return
  END SUBROUTINE rayleighcoeffsNS

!/////////////////////////////////////////////////////////////////////////
!	Computes the  coefficients	from the East-West method
!     ifrec = 0 -----> use sidereal frequency
!     ifrec != 0 -----> use solar frequency
  SUBROUTINE East_West(bin,aew,bew,avgst,avgcd,nval,ifrec,utci,utcf,zmin,zmax,is5t5,bine)
    USE globalvars
    INTEGER :: utci,utcf,is5t5,bine
    REAL(pr) :: zmin,zmax
    INTEGER :: bin,binid,nval,UTC,t5,ifrec,utc0
    REAL(pr) :: Dec,Ra,Ra0,energy,DeltaNHexaAtRa,Theta,Phi,c,d
    REAL(pr) :: aew,bew,avgst,avgcd
    
    iutcref = 1104537600   !1/1/2005
    utc0 = 1072915200
    nval=0
    ne=0
    nw=0
    aew = 0.
    bew = 0.
    avgst = 0.
    avgcd = 0.
    rewind(unit=2)
    read (2,*)
40    read (2,*,end=41)AugId,Dec,Ra,Ecor,UTC,Theta,Phi,t5,ftr
    
    if(UTC.lt.utci.or.UTC.gt.utcf)goto 40 
    if(Theta.lt.zmin.or.Theta.gt.zmax)goto 40 
    if(is5t5.eq.0.and.t5.eq.5)goto 40 
    
    energy=Ecor
    binid=0
    if(bine.eq.4) then
       if(energy.ge.Emin(1).and.energy.lt.Emin(2))binid=1
       if(energy.ge.Emin(2).and.energy.lt.Emin(3))binid=2
       if(energy.ge.Emin(3).and.energy.lt.Emin(4))binid=3
       if(energy.ge.Emin(4))binid=4
    elseif(bine.eq.2) then
       if(energy.ge.Emin(1).and.energy.lt.Emin(2))binid=1
       if(energy.ge.Emin(2))binid=2
    endif
    
    if (binid.eq.bin) then    ! only includes data on the current bin
       nval = nval + 1
       raz=float(UTC-iutcref)/239.345+31.4971
       raz=mod(raz,360.)
       if(raz.lt.0.0)raz=raz+360.
       hrs=float(UTC-utc0)/3600.0
       arg=(hrs+21.)/24.0*2.0*pi
       !  using phi to define E,W
       ieast=0
       !c			if(Phi.lt.90..or.Phi.gt.270.) ieast=1
       if(abs(Phi).lt.90.) ieast=1
       if(ieast.gt.0) then
          ne=ne+1
          if(ifrec.eq.0) then
             aew=aew + cos(raz*d2r)
             bew=bew + sin(raz*d2r)
          else
             aew=aew + cos(arg)
             bew=bew + sin(arg)
          endif
       else
          nw=nw+1
          if(ifrec.eq.0) then
             aew=aew + cos(raz*d2r+pi)
             bew=bew + sin(raz*d2r+pi)
          else
             aew=aew + cos(arg+pi)
             bew=bew + sin(arg+pi)
          endif
       endif
       !--sum sin(Theta)
       avgst = avgst + sin(Theta*d2r)
       !--sum cos(Dec)
       avgcd = avgcd + cos(Dec*d2r)
    end if
    goto 40
41  continue
    aew = 2.*aew/nval
    bew = 2.*bew/nval
    avgst = avgst/nval
    avgcd = avgcd/nval
    return
  END SUBROUTINE East_West
!//////////////////////////////////////////////////////////////////////////
! Calculates some averages of the declination and zenith angles
  SUBROUTINE funcavgs(bin,avg,iscor,utci,utcf,zmin,zmax,is5t5,bine)
    USE globalvars
    INTEGER :: is5t5,utci,utcf,bine
    REAL(pr) :: zmin,zmax
    INTEGER :: bin,binid,nval,UTC,t5,iscor,ftr
    INTEGER*8 :: AugId
    REAL(pr) :: Dec,Ra,Ra0,energy,DeltaNHexaAtRa,Theta,Phi,c,d,Ecor,Eraw,RAZ
    REAL(pr),DIMENSION(10) :: avg
    phitilt = -30.*d2r
    iutcref = 1104537600   !1/1/2005
    avgcd = 0.
    avgsd = 0.
    avgcsd = 0.
    avgcs2d = 0.
    avgc2d = 0.
    avgs2d = 0.
    avgst = 0.
    avgsct = 0.
    avgs2t = 0.
    avgct	= 0.
    nval = 0.
    rewind(unit=2)
    read (2,*)
50    read (2,*,end=51)AugId,Dec,Ra,Ecor,UTC,Theta,Phi,t5,ftr
    
    if(UTC.lt.utci.or.UTC.gt.utcf)goto 50 
    if(Theta.lt.zmin.or.Theta.gt.zmax)goto 50 
    if(is5t5.eq.0.and.t5.eq.5)goto 50

    energy = Ecor

    binid = 0

    if(bine.eq.4) then
       if(energy.ge.Emin(1).and.energy.lt.Emin(2))binid=1
       if(energy.ge.Emin(2).and.energy.lt.Emin(3))binid=2
       if(energy.ge.Emin(3).and.energy.lt.Emin(4))binid=3
       if(energy.ge.Emin(4))binid=4
    elseif(bine.eq.2) then
       if(energy.ge.Emin(1).and.energy.lt.Emin(2))binid=1
       if(energy.ge.Emin(2))binid=2
    endif
    
    if (binid.eq.bin) then    ! only includes data on the current bin
       peso = 1.!/DeltaNHexaAtRa
!     &/(1.+0.003*tan(Theta*d2r)*cos(Phi*d2r-phitilt))
       nval = nval + peso
       avgcd = avgcd + cos(Dec*d2r)*peso
       avgsd = avgsd + sin(Dec*d2r)*peso
       avgcsd = avgcsd + cos(Dec*d2r)*sin(Dec*d2r)*peso
       avgcs2d = avgcs2d + cos(Dec*d2r)*sin(Dec*d2r)**2*peso
       avgc2d = avgc2d + cos(Dec*d2r)**2*peso
       avgs2d = avgs2d + sin(Dec*d2r)**2*peso
       avgst = avgst + sin(Theta*d2r)*peso
       avgsct = avgsct + sin(Theta*d2r)*cos(Theta*d2r)*peso
       avgs2t = avgs2t + sin(Theta*d2r)**2*peso
       avgct = avgct + cos(Theta*d2r)*peso
    end if
    goto 50
51  continue
    avg(1) = avgcd/nval      ! Cos(dec)
    avg(2) = avgcsd/nval     ! Cos(dec)*Sin(dec)
    avg(3) = avgcs2d/nval    ! Cos(dec)*Sin(dec)^2
    avg(4) = avgc2d/nval     ! Cos(dec)^2
    avg(5) = avgst/nval      ! Sin(theta)
    avg(6) = avgsct/nval     ! Sin(theta)*Cos(theta)
    avg(7) = avgs2t/nval     ! Sin(theta)^2
    avg(8) = avgct/nval      ! Cos(theta)
    avg(9) = avgsd/nval      ! Sin(dec)
    avg(10) = avgs2d/nval    ! Sin(dec)^2
    return
  END SUBROUTINE funcavgs
!//////////////////////////////////////////////////////////////////
!     Calculates averages for sine and cosine of declination
!     separating northern and southtern events
  SUBROUTINE funcavgsNS(bin,avg,utci,utcf,zmin,zmax,is5t5,bine) 
    USE globalvars
    REAL(pr) :: Dec,Ra,Ra0,energy,Theta,Phi,nval(2),zmin,zmax
    REAL(pr)::  avg(4)
    INTEGER :: bin,UTC,utci,utcf,is5t5,bine
    phitilt = -30.*d2r
    iutcref = 1104537600   !1/1/2005
    avg = 0.
    nval = 0.
    rewind(unit=2)
    read (2,*)
50    read (2,*,end=51)AugId,Dec,Ra,Ecor,UTC,Theta,Phi,t5,ftr
    
    if(UTC.lt.utci.or.UTC.gt.utcf)goto 50 
    if(Theta.lt.zmin.or.Theta.gt.zmax)goto 50 
    if(is5t5.eq.0.and.t5.eq.5)goto 50
    
    energy = Ecor
!    if(iscor.eq.0) energy = Eraw
    
    binid = 0
    if(bine.eq.4) then
       if(energy.ge.Emin(1).and.energy.lt.Emin(2))binid=1
       if(energy.ge.Emin(2).and.energy.lt.Emin(3))binid=2
       if(energy.ge.Emin(3).and.energy.lt.Emin(4))binid=3
       if(energy.ge.Emin(4))binid=4
    elseif(bine.eq.2) then
       if(energy.ge.Emin(1).and.energy.lt.Emin(2))binid=1
       if(energy.ge.Emin(2))binid=2
    endif
    
    if (binid.eq.bin) then    ! only includes data on the current bin
       peso = 1.!/DeltaNHexaAtRa/(1.+0.003*tan(Theta*d2r)*cos(Phi*d2r-phitilt))
       if(Dec.gt.0.) then   ! Northern data
          nval(1) = nval(1) + peso
          avg(1) = avg(1) + cos(Dec*d2r)*peso
          avg(2) = avg(2) + cos(Dec*d2r)*sin(Dec*d2r)*peso
       else if(Dec.lt.0.) then ! Southern data
          nval(2) = nval(2) + peso
          avg(3) = avg(3) + cos(Dec*d2r)*peso
          avg(4) = avg(4) + cos(Dec*d2r)*sin(Dec*d2r)*peso
       end if
    end if
    goto 50
51  continue
    avg(1) = avg(1)/nval(1)
    avg(2) = avg(2)/nval(1)
    avg(3) = avg(3)/nval(2)
    avg(4) = avg(4)/nval(2)
    return
  END SUBROUTINE funcavgsNS
!////////////////////////////////////////////////////////////////
!     calculates the phase of a vector with x and y components
!     returns the result between 0 and 2*pi
  FUNCTION atan02pi(x,y)
    USE globalvars
    REAL(pr) :: x,y,phi,atan02pi
    phi = atan(y/x)
    if(phi.lt.0.) then
       if(x.lt.0.)phi = pi+phi
       if(x.gt.0.)phi = 2*pi+phi
    else if(phi.gt.0..and.x.lt.0.) then
       phi = pi + phi
    endif
    atan02pi=phi
    return
  END FUNCTION atan02pi
