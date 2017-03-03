//von Bertalanffy growth model

DATA_SECTION
  
  init_int nobs
  init_matrix vonBdata(1,nobs,1,2)
  init_vector testvec(1,3)
  //!!cout<< "the test vector is " << testvec << endl;
  //!!exit(43);

  vector Ages(1,nobs)
  vector Lengths_obs(1,nobs)
 LOCAL_CALCS
  Ages=column(vonBdata,1);
  Lengths_obs=column(vonBdata,2);
 END_CALCS

PARAMETER_SECTION
  
  init_number t0  //age at which length is 0
  init_number log_Linf // log of Linf
  init_number log_K // log of K (Brody growth coefficient)
  init_number log_sigma //log of sigma for normal distribution

  number Linf
  number K
  number sigma

  objective_function_value nll  // The objective function (required)

INITIALIZATION_SECTION
//Starting values for parameters
  log_Linf 7.0
  log_K -1.6
  t0 0.
  log_sigma 4.0

PROCEDURE_SECTION
 // cout << "we are at top of procedure section" << endl;
 // exit(44);
  Linf=exp(log_Linf);
  K=exp(log_K);
  sigma=exp(log_sigma);

  cout<<"print starting values for Linf, K, t0, and sigma, and quit"<<endl;
  cout<<Linf<<" " <<K<<" "<<t0<<" "<<sigma<<endl;
  exit(45);
