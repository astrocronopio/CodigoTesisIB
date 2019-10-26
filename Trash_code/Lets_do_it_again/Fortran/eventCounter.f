!! Genera archivo con número de eventos por bin de 1 hora.
!!
c		calcula el numero de eventos en cada bin temporal de ancho "binWidth" en segs a partir de la fecha inicial "linfUTC"
		integer n,j,i,status,linf,lsup,GPStime,UTC,binWidth
		real zenith,azimut,energy,interval
c		parameter(nbin = 96480)		!numero de bines desde 01/01/2004 00:00:01 UTC (1072915201) hasta 06/01/2013 00:00:00 UTC (1370044800) 1388534400
c		parameter(nbin = 87671)
		parameter(nbin = 101928)
		integer binlist(nbin)
c		open(unit=1,file='HeraldData4EeV060noiw4.dat')
c		open(unit=2,file='HeraldData4EeV060noiw4-bins.dat')
		open(unit=1,file='/home/ponci/Desktop/TesisLicenciaturaBalseiro/Trabajo_de_Coronel/Herald/Archive_v6r2p2.dat')
		open(unit=2,file='test_events_auger_herald.dat')
		binWidth =3600 !2592000
		linfUTC = 1072915200!1072915500 !corresponde a: 01/01/2004 00:00:00 UTC (coincide 1er regitro arch. hexagonos)
		binlist = 0
		maxbin = 0
		do
c			read (1,*,iostat=status)zenith,azimut,UTC,energy!,GPStime
c			read (1,*,iostat=status)UTC,zenith,azimut,energy,p,rho,rhod,iw,ib
			read (1,*,iostat=status)x1,x2,UTC,phi,the,dec,ra,s1000,ds1000
     &,energy,p,rho,rhod,iw
			if (status.ne.0) exit ! Exit on end of data file
				interval = (UTC-linfUTC)/float(binWidth)
				i = int(interval) + 1 
c			if (interval-float(i).ne.0.) i = i + 1
				if(iw.le.2)binlist(i) = binlist(i) + 1
		end do
c	determina el bin mínimo de acuerdo a un utcmin
		i=1
c		utcmin = 1104537600
c		interval = (utcmin-linfUTC)/float(binWidth)
c		i = int(interval)
c		if (interval-float(i).ne.0.) 
c		i = i + 1

		do j=i, nbin
			write(2,*) linfUTC + binWidth*j-binWidth/2,binlist(j)
     &		,sqrt(float(binlist(j)))
		end do
		end		
