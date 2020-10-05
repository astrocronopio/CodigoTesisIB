/*! calculates the dipole components using East-West method
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


  
  */

  #import <iostream>