DATA_SECTION
  init_int n
  int lflag1
  int lflag2
  init_matrix x(1,n,1,3)
  init_matrix Y(1,n,1,3)
 LOC_CALCS
   lflag1=2;
   lflag2=2;
   double lt1,lt2;
   lt1=0;
   lt2=0;
  cifstream cif("analyzer.par");
  if (!(!cif))
  {
    cif >> lt1 >> lt2;
    if (lt1<-3.9)
      lflag1=-1;
    if (lt2<-3.9)
      lflag2=-1;
  }
 END_CALCS
PARAMETER_SECTION
  init_bounded_number log_tau1(-4.0,4.0,lflag1)
  init_bounded_number log_tau2(-4.0,4.0,lflag2)
  init_bounded_number rho(-3.,3.,3)
  matrix ch(1,2,1,2)
  init_number beta1
  init_number beta2
  matrix b(1,n,1,2)
  sdreport_matrix sigma(1,2,1,2)
  sdreport_number tau1
  sdreport_number tau2
  random_effects_matrix bb(1,n,1,2,2)
  objective_function_value ll;
PROCEDURE_SECTION
  for (int i=1;i<=n;i++)
  {
    f1(i,log_tau1,log_tau2,rho,bb(i),beta1,beta2);
  }
  if (sd_phase())
  {
    tau1=exp(log_tau1);
    tau2=exp(log_tau2);
    dvar_matrix ch(1,2,1,2);
    ch(1,1)=1.0;
    ch(1,2)=0.0;
    ch(2,1)=rho;
    ch(2,2)=1.0;
    ch(2)/=norm(ch(2));
    ch(1)*=tau1;
    ch(2)*=tau2;
    sigma=ch*trans(ch);
  }

SEPARABLE_FUNCTION void f1(int& i, const prevariable & log_tau1, const prevariable & log_tau2, const prevariable & rho, const dvar_vector & bbi ,const prevariable & beta1,const prevariable & beta2)
  if (i==1) 
  {
    ll+=1.e-3*square(rho);
  }
  dvar_matrix ch(1,2,1,2);
  dvariable tau1=exp(log_tau1);
  dvariable tau2=exp(log_tau2);
  ch(1,1)=1.0;
  ch(1,2)=0.0;
  ch(2,1)=rho;
  ch(2,2)=1.0;
  ch(2)/=norm(ch(2));
  ch(1)*=tau1;
  ch(2)*=tau2;
  dvar_vector b=ch*bbi;
  dvar_vector tmp=beta1+b(1)
    +(beta2+b(2))*x(i);
  dvar_vector mu=1.0/(1.0+exp(-tmp));
  for (int t=1;t<=3;t++)
  {
    if (Y(i,t)==1)
      ll-=log(1.e-12+mu(t));
    else
      ll-=log(1.e-12+(1.0-mu(t)));
  }
  ll+=0.5*norm2(bbi);
