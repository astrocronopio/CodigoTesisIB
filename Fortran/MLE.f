!! Rutina que usa minuit para realizar Maximum Likelihood que ajusta parámetros de clima. Requiere \emph{f77} para compilar (reemplazada por rutina en C++ usando ROOT).
!!
c	  	to compile and link: f77 -o minfit minfit.f -L /cern/2005/lib -l packlib
c  	where in this case the cern libraries are in /cern/2005/lib
c		Performs a maximum likelihood fit of the model of weather effects given by Lfunc
c		using the minfit procedure from the cern libraries
		implicit double precision(a-h,o-z)
		integer j,i,iutc
c		real*8 logfact
		parameter(nbin = 82536)		!numero de bines desde 01/01/2004 00:00:01 UTC (1072915201) hasta 06/01/2013 00:00:00 UTC (1370044800) 
		dimension ievents(nbin),iutc(nbin)
		dimension pres(nbin),rho(nbin),rhod(nbin),hex6T5(nbin)
		dimension ai(4),error(4),vstrt(4),iflag(4)
		character*10 name(4)
c		dimension xpt(40),ypt(40)
		external Lfunc

		common/likefunc/pres,rho,rhod,hex6T5,ievents,iutc
		common/ref/rho0,P0,pf
c		open(unit=1,file='HeraldData060weatherdrno.dat')
		open(unit=1,file='HeraldData060weatherno.dat')
c		open(unit=1,file='HeraldData060weathergt2004.dat')
c		open(unit=7,file='HeraldData060weatherwinter.dat')
		open(unit=2,file='MLFitout.out')
		open(unit=3,file='mincommands')
		open(unit=12,file='fitmod.dat')
c		open(unit=13,file='fitmodwinter.dat')
c		open(unit=40,file='tmp.dat')
c		open(unit=14,file='fitcoefsdr.dat')
c		open(unit=15,file='HeraldDatasec1weatherdrno.dat')
c		open(unit=15,file='HeraldDatasec1weatherno.dat')
c		open(unit=16,file='HeraldDatasec2weatherdrno.dat')
c		open(unit=16,file='HeraldDatasec2weatherno.dat')
c		open(unit=17,file='HeraldDatasec3weatherdrno.dat')
c		open(unit=17,file='HeraldDatasec3weatherno.dat')
c		open(unit=18,file='HeraldDatasec4weatherdrno.dat')
c		open(unit=18,file='HeraldDatasec4weatherno.dat')
c		open(unit=19,file='HeraldDatasec5weatherdrno.dat')
c		open(unit=19,file='HeraldDatasec5weatherno.dat')

		gamma = 3.23
		B = 1.02
		pf = B*(gamma-1.)
		rho0 = 1.055!1.06d0		   !reference air density in kg/m^3
		P0 = 861.89!862.0d0			!reference pressure in hPa
		call zeroarrs		            !initialize arrays with zeros
		data iflag/4*0/
		data vstrt/ 0.0d0 , 0.0d0 , 0.0d0 , 0.0d0 /

		i = 1	
 11	read (1,*,end=12)iutc(i),ievents(i),pres(i),rho(i),
     &		rhod(i),hex6T5(i)
		i = i + 1
		goto 11
 12	continue

		call mninit(3,2,8)  !  in  out saving
		call fitf(ai,error,name,vstrt,iflag)
		
c		call mnintr(Lfunc,0)
c		goto 10

c		do i=1,4
c			write(6,*) name(i),ai(i),error(i)
c		enddo

		do i=1,3
			write(6,*) name(i),ai(i)/pf,error(i)/pf
		enddo
		write(6,*) name(4),ai(4),error(4)

		call Lfunc2(ai,chi2,ndof,fval,12,smu,isumn)
		write(6,*) '\'chi2\'=',chi2,' \'deg of freed\'=',ndof
     & ,' \'chi2/dof\'=',chi2/float(ndof-4),' \'2lnL\'=',fval

c		call fitunit(7,6,ai,iflag)
		goto 10  !salta al final

		write(3,*)'FIX 4' 
		rewind(unit=3)
		iflag(4) = 1
c	cause Minuit to read commands from the unit IRD originally specified by the user
c	in his call to MNINIT
		call mnintr(Lfunc,0)
		call fitunit(15,14,ai,iflag)
		call fitunit(16,14,ai,iflag)
		call fitunit(17,14,ai,iflag)
		call fitunit(18,14,ai,iflag)
		call fitunit(19,14,ai,iflag)

 10	end

		subroutine fitf(ai,error,name,vstrt,iflag)
		implicit double precision(a-h,o-z)
		dimension ai(4)   ! parameters to be fitted
		dimension arglis(10)          !for Minuit
		dimension error(4), vstrt(4),stp(4),nprm(4)
		dimension iflag(4)
		character*10 name(4)
		external Lfunc

		name(1)='aP';name(2)='arho';name(3)='brho'
		name(4)='lambda'
		data nprm /   1 ,  2   ,  3   ,   4   /
		data stp  / 0.1d0 , 0.1d0  ,  0.1d0 ,  0.1d0  /

