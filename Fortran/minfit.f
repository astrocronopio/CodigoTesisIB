	program minfit
c  to compile and link: f77 -o minfit minfit.f -L /cern/2003/lib -l packlib
c   where in this case the cern libraries are in /cern/2003/lib
c  makes a fit to data in file data:  x    y  sigmay
c  nhis is the number of  data points, or bins in histogram, to be fitted

 	implicit double precision(a-h,o-z)

	   call mninit(5,7,8)  !  in  out saving
	   open(unit=7,file='minuit.r')

	call fitf     ! returns ai via common

        end
c--------------------------------------------------------------------



	subroutine fitf
 	implicit double precision(a-h,o-z)
	parameter(ndat=20)
	dimension ai(5)   ! parameters to be fitted
	dimension arglis(10)          !for Minuit
	dimension xi(ndat),yi(ndat),sigyi(ndat)
	character*10 name

        common/cdat/xi,yi,sigyi

        external chi2q

	open(unit=1,file='data')
	do i=1,ndat
	   read(1,*)xi(i),yi(i),sigyi(i)
	enddo

c  starting values: id, name, strt, strterr, ? ? ?)
	 call mnparm(1,'ai1',1.d0,0.2d0,0.d0,0.d0,ier)
	 call mnparm(2,'ai2',1.d0,2.d-1,0.d0,0.d0,ier)
	 call mnparm(3,'ai3',5.d0,1.d0,0.d0,0.d0,ier)
c	 call mnparm(4,'ai4',6.d1,2.d0,0.d0,0.d0,ier)
c	 call mnparm(5,'ai5',3.d0,5.d-1,0.d0,0.d0,ier)
	 call mnexcm(chi2q,'migrad',arglis,0,ier,0)
	 call mnpout(1,name,ai(1),error,bnd1,bnd2,ier)
	 call mnpout(2,name,ai(2),error,bnd1,bnd2,ier)
	 call mnpout(3,name,ai(3),error,bnd1,bnd2,ier)
c	 call mnpout(4,name,ai(4),error,bnd1,bnd2,ier)
c	 call mnpout(5,name,ai(5),error,bnd1,bnd2,ier)

	return
	end


	subroutine chi2q(npar,grad,fval,ai,iflag,futil)
 	implicit double precision(a-h,o-z)
	parameter(ndat=20)
	dimension ai(5),grad(5),xi(ndat),yi(ndat),sigyi(ndat)
        common/cdat/xi,yi,sigyi

	pi=4.*datan(1.d0)
	d2r=pi/180.
	c38q=cos(38.*d2r)**2

	fval=0.
	do i=1,ndat
	   fval=fval+(ai(1)*(1.+ai(2)*(xi(i)-c38q)+ai(3)*(xi(i)-c38q)**2)
     &      -yi(i))**2/sigyi(i)**2
	enddo
	return
	end


