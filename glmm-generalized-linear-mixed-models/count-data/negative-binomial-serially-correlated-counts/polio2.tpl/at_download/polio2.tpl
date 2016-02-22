// This is NB regression with RE
DATA_SECTION
  init_int ndat
  init_vector y(1,ndat)
  matrix x(1,ndat,1,6);
 LOC_CALCS
   double tpi =2.0*3.14159275;
   for (int i=1;i<=ndat;i++)
   {
     int ip=i-73;
     double tpip = tpi*ip;
     x(i,1)=1;
     x(i,2)=ip/1000.;
     x(i,3)=cos(tpip/12.);
     x(i,4)=sin(tpip/12.);
     x(i,5)=cos(tpip/6.);
     x(i,6)=sin(tpip/6.);
   }
PARAMETER_SECTION
  init_vector beta(1,6)
  init_bounded_number log_a(-3.0,3.0)
  init_bounded_number log_sigma_u(-4.0,0.0,3)
  init_bounded_number rho(-0.97,0.97,4)
  random_effects_vector u(2,ndat,2)
  objective_function_value f
PROCEDURE_SECTION

   dvariable a=exp(log_a); 
   dvariable sigma_u=exp(log_sigma_u); 
   for (int i=1;i<=ndat;i++)
   {
     double ip=i-73;
     dvariable tmp=beta*x(i);
     if (current_phase()>=2)   
     {
       if (i==2)
       {
         tmp+=sigma_u*u(i);
         f+=0.91893853320467274177+0.5*square(u(2)-rho*beta(1));
       }
       else if (i>2)
       {
         tmp+=sigma_u*u(i);
         f+=0.91893853320467274177+0.5*square(u(i)-rho*u(i-1));
       }
     }
     dvariable mu=mfexp(tmp);
     dvariable tau=1.0+a*mu;
     f-=log_negbinomial_density(y(i),mu,tau);
   }
