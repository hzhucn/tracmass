#ifdef tempsalt

subroutine interp_gen3D(ib,jb,kb,x1,y1,z1,n3D,trc3D,ns)

!     computes temperature, salinity, density at position of trajectory
!     by interpolating data from the center of eight nearest boxes  
!
!     This subroutine should be improved in order to include time interpolation   

USE mod_grid
USE mod_vel
USE mod_dens
USE mod_vel
USE mod_tempsalt
IMPLICIT none

REAL*8  :: x1,y1,z1,ax,ay,az

REAL    :: tppp,tppm,tpmp,tpmm,tmpp,tmpm,tmmp,tmmm
REAL    :: sppp,sppm,spmp,spmm,smpp,smpm,smmp,smmm
REAL    :: rppp,rppm,rpmp,rpmm,rmpp,rmpm,rmmp,rmmm
REAL    :: temp,salt,dens

REAL(PP), DIMENSION(n3D) :: trc3D

INTEGER :: ib,jb,kb,ip,im,jp,jm,kp,kn,ns,id3D,n3D
! determining nearest centers of boxes 
      if(x1.le.dble(ib)-dble(.5)) then
       ip=ib
       im=ib-1
       if(im.eq.0) im=imt
      else
       ip=ib+1
       im=ib
       if(ip.gt.imt) ip=1
      endif
      if(y1.le.dble(jb)-dble(.5)) then
       jp=jb
       jm=jb-1
       if(jm.eq.0) jm=1
      else
       jp=jb+1
       jm=jb
       if(jp.gt.jmt) jp=jmt
      endif

      if(z1.le.dble(kb)-dble(.5)) then
       kp=kb
       kn=kb-1
       if(kn.le.0) kn=1
      else
       kp=kb+1
       if(kp.gt.km) kp=km
       kn=kb
      endif

      ax=dble(ip)-x1
      if(ax.gt.100.d0) then
!       print *,ax,ip,im,x1,ib
       ax=ax-dble(imt)
!       stop 49678
      elseif(ax.lt.-100.d0) then
       ax=ax+dble(imt)
!       stop 49679
      endif
      ay=(dble(jp)-y1)
      az=(dble(kp)-z1)

