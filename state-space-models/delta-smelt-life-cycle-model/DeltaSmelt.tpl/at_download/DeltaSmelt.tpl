DATA_SECTION
  init_int StartYear
  init_int EndYear
  init_vector X_J(StartYear,EndYear)
  init_vector X_A(StartYear,EndYear-1)
  init_int N_I_J
  init_matrix I_J(1,N_I_J,1,2) //year value
  init_int N_I_A
  init_matrix I_A(1,N_I_A,1,2) //year value

PARAMETER_SECTION
  init_number ln_Ninit(1)
  init_number ln_a_J(1)
  init_number ln_b_J(-1)
  init_number ln_a_A(1)
  init_number ln_b_A(2)
  init_number beta_J(4)
  init_number beta_A(4)
  init_number ln_P_sd_J(3)
  init_number ln_P_sd_A(3)
  init_number ln_O_sd_J(-6)
  init_number ln_O_sd_A(-6)

  random_effects_vector dev_J(StartYear,EndYear,3)
  random_effects_vector dev_A(StartYear,EndYear-1,3)

  number Ninit
  number a_J
  number b_J
  number a_A
  number b_A
  number P_sd_J
  number P_sd_A
  number O_sd_J
  number O_sd_A


  vector J(StartYear,EndYear)
  vector A(StartYear,EndYear)

  objective_function_value f


PROCEDURE_SECTION

  Ninit=mfexp(ln_Ninit);
  a_J=mfexp(ln_a_J);
  b_J=mfexp(ln_b_J);
  a_A=mfexp(ln_a_A);
  b_A=mfexp(ln_b_A);
  P_sd_J=mfexp(ln_P_sd_J);
  P_sd_A=mfexp(ln_P_sd_A);
  O_sd_J=mfexp(ln_O_sd_J);
  O_sd_A=mfexp(ln_O_sd_A);

  //Dynamics
  J(StartYear)=Ninit;
  for(int year=StartYear;year<=EndYear;year++)
  {
   A(year)=(a_J*J(year)/(1.0+b_J*J(year)))*mfexp(beta_J*X_J(year))*mfexp(dev_J(year)*P_sd_J-0.5*P_sd_J*P_sd_J);
   if(year<EndYear) J(year+1)=(a_A*A(year)/(1.0+b_A*A(year)))*mfexp(beta_A*X_A(year))*mfexp(dev_A(year)*P_sd_A-0.5*P_sd_A*P_sd_A);
  }

  //likelihood
  f=0;
  for(int i=1;i<=N_I_J;i++)
  {
   f+=log(O_sd_J)+0.5*square((I_J(i,2)-J(I_J(i,1)))/ O_sd_J);
  }

  for(int i=1;i<=N_I_A;i++)
  {
   f+=log(O_sd_A)+0.5*square((I_A(i,2)-A(I_A(i,1)))/ O_sd_A);
  }

  f+=0.5*norm2(dev_J);
  f+=0.5*norm2(dev_A);


REPORT_SECTION
  report<<"J"<<endl;
  report<<J<<endl;
  report<<"A"<<endl;
  report<<A<<endl;



