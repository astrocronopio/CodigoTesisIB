c     variables globales a usar en el programa 
      MODULE globalvars
      implicit none
      integer,parameter :: pr=kind(0.d0) !parametro que especifica la precisión deseada
      real(pr),parameter :: pi=4.0_pr*atan(1.0_pr)
      real(pr),parameter :: d2r=pi/180.,Bc=1.03,rho0=1.06,P0=862.0
      real(pr) :: t,p,r,rav,xnhex,xnhexT3,En
      contains
      END MODULE
      
      MODULE qgaus_mod
       INTERFACE
         FUNCTION expo(Theta)
         use globalvars
         real(pr),intent(in) :: Theta
         real(pr) :: expo
         END FUNCTION expo

         FUNCTION test(arg)
         use globalvars
         real(pr),intent(in) :: arg
         real(pr) :: test
         END FUNCTION
      END INTERFACE
      CONTAINS
      FUNCTION qgaus(f,a,b,eps)
      use globalvars
      REAL(pr), INTENT(IN) :: a,b,eps
      REAL(pr) :: qgaus
      INTERFACE
         FUNCTION f(x)
         USE globalvars
         REAL(pr), INTENT(IN) :: x
         REAL(pr) :: f
         END FUNCTION f
      END INTERFACE
      REAL(pr) :: const,c1,c2,aa,bb,u
      REAL(pr), DIMENSION(12) :: dx,w = (/.1012285362903760_pr,
     &.2223810344533740_pr,.3137066458778870_pr,
     &.3626837833783620_pr,.0271524594117540_pr,.0622535239386480_pr,
     &.0951585116824930_pr,.1246289712555340_pr,.1495959888165770_pr,
     &.1691565193950030_pr,.1826034150449240_pr,.1894506104550690_pr /),
     &  x = (/.9602898564975360_pr,.7966664774136270_pr,
     &.5255324099163290_pr,.1834346424956500_pr,.9894009349916500_pr,
     &.9445750230732330_pr,.8656312023878320_pr,.7554044083550030_pr,
     &.6178762444026440_pr,.4580167776572270_pr,.2816035507792590_pr,
     &.0950125098376370_pr /)
      const=1.0E-12_pr
   	nout4=6
      delta=const*abs(a-b)
      qgaus=0.0_pr
      aa=a
    5 y=b-aa
      if(abs(y).le.delta) return
    2 bb=aa+y
      c1=0.5_pr*(aa+bb)
      c2=c1-aa
      s8=0.0_pr
      s16=0.0_pr
      do 1 i=1,4
      u=x(i)*c2
    1 s8=s8+w(i)*(f(c1+u)+f(c1-u))
      do 3 i=5,12
      u=x(i)*c2
    3 s16=s16+w(i)*(f(c1+u)+f(c1-u))
      s8=s8*c2
      s16=s16*c2
      if(abs(s16-s8).gt.eps*(abs(s16))) goto 4
      qgaus=qgaus+s16
      aa=bb
c      qgaus=ssr
      goto 5
    4 y=0.5_pr*y
      if(abs(y).gt.delta) goto 2
      qgaus=0._pr
      write(nout4,*)'... too high accuracy required'
c        xm=0.5_sp*(b+a)
c        xr=0.5_sp*(b-a)
c        dx(:)=xr*x(:)
c        qgaus=xr*sum(w(:)*(func(xm+dx)+func(xm-dx)))
      END FUNCTION qgaus
      END MODULE

      PROGRAM exposure
      use qgaus_mod
      use globalvars
      implicit double precision(a-h,o-z)
      open(unit=1,file='tmp.dat')
      open(unit=8,file='../weather/infill/utctprhinfillwT3.dat')
      open(unit=12,file='dnhexraInfillT3_08-14.dat')
      open(unit=13,file='effsolInfillT3e01z20_08-14.dat')
      open(unit=14,file='expsolInfillT3b1_08-14.dat')
      open(unit=15,file='expsolInfillT3dNb1_08-14.dat')
c      open(unit=15,file='expsolInfillT3dNN_08-14.dat')
      open(unit=16,file='expsidInfillT3b1_08-14.dat')
      open(unit=17,file='expsidInfillT3dNb1_08-14.dat')
      call solarhex
      call sidhex
