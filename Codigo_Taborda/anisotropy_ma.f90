!!! Calcula anisotropías para el arreglo de 1500m usando análisis Rayleigh en diferentes frecuencias: sidérea, solar o anti-sidérea.
!!! También tiene la opción de calcular usando método East-West y el método de los armónicos esféricos.
!!! Funciona en simple y doble precisión
!
! 	compile with:	
!  gfortran anisotropy_ma.f90 -L /mnt/Datos/oscar/lapack-3.4.2 -llapack -lrefblas
!  or if asymmetric errors needed with: 
!  gfortran -I obj/ anisotropy_ma.f90 -L /mnt/Datos/oscar/lapack-3.4.2 -llapack -lrefblas obj/dipcl.o
!==============================================================================
!     variables globales a usar en el programa 
MODULE globalvars
  USE globalconsts
  IMPLICIT NONE
  INTEGER,PARAMETER :: pr = sp
  REAL(pr),PARAMETER :: pi = pi_s
  REAL(pr),PARAMETER :: d2r = pi/180.
  REAL(pr),PARAMETER :: rho0 = 1.06,P0 = 862.0,Bb = 1.03
  REAL(pr),PARAMETER :: bw = 1.
  REAL(pr),ALLOCATABLE :: dnhexra(:),dwra(:,:)
  REAL(pr) :: Emin(7)=(/0.125,0.25,0.5,1.,2.,4.,8./)
!  REAL(pr) :: Emin(7)=(/0.,0.,0.,4.,8.,16.,32./)
  REAL(pr) :: Eminb(2)=(/4.,8./)
CONTAINS
END MODULE globalvars
      
PROGRAM anisotropy
  USE globalvars
  INTEGER size,utci,utcf,bine,is5t5,meth,freq
  REAL(pr) :: zmax
  CHARACTER(10) :: itime,ftime
  CHARACTER(80) :: command

  INTERFACE
     SUBROUTINE dipoleSolar(iscor,freq,utci_opt,utcf,zmin_opt,zmax,is5t5_opt,iseff_opt,bine)
       USE globalvars
       INTEGER :: iscor,freq,utcf,bine
       REAL(pr) :: zmax
       INTEGER(pr),OPTIONAL :: utci_opt,is5t5_opt,iseff_opt
       REAL(pr),OPTIONAL :: zmin_opt
     END SUBROUTINE dipoleSolar

     SUBROUTINE dipoleRA(iscor,utci_opt,utcf,zmin_opt,zmax,is5t5_opt,iseff_opt,bine,outfmt)
       USE globalvars
       USE dipcl
       INTEGER :: iscor,utcf,bine,outfmt
       REAL(pr) :: zmax
       INTEGER(pr),OPTIONAL :: utci_opt,is5t5_opt,iseff_opt
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
  
  open(unit=13,file='tmp.dat')
  open(unit=1,file='HeraldInfill001EeV055noBP.dat')
!  open(unit=2,file='../CIC-Energycal/HeraldCorrectwg050a04_6t5_alltrig_310517.dat')
!  open(unit=2,file='../CIC-Energycal/HeraldCorrectwg060noBP5n6t5_pnop_080916_wca1.dat')
  

!  open(unit=2,file='Herald080noBP5n6t5a4_pnop_04-310816_wca1.dat')
  !	open(unit=2,file='energybins080_6T5a4.dat')
  !	open(unit=3,file='dip060Coreff1_04-14_wca1.tmp')
  
  !     open(unit=3,file='dip60805T5_04-311214.dat')

  !open(unit=8,file='dnhexra6T5_010713-310517.dat')
  
  !open(unit=9,file='rayleighcoefs.dat')

  open(unit=16,file='expsolmaindN_04-14_wca1.dat')
  open(unit=17,file='expsidmaindN_04-14_wca1v2.dat')
  open(unit=13,file='ev0805n6T5a4_pnop_04-310816_wca1.dat')


  ! dates mm/dd/yy
  itime = '1/1/2004'
  ftime = '1/1/2018'
  command = "date -u +%s --date='"//trim(itime)//"' > tmpdummy.xx"
  call system(command)
  command = "date -u +%s --date='"//trim(ftime)//"' >> tmpdummy.xx"
  call system(command)
  open(unit=9,action='READ',file='tmpdummy.xx')
  read(9,*)utci
  read(9,*)utcf
  close(unit=9)
  call system("rm tmpdummy.xx")

  bine = 2
  zmin = 0.
  zmax = 80.
  is5t5 = 1
  iseff = 1
  meth = 1
  freq = 1 ! 0 Solar, 1 Antisid

  if(bine.eq.6.or.bine.eq.4) then
     open(unit=2,file='Herald080noBP5n6t5a4_pnop_04-310816_wca1.dat')
!     open(unit=2,file='Herald080noBP5n6t5a4_pnop_04-311217.dat')
!     open(unit=2,file='Herald080noBP5n6t5a4_pnop_04-311217_Eraw.dat')
!     open(unit=2,file='Herald080noBP5n6t5a4_pnop_04-311217_NKG.dat')
     iseff = 0
  else
     open(unit=2,file='Herald060noBP6T5_04-311217.dat')
!     open(unit=2,file='Herald060noBP6T5_04-311217_NKG.dat')
!     open(unit=2,file='Herald060noBP6T5_04-310517.dat')
     is5t5 = 0
     zmax = 60.
  endif

  select case (meth)
  case (1)
     call dipoleSolar(iscor=1,freq=freq,utci_opt=utci,utcf=utcf,zmax=zmax,is5t5_opt=is5t5,bine=bine,iseff_opt=iseff) ! if arg1 = 0 raw energy | corrected energy otherwise
  case (2)
     call dipoleRA(iscor=1,utci_opt=utci,utcf=utcf,zmin_opt=zmin,zmax=zmax,is5t5_opt=is5t5,iseff_opt=iseff,bine=bine,outfmt=2)  ! if arg = 0 raw energy | corrected energy otherwise
  case (3)
     call dipolepquadRA(utcf=utcf,zmin_opt=zmin,zmax=zmax,is5t5_opt=is5t5,bine=bine,outfmt=1)
  case (4)
     call dipoleEW(ifrec=0,utci_opt=utci,utcf=utcf,zmax=zmax,is5t5_opt=is5t5,bine=bine)  ! if arg = 0 sidereal freq | solar freq otherwise
  end select
  !  call dipoleHA


!  call dipolepquadHA
!  
  !		call dipolepquadHA2

  !		do j=1,1000
  !			d=-90.+float(j-1)*180./999.
  !			write(1,*)d,exposure(d*d2r)
  !		enddo
END PROGRAM anisotropy
!==============================================================================	
! calculates the dipole components using harmonic analysis (spherical harmonics expansion)
  SUBROUTINE dipoleHA
    USE globalvars
    USE dipcl
    INTEGER :: n,nbin,i,nval,size
    PARAMETER (n = 4)
    REAL(pr), DIMENSION(n,n) :: K, Kinv
    REAL(pr), DIMENSION(n) :: almbar,blmbar
    REAL(pr) :: var_rbar,sigmar,var_dec,sigmad,var_ra,sigmara
    REAL*8 :: dperp,dperm,drp,drm,ddecp,ddecm

    INTERFACE
       FUNCTION K0000(x)
         import :: pr
         REAL(pr) :: x
         REAL(pr) :: K0000
       END FUNCTION K0000
       FUNCTION K1000(x)
         import :: pr
         REAL(pr) :: x
         REAL(pr) :: K1000
       END FUNCTION K1000
       FUNCTION K1m11m1(x)
         import :: pr
         REAL(pr) :: x
         REAL(pr) :: K1m11m1
       END FUNCTION K1M11M1
       FUNCTION K1010(x)
         import :: pr
         REAL(pr) :: x
         REAL(pr) :: K1010
       END FUNCTION K1010
    END INTERFACE
    
    open(unit=8,file='dnhexra5n6T5_pnop_04-0816.dat')
    size = int(360.1/bw)
    allocate(dnhexra(size))
    do i=1,size
       read (8,*)dnhexra(i)
    enddo
        
    ep=1.e-7
    nbin = 7
    K = 0.
    call qsimp(K0000,-pi/2+ep,pi/2-ep,K(1,1))
    call qsimp(K1000,-pi/2+ep,pi/2-ep,K(1,3))
    call qsimp(K1m11m1,-pi/2+ep,pi/2-ep,K(2,2))
    call qsimp(K1010,-pi/2+ep,pi/2-ep,K(3,3))
    K(1,1) = 2.*pi*K(1,1)
    K(1,3) = 2.*pi*sqrt(3.)*K(1,3)
    K(2,2) = 3.*pi*K(2,2)
    K(3,3) = 6.*pi*K(3,3)
    K(3,1) = K(1,3)
    K(4,4) = K(2,2)
    do i=1,n
       write (6,*) ( K(i,j),j=1,n)
    enddo
    call inverseMatrix(K,n,Kinv)
    print '(" ")'
    print*,"Inverse Matrix:"
    do i=1,n
       write (6,*) ( Kinv(i,j),j=1,n)
    enddo
    print '(" ")'
    do i=6,nbin
