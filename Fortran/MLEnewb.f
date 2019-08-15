c	  	to compile and link: f77 -o minfit minfit.f -L /cern/2005/lib -l packlib
c  	where in this case the cern libraries are in /cern/2005/lib
c		Performs a maximum likelihood fit of the model of weather effects given by Lfunc
c		using the minfit procedure from the cern libraries
		implicit double precision(a-h,o-z)
		integer j,i,status,iUTC,ibinWidth
c		real zenith,azimut,energy,binterval
c		real*8 logfact
		parameter(nbin = 82536)		!numero de bines desde 01/01/2004 00:00:01 UTC (1072915201) hasta 06/01/2014 00:00:00 UTC (1370044800) 
		dimension ievents(nbin),iutc(nbin)
		dimension pres(nbin),rho(nbin),rhod(nbin),hex6T5(nbin)
		dimension arglis(10)
		dimension ai(5),error(5),iflag(5),vstrt(5)
		character*10 name(5)

		external Lfunc

		common/likefunc/pres,rho,rhod,hex6T5,ievents,iutc
		common/ref/rho0,P0
c		open(unit=1,file='HeraldData060weathergt2004.dat')
		open(unit=1,file='HeraldData060weatherdlayrho.dat')
c		open(unit=7,file='HeraldDatasec1weatherdlayrho.dat')
		open(unit=2,file='MLFitoutnewb.out')
		open(unit=3,file='mincommands')
		open(unit=12,file='fitmodnewbdlayrho3EeV.dat')
c		open(unit=13,file='fitmodnewbdlayrhowinter.dat')
		open(unit=13,file='tmp.dat')
		open(unit=14,file='fitcoefs.dat')
		open(unit=15,file='HeraldDatasec1weatherdlayrho.dat')
		open(unit=16,file='HeraldDatasec2weatherdlayrho.dat')
		open(unit=17,file='HeraldDatasec3weatherdlayrho.dat')
		open(unit=18,file='HeraldDatasec4weatherdlayrho.dat')
		open(unit=19,file='HeraldDatasec5weatherdlayrho.dat')

		rho0 = 1.055d0!1.06d0		!reference air density in kg/m^3
		P0 = 861.89d0!862.0d0			!reference pressure in hPa
c		initialize arrays with zeros
		call zeroarrs
		data iflag/5*0/
		data vstrt/ 0.0d0 , 0.0d0 , 0.0d0 , 0.0d0 , 0.0d0 /

		i = 1
 40		read (19,*,end=41)iutc(i),ievents(i),pres(i),rho(i),
     &		rhod(i),hex6T5(i)
			i = i + 1
			goto 40
 41		continue

		call mninit(3,2,8)  !  in  out saving
		call fitf(ai,error,name,vstrt,iflag)

c		write(3,*)'SET parameter 4 0.0' 
c		write(3,*)'FIX 4 3 2' 
c		write(3,*)'SCAN'
c		rewind(unit=3)
c		call mnintr(Lfunc,0)
c		iflag(4)=1
c		iflag(3)=1
c		iflag(2)=1
c		call fitf(ai,error,name,iflag)
		
		do i=1,4
			write(6,*) name(i),ai(i)/2.48,error(i)/2.48
		end do
		write(6,*) name(5),ai(5),error(5)

		call Lfunc2(ai,chi2,ndof,fval,12)
		write(6,*) '\'chi2\'=',chi2,' \'deg of freed\'=',ndof
     & ,' \'chi2/dof\'=',chi2/float(ndof-5),' \'2lnL\'=',fval

		goto 10

c		write(3,*)'SET parameter 4 0.' 
c		rewind(unit=3)
c		iflag(3)=1
c		iflag(4)=1
c	cause Minuit to read commands from the unit IRD originally specified by the user
c	in his call to MNINIT
c		call mnintr(Lfunc,0)
c		call fitunit(15,6)
c		call fitunit(16,14)
		call fitunit(17,6,ai,iflag)
c		call fitunit(18,6,iflag)
c		call fitunit(19,6)
		call mnintr(Lfunc,0)
 10	end

		subroutine fitf(ai,error,name,vstrt,iflag)
		implicit double precision(a-h,o-z)
		dimension ai(5)   ! parameters to be fitted
		dimension arglis(10)          !for Minuit
		dimension error(5),vstrt(5),stp(5),nprm(5)
		character*10 name(5)
		dimension iflag(5)  !flag array indicating for each parameter if value= 0: no-fixed or 1: fixed 

		external Lfunc

		name(1)='aP';name(2)='arho';name(3)='b0'
		name(4)='b1';name(5)='lambda'
		data nprm /   1 ,  2   ,  3   ,   4  , 5   /
		data stp  / 0.1d0 , 0.1d0  ,  0.1d0 ,  0.1d0 , 0.1d0  /

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
		if(iflag(5).eq.0) then
			call mnparm(nprm(5),name(5),vstrt(5),stp(5),0.0d0,0.0d0,ier)
		endif
		
