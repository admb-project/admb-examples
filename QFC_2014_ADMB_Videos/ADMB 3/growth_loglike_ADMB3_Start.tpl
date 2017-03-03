//von Bertalanffy growth model

DATA_SECTION
  
  init_int nobs
  init_matrix vonBdata(1,nobs,1,2)
  init_vector testvec(1,3)
  !!cout<< "the test vector is " << testvec << endl;
  !!exit(43);

PARAMETER_SECTION
  
  init_number t0  //age at which length is 0
  objective_function_value nll  // The objective function (required)

PROCEDURE_SECTION
  cout << "we are at top of procedure section" << endl;
  exit(44);