! Estimate dipole amplitude, Ra and dec using Harmonic analysis
       almbar=0.
       call almbarcoeffs(almbar,blmbar,Kinv,i,n)! harmonic coeff. for nbin=6 (4EeV-8EeV) nbin=7 (>8EeV)
       rbar = sqrt(3.*(almbar(3)**2+almbar(4)**2+almbar(2)**2))/almbar(1)
       decbar = asin(sqrt(3.)*almbar(3)/almbar(1)/rbar)
       rabar = atan(almbar(2)/almbar(4))
       if(rabar.lt.0.) then
          if(almbar(4).lt.0.)rabar = pi+rabar
          if(almbar(4).gt.0.)rabar = 2*pi+rabar
       else if(rabar.gt.0..and.almbar(4).lt.0.) then
          rabar = pi + rabar
       endif

       delx=sqrt(3.)*almbar(4)/almbar(1)
       dely=sqrt(3.)*almbar(2)/almbar(1)
       delz=sqrt(3.)*almbar(3)/almbar(1)
       dper=sqrt(delx**2+dely**2)

!			decbar = atan(delz/sqrt(delx**2+dely**2))

!	Caculate Errors
       var_rbar=3./(almbar(2)**2+almbar(3)**2+almbar(4)**2)/almbar(1)&
            *(Kinv(2,2)*almbar(2)**2+Kinv(3,3)*almbar(3)**2+Kinv(4,4)*almbar(4)**2)

       sgmrbar = sqrt(var_rbar)

!		var_dec = 1./(almbar(2)**2+almbar(4)**2)*(Kinv(3,3)
!     & *almbar(1)+sigmar**2*almbar(3)**2/rbar**2)

!		sigmad = sqrt(var_dec)

       var_dec = 3./almbar(1)/(delx**2+dely**2+delz**2)**2*(delz**2&
            *(delx**2*Kinv(4,4)+dely**2*Kinv(2,2))/(delx**2+dely**2)+(delx**2&
            +dely**2)*Kinv(3,3))

       sgmdec = sqrt(var_dec)
       
       var_ra = almbar(1)/(almbar(4)**2+almbar(2)**2)**2*(Kinv(2,2)*almbar(4)**2&
            +Kinv(4,4)*almbar(2)**2)

       sgmra = sqrt(var_ra)

!		ddz = sqrt(3.*Kinv(3,3)*K(1,1)/nval)
       sgmdper = sqrt(3./almbar(1)/(delx**2+dely**2)*(delx**2*Kinv(4,4)&
            +dely**2*Kinv(2,2)))
       sgmdz =  sqrt(3.*Kinv(3,3)/almbar(1))
       ddx = sqrt(3.*Kinv(4,4)/almbar(1))

       ! Asymmetric error estimates for the total dipole amplitude and the declination
       call ampcl(dble(dper),dble(ddx),dperp,dperm)
       call amptotcl(dble(dper),dble(delz),dble(sgmdper),dble(sgmdz),drp,drm)
       call deccl(dble(rbar),dble(decbar)/d2r,dble(sgmdper),dble(sgmdz),ddecp,ddecm)

       select case (i)
       case (1)
          E=(Emin(1)+Emin(2))/2
       case (2)
          E=(Emin(2)+Emin(3))/2
       case (3)
          E=(Emin(3)+Emin(4))/2
       case (4)
          E=(Emin(4)+Emin(5))/2
       case (5)
          E=(Emin(5)+Emin(6))/2
       case (6)
          E=(Emin(6)+Emin(7))/2
       case (7)
          E=(Emin(7)+2.*Emin(7))/2
       end select

!       write(6,*)E,delz,sgmdz,dper,real(dperp),real(dperm),rbar,real(drp),real(drm),decbar/d2r&
!            ,real(ddecp),real(ddecm),rabar/d2r,sgmra/d2r
!       write(6,*)E,delz,sgmdz,dper,sgmdper,rbar,sgmrbar,decbar/d2r,sgmdec/d2r,rabar/d2r,sgmra/d2r
       do m=1,n
!          write(6,*)E,blmbar(m),almbar(m),sqrt(Kinv(m,m)*almbar(1))
       enddo
    enddo
    deallocate(dnhexra)
    close(unit=8)
    return
  END SUBROUTINE dipoleHA
!=============================================================================
  SUBROUTINE dipolepquadHA2
    USE globalvars
    INTEGER :: n,nbin,i,nval
    PARAMETER (n = 9)
    REAL(pr), DIMENSION(n,n) :: K, Kinv
    REAL(pr), DIMENSION(n) :: almbar,blmbar
    REAL(pr) :: var_rbar,sigmar,var_dec,sigmad,var_ra,sigmara
    REAL(pr) :: k11,k12,k44,k22,k67,k88,k55,k33,k23

    external K0000,K1000,K1m11m1,K1010,K2111,K2m22m2,K2m12m1
    external K2020,K2010
    ep=1.e-7
    nbin = 2
    K = 0.
    call qsimp(K0000,-pi/2+ep,pi/2-ep,k11)
    call qsimp(K1000,-pi/2+ep,pi/2-ep,k12)
    call qsimp(K1m11m1,-pi/2+ep,pi/2-ep,k44)
    call qsimp(K1010,-pi/2+ep,pi/2-ep,k22)
    call qsimp(K2111,-pi/2+ep,pi/2-ep,k67)
    call qsimp(K2m22m2,-pi/2+ep,pi/2-ep,k88)
    call qsimp(K2m12m1,-pi/2+ep,pi/2-ep,k55)
    call qsimp(K2020,-pi/2+ep,pi/2-ep,k33)
    call qsimp(K2010,-pi/2+ep,pi/2-ep,k23)
    K(1,1) = 2.*pi*k11
    K(1,3) = sqrt(5.)*pi*(2*k22-k44)
    K(2,2) = 6.*pi*k22
    K(3,3) = 2.5*pi*k33
    K(3,1) = K(1,3)
    K(4,4) = 3.*pi*k44
    K(1,2) = 2.*pi*sqrt(3.)*k12
    K(5,5) = 15*pi*k55
    K(6,6) = K(4,4)
    K(7,7) = K(5,5)
    K(2,3) = sqrt(15.)*pi*(2*k23-k67)
    K(4,5) = sqrt(45.)*pi*k67
    K(6,7) = K(4,5)
    K(8,8) = 3.75*pi*k88
    K(9,9) = K(8,8)
    K(2,1) = K(1,2)
    K(3,2) = K(2,3)
    K(5,4) = K(4,5)
    K(7,6) = K(6,7)

    do i=1,n
       write (6,*) ( K(i,j),j=1,n)
    enddo

    call inverseMatrix(K,n,Kinv)
    print '(" ")'
    print*,"Inverse Matrix:"
    do i=1,n
       write (6,*) ( Kinv(i,j),j=1,n)
    enddo
    print '(" ")'
    dd = K(5,5)/(K(4,4)*K(5,5)-K(4,5)**2)
    write(6,*)dd
    return
  END SUBROUTINE dipolepquadHA2
