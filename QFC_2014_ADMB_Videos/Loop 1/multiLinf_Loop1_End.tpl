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

PARAMETER_SECTION

  init_number log_K
  init_number log_sigma
  init_number t0
  init_vector log_Linfs(1,nponds)

  number K
  number sigma
  vector Linfs
  matrix pred_lengths(fage,lage,1,nponds);
  matrix resids(fage,lage,1,nponds);

  objective_function_value f

INITIALIZATION_SECTION
  log_K -1.61
  log_sigma 3.9
  t0 0

PRELIMINARY_CALCS_SECTION
 
  for(int i=1;i<=nponds;i++) log_Linfs(i) = log(max(column(lengths,i)));

  //cout<<log_Linfs<<endl;
  //exit(51);

PROCEDURE_SECTION



REPORT_SECTION
  

  
