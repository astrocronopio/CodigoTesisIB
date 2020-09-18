
		integer n,nbin,i,nval
		parameter (n = 9)
		REAL, DIMENSION(n,n) :: K, Kinv
		REAL, DIMENSION(n) :: almbar,blmbar
		REAL var_rbar,sigmar,var_dec,sigmad,var_ra,sigmara
		external K0000,K1000,K1m11m1,K1010,K2000,K2m11m1,K2010,K2m22m2
		external K2m12m1,K2020
		common/com/pi,d2r
		open(unit=1,file='prueba.dat')
				open(unit=2,file='energybinsnew.dat')
				open(unit=3,file='quadrupoleEstimateNew.dat')
		pi = 4.*atan(1.)
		d2r = pi/180.
		ep=1.e-7
		nbin = 2
		K = 0.
		call qsimp(K0000,-pi/2+ep,pi/2-ep,K(1,1))
		call qsimp(K1000,-pi/2+ep,pi/2-ep,K(1,3))
		call qsimp(K1m11m1,-pi/2+ep,pi/2-ep,K(2,2))
		call qsimp(K1010,-pi/2+ep,pi/2-ep,K(3,3))
		call qsimp(K2000,-pi/2+ep,pi/2-ep,K(1,7))
		call qsimp(K2m11m1,-pi/2+ep,pi/2-ep,K(2,6))
		call qsimp(K2010,-pi/2+ep,pi/2-ep,K(3,7))
		call qsimp(K2m22m2,-pi/2+ep,pi/2-ep,K(5,5))
		call qsimp(K2m12m1,-pi/2+ep,pi/2-ep,K(6,6))
		call qsimp(K2020,-pi/2+ep,pi/2-ep,K(7,7))
		K(3,1) = K(1,3)
		K(4,4) = K(2,2)
		K(7,1) = K(1,7)
		K(6,2) = K(2,6)
		K(4,8) = K(2,6)
		K(8,4) = K(4,8)
		K(7,3) = K(3,7)
		K(9,9) = K(5,5)
		K(8,8) = K(6,6)

		PRINT '(" ")'
		   PRINT*,"K Matrix:"
		do i=1,n
		      write (6,*) ( K(i,j),j=1,9)
		enddo

		call inverseMatrix(K,n,Kinv)

		PRINT '(" ")'
		   PRINT*,"Inverse K Matrix:"
		do i=1,n
		      write (6,*) ( Kinv(i,j),j=1,9)
		   enddo
		PRINT '(" ")'

		DO i=1,nbin
c Estimate dipole amplitude, Ra and dec using Harmonic analysis
			almbar=0.
			call almbarcoeffs(almbar,blmbar,Kinv,i,n)	! harmonic coeff. for binid=1 (4EeV-8EeV) binid=2 (>8EeV)
			rbar = sqrt(3.*(almbar(3)**2+almbar(4)**2+almbar(2)**2))
     &		/almbar(1)
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

		decbar = atan(delz/sqrt(delx**2+dely**2))

			if(i.eq.1) E = 6.
			if(i.eq.2) E = 10.

c	Caculate Errors

		var_rbar=3./(almbar(2)**2+almbar(3)**2+almbar(4)**2)/almbar(1)
     &	*(Kinv(2,2)*almbar(2)**2+Kinv(3,3)*almbar(3)**2+
     &	Kinv(4,4)*almbar(4)**2)
c     &	+ 3.*(almbar(2)**2+almbar(3)**2+almbar(4)**2)
c     &	*Kinv(1,1)/almbar(1)**3

		sigmar = sqrt(var_rbar)

c		var_dec = 1./(almbar(2)**2+almbar(4)**2)*(Kinv(3,3)
c     & *almbar(1)+sigmar**2*almbar(3)**2/rbar**2)

c		sigmad = sqrt(var_dec)

		var_dec = 3./almbar(1)/(delx**2+dely**2+delz**2)**2*(delz**2
     &*(delx**2*Kinv(4,4)+dely**2*Kinv(2,2))/(delx**2+dely**2)+(delx**2
     &+dely**2)*Kinv(3,3))

		sigmad = sqrt(var_dec)

		var_ra = almbar(1)/(almbar(4)**2+almbar(2)**2)**2*(Kinv(2,2)*
     &	almbar(4)**2+Kinv(4,4)*almbar(2)**2)

		sigmara = sqrt(var_ra)

		ddz = sqrt(3.*Kinv(3,3)*K(1,1)/nval)
		ddper = sqrt(3./almbar(1)/(delx**2+dely**2)*(delx**2*Kinv(4,4)
     &	+dely**2*Kinv(2,2)))
		ddz2 =  sqrt(3.*Kinv(3,3)/almbar(1))
		ddx = sqrt(3.*Kinv(4,4)/almbar(1))

		write(6,*)E,rbar,sigmar,decbar/d2r,sigmad/d2r,rabar/d2r,
     &	sigmara/d2r,ddz2,ddx


		DO m=1,n
		write(3,*)E,blmbar(m),almbar(m),sqrt(Kinv(m,m)*almbar(1))
		ENDDO

		ENDDO
		