!========================================================================
! Calculates the dipole and quadrupole components using harmonic analysis
  SUBROUTINE dipolepquadHA
    USE globalvars
    INTEGER :: n,nbin,i,nval,size
    PARAMETER (n = 9)
    REAL(pr), DIMENSION(n,n) :: K, Kinv
    REAL(pr), DIMENSION(n) :: almbar,blmbar
    REAL(pr) :: var_rbar,sigmar,var_dec,sigmad,var_ra,sigmara
    REAL(pr) :: k11,k13,k22,k33,k48,k55,k66,k77,k37,k88

        INTERFACE
       FUNCTION K0000(x)
         import :: pr
         REAL(pr) :: x
         REAL(pr) :: K0000
       END FUNCTION K0000
       FUNCTION K1000(x)
         import :: pr
         REAL(pr) :: x
         REAL(pr) :: K1000
       END FUNCTION K1000
       FUNCTION K1m11m1(x)
         import :: pr
         REAL(pr) :: x
         REAL(pr) :: K1m11m1
       END FUNCTION K1M11M1
       FUNCTION K1010(x)
         import :: pr
         REAL(pr) :: x
         REAL(pr) :: K1010
       END FUNCTION K1010
       FUNCTION K2111(x)
         import :: pr
         REAL(pr) :: x
         REAL(pr) :: K2111
       END FUNCTION K2111
       FUNCTION K2m22m2(x)
         import :: pr
         REAL(pr) :: x
         REAL(pr) :: K2m22m2
       END FUNCTION K2M22M2
       FUNCTION K2m12m1(x)
         import :: pr
         REAL(pr) :: x
         REAL(pr) :: K2m12m1
       END FUNCTION K2M12M1
       FUNCTION K2020(x)
         import :: pr
         REAL(pr) :: x
         REAL(pr) :: K2020
       END FUNCTION K2020
       FUNCTION K2010(x)
         import :: pr
         REAL(pr) :: x
         REAL(pr) :: K2010
       END FUNCTION K2010
    END INTERFACE

    open(unit=8,file='dnhexra5n6T5_pnop_04-0816.dat')
    size = int(360.1/bw)
    allocate(dnhexra(size))
    do i=1,size
       read (8,*)dnhexra(i)
    enddo

    ep=1.e-7
    nbin = 7
    K = 0.
    call qsimp(K0000,-pi/2+ep,pi/2-ep,k11)
    call qsimp(K1000,-pi/2+ep,pi/2-ep,k13)
    call qsimp(K1m11m1,-pi/2+ep,pi/2-ep,k22)
    call qsimp(K1010,-pi/2+ep,pi/2-ep,k33)
    call qsimp(K2111,-pi/2+ep,pi/2-ep,k48)
    call qsimp(K2m22m2,-pi/2+ep,pi/2-ep,k55)
    call qsimp(K2m12m1,-pi/2+ep,pi/2-ep,k66)
    call qsimp(K2020,-pi/2+ep,pi/2-ep,k77)
    call qsimp(K2010,-pi/2+ep,pi/2-ep,k37)
    K(1,1) = 2.*pi*k11
    K(1,3) = 2.*pi*sqrt(3.)*k13
    K(2,2) = 3.*pi*k22
    K(3,3) = 6.*pi*k33
    K(3,1) = K(1,3)
    K(4,4) = K(2,2)
    K(4,8) = sqrt(45.)*pi*k48
    K(5,5) = 3.75*pi*k55
    K(6,6) = 15*pi*k66
    K(7,7) = 2.5*pi*k77
    K(1,7) = sqrt(5.)*pi*(2*k33-k22)
    K(2,6) = K(4,8)
    K(3,7) = sqrt(15.)*pi*(2*k37-k48)
    K(8,8) = K(6,6)
    K(9,9) = K(5,5)
    K(8,4) = K(4,8)
    K(7,1) = K(1,7)
    K(6,2) = K(2,6)
    K(7,3) = K(3,7)

    do i=1,n
       write (6,*) ( K(i,j),j=1,n)
    enddo

    call inverseMatrix(K,n,Kinv)
    print '(" ")'
    print*,"Inverse Matrix:"
    do i=1,n
       write (6,*) ( Kinv(i,j),j=1,n)
    enddo
    print '(" ")'
    !		goto 33
    DO i=6,nbin
       ! Estimate dipole amplitude, Ra and dec using Harmonic analysis
       almbar=0.
       call almbarcoeffs(almbar,blmbar,Kinv,i,n)!harmonic coeff. for binid=1 (4EeV-8EeV) binid=2 (>8EeV)
       rbar = sqrt(3.*(almbar(3)**2+almbar(4)**2+almbar(2)**2))/almbar(1)
       decbar = asin(sqrt(3.)*almbar(3)/almbar(1)/rbar)
       rabar = atan(almbar(2)/almbar(4))
       if(rabar.lt.0.) then
          if(almbar(4).lt.0.)rabar = pi+rabar
          if(almbar(4).gt.0.)rabar = 2*pi+rabar
       else if(rabar.gt.0..and.almbar(4).lt.0.) then
          rabar = pi + rabar
       endif

       dx=sqrt(3.)*almbar(4)/almbar(1)
       dy=sqrt(3.)*almbar(2)/almbar(1)
       dz=sqrt(3.)*almbar(3)/almbar(1)
       decbar = atan(dz/sqrt(dx**2+dy**2))

       ! components of the quadrupole tensor Qij
       Qxx=sqrt(5.)/almbar(1)*(sqrt(3.)*almbar(9)-almbar(7))
       Qyy=-sqrt(5.)/almbar(1)*(sqrt(3.)*almbar(9)+almbar(7))
       Qzz=-(Qxx+Qyy)
       Qxy=sqrt(15.)*almbar(5)/almbar(1)
       Qxz=sqrt(15.)*almbar(8)/almbar(1)
       Qyz=sqrt(15.)*almbar(6)/almbar(1)

       if(i.eq.6) E = 6.
       if(i.eq.7) E = 12.

       !	Caculate Errors
       var_rbar=3./(almbar(2)**2+almbar(3)**2+almbar(4)**2)/almbar(1)&
            *(Kinv(2,2)*almbar(2)**2+Kinv(3,3)*almbar(3)**2+Kinv(4,4)*almbar(4)**2)

       sigmar = sqrt(var_rbar)

       !		var_dec = 1./(almbar(2)**2+almbar(4)**2)*(Kinv(3,3)
       !     & *almbar(1)+sigmar**2*almbar(3)**2/rbar**2)

       !		sigmad = sqrt(var_dec)

       var_dec = 3./almbar(1)/(dx**2+dy**2+dz**2)**2*(dz**2&
            *(dx**2*Kinv(4,4)+dy**2*Kinv(2,2))/(dx**2+dy**2)+(dx**2&
            +dy**2)*Kinv(3,3))

       sigmad = sqrt(var_dec)

       var_ra = almbar(1)/(almbar(4)**2+almbar(2)**2)**2*(Kinv(2,2)*&
            almbar(4)**2+Kinv(4,4)*almbar(2)**2)

       sigmara = sqrt(var_ra)

       ddz = sqrt(3.*Kinv(3,3)*K(1,1)/nval)
       ddper = sqrt(3./almbar(1)/(dx**2+dy**2)*(dx**2*Kinv(4,4)&
            +dy**2*Kinv(2,2)))
       ddz2 =  sqrt(3.*Kinv(3,3)/almbar(1))
       ddx = sqrt(3.*Kinv(4,4)/almbar(1))

       sgmdx=sqrt(3.*Kinv(4,4)/almbar(1))
       sgmdy=sqrt(3.*Kinv(2,2)/almbar(1))
       sgmdz=sqrt(3.*Kinv(3,3)/almbar(1))
       sgmQxx=sqrt(15.*Kinv(9,9)/almbar(1)+5.*Kinv(7,7)/almbar(1))
       sgmQyy=sgmQxx
       !		sgmQzz=sqrt(2.)*sgmQxx
       sgmQzz=sqrt(20.*Kinv(7,7)/almbar(1))
       sgmQxy=sqrt(15.*Kinv(5,5)/almbar(1))
       sgmQxz=sqrt(15.*Kinv(8,8)/almbar(1))
       sgmQyz=sqrt(15.*Kinv(6,6)/almbar(1))
       !		write(4,*)E,rbar,sigmar,decbar/d2r,sigmad/d2r,rabar/d2r,
       !     &	sigmara/d2r,Qxx,Qyy,Qzz,Qxy,Qxz,Qyz
!       write(6,*)E,dx,sgmdx,dy,sgmdy,dz,sgmdz,Qxx,sgmQxx,Qyy,sgmQyy,Qzz,sgmQzz,Qxy,sgmQxy,Qxz&
!            ,sgmQxz,Qyz,sgmQyz

       do m=1,n
          write(6,*)E,blmbar(m),almbar(m),sqrt(Kinv(m,m)*almbar(1))
       enddo
    enddo
33  continue
    deallocate(dnhexra)
    close(unit=8)
    return
  END SUBROUTINE dipolepquadHA
!==========================================================================
! calculates the dipole components using rayleigh analysis
  SUBROUTINE dipoleRA(iscor,utci_opt,utcf,zmin_opt,zmax,is5t5_opt,iseff_opt,bine,outfmt)
    USE globalvars
    USE dipcl
    IMPLICIT NONE
    INTEGER :: iscor,utcf,bine,outfmt
    REAL(pr) :: zmax
    INTEGER(pr),OPTIONAL :: utci_opt,is5t5_opt,iseff_opt
    REAL(pr),OPTIONAL :: zmin_opt
    REAL(pr),DIMENSION(4) :: a,b,aphi,bphi
    REAL(pr) :: avg(10)
    REAL(pr) :: rtilde,dper,dz,decd,rd,rtilde2,prtilde,prtilde2,rad,rad2
    REAL(pr) :: sgmdper,sgmdz,promdec,promzen,zmin
    REAL(pr) :: r99,sgmrd,sgmra,sgmdec,sumaN,c,d,E,atan02pi
    REAL*8 :: rp,rm,drp,drm,ddecp,ddecm
    INTEGER :: nbin,iunit,i,nval,size,utci,is5t5,iseff
    CHARACTER(200) :: command,hexfile

    utci = 0
    zmin = 0._pr
    is5t5 = 0
    iseff = 0
    if(present(utci_opt))utci = utci_opt
    if(present(zmin_opt))zmin = zmin_opt
    if(present(is5t5_opt))is5t5 = is5t5_opt
    if(present(iseff_opt))iseff = iseff_opt
    
    hexfile = '../datos_auger/utctprhdrc_010104_070518.dat'
    if(is5t5.eq.0) then
       write(command,*)"./dnhexv3.out ",trim(hexfile),1,1,utci,utcf
       call system(command)
       open(unit=8,file='dnhex.dat')
!       open(unit=8,file='dnhexra6T5_04-17.dat')
    else
       write(command,*)"./dnhexv3.out ",trim(hexfile),1,3,utci,utcf
       call system(command)
       !open(unit=8,file='dnhexra5n6T5_pnop_04-17.dat')
!       open(unit=8,file='dnhexra5n6T5_pnop_04-0517.dat')
       open(unit=8,file='dnhex.dat')
    endif
    
    size = int(360.1/bw)
    allocate(dnhexra(size),dwra(size,7))
    do i=1,size
       read (8,*)dnhexra(i)
    enddo
  
    nbin = 7    
    do i=bine,nbin
! Estimate dipole amplitude, Ra and dec using Rayleigh analysis
       call rayleighcoeffs(i,a,b,aphi,bphi,nval,sumaN,iscor,utci,utcf,zmin,zmax,is5t5,iseff,bine)
       call funcavgs(i,avg,iscor,utci,utcf,zmin,zmax,is5t5,iseff,bine)
       
!       write(6,*)'a1 | b1 | a2 | b2 | a3 | b3 | a4 | b4 | sigma'
!       write(6,*)a(1),b(1),a(2),b(2),a(3),b(3),a(4),b(4),sqrt(2./sumaN),nval
!       stop
              
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
          E=(Emin(4)+Emin(5))/2
       case (5)
          E=(Emin(5)+Emin(6))/2
       case (6)
          E=(Emin(6)+Emin(7))/2
       case (7)
          E=(Emin(7)+2.*Emin(7))/2
       end select
