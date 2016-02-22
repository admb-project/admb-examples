// Example of how to parameterize a correlation matrix C via its Cholesky factor L.
// Estimate (.rep file) C in a Gaussian model where it matches the empirical correlation matrix 

DATA_SECTION
 
  init_matrix y(1,30,1,4)			// Data

PARAMETER_SECTION

  matrix L(1,4,1,4)				// Cholesky factor 
  init_vector a(1,6) 				// Free parameters in L
  init_bounded_vector sd(1,4,.001,1000) 	// Standard deviations
  init_vector mu(1,4) 				// Mean parameter

  objective_function_value l
 

PROCEDURE_SECTION
  int i, j;

  // Build L and C
  int k=1;
  L(1,1) = 1.0;
  for(i=2;i<=4;i++)
  {
    L(i,i) = 1.0;
    for(j=1;j<=i-1;j++)
      L(i,j) = a(k++);
    L(i)(1,i) /= norm(L(i)(1,i)); 		// Ensures that C(i,i) = 1
  }
  dvar_matrix C = L*trans(L);			// Correlation matrix

  // Scale up to variances (maybe not the most efficient way of doing this)
  dvar_matrix S(1,4,1,4);			// Covariance matrix
  for(i=1;i<=4;i++)
    for(j=1;j<=4;j++)
      S(i,j) = sd(i)*sd(j)*C(i,j);
;			   
  // Gaussian likelihood
  for(i=1;i<=30;i++)
  {
    dvar_vector tmp = solve(S,y(i)-mu);		// More efficient to calculate the inverse of S outside loop
    l -= -0.5*log(det(S)) - 0.5*tmp*(y(i)-mu);    
  }

REPORT_SECTION
  report << L*trans(L) << endl;

TOP_OF_MAIN_SECTION
  arrmblsize = 4000000L;
  gradient_structure::set_GRADSTACK_BUFFER_SIZE(30000000);
  gradient_structure::set_CMPDIF_BUFFER_SIZE(500000000);
  gradient_structure::set_MAX_NVAR_OFFSET(50000);

