c  finds maximum density interpolating between maxima of previous and next day
c  rewrites utctprh.dat in utctprh2.dat with added column 10
      parameter(n5=12*36)
      dimension iutck(n5),tk(n5),pk(n5),rk(n5),ravk(n5),
     &    h6k(n5),h5k(n5),iwk(n5),ibk(n5)

      open(unit=1,file='utctprh2.dat')
      open(unit=2,file='utctprh3.dat')

 90   format(i10,1x,2(f8.3,1x),2(f7.4,1x),2(f7.1,1x),2(i2,1x),f7.4)

      k=1
c  reads first 2 days
      do k=1,12*36
       read(1,*)iutck(k),tk(k),pk(k),rk(k),ravk(k)
     &     ,h6k(k),h5k(k),iwk(k),ibk(k)
      enddo
      it1=iutck(1)
      rmax1=rk(1)
      km=1
       write(2,90)iutck(km),tk(km),pk(km),rk(km),ravk(km)
     &     ,h6k(km),h5k(km),iwk(km),ibk(km),rk(km)
c finds maximum rho between 6 and 30 hours later
      rmax2=0.
      do k=12*12,36*12
         if(rk(k).gt.rmax2) then
            rmax2=rk(k)
            it2=iutck(k)
         endif
      enddo

 10   continue
      do k=2,12*36
         iutck(k-1)=iutck(k)
         tk(k-1)=tk(k)
         pk(k-1)=pk(k)
         rk(k-1)=rk(k)
         ravk(k-1)=ravk(k)
			h6k(k-1)=h6k(k)	!<----
			h5k(k-1)=h5k(k)	!<----
			iwk(k-1)=iwk(k)	!<----
			ibk(k-1)=ibk(k)	!<----
      enddo
      j=36*12
      read(1,*,end=11)iutck(j),tk(j),pk(j),rk(j),ravk(j)
     &     ,h6k(j),h5k(j),iwk(j),ibk(j)

      rint=rmax1+(rmax2-rmax1)/float(it2-it1)*(iutck(1)-it1)
      km=1
       write(2,90)iutck(km),tk(km),pk(km),rk(km),ravk(km)
     &     ,h6k(km),h5k(km),iwk(km),ibk(km),rint
 

      if(iutck(1).ge.it2) then
         it1=it2
         rmax1=rmax2
c finds maximum rho between 8 and 32 hours later
      rmax2=0.
      do k=12*12,36*12
         if(rk(k).gt.rmax2) then
            rmax2=rk(k)
            it2=iutck(k)
         endif
      enddo
      endif
      goto 10
 11    end
         
