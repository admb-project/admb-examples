

TOP_OF_MAIN_SECTION
  //gradient_structure::set_NUM_DEPENDENT_VARIABLES(20000);
  //gradient_structure::set_MAX_NVAR_OFFSET(20000);
  //arrmblsize = 400000000;
  //gradient_structure::set_GRADSTACK_BUFFER_SIZE(35000000); // This is about the highest I can get it on my laptop, but Taylor and Hicks say 2e9 is the windows limit
  //gradient_structure::set_CMPDIF_BUFFER_SIZE(35000000);   // This is about the highest I can get it on my laptop, but Taylor and Hicks say 2e9 is the windows limit

// =====================================================================

DATA_SECTION
  !!CLASS ofstream post("post.csv");        // Crazy jibberish for dumping results in a text file

  init_number Heat
  
  init_vector Mean1(1,2)
  init_vector Mean2(1,2)
  init_number LnDet1
  init_number LnDet2
  init_matrix Inv1(1,2,1,2)
  init_matrix Inv2(1,2,1,2)
  init_vector Mix(1,2)

  !! cout << "Mean1 " << Mean1 << endl;
  !! cout << "Mean2 " << Mean2 << endl;
  !! cout << "LnDet1 " << LnDet1 << endl;
  !! cout << "LnDet2 " << LnDet2 << endl;
  !! cout << "Inv1 " << Inv1 << endl;
  !! cout << "Inv2 " << Inv2 << endl;
  !! cout << "Mix " << Mix << endl;
  
      

// =====================================================================

PARAMETER_SECTION

  init_bounded_number Dummy(-10,10,-1)   //# This is to show that the method works with fixed parameters
  init_bounded_vector Loc(1,2,-10,10,1)
  
  sdreport_vector LocRep(1,2)
  
  number LL1
  number LL2
  
  objective_function_value nll

// =====================================================================

INITIALIZATION_SECTION
  Loc 1

// =====================================================================

PROCEDURE_SECTION
  LocRep = Loc;
  
  LL1 = ( 2*log(2*3.141592) + LnDet1 + (Loc-Mean1)*Inv1*(Loc-Mean1) ) * -1/2;   //# ADMB failed on my compiler with the -1/2 in the front!
  LL2 = ( 2*log(2*3.141592) + LnDet2 + (Loc-Mean2)*Inv2*(Loc-Mean2) ) * -1/2;

  nll = -1 * log( mfexp(LL1)*Mix(1) + mfexp(LL2)*Mix(2) ) / Heat;

  if(mceval_phase()){
    post << nll <<endl;
  }

// =====================================================================

REPORT_SECTION
  
// =====================================================================

