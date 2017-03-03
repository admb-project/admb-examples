//von Bertalanffy growth model

DATA_SECTION

  init_int nobs
  init_matrix vonBdata(1,nobs,1,2)
  init_vector testvec(1,3)
  //!!cout<< "the test vector is " << testvec << endl;
  //!!exit(43);

  vector Ages(1,nobs)
  vector Lengths_obs(1,nobs)
  vector agelst(1,11)

 LOCAL_CALCS
  Ages=column(vonBdata,1);
  Lengths_obs=column(vonBdata,2);
  agelst.fill_seqadd(1,1);
 END_CALCS

PARAMETER_SECTION
  
  init_number t0(2)  //age at which length is 0
  init_bounded_vector  log_Linfs(1,3,5.5,7.5) // log of Linf
  init_number log_K(1) // log of K (Brody growth coefficient)
  init_bounded_number log_sigma(2.3,4.6,3) //log of sigma for normal distribution

  vector Linfs(1,3)
  number K
  number sigma

  vector Lengths_pred(1,nobs)
  vector resids(1,nobs)

  sdreport_vector predlst(1,11)

  objective_function_value nll  // The objective function (required)

INITIALIZATION_SECTION
//Starting values for parameters
  log_Linf 7.0
  log_K -1.6
  t0 0.
  log_sigma 4.0

PRELIMINARY_CALCS_SECTION
  log_Linf=log(max(Lengths_obs));


PROCEDURE_SECTION
 // cout << "we are at top of procedure section" << endl;
 // exit(44);

 // cout<<t0<<endl;
 // cout<<log_Linf<<endl;
 // cout<<log_K<<endl;
 // cout<<log_sigma<<endl;
 // exit(44);

  Linf=exp(log_Linf);
  K=exp(log_K);
  sigma=exp(log_sigma);

 // cout<<"print starting values for Linf, K, t0, and sigma, and quit"<<endl;
 //cout<<Linf<<" " <<K<<" "<<t0<<" "<<sigma<<endl;
 // exit(45);

  Lengths_pred=Linf*(1.-exp(-K*(Ages-t0)));
  resids=Lengths_obs-Lengths_pred;

  predlst=Linf*(1.-exp(-K*(agelst-t0)));
  
 // cout<<"predicted lengths"<<endl;
 // cout<<Lengths_pred<<endl;
 // cout<<"residuals"<<endl;
  //cout<<resids<<endl;
  //exit(46);

  nll=nobs*log_sigma + (0.5/square(sigma))*norm2(resids);


REPORT_SECTION
  report << "parameter estimates - backtransformed if needed: Linf, K, t0, sigma" <<endl;
  report << Linf <<" " << K << " " << t0 << " " << sigma << endl;
  report << "predicted lengths for ages 1-11" << endl;
  report << predlst << endl;
  report << "residuals for all observed values" << endl;
  report << resids<<endl;
  report << "predictions for all observed values" <<endl;
  report << Lengths_pred<<endl;