!			ddx2 = sqrt(cos(rad)**2*ddper**2+dper**2*sin(rad)**2*sgmra**2)
!			write(6,*)dper,sgmdper,rad/d2r,sgmra/d2r,rtilde,prtilde,nval			
!!$			write(3,*)E,a(1),b(1),sqrt(2./sumaN),rtilde,prtilde,r99,nval
!!$			write(6,*)a(2),b(2),sqrt(2./sumaN),rtilde2,rad2/d2r,prtilde2			
!!$			write(3,*)E,aphi(1),aphi(2),bphi(1),bphi(2),sqrt(2./sumaN)
!!$			write(3,*)E,dz,sgmdz,dper,sgmdper,rd,sgmrd
!!$			write(3,*)E,decd/d2r,sgmdec/d2r,rad/d2r,sgmra/d2r
!!$			write(6,*)E,dper,sgmdper,rad/d2r,sgmra/d2r,prtilde&
!!$             ,r99/promdec,nval       

       if(outfmt.eq.1) then
          iunit = 6
          write(iunit,*)"------------------------------------------"

          if(i.lt.7) then
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
          !write(6,*)E,dz,sgmdz,dper,real(rp)/promdec,real(rm)/promdec,rd,real(drp),real(drm)&
           !    ,decd/d2r,real(ddecp),real(ddecm),rad/d2r,sgmra/d2r
          !     write(6,*)E,rtilde,sqrt(2./sumaN),rad/d2r,sgmra/d2r,r99,nval,prtilde,dper,rp/promdec,rm/promdec

!          write(6,*)E,nval,dper,rp/promdec,rm/promdec,rad/d2r,sgmra/d2r,prtilde,r99/promdec

          write(6,*)E,utci,utcf,rtilde,sqrt(2./sumaN),rad/d2r,sgmra/d2r,nval,r99,prtilde
       endif       
    enddo
    return
  END SUBROUTINE dipoleRA
!===========================================================================
!     calculates the dipole and quadrupole components using rayleigh analysis
  SUBROUTINE dipolepquadRA(utci_opt,utcf,zmin_opt,zmax,is5t5_opt,bine,outfmt)
    USE globalvars
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


    !open(unit=4,file='dipquad50606T5_1-2_04-0517.dat')
    if(is5t5.eq.0) then
       open(unit=8,file='dnhexra6T5_04-0816.dat')
    else
       open(unit=8,file='dnhexra5n6T5_pnop_04-0816.dat')
    endif
    
    size = int(360.1/bw)
    allocate(dnhexra(size),dwra(size,7))
    do i=1,size
       read (8,*)dnhexra(i)
    enddo    

    nbin = 7
    d0 = -35.2*d2r
    do i=bine,nbin
       ! Calculates 1st and 2nd harmonics and relevant averages
       call rayleighcoeffs(i,a,b,aphi,bphi,nval,sumaN,1,utci,utcf,zmin,zmax,is5t5,0,bine)
       call funcavgs(i,avg,1,utci,utcf,zmin,zmax,is5t5,0,bine)
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
!       vardz=((dz**2*(1.-a3*a4)/(cos(d0)*avg(5)*a1**2))**2&
!            +(dz**2/(cos(d0)**2*avg(7)*a1)*(4*sin(d0)*avg(6)*(1.-a3*a4)&
!            /avg(5)/a1-8.*a3/3.))**2)*2./sumaN
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
       case (6)
          E=(Emin(6)+Emin(7))/2
       case (7)
          E=(Emin(7)+2.*Emin(7))/2
       end select

!!$       write(6,*)"======================================================"
!!$       write(iunit,*)a(1),b(1),a(2),b(2),sqrt(2./sumaN),nval
!!$       !			write(6,*)c,d,sqrt(2.*avg(10)/sumaN)
!!$       write(iunit,*)nvalNS(2),aNS(2),bNS(2),sqrt(2./sumaNNS(2)),rS&
!!$            ,phiS/d2r,prS
!!$       write(iunit,*)nvalNS(1),aNS(1),bNS(1),sqrt(2./sumaNNS(1)),rN&
!!$            ,phiN/d2r,prN
!!$       !			write(6,*)aphi(1),bphi(1),aphi(2),bphi(2),sqrt(2./sumaN)
!!$       !			write(4,*)E,rd,sgmrd,decd/d2r,sgmdec/d2r,rad/d2r,sgmra/d2r

       iunit = 6
       if(outfmt.eq.0) then
          write(iunit,*)E,dx,sgmdx,dy,sgmdx,dz,sgmdz,Qxx,sgmQxx,Qyy,sgmQxx,Qzz,sgmQzz,Qxy,sgmQxy&
               ,Qxz,sgmQxz,Qyz,sgmQxz
       else
!!$       iunit = 6
          write(iunit,*)"------------------------------------------"
          if(i.lt.7) then
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
    open(unit=10,file='dip080EW5n6T5_pnop_04-0517.dat')

    ! //// optional arguments
    utci = 0
    zmin = 0._pr
    is5t5 = 0
    if(present(utci_opt))utci = utci_opt
    if(present(zmin_opt))zmin = zmin_opt
    if(present(is5t5_opt))is5t5 = is5t5_opt

    
    nbin = 7
    
    do i=bine,nbin
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
          E=(Emin(4)+Emin(5))/2
       case (5)
          E=(Emin(5)+Emin(6))/2
       case (6)
          E=(Emin(6)+Emin(7))/2
       case (7)
          E=(Emin(7)+2.*Emin(7))/2
       end select
       !write(6,*)"-------------------------------------------------"
       !write(6,*)aew,bew,sigray,rtilde,prtilde,nval
       !write(6,*)E,dper,sgmdper,rad/d2r,sgmrad/d2r,prtilde&
        !    ,r99/promcosd,nval
       write(6,*)E,rray,sigma,rad/d2r,sgmrad/d2r,r99,nval,prtilde,dper,real(rp/promcosd),real(rm/promcosd)
       !			write(6,*) promsint
    enddo
    return
  END SUBROUTINE dipoleEW
!=============================================================================
! calculates amplitud and phase of modulation in solar or anti-sid frequency
!   iscor = 0  ------->  use raw energy
!     iscor != 0 ------->  use corrected energy
!     freq = 0 ------->  use solar freq, antisidereal freq otherwise
  SUBROUTINE dipoleSolar(iscor,freq,utci_opt,utcf,zmin_opt,zmax,is5t5_opt,iseff_opt,bine)
    USE globalvars
    USE dipcl
    IMPLICIT NONE
    INTEGER :: iscor,freq,utcf,bine
    REAL(pr) :: zmax
    INTEGER :: bin,binid,nval,UTC,utc0,unt,gps,t5,nh,i,ie,nbin
    INTEGER :: iw,ind,ftr,iunit,utci,is5t5,iseff
    REAL(pr) :: Dec,Ra,Eraw,Ecor,Theta,Phi,p,r,rav,r99r,Egeo,zmin
    REAL(pr) :: a,b,sumaN,hrs,peso,arg,rad,rtilde,prtilde,sigma,sgmra
    REAL(pr) :: E,energy,phitilt,sec,x,aP,arho,brho,pow,E05,eff,En
    REAL(pr) :: AugId,S1000_obs,Stot,raz,fas,sin2
    REAL(pr) :: dnhprhr(24,4),dnhexhr(24)
    REAL(pr) :: dnwhr(24,57),dnwshr(24,7)
    REAL(pr) :: kAlphaP(5), kAlphaRho(5),kBetaRho(5)
    REAL*8 :: rp,rm
    CHARACTER(30) :: dS1000_obs
    CHARACTER(200) :: command,hexfile

    !//// optional parameters
    INTEGER(pr),OPTIONAL :: utci_opt,is5t5_opt,iseff_opt
    REAL(pr),OPTIONAL :: zmin_opt
    utci = 0
    zmin = 0._pr
    is5t5 = 0
    iseff = 0
    if(present(utci_opt))utci = utci_opt
    if(present(zmin_opt))zmin = zmin_opt
    if(present(is5t5_opt))is5t5 = is5t5_opt
    if(present(iseff_opt))iseff = iseff_opt

    hexfile = '../datos_auger/utctprhdrc_010104_070518.dat'
    if(is5t5.eq.0) then
!       open(unit=11,file='dnhexhr6T5_04-17.dat')
       !       open(unit=18,file='dnhexasid6T5_04-17.dat')
       if(freq.eq.0) then
          write(command,*)"./dnhexv3.out ",trim(hexfile),2,1,utci,utcf
          call system(command)
          open(unit=11,file='dnhex.dat')
       else
          write(command,*)"./dnhexv3.out ",trim(hexfile),3,1,utci,utcf
          call system(command)
          open(unit=18,file='dnhex.dat')
       endif
    else
       !open(unit=11,file='dnhexhr5n6T5_pnop_04-17.dat')
       !open(unit=18,file='dnhexasid5n6T5_pnop_04-17.dat')
       if(freq.eq.0) then
          write(command,*)"./dnhexv3.out ",trim(hexfile),2,3,utci,utcf
          call system(command)
          open(unit=11,file='dnhex.dat')
       else
          write(command,*)"./dnhexv3.out ",trim(hexfile),3,3,utci,utcf
          call system(command)
          open(unit=18,file='dnhex.dat')
       endif
    endif
    !    open(unit=12,file='dip060SolnoCoreff_04-0517.dat')
!    open(unit=12,file='dip080Sol5n6T5_pnop_04-0517v2.dat')
!    open(unit=19,file='dip080Asid5n6T5_pnop_04-0517v2.dat')
    do i=1,24
       if(freq.eq.0) then
          read (11,*)dnhexhr(i)
       else
          read (18,*)dnhexhr(i)
       end if
    enddo

    t5 = 0
    phitilt = -30.*d2r
    utc0 = 1072915200
    nbin = 7
    binid = 0
    fas = 1.0_pr
    if(freq.ne.0)fas=364.25/365.25         !  antisid/solar
    
    DO bin=bine,nbin
       nval=0
       a = 0.
       b = 0.
       sumaN = 0.
       rewind(unit=2)
       read(2,*)