c		DO j=1,1000
c			d=-90.+float(j-1)*180./999.
c			write(1,*)d,exposure(d*d2r)
c		ENDDO
		END	

		SUBROUTINE trapzd(func,a,b,s,n)
		INTEGER n
		REAL a,b,s,func
		EXTERNAL func
c	This routine computes the nth stage of refinement of an extended trapezoidal rule. func is
c	input as the name of the function to be integrated between limits a and b, also input. When
c	called with n=1, the routine returns as s the crudest estimate of a f (x)dx. Subsequent
c	calls with n=2,3,... (in that sequential order) will improve the accuracy of s by adding 2n-2
c	additional interior points. s should not be modified between sequential calls.
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
		END

		SUBROUTINE qsimp(func,a,b,s)
	  	INTEGER JMAX
	  	REAL a,b,func,s,EPS
	  	EXTERNAL func
	 	PARAMETER (EPS=1.e-6, JMAX=20)
c	USES trapzd
c 	Returns as s the integral of the function func from a to b. The parameters EPS can be set
c 	to the desired fractional accuracy and JMAX so that 2 to the power JMAX-1 is the maximum
c 	allowed number of steps. Integration is performed by Simpson’s rule.
		INTEGER j
		REAL os,ost,st
		ost = -1.e30
		os = -1.e30
		do j=1,JMAX
			call trapzd(func,a,b,st,j)
			s = (4.*st - ost)/3.
			if (j.gt.5) then
			if (abs(s-os).lt.EPS*abs(os).or.
     &		(s.eq.0..and.os.eq.0.)) return
			endif
			os = s
			ost = st
		enddo
cpause ’too many steps in qsimp’
		END

		FUNCTION exposure(Dec)
			real Dec,xi
			common/com/pi,d2r
			thetaM = 55.
			a0 =-35.2
			xi = 	(cos(thetaM*d2r) - sin(a0*d2r)*sin(Dec))/cos(Dec)
     &		/cos(a0*d2r)
			if(xi.gt.1.)then 
				am = 0.
			elseif(xi.lt.-1.) then
				am = pi
			else
				am = acos(xi)
			endif

			exposure = (cos(a0*d2r)*cos(Dec)*sin(am)+am*sin(a0*d2r)
     &			*sin(Dec))/(-pi*sin(a0*d2r))
		return
		END

		FUNCTION K0000(Dec)
		real Dec
		common/com/pi,d2r
			K0000 = 4.*pi*0.5*cos(Dec)*exposure(Dec)
		return
		END

		FUNCTION K1000(Dec)
		real Dec
		common/com/pi,d2r
			K1000 = 4.*pi*0.5*sqrt(3.)*cos(Dec)*sin(Dec)*exposure(Dec)
		return
		END

		FUNCTION K1m11m1(Dec)
		real Dec
		common/com/pi,d2r
			K1m11m1 = 4.*pi*3./4.*(cos(Dec))**3*exposure(Dec)
		return
		END	

		FUNCTION K1010(Dec)
		real Dec
		common/com/pi,d2r
		K1010 = 4.*pi*1.5*cos(Dec)*sin(Dec)**2*exposure(Dec)
		return
		END

		FUNCTION K2000(Dec)
		real Dec
		common/com/pi,d2r
		K2000 = sqrt(5.)*pi*cos(Dec)*(3.*sin(Dec)**2-1.)*exposure(Dec)
		return
		END

		FUNCTION K2m11m1(Dec)
		real Dec
		common/com/pi,d2r
		K2m11m1 = sqrt(45.)*pi*cos(Dec)**3*sin(Dec)*exposure(Dec)
		return
		END

		FUNCTION K2010(Dec)
		real Dec
		common/com/pi,d2r
		K2010 = sqrt(15.)*pi*cos(Dec)*sin(Dec)*(3.*sin(Dec)**2-1.)
     &	*exposure(Dec)
		return
		END

		FUNCTION K2m22m2(Dec)
		real Dec
		common/com/pi,d2r
		K2m22m2 = 15.*pi/4.*cos(Dec)**5*exposure(Dec)
		return
		END

		FUNCTION K2m12m1(Dec)
		real Dec
		common/com/pi,d2r
		K2m12m1 = 15.*pi*cos(Dec)**3*sin(Dec)**2*exposure(Dec)
		return
		END

		FUNCTION K2020(Dec)
		real Dec
		common/com/pi,d2r
		K2020 = 5.*pi/2.*cos(Dec)*(3.*sin(Dec)**2-1.)**2*exposure(Dec)
		return
		END

		SUBROUTINE inverseMatrix(A,N,Ainv)	
      INTEGER :: i,j, LWORK
      INTEGER	INFO,LDA,M,N
      INTEGER, DIMENSION(N) :: IPIV
		REAL, DIMENSION(N,N) :: A, Ainv
      REAL, DIMENSION(N*N) :: WORK

