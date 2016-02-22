DATA_SECTION
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

  random_effects_vector u(1,n,2)
  normal_prior M(u);

  objective_function_value l

PROCEDURE_SECTION
  int i;

  for (i=1;i<=n;i++)
    normal_loglik(i,u(i),beta,log_sigma,log_sigma_e);         // Likelilhood arising from measurement error

SEPARABLE_FUNCTION void normal_loglik(int i,const dvariable& u_i,const dvariable& beta,const dvariable& log_sigma,const dvariable& log_sigma_e)
    dvariable sigma = exp(log_sigma);
    dvariable sigma_e = exp(log_sigma_e);
    dvariable mu = beta + sigma*u_i;       // Linear predictor
    l -= -log_sigma_e - 0.5*square((Y(i)-mu)/sigma_e);

NORMAL_PRIOR_FUNCTION void get_M(const dvariable& a)
  int i,j;
  dvar_matrix tmpM(1,n,1,n);

  for (i=1;i<=n;i++)
  {
    tmpM(i,i)=1.0;
    for ( j=1;j<i;j++)
    {
      tmpM(i,j)=exp(-a*d(i,j));                       // Exponentially decaying correlation
      tmpM(j,i)=tmpM(i,j);
    }
  }
  M=tmpM;

FUNCTION void evaluate_M(void)	                     // You CAN NOT change the name of this funtion
  get_M(a);					     // Call the function of NORMAL_PRIOR_FUNCTION type


TOP_OF_MAIN_SECTION
  arrmblsize = 40000000L;
  gradient_structure::set_GRADSTACK_BUFFER_SIZE(3000000);
  gradient_structure::set_CMPDIF_BUFFER_SIZE(200000);
  gradient_structure::set_MAX_NVAR_OFFSET(460404);

REPORT_SECTION
  report << Y - (beta+u*exp(log_sigma)) << endl; 	// Residual