!!$ 40		read (unt,*,end=41)Dec,Ra,Ecor,UTC,Theta,Phi,t5
!!$c 40		read (unt,*,end=41)Dec,Ra,Eraw,Ecor,UTC,Theta,Phi,p,r,rav,t5
!!$c 40		read (unt,*,end=41)ID,Theta,Phi,gps,rawe,energy
!!$c 40      read (unt,*,end=41)Dec,Ra,Ecor,i,UTC,Theta,Phi
40     if(iseff.eq.0.and.bine.eq.6) then         
          read (2,*,end=41)AugId,Dec,Ra,Ecor,UTC,Theta,Phi,t5,ftr
       else
          read (2,*,end=41)AugId,UTC,Phi,Theta,Dec,Ra,Ecor,p,r,rav,iw
       endif
       !  40	read (unt,*,end=41)AugId,Dec,Ra,Egeo,Ecor,UTC,Theta,Phi,t5,ftr
!40     read (2,*,end=41)AugId,UTC,Phi,Theta,Dec,Ra,raz,S1000_obs&
!            ,dS1000_obs,Stot,Eraw,Ecor,p,r,rav,iw,t5,ftr
       !  UTC=gps + 315964800

       if(UTC.lt.utci.or.UTC.gt.utcf)goto 40 
       if(Theta.lt.zmin.or.Theta.gt.zmax)goto 40 
       if(is5t5.eq.0.and.t5.eq.5)goto 40 
       
       energy = Ecor
       if(iscor.eq.0)energy = Eraw

       binid = 0
       
       if(energy.ge.Emin(1).and.energy.lt.Emin(2))binid=1
       if(energy.ge.Emin(2).and.energy.lt.Emin(3))binid=2
       if(energy.ge.Emin(3).and.energy.lt.Emin(4))binid=3
       if(energy.ge.Emin(4).and.energy.lt.Emin(5))binid=4
       if(energy.ge.Emin(5).and.energy.lt.Emin(6))binid=5
       if(energy.ge.Emin(6).and.energy.lt.Emin(7))binid=6
       if(energy.ge.Emin(7))binid=7
       !----- calculates the hour of the day
       !			hrs=dfloat(UTC-utc0)/3600.0
       !			nh=mod(int((hrs+21.)/fas),24)+1
       hrs=(float(UTC-utc0)/3600.0 + 21.)*fas
       nh=mod(int(hrs),24)+1
       
       if (binid.eq.bin) then ! only includes data on the current bin
          if(iseff.eq.1) then
             !sec = 1./cos(Theta*d2r)         
             !========== wc from all E ====================================================
             !            aP=0.00024-0.0057*(sec-1.)+0.0030*(sec-1.)**2
             !            arho=-1.2+1.1*(sec-1.)-0.12*(sec-1.)**2
             !            brho=-0.29+0.077*(sec-1.)+0.23*(sec-1.)**2
             !------- last results obtained for the paper JINST 17--------------------------
             !aP=0.00011-0.006*(sec-1.)+0.003*(sec-1.)**2
             !arho=-1.10+1.0*(sec-1.)-0.06*(sec-1.)**2
             !brho=-0.31+0.2*(sec-1.)+0.13*(sec-1.)**2
             !========== wc from E > 1 EeV ================================================
             !            aP=-0.00007-0.008*(sec-1.)+0.006*(sec-1.)**2
             !            arho=-1.21+1.8*(sec-1.)-0.6*(sec-1.)**2
             !            brho=-0.45+0.7*(sec-1.)-0.4*(sec-1.)**2
             !------- last results obtained for the paper--------------------------
             !            aP=0.00008-0.008*(sec-1.)+0.007*(sec-1.)**2
             !            arho=-1.22+1.7*(sec-1.)-0.7*(sec-1.)**2
             !            brho=-0.43+0.8*(sec-1.)-0.4*(sec-1.)**2

             sin2 = sin(Theta*d2r)*sin(Theta*d2r)
             aP=0.0009-0.011*sin2+0.011*(sin2)**2
             arho=-1.15+0.6*sin2+0.9*(sin2)**2
             brho=-0.42+0.5*sin2-0.001*(sin2)**2
             if(arho.gt.0.)arho = 0.
             if(brho.gt.0.)brho = 0.

             !=========== wc from paper: Astro phys 32 (2009) =============================
             !            kAlphaP = (/-0.00044,-0.0016,-0.0023,-0.0019,-0.0028/)
             !            kAlphaRho = (/-0.97,-0.72,-0.54,-0.40,-0.15/)
             !            kBetaRho = (/-0.26,-0.22,-0.20,-0.043,-0.023/)
             !            ind = int((sec-1)/0.2)+1
             !            aP = kAlphaP(ind)
             !            arho = kAlphaRho(ind)
             !            brho = kBetaRho(ind)

             ! ///////////////// efficiency calculation ///////////////////
             !x = (sin(Theta*d2r))**2
!!$          pow = 5.2*x**2 - 0.6*x + 2.79
!!$          E05 = 4.5*x**3 - 2.2*x**2 - 0.4*x + 0.98

             !//////// Conventional triggers //////////////////////////////         
             pow = 4.9*(sin2)**2 - 2.0*sin2 + 3.5
             E05 = 4.1*(sin2)**3 - 2.0*(sin2)**2 - 0.2*sin2 + 0.86

             !///////// All triggers (TOT-TOTd-MOPS)///////////////////////         
             !pow = 0.6*(sin2)**2 + 0.5*sin2 + 3.5
             !E05 = 5.0*(sin2)**3 - 3.0*(sin2)**2 + 0.5*sin2 + 0.37
             
             En=energy

             !				if(En**pow/(En**pow+E05**pow).lt.0.2)goto 40
             eff=1+Bb*(aP*(p-P0)+arho*(rav-rho0)+brho*(r-rav))&
                  *pow*E05**pow/(En**pow+E05**pow)
             !				eff=dnhprhr(nh,1)+Bb*(aP*dnhprhr(nh,2)+arho*dnhprhr(nh,3)+brho*
             !     &	dnhprhr(nh,4))*pow*E05**pow/((En**pow+E05**pow))

             !		      peso = 1./eff
             !				ie = int((log10(energy)+2.)/(1./15))+1
             !				peso = 1./dnwhr(nh,ie)
             !				peso = 1./dnwshr(nh,bin)
             peso = 1./(dnhexhr(nh)*eff)
          else
             peso = 1./dnhexhr(nh)
          endif
          !     &/(1.+0.003*tan(Theta*d2r)*cos(Phi*d2r-phitilt))
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
          E=(Emin(4)+Emin(5))/2
       case (5)
          E=(Emin(5)+Emin(6))/2
       case (6)
          E=(Emin(6)+Emin(7))/2
       case (7)
          E=(Emin(7)+2*Emin(7))/2
       end select
 !=======  write data ====================================================
       if(freq.eq.0) then
!         write(12,*)E,a,b,sigma,rtilde,prtilde,rad/d2r,sgmra/d2r,r99r,nval
          write(6,*)E,a,b,sigma,rtilde,real(rp),real(rm),prtilde,rad/d2r,sgmra/d2r,r99r,nval
!!$          iunit = 6
!!$          write(iunit,*)"------------------------------------------"
!!$
!!$          if(bin.lt.7) then
!!$             write(iunit,'(a,F4.1,a,F4.1,a)')' E      = [',Emin(bin),'-',Emin(bin+1),']'
!!$          else
!!$             write(iunit,'(a,F4.1)')' E      > ',Emin(bin)
!!$          endif
!!$          write(iunit,*)'N      =',nval
!!$          write(iunit,*)'a1     =',a
!!$          write(iunit,*)'b1     =',b
!!$          write(iunit,*)'sgm    =',sigma
!!$          write(iunit,*)'r1     =',real(rtilde),'+',real(rp),'-',real(rm)
!!$          write(iunit,*)'p(>r1) =',prtilde
!!$          write(iunit,*)'r99    =',r99r
!!$          write(iunit,*)'phi     =',rad/d2r,'+/-',sgmra/d2r
       else
!          write(19,*)E,a,b,sigma,rtilde,prtilde,rad/d2r,sgmra/d2r,r99r,nval
          write(6,*)E,a,b,sigma,rtilde,real(rp),real(rm),prtilde,rad/d2r,sgmra/d2r,r99r,nval
!!$          iunit = 6
!!$          write(iunit,*)"------------------------------------------"
!!$
!!$          if(bin.lt.7) then
!!$             write(iunit,'(a,F4.1,a,F4.1,a)')' E      = [',Emin(bin),'-',Emin(bin+1),']'
!!$          else
!!$             write(iunit,'(a,F4.1)')' E      > ',Emin(bin)
!!$          endif
!!$          write(iunit,*)'N      =',nval
!!$          write(iunit,*)'a1     =',a
!!$          write(iunit,*)'b1     =',b
!!$          write(iunit,*)'sgm    =',sigma
!!$          write(iunit,*)'r1     =',real(rtilde),'+',real(rp),'-',real(rm)
!!$          write(iunit,*)'p(>r1) =',prtilde
!!$          write(iunit,*)'r99    =',r99r
!!$          write(iunit,*)'phi     =',rad/d2r,'+/-',sgmra/d2r
       end if
    ENDDO
    return
  END SUBROUTINE dipoleSolar
