DATA_SECTION
  init_int fage
  init_int lage
  init_int nponds
  init_matrix lengths(fage,lage,1,nponds)
  init_vector test(1,3)
 // !!cout <<test<<endl;
 // !!exit(50);

  vector Ages(fage,lage)
  number nobs
  !!nobs=double(size_count(lengths));
  !!Ages.fill_seqadd(double(fage),1.0);


  //looping variables
  int i
  int j
 
 LOCAL_CALCS 
  if ((test(1)!= 1) || (test(2)!=2) || (test(3)!=3) ) 
    {
      cout<<endl<<"data error!!"<<endl;
      exit(50);
    }  
  else cout<< "data seem to be ok"<<endl;


 END_CALCS

PARAMETER_SECTION

  init_number log_K
  init_number log_sigma
  init_number t0
  init_vector log_Linfs(1,nponds)


  number K
  number sigma
  vector Linfs(1,nponds)
  matrix pred_lengths(fage,lage,1,nponds)
  matrix resids(fage,lage,1,nponds)

  objective_function_value f

INITIALIZATION_SECTION
  log_K -1.61
  log_sigma 3.9
  t0 0
  

PRELIMINARY_CALCS_SECTION

  for (i=1;i<=nponds;i++) log_Linfs(i) = log(max(column(lengths,i)));
 

PROCEDURE_SECTION

  K=exp(log_K);
  sigma=exp(log_sigma);  
  Linfs=exp(log_Linfs);

  for (j=1;j<=nponds;j++) pred_lengths.colfill(j,Linfs(j)*(1.-exp(-K*(Ages-t0))));

  resids=lengths-pred_lengths;
  f=nobs*log_sigma + (0.5/square(sigma))*norm2(resids);


REPORT_SECTION
  report << "*** BACKTRANSFORMED PARAMETERS ***"<<endl;
  report << "K, t0, sigma :  "<< K <<" " << t0 <<" "<< sigma<<endl;
  report << "Linfs : " << Linfs << endl<<endl;
  report << "Observed lengths "<<endl;
  report << lengths <<endl<<endl;
  report << "Predicted lengths "<<endl;
  report << pred_lengths<<endl<<endl;
  report << "Residuals" << endl;
  report << resids <<endl;


   

  
