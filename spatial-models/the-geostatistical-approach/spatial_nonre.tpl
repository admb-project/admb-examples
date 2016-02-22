DATA_SECTION

  !!USER_CODE ad_comm::change_datafile_name("spatial_simple.dat");
  init_int n                    // Number of observations
  init_vector Y(1,n)            // 
  init_matrix Z(1,n,1,2)        // Locations (xy-coordinates)

  // Construct distance matrix
  matrix d(1,n,1,n);           
 LOC_CALCS
  d.initialize();
  for(int i=1;i<=n;i++)
  {
    for (int j=1;j<i;j++)
    {
      d(i,j)=sqrt(square(Z(i,1)-Z(j,1))+square(Z(i,2)-Z(j,2)));
      d(j,i)=d(i,j);		//Symmetry
    }
  }
 END_CALCS

PARAMETER_SECTION

  init_number beta				// Expectation value
  init_bounded_number log_sigma(-5.0,5.0,2)	// log-SD laten random field 
  init_bounded_number log_sigma_e(-5.0,5.0)		// log-SD easurement error
  init_bounded_number a(0.001,1.0,2)		// Correlation parameter

  matrix M(1,n,1,n)			// Correlation matrix of u
  matrix S(1,n,1,n)			// Covariance matrix of Y

  number sigma_e2
  number sigma2

  objective_function_value l

PROCEDURE_SECTION

  int i;

  sigma_e2 = square(exp(log_sigma_e));
  sigma2 = square(exp(log_sigma));
  M = exp(-a*d);

  S = sigma2*M;
  for (i=1;i<=n;i++)
    S(i,i) += sigma_e2;

  l = 0;
  l -= -0.5*log(det(S)) - 0.5*(Y-beta)*solve(S,Y-beta);