!---------------------------------------------------------------------
!!$	This routine computes the nth stage of refinement of an extended trapezoidal rule. func is
!!$	input as the name of the function to be integrated between limits a and b, also input. When
!!$	called with n=1, the routine returns as s the crudest estimate of a f (x)dx. Subsequent
!!$	calls with n=2,3,... (in that sequential order) will improve the accuracy of s by adding 2n-2
!!$	additional interior points. s should not be modified between sequential calls.
  SUBROUTINE trapzd(func,a,b,s,n)
    USE globalvars
    INTEGER :: n
    REAL(pr) :: a,b,s
    INTERFACE
       FUNCTION func(x)
         import :: pr
         REAL(pr) :: x
         REAL(pr) :: func
       END FUNCTION func
    END INTERFACE
    INTEGER it,j
    REAL del,sum,tnm,x
    if (n.eq.1) then
       s = 0.5*(b-a)*(func(a) + func(b))
    else
       it = 2**(n-2)
       tnm = it
       del = (b-a)/tnm	! This is the spacing of the points to be added.
       x = a + 0.5*del
       sum = 0.
       do j=1,it
          sum = sum + func(x)
          x = x + del
       enddo
       s = 0.5*(s+(b-a)*sum/tnm)	! This replaces s by its refined value.
    endif
    return
  END SUBROUTINE trapzd
!-------------------------------------------------------------------
!	USES trapzd
! 	Returns as s the integral of the function func from a to b. The parameters EPS can be set
! 	to the desired fractional accuracy and JMAX so that 2 to the power JMAX-1 is the maximum
! 	allowed number of steps. Integration is performed by Simpson’s rule.
  SUBROUTINE qsimp(func,a,b,s)
    USE globalvars
    INTEGER :: JMAX
    REAL(pr) :: a,b,s,EPS
    INTERFACE
       FUNCTION func(x)
         import :: pr
         REAL(pr) :: x
         REAL(pr) :: func
       END FUNCTION func
    END INTERFACE
    PARAMETER (EPS=1.e-6, JMAX=20)
    INTEGER :: j
    REAL(pr) :: os,ost,st
    ost = -1.e30
    os = -1.e30
    do j=1,JMAX
       call trapzd(func,a,b,st,j)
       s = (4.*st - ost)/3.
       if (j.gt.5) then
          if (abs(s-os).lt.EPS*abs(os).or.&
               (s.eq.0..and.os.eq.0.)) return
       endif
       os = s
       ost = st
    enddo
!pause ’too many steps in qsimp’
  END SUBROUTINE qsimp

!!$		FUNCTION exposure(Dec)
!!$			real Dec,xi
!!$			common/com/pi,d2r
!!$			thetaM = 55.
!!$			a0 =-35.2
!!$			xi = 	(cos(thetaM*d2r) - sin(a0*d2r)*sin(Dec))/cos(Dec)
!!$    &		/cos(a0*d2r)
!!$			if(xi.gt.1.)then 
!!$				am = 0.
!!$			elseif(xi.lt.-1.) then
!!$				am = pi
!!$			else
!!$				am = acos(xi)
!!$			endif
!!$
!!$			exposure = (cos(a0*d2r)*cos(Dec)*sin(am)+am*sin(a0*d2r)
!!$     &			*sin(Dec))/(-pi*sin(a0*d2r))
!!$		return
!!$		END
!-----------------------------------------------------------------
  FUNCTION exposure(Dec)
    USE globalvars
    REAL(pr) :: Dec,xi1,xi2
    thetaM1 = 0.
    thetaM2 = 60.
    a0 =-35.2
    xi1 = (cos(thetaM1*d2r) - sin(a0*d2r)*sin(Dec))/cos(Dec)&
     		/cos(a0*d2r)
    if(xi1.gt.1.)then 
       am1 = 0.
    elseif(xi1.lt.-1.) then
       am1 = pi
    else
       am1 = acos(xi1)
    endif

    xi2 = (cos(thetaM2*d2r) - sin(a0*d2r)*sin(Dec))/cos(Dec)&
     		/cos(a0*d2r)
    if(xi2.gt.1.)then 
       am2 = 0.
    elseif(xi2.lt.-1.) then
       am2 = pi
    else
       am2 = acos(xi2)
    endif

    exposure = (cos(a0*d2r)*cos(Dec)*(sin(am2)-sin(am1))+&
         (am2-am1)*sin(a0*d2r)*sin(Dec))/(-pi*sin(a0*d2r))
    return
  END FUNCTION exposure

  FUNCTION K0000(Dec)
    USE globalvars
    REAL(pr) :: Dec
    REAL(pr) :: K0000
    K0000 = cos(Dec)*exposure(Dec)
    return
  END FUNCTION K0000

  FUNCTION K1000(Dec)
    USE globalvars
    REAL(pr) :: Dec
    REAL(pr) :: K1000
    K1000 = cos(Dec)*sin(Dec)*exposure(Dec)
    return
  END FUNCTION K1000

  FUNCTION K1m11m1(Dec)
    USE globalvars
    REAL(pr) :: Dec
    REAL(pr) :: K1m11m1
    K1m11m1 = (cos(Dec))**3*exposure(Dec)
    return
  END FUNCTION K1m11m1

  FUNCTION K1010(Dec)
    USE globalvars
    REAL(pr) :: Dec
    REAL(pr) :: K1010
    K1010 = cos(Dec)*sin(Dec)**2*exposure(Dec)
    return
  END FUNCTION K1010

  FUNCTION K2111(Dec)
    USE globalvars
    REAL(pr) :: Dec
    REAL(pr) :: K2111
    K2111 = sin(Dec)*cos(Dec)**3*exposure(Dec)
    return
  END FUNCTION K2111

  FUNCTION K2m22m2(Dec)
    USE globalvars
    REAL(pr) :: Dec
    REAL(pr) :: K2m22m2
    K2m22m2 = cos(Dec)**5*exposure(Dec)
    return
  END FUNCTION K2m22m2

  FUNCTION K2m12m1(Dec)
    USE globalvars
    REAL(pr) :: Dec
    REAL(pr) :: K2m12m1
    K2m12m1 = sin(Dec)**2*cos(Dec)**3*exposure(Dec)
    return
  END FUNCTION K2m12m1

  FUNCTION K2020(Dec)
    USE globalvars
    REAL(pr) :: Dec
    REAL(pr) :: K2020
    K2020 = cos(Dec)*(3*sin(Dec)**2-1)**2*exposure(Dec)
    return
  END FUNCTION K2020

  FUNCTION K2010(Dec)
    USE globalvars
    REAL(pr) :: Dec
    REAL(pr) :: K2010
    K2010 = cos(Dec)*sin(Dec)**3*exposure(Dec)
    return
  END FUNCTION K2010
!-------------------------------------------------------------
  SUBROUTINE inverseMatrix(A,N,Ainv)
    USE globalvars
    INTEGER :: i,j, LWORK
    INTEGER	INFO,LDA,M,N
    INTEGER, DIMENSION(N) :: IPIV
    REAL(pr), DIMENSION(N,N) :: A, Ainv
    REAL(pr), DIMENSION(N*N) :: WORK

    !	Calculate the inverse of the matrix A using the external library LAPACK

    external SGETRF
    external SGETRI

    LDA = N
    LWORK = N*N

    !     DGETRF computes an LU factorization of a general M-by-N matrix A
    !     using partial pivoting with row interchanges.

    M = N
    LDA = N

    !  Store A in Ainv to prevent it from being overwritten by LAPACK

    Ainv = A

    CALL SGETRF( M, N, Ainv, LDA, IPIV, INFO )

    PRINT '(" ")'
    IF(INFO.EQ.0)THEN
       PRINT '(" LU decomposition successful ")'
    ENDIF
    IF(INFO.LT.0)THEN
       PRINT '(" LU decomposition:  illegal value ")'
       STOP
    ENDIF
    IF(INFO.GT.0)THEN
       WRITE(*,35)INFO,INFO
35     FORMAT( 'LU decomposition: U(',I4,',',I4,') = 0 ')
    ENDIF

    !  DGETRI computes the inverse of a matrix using the LU factorization
    !  computed by DGETRF.
    CALL SGETRI(N, Ainv, N, IPIV, WORK, LWORK, INFO)

    PRINT '(" ")'
    IF (info.NE.0) THEN
       stop 'Matrix inversion failed!'
    ELSE
       PRINT '(" Inverse Successful ")'
    ENDIF

    RETURN
  END SUBROUTINE inverseMatrix
!---------------------------------------------------------------
  SUBROUTINE almbarcoeffs(almbar,blmbar,K,bin,n)
    USE globalvars
    INTEGER :: bin,n,status,binid,UTC
    REAL(pr),DIMENSION(n,n) :: K
    REAL(pr),DIMENSION(n) :: almbar,blmbar
    REAL(pr) :: Dec,Ra,Ra0,energy,DeltaNHexaAtRa,a,b,promdec,sumaN
    REAL(pr) :: aphi,bphi,promzen,peso,sump
    !	Computes the estimated harmonic harmonic coefficients	for a energy bin
    iutcref = 1104537600   !1/1/2005
    phitilt = -30.*d2r
    blmbar = 0.
    almbar = 0.
    rewind(unit=2)
    read (2,*)