c	Calculate the inverse of the matrix A using the external library LAPACK

      external SGETRF
      external SGETRI

      LDA = N
      LWORK = N*N

C     DGETRF computes an LU factorization of a general M-by-N matrix A
C     using partial pivoting with row interchanges.

      M = N
      LDA = N

C  Store A in Ainv to prevent it from being overwritten by LAPACK

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
35       FORMAT( 'LU decomposition: U(',I4,',',I4,') = 0 ')
      ENDIF

C  DGETRI computes the inverse of a matrix using the LU factorization
C  computed by DGETRF.

      CALL SGETRI(N, Ainv, N, IPIV, WORK, LWORK, INFO)


      PRINT '(" ")'
      IF (info.NE.0) THEN
         stop 'Matrix inversion failed!'
      ELSE
         PRINT '(" Inverse Successful ")'
      ENDIF
		
		RETURN
		END

		SUBROUTINE almbarcoeffs(almbar,blmbar,K,bin,n)
			INTEGER bin,n,status,binid
			REAL,DIMENSION(n,n) :: K
			REAL,DIMENSION(n) :: blmbar,almbar
			REAL Dec,Ra,Ra0,energy,DeltaNHexaAtRa,a,b,promdec,sumaN
			REAL aphi,bphi,promzen
		common/com/pi,d2r
c	Computes the estimated harmonic harmonic coefficients	for a energy bin
		blmbar = 0.
		almbar = 0.
		rewind(unit=2)
		DO
		read (2, *, iostat=status)Dec,Ra,Ra0,energy,DeltaNHexaAtRa,binid
     &		,UTC,Theta,Phi
			if (status.ne.0) exit ! Exit on end of data file
		   if (binid.eq.bin) then    ! only includes data on the current bin
				!b00
				blmbar(1) = blmbar(1) + 1./DeltaNHexaAtRa !1./sqrt(4.*pi)/DeltaNHexaAtRa
				!b1-1
				blmbar(2) = blmbar(2) + sqrt(3.)*cos(Dec*d2r) !sqrt(3./4./pi)*cos(Dec*d2r)
     &			*sin(Ra*d2r)/DeltaNHexaAtRa
				!b10
				blmbar(3) = blmbar(3) + sqrt(3.)*sin(Dec*d2r) !sqrt(3./4./pi)*sin(Dec*d2r)
     &			/DeltaNHexaAtRa
				!b11
				blmbar(4) = blmbar(4) + sqrt(3.)*cos(Dec*d2r) !sqrt(3./4./pi)*cos(Dec*d2r)
     &			*cos(Ra*d2r)/DeltaNHexaAtRa
				!b2-2
				blmbar(5) = blmbar(5) + sqrt(15.)*cos(Dec*d2r)**2
     &			*sin(Ra*d2r)*cos(Ra*d2r)/DeltaNHexaAtRa
				!b2-1
				blmbar(6) = blmbar(6) + sqrt(15.)*cos(Dec*d2r)*sin(Dec*d2r)
     &			*sin(Ra*d2r)/DeltaNHexaAtRa
				!b20
				blmbar(7) = blmbar(7) + sqrt(5.)/2.*(3.*sin(Dec*d2r)**2-1.)
     &			/DeltaNHexaAtRa
				!b21
				blmbar(8) = blmbar(8) + sqrt(15.)*cos(Dec*d2r)*sin(Dec*d2r)
     &			*cos(Ra*d2r)/DeltaNHexaAtRa
				!b22
				blmbar(9) = blmbar(9) + sqrt(15.)/2.*cos(Dec*d2r)**2
     &			*(cos(Ra*d2r)**2-sin(Ra*d2r)**2)/DeltaNHexaAtRa
				

c			write(1,*)Dec,Ra,Ra0,energy,DeltaNHexaAtRa,binid
c     &		,(blmbar(j),j=1,4)
	      end if 
		ENDDO
		
		DO i=1,n
			DO j=1,n
			almbar(i) = almbar(i) + K(i,j)*blmbar(j)
			ENDDO
		ENDDO
		RETURN
		END