c  starting values: id, name, strt, strterr, ? ? ?)
		if(iflag(1).eq.0) then
			call mnparm(nprm(1),name(1),vstrt(1),stp(1),0.0d0,0.0d0,ier)
		endif
		if(iflag(2).eq.0) then
			call mnparm(nprm(2),name(2),vstrt(2),stp(2),0.0d0,0.0d0,ier)
		endif
		if(iflag(3).eq.0) then
			call mnparm(nprm(3),name(3),vstrt(3),stp(3),0.0d0,0.0d0,ier)
		endif
		if(iflag(4).eq.0) then
			call mnparm(nprm(4),name(4),vstrt(4),stp(4),0.0d0,0.0d0,ier)
		endif

c		arglis(2) = 4.
c		arglis(3) = 5.
		call mnexcm(Lfunc,'MIGRAD',arglis,0,ier,0)
c		call mnexcm(Lfunc,'MINOS',arglis,0,ier,0)
c		arglis(1) = 16.
c		call mnexcm(Lfunc,'SET ERR',arglis,1,ier,0)
c		arglis(1) = 1.
c		arglis(2) = 2.
c		arglis(3) = 4.
c		call mnexcm(Lfunc,'MNCONTOUR',arglis,2,ier,0)
		call mnpout(1,name(1),ai(1),error(1),bnd1,bnd2,ier)
		call mnpout(2,name(2),ai(2),error(2),bnd1,bnd2,ier)
		call mnpout(3,name(3),ai(3),error(3),bnd1,bnd2,ier)
		call mnpout(4,name(4),ai(4),error(4),bnd1,bnd2,ier)
c		call mnstat(fmin,fedm,errdef,npari,nparx,istat)
		return
		end

		subroutine Lfunc(npar,grad,fval,ai,iflag,futil)
		implicit double precision(a-h,o-z)
		parameter(nbin = 82536)
		dimension ievents(nbin),iutc(nbin)
		dimension pres(nbin),rho(nbin),rhod(nbin),hex6T5(nbin)
		real*8 mu,logfact
		dimension ai(*),grad(*)
		common/likefunc/pres,rho,rhod,hex6T5,ievents,iutc
		common/ref/rho0,P0,pf
		fval = 0.
		isumn = 0
		sumhex = 0.
		t0=(1220227200-1104537601)/(365.25*24*3600)
c	calculate R0: average rate we would have observed if the atmospheric 
c	parameters were always the reference ones
		do j=1, nbin
c			if(iutc(j).gt.1370044800) exit
			isumn = isumn + ievents(j)
			C=1.+ai(1)*(pres(j)-P0)+ai(2)*(rhod(j)-rho0)+ai(3)*
     &			(rho(j)-rhod(j))
			ti=(iutc(j)-1104537601)/(365.25*24*3600)
			ee=dexp(-ai(4)*(ti-t0))
			if(ee.gt.1.d0) ee = 1.
			sumhex = sumhex + hex6T5(j)*C*ee
c			sumhex = sumhex + hex6T5(j)*C
		end do
		R0 = isumn/sumhex
c	calculate the loglikelihood function
		do j=1, nbin
c			if(iutc(j).gt.1370044800) exit
			C=1.+ai(1)*(pres(j)-P0)+ai(2)*(rhod(j)-rho0)+ai(3)*
     &			(rho(j)-rhod(j))
			ti=(iutc(j)-1104537601)/(365.25*24*3600)
			ee=dexp(-ai(4)*(ti-t0))
			if(ee.gt.1.d0) ee = 1.
			mu = R0*hex6T5(j)*C*ee
c			mu = R0*hex6T5(j)*C
c			if(mu.ge.3.d0.and.ievents(j).eq.0) goto 20
c			if(mu.lt.0.5d0) goto 20
			if(mu.eq.0.0d0) goto 20
			fval = fval-2*( ievents(j)*dlog(mu)-mu-logfact(ievents(j)) )
 20	continue
		end do
		return	
		end		