c		arglis(1) = 0.0d0
		call mnexcm(Lfunc,'MIGRAD',arglis,0,ier,0)
		call mnpout(1,name(1),ai(1),error(1),bnd1,bnd2,ier)
		call mnpout(2,name(2),ai(2),error(2),bnd1,bnd2,ier)
		call mnpout(3,name(3),ai(3),error(3),bnd1,bnd2,ier)
		call mnpout(4,name(4),ai(4),error(4),bnd1,bnd2,ier)
		call mnpout(5,name(5),ai(5),error(5),bnd1,bnd2,ier)
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
		common/ref/rho0,P0
		fval = 0.
		isumn = 0
		sumhex = 0.
		t0=(1220227200-1104537601)/(365.25*24*3600)
c	calculate R0: average rate we would have observed if the atmospheric 
c	parameters were always the reference ones
		do j=1, nbin
			isumn = isumn + ievents(j)
			C=1.+ai(1)*(pres(j)-P0)+ai(2)*(rhod(j)-rho0)+
     &			(ai(3)+ai(4)*(rhod(j)-rho0))*(rho(j)-rhod(j))
			ti=(iutc(j)-1104537601)/(365.25*24*3600)
			ee=dexp(-ai(5)*(ti-t0))
			if(ee.gt.1.d0) ee = 1.
			sumhex = sumhex + hex6T5(j)*C*ee
		end do
		R0 = isumn/sumhex
c	calculate the loglikelihood function
		do j=1, nbin
			C=1.+ai(1)*(pres(j)-P0)+ai(2)*(rhod(j)-rho0)+
     &			(ai(3)+ai(4)*(rhod(j)-rho0))*(rho(j)-rhod(j))
			ti=(iutc(j)-1104537601)/(365.25*24*3600)
			ee=dexp(-ai(5)*(ti-t0))
			if(ee.gt.1.d0) ee = 1.
			mu = R0*hex6T5(j)*C*ee
c			mu = R0*hex6T5(j)*C*exp(-ti*ai(5))*ai(6)
c		if(mu.ge.3.d0.and.ievents(j).eq.0) goto 30
		if(mu.eq.0.d0) goto 30
		fval = fval-2*( ievents(j)*dlog(mu)-mu-logfact(ievents(j)) )
 30	continue
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


		subroutine Lfunc2(ai,chi2,ndof,fval,iunit)
		implicit double precision(a-h,o-z)
		parameter(nbin = 82536)
		dimension ievents(nbin),iutc(nbin)
		dimension pres(nbin),rho(nbin),rhod(nbin),hex6T5(nbin)
		real*8 mu,logfact
		dimension ai(*)
		common/likefunc/pres,rho,rhod,hex6T5,ievents,iutc
		common/ref/rho0,P0
			fval = 0.
		isumn = 0
		sumhex = 0.
		chi2 = 0.
		ndof = 0
		t0=(1220227200-1104537601)/(365.25*24*3600)
c	calculate R0: average rate we would have observed if the atmospheric 
c	parameters were always the reference ones
		do j=1, nbin
			isumn = isumn + ievents(j)
			C=1.+ai(1)*(pres(j)-P0)+ai(2)*(rhod(j)-rho0)+
     &			(ai(3)+ai(4)*(rhod(j)-rho0))*(rho(j)-rhod(j))
			ti=(iutc(j)-1104537601)/(365.25*24*3600)
			ee=dexp(-ai(5)*(ti-t0))
			if(ee.gt.1.d0) ee = 1.
			sumhex = sumhex + hex6T5(j)*C*ee
		end do
		R0 = isumn/sumhex
c	calculate the loglikelihood function
		do j=1, nbin
			C=1.+ai(1)*(pres(j)-P0)+ai(2)*(rhod(j)-rho0)+
     &			(ai(3)+ai(4)*(rhod(j)-rho0))*(rho(j)-rhod(j))
			ti=(iutc(j)-1104537601)/(365.25*24*3600)
			t0=(1220227200-1104537601)/(365.25*24*3600)
			ee=dexp(-ai(5)*(ti-t0))
			if(ee.gt.1) ee = 1.
			mu = R0*hex6T5(j)*C*ee
c			mu = R0*hex6T5(j)*C*exp(-ti*ai(5))*ai(6)
c			if(mu.ge.3.d0.and.ievents(j).eq.0) goto 20
			if(mu.eq.0.d0) goto 20
			chi2 = chi2 + (float(ievents(j))-mu)**2/mu
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
		dimension ai(5),error(5),iflag(5),vstrt(5)
		character*10 name(5)

		call zeroarrs

		i = 1
 11	read (iunitin,*,end=12)iutc(i),ievents(i),pres(i),rho(i),
     &		rhod(i),hex6T5(i)
		i = i + 1
		goto 11
 12	continue

		call fitf(ai,error,name,vstrt,iflag)
		write(iunitout,*) ''
		do i=1,4
			write(iunitout,*) name(i),ai(i)/2.48,error(i)/2.48
		end do
			write(iunitout,*) name(5),ai(5),error(5)

		call Lfunc2(ai,chi2,ndof,fval,13)
		write(iunitout,*) '\'chi2\'=',chi2,' \'deg of freed\'=',ndof
     & ,' \'chi2/dof\'=',chi2/float(ndof-4),' \'2lnL\'=',fval

		do k=1,5;vstrt(k)=ai(k);enddo
		return
		end