c      goto 100
c      call gauss1(test,0._pr,2*pi,ssr,0.1_pr)
c      write(6,*)qgaus(test,0._pr,2*pi,0.01_pr),ssr
 100  END PROGRAM

      FUNCTION test(arg)
      use globalvars
      real(pr),intent(in) :: arg
      real(pr) :: test
      test=(sin(arg))**2
      END FUNCTION

      FUNCTION expo(Theta)
      use globalvars
      implicit none
      real(pr),intent(in) :: Theta
      real(pr) :: expo
      real(pr) :: sec,aP,arho,brho,x,pow,E05,eff
      !--weather coeffs
      sec = 1./cos(Theta)
		aP = -0.0012-0.0043*(sec-1.)!+0.0030*(sec-1.)**2
		arho = -0.13*(sec-2.)-0.49*(sec-2.)**2
		brho = 0.9*(sec-2.)+0.8*(sec-2.)**2
      !----------
      x = (sin(Theta))**2
      pow = 17.3*x**3 - 2.2*x**2 - 2.2*x + 3.56   
      E05 = 0.7*x**3 - 0.3*x**2 + 0.09*x + 0.070
      eff=En**pow/(En**pow+E05**pow)+En*Bc*(aP*(p-P0)+arho*(rav-rho0)
     &   +brho*(r-rav))*pow*E05**pow*En**(pow-1)/(En**pow+E05**pow)**2      
      expo = cos(Theta)*sin(Theta)*eff
      END FUNCTION

      SUBROUTINE solarhex()
c      implicit double precision(a-h,o-z)
      use globalvars
      use qgaus_mod
      implicit none
      integer :: iutc,iw,ib,i,ihr,iutc0,ie,maxbin,fl,ie2,j
      real(pr) ::  effsol(24),reffsol(24),mneff,mnw
      real(pr) :: Theta,sec,aP,arho,brho,eff,E05,pow,x,wp,Ei,Ef,bw
      real(pr) :: Er1,Er2,gam,Nref,dN,mnw2,w2(24,6)
      real(pr),allocatable :: w(:,:)
c      external expo
c      real(pr) :: t,p,r,rav,xnhex,xnhexT3
      iutc0 = 1072915200
		effsol = 0._pr
		reffsol = 0._pr
		mneff = 0._pr
      Ef = 63._pr
      Ei = 0.01_pr
      bw = 1._pr/15
      Er1 = 0.3_pr
      Er2 = 0.6_pr
      Nref = 41804._pr
      gam = 3.3_pr
      fl = 0
      maxbin = int((log10(Ef)-log10(Ei))/bw)+1
      allocate(w(24,maxbin))
      w = 0.
      w2 = 0.
      do ie=maxbin,1,-1
      mnw = 0.
      En = 10**(log10(Ei)+(ie-0.5)*bw)
      ie2 = int((log10(Ei)+ie*bw-log10(0.0125))/log10(2.))+1
c      ie2 = int((log10(Ei)+ie*bw-log10(0.015625))/log10(2.))+1
      if(ie2.gt.6)ie2 = 6
      if(10**(-2+(ie-1)*bw).lt.0.09.and.fl.eq.0) then
         Nref=((10**(-2+(ie-1)*bw))**(1-gam)-(10**(-2+ie*bw))**(1-gam))
     &        /(Er1**(1-gam)-Er2**(1-gam))*Nref
         gam = 2.95
         Er1=10**(-2+(ie-1)*bw)
         Er2=10**(-2+ie*bw)
         fl = 1
      end if
      dN = ((10**(-2+(ie-1)*bw))**(1-gam)-(10**(-2+ie*bw))**(1-gam))
     &     /(Er1**(1-gam)-Er2**(1-gam))*Nref
c      write (6,*)dN,Nref,En
c      Theta = 20.
      !--weather coeffs
c      sec = 1./cos(Theta*d2r)
c		aP = -0.0012-0.0043*(sec-1.)!+0.0030*(sec-1.)**2
c		arho = -0.13*(sec-2.)-0.49*(sec-2.)**2
c		brho = 0.9*(sec-2.)+0.8*(sec-2.)**2
      !----------
c      x = (sin(Theta*d2r))**2
c      pow = 17.3*x**3 - 2.2*x**2 - 2.2*x + 3.56   
c      E05 = 0.7*x**3 - 0.3*x**2 + 0.09*x + 0.070
      rewind(unit=8)
 61   read (8,*,end=60)iutc,t,p,r,rav,xnhex,xnhexT3,iw,ib
		if(iutc.gt.1420070400)goto 61 !1356998400 1388534400 1420070400
c		if(iutc.lt.1356998400.and.iutc.gt.1388534400)goto 51 
c      if(ib.eq.1.and.iw.lt.5) then
      if(iw.lt.5) then
c      eff=En**pow/(En**pow+E05**pow)+En*B*(1.-aP*(p-P0)-arho*(rav-rho0)
c     &   -brho*(r-rav))*pow*E05**pow*En**(pow-1)/(En**pow+E05**pow)**2
         !---- solar time
         ihr=mod(int(dfloat(iutc-iutc0)/3600.+21.),24)+1
c         call gauss1(expo,0.,55.,wp,0.1d0)
         wp = qgaus(expo,0._pr,55.*d2r,0.1_pr)
         w(ihr,ie) = w(ihr,ie) + wp*xnhexT3
         w2(ihr,ie2) = w2(ihr,ie2) + wp*xnhexT3*dN