! temperature, salinity, density calculation 
!      tppp=tem(ip,jp,kp,ns)
!      if(tppp.eq.0.) tppp=tem(ib,jb,kb,ns)
!      tppm=tem(ip,jp,kn,ns)
!      if(tppm.eq.0.) tppm=tem(ib,jb,kb,ns)
!      tpmp=tem(ip,jm,kp,ns)
!      if(tpmp.eq.0.) tpmp=tem(ib,jb,kb,ns)
!      tpmm=tem(ip,jm,kn,ns)
!      if(tpmm.eq.0.) tpmm=tem(ib,jb,kb,ns)
!      tmpp=tem(im,jp,kp,ns)
!      if(tmpp.eq.0.) tmpp=tem(ib,jb,kb,ns)
!      tmpm=tem(im,jp,kn,ns)
!      if(tmpm.eq.0.) tmpm=tem(ib,jb,kb,ns)
!      tmmp=tem(im,jm,kp,ns)
!      if(tmmp.eq.0.) tmmp=tem(ib,jb,kb,ns)
!      tmmm=tem(im,jm,kn,ns)
!      if(tmmm.eq.0.) tmmm=tem(ib,jb,kb,ns)
!
!      sppp=sal(ip,jp,kp,ns)
!      if(sppp.eq.0.) sppp=sal(ib,jb,kb,ns)
!      sppm=sal(ip,jp,kn,ns)
!      if(sppm.eq.0.) sppm=sal(ib,jb,kb,ns)
!      spmp=sal(ip,jm,kp,ns)
!      if(spmp.eq.0.) spmp=sal(ib,jb,kb,ns)
!      spmm=sal(ip,jm,kn,ns)
!      if(spmm.eq.0.) spmm=sal(ib,jb,kb,ns)
!      smpp=sal(im,jp,kp,ns)
!      if(smpp.eq.0.) smpp=sal(ib,jb,kb,ns)
!      smpm=sal(im,jp,kn,ns)
!      if(smpm.eq.0.) smpm=sal(ib,jb,kb,ns)
!      smmp=sal(im,jm,kp,ns)
!      if(smmp.eq.0.) smmp=sal(ib,jb,kb,ns)
!      smmm=sal(im,jm,kn,ns)
!      if(smmm.eq.0.) smmm=sal(ib,jb,kb,ns)
!
!      rppp=rho(ip,jp,kp,ns)
!      if(rppp.eq.0.) rppp=rho(ib,jb,kb,ns)
!      rppm=rho(ip,jp,kn,ns)
!      if(rppm.eq.0.) rppm=rho(ib,jb,kb,ns)
!      rpmp=rho(ip,jm,kp,ns)
!      if(rpmp.eq.0.) rpmp=rho(ib,jb,kb,ns)
!      rpmm=rho(ip,jm,kn,ns)
!      if(rpmm.eq.0.) rpmm=rho(ib,jb,kb,ns)
!      rmpp=rho(im,jp,kp,ns)
!      if(rmpp.eq.0.) rmpp=rho(ib,jb,kb,ns)
!      rmpm=rho(im,jp,kn,ns)
!      if(rmpm.eq.0.) rmpm=rho(ib,jb,kb,ns)
!      rmmp=rho(im,jm,kp,ns)
!      if(rmmp.eq.0.) rmmp=rho(ib,jb,kb,ns)
!      rmmm=rho(im,jm,kn,ns)
!      if(rmmm.eq.0.) rmmm=rho(ib,jb,kb,ns)
      
      DO id3D=1,n3D
         tppp = tracers3D(id3D)%data(ip,jp,kp,ns)      
         if(tppp == tracers3D(id3D)%missval) then
          tppp = tracers3D(id3D)%data(ip,jp,kn,ns)
         endif
         
         tppm = tracers3D(id3D)%data(ip,jp,kn,ns)      
         if(tppm == tracers3D(id3D)%missval) then
          tppm = tracers3D(id3D)%data(ip,jp,kn,ns)
         endif
         
         tpmp = tracers3D(id3D)%data(ip,jm,kp,ns)
         if(tpmp == tracers3D(id3D)%missval) then
          tpmp = tracers3D(id3D)%data(ip,jp,kn,ns)
         endif
         
         tpmm = tracers3D(id3D)%data(ip,jm,kn,ns)
         if(tpmm == tracers3D(id3D)%missval) then
          tpmm = tracers3D(id3D)%data(ip,jp,kn,ns)
         endif
         
         tmpp = tracers3D(id3D)%data(im,jp,kp,ns)      
         if(tmpp== tracers3D(id3D)%missval) then
          tmpp=tracers3D(id3D)%data(ip,jp,kn,ns)       
         endif
         
         tmpm = tracers3D(id3D)%data(im,jp,kn,ns)
         if(tmpm==tracers3D(id3D)%missval) then
          tmpm=tracers3D(id3D)%data(ip,jp,kn,ns)
         endif
         
         tmmp=tracers3D(id3D)%data(im,jm,kp,ns)
         if(tmmp==tracers3D(id3D)%missval) then
          tmmp=tracers3D(id3D)%data(ip,jp,kn,ns)
         endif
         
         tmmm=tracers3D(id3D)%data(im,jm,kn,ns)
         if(tmmm==tracers3D(id3D)%missval) then
          tmmm=tracers3D(id3D)%data(ip,jp,kn,ns)
         endif
   
         trc3D(id3D)=tppp*(1.-ax)*(1.-ay)*(1.-az) &
         + tmpp*    ax *(1.-ay)*(1.-az) &
         + tpmp*(1.-ax)*    ay *(1.-az) &
         + tmmp*    ax *    ay *(1.-az) &
         + tppm*(1.-ax)*(1.-ay)*    az  &
         + tmpm*    ax *(1.-ay)*    az  &
         + tpmm*(1.-ax)*    ay *    az  &
         + tmmm*    ax *    ay *    az          
     
     END DO

return
end subroutine interp_gen3D

#endif