!20  read (2, *,end=10)Dec,Ra,energy,binid,UTC,Theta,Phi!,DeltaNHexaAtRa
20  read (2, *,end=10)AugId,Dec,Ra,Ecor,UTC,Theta,Phi,t5,ftr
    !     calculates the right ascension of zenith
    !		if(UTC.lt.1325376000)goto 20   ! 1388534400 1356998400 1325376000
    if(UTC.gt.1472688000.or.Theta.gt.60.)goto 20
    raz=float(UTC-iutcref)/239.345+31.4971
    raz=mod(raz,360.)
    if(raz.lt.0.0)raz=raz+360.
    ira=int(raz/bw)+1
    energy = Ecor
    if(iscor.eq.0) energy = Eraw
    binid = 0

    if(energy.ge.Emin(1).and.energy.lt.Emin(2))binid=1
    if(energy.ge.Emin(2).and.energy.lt.Emin(3))binid=2
    if(energy.ge.Emin(3).and.energy.lt.Emin(4))binid=3
    if(energy.ge.Emin(4).and.energy.lt.Emin(5))binid=4
    if(energy.ge.Emin(5).and.energy.lt.Emin(6))binid=5
    if(energy.ge.Emin(6).and.energy.lt.Emin(7))binid=6
    if(energy.ge.Emin(7))binid=7
    
    if (binid.eq.bin) then    ! only includes data on the current bin
       peso = 1./dnhexra(ira)/(1.+0.003*tan(Theta*d2r)*cos(Phi*d2r-phitilt))
       !b00
       blmbar(1) = blmbar(1) + peso
       !b1-1
       blmbar(2) = blmbar(2) + sqrt(3.)*cos(Dec*d2r)*sin(Ra*d2r)*peso
       !b10
       blmbar(3) = blmbar(3) + sqrt(3.)*sin(Dec*d2r)*peso
       !b11
       blmbar(4) = blmbar(4) + sqrt(3.)*cos(Dec*d2r)*cos(Ra*d2r)*peso
       if(n==4) goto 20 !if only dipole is being calculated
       !b2-2
       blmbar(5) = blmbar(5) + sqrt(15.)*cos(Dec*d2r)**2 &
     			*cos(Ra*d2r)*sin(Ra*d2r)*peso
       !b2-1
       blmbar(6) = blmbar(6) + sqrt(15.)*cos(Dec*d2r) &
     			*sin(Dec*d2r)*sin(Ra*d2r)*peso
       !b20
       blmbar(7) = blmbar(7) + sqrt(5.)/2*(2*sin(Dec*d2r)**2 &
     			-cos(Dec*d2r)**2)*peso
       !b21
       blmbar(8) = blmbar(8) + sqrt(15.)*cos(Dec*d2r) &
     			*sin(Dec*d2r)*cos(Ra*d2r)*peso
       !b22
       blmbar(9) = blmbar(9) + sqrt(15.)/2*cos(Dec*d2r)**2&
     			*(cos(Ra*d2r)**2-sin(Ra*d2r)**2)*peso
    end if
    goto 20
10  continue		
    do i=1,n
       do j=1,n
          almbar(i) = almbar(i) + K(i,j)*blmbar(j)
       enddo
    enddo
    return
  END SUBROUTINE almbarcoeffs
!=======================================================================
!	Computes the estimated harmonic coefficients	for an energy bin
!     iscor = 0 --------> use raw energy
!     iscor != 0 -------> use corrected energy
  SUBROUTINE rayleighcoeffs(bin,a,b,aphi,bphi,nval,sumaN,iscor,utci,utcf,zmin,zmax,is5t5,iseff,bine)
    USE globalvars
    INTEGER :: is5t5,iseff,utci,utcf,bine
    REAL(pr) :: zmin,zmax
    INTEGER :: bin,binid,nval,UTC,t5,iscor,ftr,wflag,date(9)
    INTEGER*8 :: AugId
    REAL(pr) :: Dec,Ra,Ra0,energy,DeltaNHexaAtRa,Theta,Phi,Ecor,Eraw
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
!c  40	read (2,*,end=41)Dec,Ra,Ecor,UTC,Theta,Phi,t5
!c 40	read (2,*,end=41)Dec,Ra,Eraw,Ecor,UTC,Theta,Phi,p,r,rav,t5
!c 40	read (2,*,end=41)Dec,Ra,Eraw,Ecor,UTC,Theta,Phi,p,r,rav,iw,t5
    !c 40	read (2,*,end=41)Dec,Ra,Ecor,i,UTC,Theta,Phi
    
40     if(iseff.eq.0.and.bine.eq.6.or.bine.eq.4) then         
          read (2,*,end=41)AugId,Dec,Ra,Ecor,UTC,Theta,Phi,t5,ftr
       else
          read (2,*,end=41)AugId,UTC,Phi,Theta,Dec,Ra,Ecor,p,r,rav,iw
       endif
!40  read (2,*,end=41)AugId,UTC,Phi,Theta,Dec,Ra,Ecor,p,r,rav,iw,t5,ftr
! 40   read (2,*,end=41)AugId,Dec,Ra,Ecor,Egeo,UTC,Theta,Phi,t5,ftr
! 40	read (2,*,end=41)AugId,Dec,Ra,Ecor,UTC,Theta,Phi,t5      
!40  read (2,*,end=41)AugId,UTC,Phi,Theta,Dec,Ra,raz,S1000_obs,dS1000_obs&
    !         ,Stot,Eraw,Ecor,p,r,rav,iw,t5,ftr
    
    
    !		if(iw.eq.4)goto 40
    if(UTC.lt.utci.or.UTC.gt.utcf)goto 40 
    if(Theta.le.zmin.or.Theta.gt.zmax)goto 40 
    if(is5t5.eq.0.and.t5.eq.5)goto 40
    
    energy = Ecor!Eraw
    if(iscor.eq.0) energy = Eraw
    
    binid = 0

    if(energy.ge.Emin(1).and.energy.lt.Emin(2))binid=1
    if(energy.ge.Emin(2).and.energy.lt.Emin(3))binid=2
    if(energy.ge.Emin(3).and.energy.lt.Emin(4))binid=3
    if(energy.ge.Emin(4).and.energy.lt.Emin(5))binid=4
    if(energy.ge.Emin(5).and.energy.lt.Emin(6))binid=5
    if(energy.ge.Emin(6).and.energy.lt.Emin(7))binid=6
    if(energy.ge.Emin(7))binid=7

    !/////////// select winter or summer ///////////////////////////
!!$    call gmtime(UTC,date)
!!$    mon = date(5)  		! month of the UTC (0-11)
!!$    day = date(4)			! day of the UTC	(1-31)
!!$    ! summer (21 sept to 21 march)
!!$    if(mon.lt.2.or.mon.gt.8) wflag=0
!!$    if(mon.eq.2.and.day.lt.21) wflag=0
!!$    if(mon.eq.8.and.day.ge.21) wflag=0
!!$    ! winter (21 march to 21 sept)
!!$    if(mon.gt.2.and.mon.lt.8) wflag=1
!!$    if(mon.eq.2.and.day.ge.21) wflag=1
!!$    if(mon.eq.8.and.day.lt.21) wflag=1
    
    if (binid.eq.bin) then    ! only includes data on the current bin
!    if (binid.eq.bin.and.wflag.eq.1) then
       
       !///////////// calculates the right ascension of zenith//////////////
       raz=float(UTC-iutcref)/239.345+31.4971
       raz=mod(raz,360.)
       if(raz.lt.0.0)raz=raz+360.
       ira=int(raz/bw)+1
       
       if(iseff.eq.1) then
          !//////////////// weather coeffs ////////////////////////////////////////

!!$       sec = 1./cos(Theta*d2r)
!!$       aP=0.00024-0.0057*(sec-1.)+0.0030*(sec-1.)**2
!!$       arho=-1.2+1.1*(sec-1.)-0.12*(sec-1.)**2
!!$       brho=-0.29+0.077*(sec-1.)+0.23*(sec-1.)**2

          !------ for main array > 1 EeV
          !		aP=-0.00007-0.008*(sec-1.)+0.006*(sec-1.)**2
          !      arho=-1.21+1.8*(sec-1.)-0.6*(sec-1.)**2
          !		brho=-0.45+0.7*(sec-1.)-0.4*(sec-1.)**2

          sin2 = sin(Theta*d2r)*sin(Theta*d2r)
          aP=0.0009-0.011*sin2+0.011*(sin2)**2
          arho=-1.15+0.6*sin2+0.9*(sin2)**2
          brho=-0.42+0.5*sin2-0.001*(sin2)**2
          if(arho.gt.0.)arho = 0.
          if(brho.gt.0.)brho = 0.

          !////////////// efficiency calculation //////////////////////////////////

!!$       x = (sin(Theta*d2r))**2
!!$       pow = 5.2*x**2 - 0.6*x + 2.79
!!$       E05 = 4.5*x**3 - 2.2*x**2 - 0.4*x + 0.98      
          pow = 4.9*(sin2)**2 - 2.0*sin2 + 3.5
          E05 = 4.1*(sin2)**3 - 2.0*(sin2)**2 - 0.2*sin2 + 0.86

          En=energy
          !			if(En**pow/(En**pow+E05**pow).lt.0.2)goto 40
          eff=1+Bb*(aP*(p-P0)+arho*(rav-rho0)+brho*(r-rav))&
               *pow*E05**pow/(En**pow+E05**pow)

          peso = 1./(dnhexra(ira)*eff)
          !	peso = 1./dwra(ira,binid)
       else
          if(bine.eq.6.or.bine.eq.4) then
             peso = 1./dnhexra(ira)&
                  /(1.+0.003*tan(Theta*d2r)*cos(Phi*d2r-phitilt))
          else
             peso = 1./dnhexra(ira)
          endif
       endif
       if(iscor.eq.0) peso = 1.
              
       nval = nval + 1
       sumaN = sumaN + peso
       a(1) = a(1) + cos(Ra*d2r)*peso
       b(1) = b(1) + sin(Ra*d2r)*peso
       a(2) = a(2) + cos(2*Ra*d2r)*peso
       b(2) = b(2) + sin(2*Ra*d2r)*peso
       
