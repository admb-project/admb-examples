DATA_SECTION

  init_int n                 // Number of grid_cels
  init_ivector counts(1,n)   // Response (count)
  init_vector aff(1,n)       // Continuous covariate
  init_vector E(1,n)	     // Expected count (offset-type)							

  !!USER_CODE ad_comm::change_datafile_name("scotlandgraph.dat");
  init_ivector m(1,n)       // Number of neighbors
  init_imatrix W(1,n,0,m)   // Compressed neighbor matrix

  !! cout << W << endl;
     
PARAMETER_SECTION

  init_bounded_number b(-10.0,10.0,1) 
  init_bounded_number sigma(0.00001,10.0,2)	// SD(phi) 
  init_bounded_number tau(0.00001,10.0,3) 	// SD(theta)

  random_effects_vector phi(1,n,2)   // CAR random field
  random_effects_vector theta(1,n,3) // Independent heterogeneities

  objective_function_value g
  
PROCEDURE_SECTION

  int i;     
 
  for (i=1;i<=n;i++)
  {
    int is_island = (m(i) == 0);


    ll_poisson(phi(i),theta(i),b,sigma,tau,i,is_island);  

    n01_prior(theta(i));	// Independent effects

    if(is_island)
      n01_prior(phi(i));	// In this case phi(i) should not be used, 
				// according to the winbugs example. In ADMB
				// we nevertheless must assign a prior to it.
				// The alternative would be to omit it from
 				// the phi-vector, but that is notationally clumsy.
    else
      car_prior(phi(W(i)),i);	// Here: phi(W(i) = area-i and its neighboors.
  }


SEPARABLE_FUNCTION void n01_prior(const dvariable& phi)
  g -= -0.5*square(phi);

SEPARABLE_FUNCTION void car_prior(const dvar_vector& phi,const int i)

  dvariable mean = sum(phi(1,m(i)))/m(i);
  g -= -0.5*square(phi(0)-mean)*m(i);
            
SEPARABLE_FUNCTION void ll_poisson(const dvariable& phi, const dvariable& theta, const dvariable& b, const dvariable& sigma, const dvariable& tau, int i, int is_island)

  dvariable eta = b*aff(i)/10 + tau*theta;

  if(!is_island)
    eta += sigma*phi;

  dvariable mu = E(i)*mfexp(eta);
  g -= log_density_poisson(counts(i),mu);
    

TOP_OF_MAIN_SECTION
  arrmblsize = 4000000L;
  gradient_structure::set_GRADSTACK_BUFFER_SIZE(500000);
  gradient_structure::set_CMPDIF_BUFFER_SIZE(2000000);
  gradient_structure::set_MAX_NVAR_OFFSET(50850);
