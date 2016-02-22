DATA_SECTION
  init_int nobs
  init_matrix data(1,nobs,1,7)
  vector variety
  vector rep
  vector yield
  vector lat
  vector longitude
  int n
  int m
  int p
  int q

 LOCAL_CALCS
  variety=column(data,2);
  rep=column(data,4);
  yield=column(data,5);
  lat=column(data,6);
  longitude=column(data,7);
  n=max(lat);
  m=max(longitude);
  p=max(variety);
 END_CALCS

  !! cout << n << " "<< m << " " << p << endl;

PARAMETER_SECTION
  
  init_bounded_number log_sigma_eps(-5.,5.,2)	// 
  init_bounded_number log_sigma(-5.0,5.0)	// SD of measurement error
  init_bounded_number phi1(0.001,0.999)
  init_bounded_number phi2(0.001,0.999)		// SD of innovation of AR1 process in both spatial directions
  init_vector mm(1,p)
  vector mu(1,nobs)

  matrix C1(1,n,1,n)
  matrix C2(1,m,1,m)
  matrix S(1,nobs,1,nobs)

  objective_function_value f

PROCEDURE_SECTION
  int i,j,ii,jj;

// Find mean vector
  for(i=1;i<=nobs;i++)
    mu(i) = mm(variety(i));
  
// Covariance matrix in latitudinal direction
  for(i=1;i<=n;i++)
    for(j=1;j<=n;j++)
      C1(i,j) = pow(phi1,abs(i-j));

// Covariance matrix in longitudinal direction
  for(i=1;i<=m;i++)
    for(j=1;j<=m;j++)
      C2(i,j) = pow(phi2,abs(i-j));

// Kronecker product
  for(ii=1;ii<=n;ii++)
    for(jj=1;jj<=n;jj++)
      for(i=1;i<=m;i++)
        for(j=1;j<=m;j++)
          S((ii-1)*m+i,(jj-1)*m+j) = C1(ii,jj)*C2(i,j);

// Scale up with variances
  S *= exp(2*log_sigma_eps)/(1-square(phi1))/(1-square(phi2));

// Add observational variance to diagonal

  for(i=1;i<=nobs;i++)
    S(i,i) += exp(2*log_sigma);

  f = 0.5*log(det(S)) + 0.5*(yield-mu)*solve(S,yield-mu);

REPORT_SECTION
  report << S << endl;
  report << C1 << endl;
  report << C2 << endl;

TOP_OF_MAIN_SECTION
  arrmblsize=40000000;
  gradient_structure::set_GRADSTACK_BUFFER_SIZE(2000000);
  gradient_structure::set_CMPDIF_BUFFER_SIZE(100000000);
  gradient_structure::set_MAX_NVAR_OFFSET(2000000);