!!$       a(3) = a(3) + cos(3*Ra*d2r)*peso
!!$       b(3) = b(3) + sin(3*Ra*d2r)*peso
!!$       a(4) = a(4) + cos(4*Ra*d2r)*peso
!!$       b(4) = b(4) + sin(4*Ra*d2r)*peso
       
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

!!$    a(3) = 2.*a(3)/sumaN
!!$    a(4) = 2.*a(4)/sumaN
!!$    b(3) = 2.*b(3)/sumaN
!!$    b(4) = 2.*b(4)/sumaN
    
    aphi(1) = 2.*aphi(1)/sumaN
    aphi(2) = 2.*aphi(2)/sumaN
    bphi(1) = 2.*bphi(1)/sumaN
    bphi(2) = 2.*bphi(2)/sumaN
    return
  END SUBROUTINE rayleighcoeffs
!------------------------------------------------------------------
!	Computes the estimated first harmonic coefficients	for an energy bin 
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
!40  read (2,*,end=41)Dec,Ra,energy,binid,UTC,Theta,Phi!,DeltaNHexaAtRa
40  if(bine.eq.6) then         
       read (2,*,end=41)AugId,Dec,Ra,Ecor,UTC,Theta,Phi,t5,ftr
    else
       read (2,*,end=41)AugId,UTC,Phi,Theta,Dec,Ra,Ecor,p,r,rav,iw
    endif

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
    if(energy.ge.Emin(1).and.energy.lt.Emin(2))binid=1
    if(energy.ge.Emin(2).and.energy.lt.Emin(3))binid=2
    if(energy.ge.Emin(3).and.energy.lt.Emin(4))binid=3
    if(energy.ge.Emin(4).and.energy.lt.Emin(5))binid=4
    if(energy.ge.Emin(5).and.energy.lt.Emin(6))binid=5
    if(energy.ge.Emin(6).and.energy.lt.Emin(7))binid=6
    if(energy.ge.Emin(7))binid=7
    
    if (binid.eq.bin) then    ! only includes data on the current bin
       !//////////////// weather coeffs ////////////////////////////////////////
       !------ for main array > 1 EeV       
       sin2 = sin(Theta*d2r)*sin(Theta*d2r)
       aP=0.0009-0.011*sin2+0.011*(sin2)**2
       arho=-1.15+0.6*sin2+0.9*(sin2)**2
       brho=-0.42+0.5*sin2-0.001*(sin2)**2
       if(arho.gt.0.)arho = 0.
       if(brho.gt.0.)brho = 0.
       
       !////////////// efficiency calculation //////////////////////////////////
       pow = 3.8*(sin2)**2 - 1.2*sin2 + 3.3
       E05 = 4.3*(sin2)**3 - 2.2*(sin2)**2 - 0.2*sin2 + 0.88
       En=energy
       eff=1+Bb*(aP*(p-P0)+arho*(rav-rho0)+brho*(r-rav))&
            *pow*E05**pow/(En**pow+E05**pow)
       
!       peso = 1./(dnhexra(ira)*eff)&
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

!----------------------------------------------------------------
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
    !40	read (2,*,end=41)Dec,Ra,energy,binid,UTC
    !     &		,Theta,Phi!,t5
    !40	read (2,*,end=41)Dec,Ra,Eraw,Ecor,UTC,Theta,Phi,p,r,rav,t5
    !40  read (2,*,end=41)AugId,UTC,Phi,Theta,Dec,Ra,raz,S1000_obs &
    !     ,dS1000_obs,Stot,Eraw,Ecor,p,r,rav,iw,t5

40  if(bine.eq.6.or.bine.eq.4) then         
       read (2,*,end=41)AugId,Dec,Ra,Ecor,UTC,Theta,Phi,t5,ftr
    else
       read (2,*,end=41)AugId,UTC,Phi,Theta,Dec,Ra,Ecor,p,r,rav,iw
    endif
    
    if(UTC.lt.utci.or.UTC.gt.utcf)goto 40 
    if(Theta.lt.zmin.or.Theta.gt.zmax)goto 40 
    if(is5t5.eq.0.and.t5.eq.5)goto 40 

    !energy=Eraw
    energy=Ecor
    binid=0
    if(energy.ge.Emin(1).and.energy.lt.Emin(2))binid=1
    if(energy.ge.Emin(2).and.energy.lt.Emin(3))binid=2
    if(energy.ge.Emin(3).and.energy.lt.Emin(4))binid=3
    if(energy.ge.Emin(4).and.energy.lt.Emin(5))binid=4
    if(energy.ge.Emin(5).and.energy.lt.Emin(6))binid=5
    if(energy.ge.Emin(6).and.energy.lt.Emin(7))binid=6
    if(energy.ge.Emin(7))binid=7
    
    if (binid.eq.bin) then    ! only includes data on the current bin
       nval = nval + 1
       raz=float(UTC-iutcref)/239.345+31.4971
       raz=mod(raz,360.)
       if(raz.lt.0.0)raz=raz+360.
       hrs=float(UTC-utc0)/3600.0
       arg=(hrs+21.)/24.0*2.0*pi
       !c  using phi to define E,W
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
    !c		write(6,*)ne,nw
    return
  END SUBROUTINE East_West
!-------------------------------------------------------------
! Calculates some averages of the declination and zenith angles
  SUBROUTINE funcavgs(bin,avg,iscor,utci,utcf,zmin,zmax,is5t5,iseff,bine)
    USE globalvars
    INTEGER :: is5t5,iseff,utci,utcf,bine
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
    !c  50	read (2,*,end=51)Dec,Ra,Ecor,UTC,Theta,Phi,t5
    !c 50	read (2,*,end=51)Dec,Ra,Eraw,Ecor,UTC,Theta,Phi,p,r,rav,t5
    !c 50   read (2,*,end=51)Dec,Ra,Eraw,Ecor,UTC,Theta,Phi,p,r,rav,iw,t5
   !c 50   read (2,*,end=51)Dec,Ra,Ecor,i,UTC,Theta,Phi
!50  read (2,*,end=51)AugId,UTC,Phi,Theta,Dec,Ra,Ecor,p,r,rav,iw
!50  read (2,*,end=51)AugId,UTC,Phi,Theta,Dec,Ra,Ecor,p,r,rav,iw,t5,ftr
50  if(iseff.eq.0.and.bine.eq.6.or.bine.eq.4) then         
       read (2,*,end=51)AugId,Dec,Ra,Ecor,UTC,Theta,Phi,t5,ftr
    else
       read (2,*,end=51)AugId,UTC,Phi,Theta,Dec,Ra,Ecor,p,r,rav,iw
    endif
! 50     read (2,*,end=51)AugId,Dec,Ra,Ecor,Egeo,UTC,Theta,Phi,t5,ftr
! 50   read (2,*,end=51)AugId,UTC,Phi,Theta,Dec,Ra,raz,S1000_obs,dS1000_obs
    !     &      ,Stot,Eraw,Ecor,p,r,rav,iw,t5
    
    if(UTC.lt.utci.or.UTC.gt.utcf)goto 50 
    if(Theta.lt.zmin.or.Theta.gt.zmax)goto 50 
    if(is5t5.eq.0.and.t5.eq.5)goto 50
    !		if(iw.eq.4)goto 50
    

    energy = Ecor
    if(iscor.eq.0) energy = Eraw
    binid = 0

    if(energy.ge.Emin(1).and.energy.lt.Emin(2))binid=1
    if(energy.ge.Emin(2).and.energy.lt.Emin(3))binid=2
    if(energy.ge.Emin(3).and.energy.lt.Emin(4))binid=3
    if(energy.ge.Emin(4).and.energy.lt.Emin(5))binid=4
    if(energy.ge.Emin(5).and.energy.lt.Emin(6))binid=5
    if(energy.ge.Emin(6).and.energy.lt.Emin(7))binid=6
    if(energy.ge.Emin(7))binid=7
    
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
!-----------------------------------------------------------
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
!50  read (2,*,end=51)Dec,Ra,energy,binid,UTC,Theta,Phi
50  if(bine.eq.6) then
       read (2,*,end=51)AugId,Dec,Ra,Ecor,UTC,Theta,Phi,t5,ftr
    else
       read (2,*,end=51)AugId,UTC,Phi,Theta,Dec,Ra,Ecor,p,r,rav,iw
    endif
    
    if(UTC.lt.utci.or.UTC.gt.utcf)goto 50 
    if(Theta.lt.zmin.or.Theta.gt.zmax)goto 50 
    if(is5t5.eq.0.and.t5.eq.5)goto 50
    
    energy = Ecor
!    if(iscor.eq.0) energy = Eraw
    
    binid = 0
    if(energy.ge.Emin(1).and.energy.lt.Emin(2))binid=1
    if(energy.ge.Emin(2).and.energy.lt.Emin(3))binid=2
    if(energy.ge.Emin(3).and.energy.lt.Emin(4))binid=3
    if(energy.ge.Emin(4).and.energy.lt.Emin(5))binid=4
    if(energy.ge.Emin(5).and.energy.lt.Emin(6))binid=5
    if(energy.ge.Emin(6).and.energy.lt.Emin(7))binid=6
    if(energy.ge.Emin(7))binid=7
    
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
!-------------------------------------------------------------
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
