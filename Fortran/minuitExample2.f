		program minorm
		implicit none
		integer i,ierr
		real*8 arg(10),pval(10),perr(10),plo(10),phi(10),gint
		character*10 name(10)
		external minfcn ! need to pass function name to MINUIT
		print '('' sanity: '',f15.5)',gint(0.0d0,1.0d0,0.0d0,1.0d0)
c initialize minuit
		open(86,file='minorm.out')
		call mninit(5,86,7) 
c set up parameters
		call mnparm(1,'N' , 500.0d0, 10.0d0, 0.0d0,10000.0d0, ierr)
		call mnparm(2,'mean' , 50.0d0, 1.0d0, 0.0d0, 100.0d0, ierr)
		call mnparm(3,'sigma', 10.0d0, 1.0d0, 0.0d0, 100.0d0, ierr)
c minimize
		arg(1) = 1.0d0
		call mnexcm(minfcn,'SET PRINT', arg,1,ierr,0) ! set print level (normal)
		call mnexcm(minfcn,'SIMPLEX', arg,0,ierr,0) ! perform simplex minimization
		call mnexcm(minfcn,'MIGRAD', arg,0,ierr,0) ! perform MIGRAD minimization
		call mnexcm(minfcn,'MINOS', arg,0,ierr,0) ! perform MINOS minimization
c get parameters and errors
		do i=1,3
		call mnpout(i,name(i),pval(i),perr(i),plo(i),phi(i),ierr)
		enddo
c print out result
		print '(a10,4f15.5)', (name(i),pval(i),perr(i),i=1,3)
		end

		subroutine minfcn(npara,grad,fval,xval,iflag,dummy)
c MINUIT objective function
c
c supplied in call to function:
c
c npara - number of parameter modified (or something)
c xval - vector of current parameters
c futil - (optional) name of utility routine [not used here]
c iflag - 1: read input data, etc.
c 2: calculate gradients [not used here]
c 3: final call (print, etc. if needed...)
c
c returned by function:
c
c fval - calculated function value
c grad - (optional) vector of fist derivatives [not used here]
c
		implicit none
		integer npara
		integer iflag
		real*8 fval,xval(*),grad(*),mu,gint,xlo,xhi
		external dummy
		integer i,ndat(20)
		data ndat/ 0, 0, 0, 0, 0, 5, 11, 29, 91,118,151,114,109, 48, 19, 3, 1, 1, 0, 0/
c given the parameters, calculate -lnL
		fval = 0.
		do i=1,20
c get mu in bin
			xlo = float(i-1)*5.
			xhi = float(i)*5.
			mu = xval(1) * gint(xlo,xhi,xval(2),xval(3))
			fval = fval - ( ndat(i)*log(mu) - mu )
		enddo
		fval = 2.0*fval ! change to chi-square-like norm
		return
		end

		real*8 function gint(xlo,xhi,mu,sig)
		implicit none
		real*8 xlo,xhi,mu,sig,x,dx
		integer i
		real*8 root2pi
		parameter(root2pi=2.50663)
		dx = (xhi-xlo) /100.
		gint = 0.
		do i=1,100
		x = xlo + dx/2. + dx*float(i-1)
		gint = gint + exp(-(x-mu)**2/(2.0*sig**2))
		enddo
		gint = gint * dx/root2pi/sig
		return
		end
