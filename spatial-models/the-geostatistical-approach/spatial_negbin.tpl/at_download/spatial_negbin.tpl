DATA_SECTION

  init_int n                    // Number of observations
  init_ivector Y(1,n)            // 
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
  init_bounded_number tau(1.0,20.0)		// Overdispersion of negbin distribution
  init_bounded_number a(0.001,1.0,2)		// Correlation parameter

  random_effects_vector u(1,n,2)
  normal_prior M(u);

  objective_function_value l

PROCEDURE_SECTION
  int i;

  for (i=1;i<=n;i++)
    negbin_loglik(i,u(i),beta,log_sigma,tau);         // Likelilhood arising from measurement error

SEPARABLE_FUNCTION void negbin_loglik(int i,const dvariable& u_i,const dvariable& beta,const dvariable& log_sigma,const dvariable& tau)
    dvariable sigma = exp(log_sigma);
    dvariable mu = exp(beta + sigma*u_i);       // Mean of Y
    l -= log_negbinomial_density(Y(i),mu,tau);

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