c         write(6,*)wp
c         effsol(ihr)=effsol(ihr)+xnhexT3*eff
c         if(effsol(ihr).gt.1.d6) then
c            reffsol(ihr)=reffsol(ihr)+effsol(ihr)/1.d6
c            effsol(ihr)=0.d0
c         endif
		endif
		goto 61
 60	continue
      do i=1,24
c         reffsol(i)=reffsol(i)+effsol(i)/1.d6
c			mneff = mneff + reffsol(i)/24.
         mnw = mnw + w(i,ie)/24.
      enddo
c		mnhra=rnhexra(1)
		do i=1,24
c			reffsol(i)=reffsol(i)/mneff
c			write(13,*)reffsol(i)
c			write(14,*)w(i)/mnw
         w(i,ie) = w(i,ie)/mnw
		enddo
      end do
      do i=1,24
         write(14,*)(w(i,ie),ie=1,maxbin)
      end do
      do i=1,6
         mnw2 = 0._pr
         do j=1,24
            mnw2 = mnw2 + w2(j,i)/24
         end do
         do j=1,24
            w2(j,i) = w2(j,i)/mnw2
         end do
      end do
      do j=1,24
         write(15,*)(w2(j,i),i=1,6)
      end do
      END SUBROUTINE

      SUBROUTINE sidhex()
c      implicit double precision(a-h,o-z)
      use globalvars
      use qgaus_mod
      implicit none
      integer :: iutc,iw,ib,i,ira,iutcref,ie,maxbin,fl,ie2,j,size
      real(pr) ::  effsid(360),reffsid(360),mneff,mnw,raz
      real(pr) :: Theta,sec,aP,arho,brho,eff,E05,pow,x,wp,Ei,Ef,bw
      real(pr) :: Er1,Er2,gam,Nref,dN,mnw2,bwra
      real(pr),allocatable :: w(:,:),w2(:,:)
      iutcref = 1104537600   !1/1/2005
		mneff = 0._pr
      Ef = 63._pr
      Ei = 0.01_pr
      bw = 1._pr/15
      Er1 = 0.3_pr
      Er2 = 0.6_pr
      Nref = 41804._pr
      gam = 3.3_pr
      fl = 0
      bwra = 15.
      size = int(360.1/bwra)
      maxbin = int((log10(Ef)-log10(Ei))/bw)+1
      allocate(w(size,maxbin),w2(size,6))
      w = 0.
      w2 = 0.
      do ie=maxbin,1,-1
      mnw = 0.
      En = 10**(log10(Ei)+(ie-0.5)*bw)
      ie2 = int((log10(Ei)+ie*bw-log10(0.0125))/log10(2.))+1
c      ie2 = int((log10(Ei)+ie*bw-log10(0.015625))/log10(2.))+1
      if(ie2.gt.6)ie2 = 6
      if(10**(-2+(ie-1)*bw).lt.0.09.and.fl.eq.0) then
         Nref=((10**(-2+(ie-1)*bw))**(1-gam)-(10**(-2+ie*bw))**(1-gam))
     &        /(Er1**(1-gam)-Er2**(1-gam))*Nref
         gam = 2.95
         Er1=10**(-2+(ie-1)*bw)
         Er2=10**(-2+ie*bw)
         fl = 1
      end if
      dN = ((10**(-2+(ie-1)*bw))**(1-gam)-(10**(-2+ie*bw))**(1-gam))
     &     /(Er1**(1-gam)-Er2**(1-gam))*Nref
c      write (6,*)dN,Nref,En
      rewind(unit=8)
 61   read (8,*,end=60)iutc,t,p,r,rav,xnhex,xnhexT3,iw,ib
		if(iutc.gt.1420070400)goto 61 !1356998400 1388534400 1420070400
c		if(iutc.lt.1356998400.and.iutc.gt.1388534400)goto 51 
      if(iw.lt.5) then
         !---- sidereal time
         raz=float(iutc-iutcref)/239.345_pr+31.4971_pr
         raz=mod(raz,360._pr)
         if(raz.lt.0.0_pr)raz=raz+360._pr
         ira=int(raz/bwra)+1
         wp = qgaus(expo,0._pr,55.*d2r,0.1_pr)
         w(ira,ie) = w(ira,ie) + wp*xnhexT3
         w2(ira,ie2) = w2(ira,ie2) + wp*xnhexT3*dN
		endif
		goto 61
 60	continue
      do i=1,size
         mnw = mnw + w(i,ie)/float(size)
      enddo
		do i=1,size
         w(i,ie) = w(i,ie)/mnw
		enddo
      end do
      do i=1,size
         write(16,*)(w(i,ie),ie=1,maxbin)
      end do
      do i=1,6
         mnw2 = 0._pr
         do j=1,size
            mnw2 = mnw2 + w2(j,i)/float(size)
         end do
         do j=1,size
            w2(j,i) = w2(j,i)/mnw2
         end do
      end do
      do j=1,size
         write(17,*)(w2(j,i),i=1,6)
      end do
      END SUBROUTINE