c	function to calculate the natural logarithm to the factorial of N
		real*8 function logfact(N)
			integer N,I
			logfact=0.
			if(N.gt.1)then
			 	do I=2,N 
			 		logfact = logfact + dlog(dfloat(I)) 					
			 	end do
			end if 
		return 
		end


		subroutine Lfunc2(ai,chi2,ndof,fval,iunit,smu,isumn)
		implicit double precision(a-h,o-z)
		parameter(nbin = 82536)
		dimension ievents(nbin),iutc(nbin)
		dimension pres(nbin),rho(nbin),rhod(nbin),hex6T5(nbin)
		real*8 mu,logfact
		dimension ai(*)
		common/likefunc/pres,rho,rhod,hex6T5,ievents,iutc
		common/ref/rho0,P0,pf
		fval = 0.
		isumn = 0
		sumhex = 0.
		chi2 = 0.
		ndof = 0
		smu = 0.
		t0=(1220227200-1104537601)/(365.25*24*3600)
c	calculate R0: average rate we would have observed if the atmospheric 
c	parameters were always the reference ones
		do j=1, nbin
c			if(iutc(j).gt.1370044800) exit
			isumn = isumn + ievents(j)
			C=1.+ai(1)*(pres(j)-P0)+ai(2)*(rhod(j)-rho0)+ai(3)*
     &			(rho(j)-rhod(j))
			ti=(iutc(j)-1104537601)/(365.25*24*3600)
			ee=dexp(-ai(4)*(ti-t0))
			if(ee.gt.1.d0) ee = 1.
			sumhex = sumhex + hex6T5(j)*C*ee
c			sumhex = sumhex + hex6T5(j)*C
		end do
		R0 = isumn/sumhex
c	calculate the loglikelihood function
		do j=1, nbin
c			if(iutc(j).gt.1370044800) exit
			C=1.+ai(1)*(pres(j)-P0)+ai(2)*(rhod(j)-rho0)+ai(3)*
     &			(rho(j)-rhod(j))
			ti=(iutc(j)-1104537601)/(365.25*24*3600)
			ee=dexp(-ai(4)*(ti-t0))
			if(ee.gt.1.d0) ee = 1.
			mu = R0*hex6T5(j)*C*ee
c			mu = R0*hex6T5(j)*C
c			if(mu.ge.3.d0.and.ievents(j).eq.0) goto 20
c			if(mu.lt.0.5d0) goto 20
			if(mu.eq.0.0d0) goto 20
			smu = smu + mu
			chi2 = chi2 + (dfloat(ievents(j))-mu)**2/mu
			ndof = ndof + 1
			fval = fval+2*( ievents(j)*dlog(mu)-mu-logfact(ievents(j)) )
			write(iunit,*)iutc(j),mu,ievents(j),sqrt(float(ievents(j)))
     &			,hex6T5(j),ti*365.25
 20		continue
		end do
		return	
		end

c     fills the common arrays with zeroes
		subroutine zeroarrs
		implicit double precision(a-h,o-z)
		parameter(nbin = 82536)
		dimension ievents(nbin),iutc(nbin)
		dimension pres(nbin),rho(nbin),rhod(nbin),hex6T5(nbin)
		common/likefunc/pres,rho,rhod,hex6T5,ievents,iutc
		do i=1,nbin
			ievents(i)=0
			iutc(i)=0
			pres(i)=0.
			rho(i)=0.
			rhod(i)=0.
			hex6T5(i)=0.
		enddo
		return
		end

c     runs the fit procedure taking the data from file in unit 'iunitin'
c     and the previous fit parameter and writes the new fit parameters in 'iunitout'
		subroutine fitunit(iunitin,iunitout,vstrt,iflag)
		implicit double precision(a-h,o-z)
		parameter(nbin = 82536)
		dimension ievents(nbin),iutc(nbin)
		dimension pres(nbin),rho(nbin),rhod(nbin),hex6T5(nbin)
		common/likefunc/pres,rho,rhod,hex6T5,ievents,iutc
		common/ref/rho0,P0,pf
		dimension ai(4),error(4),vstrt(4),iflag(4)
		character*10 name(4)
		integer status

		call zeroarrs

		i = 1
 11	read (iunitin,*,end=12)iutc(i),ievents(i),pres(i),rho(i),
     &		rhod(i),hex6T5(i)
		i = i + 1
		goto 11
 12	continue

		call fitf(ai,error,name,vstrt,iflag)
		write(iunitout,*) ''
c		do i=1,4
c			write(iunitout,*) name(i),ai(i),error(i)
c		end do

		do i=1,3
			write(iunitout,*) name(i),ai(i)/pf,error(i)/pf
		enddo
		write(iunitout,*) name(4),ai(4),error(4)

		call Lfunc2(ai,chi2,ndof,fval,13,smu,isumn)
		write(iunitout,*) '\'chi2\'=',chi2,' \'deg of freed\'=',ndof
     & ,' \'chi2/dof\'=',chi2/float(ndof-3),' \'2lnL\'=',fval
		
		do k=1,5;vstrt(k)=ai(k);enddo
		return
		end
