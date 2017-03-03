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

INITIALIZATION_SECTION
  log_K -1.61
  log_sigma 3.9
  log_sigma_Linf 3.9
  t0 0

PARAMETER_SECTION

  init_number log_K
  init_number log_sigma
  init_number log_sigma_Linf
  init_number t0
  //init_vector log_Linfs(1,nponds)
  init_number log_Linf_bar

  random_effects_vector Linf_devs(1,nponds)

  number K
  number sigma
  number sigma_Linf
  vector Linfs(1,nponds)
  matrix pred_lengths(fage,lage,1,nponds)
  matrix resids(fage,lage,1,nponds)

  objective_function_value f


PRELIMINARY_CALCS_SECTION

 // for (i=1;i<=nponds;i++) log_Linfs(i) = log(max(column(lengths,i)));
  log_Linf_bar=log(max(lengths));
 

PROCEDURE_SECTION

  K=exp(log_K);
  sigma=exp(log_sigma);
  sigma_Linf=exp(log_sigma_Linf);  
 // Linfs=exp(log_Linfs);
  Linfs=exp(log_Linf_bar)+Linf_devs;

 // for (j=1;j<=nponds;j++) pred_lengths.colfill(j,Linfs(j)*(1.-exp(-K*(Ages-t0))));

  for(j=1;j<=nponds;j++)
  {
  for(i=fage;i<=lage;i++) pred_lengths(i,j)=Linfs(j)*(1.-exp(-K*(Ages(i)-t0)));
  }
 
 // cout<<"log_Linf_bar "<<"log_K "<<"t0 "<<"log_sigma "<<"log_sigma_Linf "<<endl;
 // cout<<log_Linf_bar<<" "<<log_K<<" "<<t0<<" "<<log_sigma<<" "<<log_sigma_Linf<<endl;
 // cout<<"Linfs:"<<Linfs;
 // exit(55);

  resids=lengths-pred_lengths;
  f=nobs*log_sigma + (0.5/square(sigma))*norm2(resids);
  f+=double(size_count(Linf_devs))*log_sigma_Linf+(0.5/square(sigma_Linf))*norm2(Linf_devs);


REPORT_SECTION
  report << "*** BACKTRANSFORMED PARAMETERS ***"<<endl;
  report << "Linf_bar,K, t0, sigma, sigma_Linf :  "<<exp(log_Linf_bar)<<" "<< K <<" " << t0 <<" "<< sigma<<" "<<sigma_Linf<<endl;
  report << "Linfs : " << Linfs << endl<<endl;
  report << "Observed lengths "<<endl;
  report << lengths <<endl<<endl;
  report << "Predicted lengths "<<endl;
  report << pred_lengths<<endl<<endl;
  report << "Residuals" << endl;
  report << resids <<endl;


   

  
