// This is Poisson regression with RE
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
  init_bounded_number log_sigma_u(-4.0,0.0,3)
  init_bounded_number rho(-0.97,0.97,4)
  random_effects_vector u(2,ndat,2)
  objective_function_value f
PROCEDURE_SECTION

  f0(beta);
  f1(u(2),log_sigma_u,rho,beta);
  for (int i=3;i<=ndat;i++)
  {
    f2(i,u(i),u(i-1),log_sigma_u,rho,beta);
  }

SEPARABLE_FUNCTION void f2(int i,const prevariable& ui,const prevariable& ui1,const prevariable& log_sigma_u,const prevariable& rho,const dvar_vector& beta)

     dvariable sigma_u=exp(log_sigma_u); 
     dvariable tmp=beta*x(i);
     tmp+=sigma_u*ui;
     f+=0.91893853320467274177+0.5*square(ui-rho*ui1);
     dvariable mu=mfexp(tmp);
     f-=log_density_poisson(y(i),mu);

SEPARABLE_FUNCTION void f1(const prevariable& ui,const prevariable& log_sigma_u,const prevariable& rho,const dvar_vector& beta)

     dvariable sigma_u=exp(log_sigma_u); 
     dvariable tmp=beta*x(2);
     tmp+=sigma_u*ui;
     f+=0.91893853320467274177+0.5*square(ui-rho*beta(1));
     dvariable mu=mfexp(tmp);
     f-=log_density_poisson(y(2),mu);

SEPARABLE_FUNCTION void f0(const dvar_vector& beta)

     dvariable tmp=beta*x(1);
     dvariable mu=mfexp(tmp);
     f-=log_density_poisson(y(1),mu);

REPORT_SECTION
   ofstream ofs("u3");
   ofs << beta(1) << " " << exp(log_sigma_u)*u << endl;
