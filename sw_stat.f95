
module mod_stat
contains
  subroutine statv(t, s, rho, kmm)

    REAL*4, ALLOCATABLE, DIMENSION (:) :: dens_temp, dens_zero, t, s, rho
    INTEGER KMM,k
    
    REAL, PARAMETER ::  a0 = 999.842594
    REAL, PARAMETER ::  a1 =   6.793952e-2
    REAL, PARAMETER ::  a2 =  -9.095290e-3
    REAL, PARAMETER ::  a3 =   1.001685e-4
    REAL, PARAMETER ::  a4 =  -1.120083e-6
    REAL, PARAMETER ::  a5 =   6.536332e-9
    
    REAL, PARAMETER :: b0 =  8.24493e-1
    REAL, PARAMETER :: b1 = -4.0899e-3
    REAL, PARAMETER :: b2 =  7.6438e-5
    REAL, PARAMETER :: b3 = -8.2467e-7
    REAL, PARAMETER :: b4 =  5.3875e-9
    
    REAL, PARAMETER :: c0 = -5.72466e-3
    REAL, PARAMETER :: c1 = +1.0227e-4
    REAL, PARAMETER :: c2 = -1.6546e-6
    
    REAL, PARAMETER :: d0 = 4.8314e-4
    
  allocate ( dens_temp(KM),dens_zero(KM) )
  do k=1,kmm
  dens_temp(k) = a0 + (a1 + (a2 + (a3 + (a4 + a5*t(k))*t(k))*t(k))*t(k))*t(k)
  dens_zero(k)  = dens_temp(k) + (b0 + (b1 + (b2 + (b3 + b4*t(k))*t(k))*t(k))*t(k))*s(k) &
       + (c0 + (c1 + c2*T(k))*T(k))*s(k)*sqrt(S(k)) + d0*s(k)**2
  
  rho(k)=dens_zero(k)-1000.
  enddo
  
  !  densP0 = sw_dens0(S,T);
  !  K      = sw_seck(S,T,P);
  !  P      = P/10;  ! convert from db to atm pressure units
  !  dens   = densP0./(1-P./K);
  
end subroutine statv
end module mod_stat
