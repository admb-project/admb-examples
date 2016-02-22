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
  imatrix alpha			// Pattern of Q1 
  imatrix beta			// Pattern of Q1 
  init_matrix N(1,n,1,m)        // data
  int nzalpha
  int nzbeta
 LOC_CALCS
  alpha.allocate(1,3,1,3*n-2);
  beta.allocate(1,3,1,3*m-2);
  alpha=sparse_info(n); // alpha(1) contains the first index
                        // alpha(2) contains the second index 
                        // alpha(3) contains the type
  beta=sparse_info(m);
  nzalpha=alpha(1).indexmax();
  nzbeta=beta(1).indexmax();

PARAMETER_SECTION
  
  init_bounded_number log_sigma_eps(-3.,3.,2)
  sdreport_number real_sig_eps
  sdreport_number real_sig_eps2
  init_bounded_number log_sigma(-3.0,3.0)
  init_bounded_number phi1(0.001,0.999)
  init_bounded_number phi2(0.001,0.999)
  init_vector mm(1,p)
  random_effects_matrix u(1,n,1,m)
  objective_function_value f

PROCEDURE_SECTION
  int i;

  f=0;
  for(i=1;i<=nzalpha;i++)
  {   // Loop through non-zeros of Q1
    int ia=alpha(1,i);
    int ka=alpha(2,i);
    for(int j=1;j<=nzbeta;j++)
    { // Loop through non-zeros of Q2
      int jb=beta(1,j);
      int lb=beta(2,j);
      quad_form(i,j,phi1,phi2,u(ia,jb),u(ka,lb));
    }
  }

  // log-determinant of Kronecker product:
  logdetQ_contrib(phi1,phi2);

  for (int i=1;i<=nobs;i++)
  {
    normal_ll(i,mm(variety(i)),log_sigma_eps,log_sigma,u(lat(i),longitude(i)));
  }
  #if defined(SCALED)
    real_sig_eps=exp(log_sigma_eps);
  #else
    dvariable kappa1=1/(1-phi1*phi1);  
    dvariable kappa2=1/(1-phi2*phi2);  
    real_sig_eps=exp(log_sigma_eps)/(kappa1*kappa2);
    real_sig_eps2=exp(log_sigma_eps)*(kappa1*kappa2);
  #endif

SEPARABLE_FUNCTION void normal_ll(int i,const prevariable & mm,const prevariable & log_sigma_eps,const prevariable & log_sigma ,const prevariable &  uij)

    dvariable pred=mm+exp(log_sigma_eps)*uij;
    f+=0.9189385332046+log_sigma+0.5*square((yield(i)-pred)/exp(log_sigma));

SEPARABLE_FUNCTION void quad_form(int i,int j,const dvariable& phi1, const dvariable& phi2, const dvariable& ui, const dvariable& uj)
  dvariable Q1x;
  dvariable Q2x;

  #if defined(SCALED)
    dvariable kappa1=1/(1-phi1*phi1);  
    dvariable kappa2=1/(1-phi2*phi2);  
  #endif

  switch(alpha(3,i))
  {
  case 1:
    Q1x=-phi1; 
    break;
  case 2:
    Q1x=1; 
    break;
  case 3:
    Q1x=1+phi1*phi1;
    break;
  default:
    cout << "Bad bound in Qx(" << i << ")" << endl;
    ad_exit(1);
  }
  switch(beta(3,j))
  {
  case 1:
    Q2x=-phi2; 
    break;
  case 2:
    Q2x=1; 
    break;
  case 3:
    Q2x=1+phi2*phi2;
    break;
  default:
    cout << "Bad bound in Qx(" << j << ")" << endl;
    ad_exit(1);
  }

  #if defined(SCALED)
    f += 0.5*ui*Q1x*Q2x*uj*kappa1*kappa2;
  #else
    f += 0.5*ui*Q1x*Q2x*uj;
  #endif


SEPARABLE_FUNCTION void logdetQ_contrib(const dvariable& phi1,const prevariable& phi2)
  dvariable logdet1=log(1-square(phi1));
  #if defined(SCALED)
    dvariable kappa1=1/(1-square(phi1));
    logdet1+=n*log(kappa1);
  #endif
  f -= 0.5*m*logdet1;

  dvariable logdet2=log(1-square(phi2));
  #if defined(SCALED)
    dvariable kappa2=1/(1-square(phi2));
    logdet2+=m*log(kappa2);
  #endif
  f -= 0.5*n*logdet2;


TOP_OF_MAIN_SECTION
  arrmblsize=40000000;
  gradient_structure::set_GRADSTACK_BUFFER_SIZE(2000000);
  gradient_structure::set_CMPDIF_BUFFER_SIZE(100000000);
  gradient_structure::set_MAX_NVAR_OFFSET(2000000);
GLOBALS_SECTION
  #include <admodel.h>
  
  imatrix sparse_info(int n)
  {
    // get the row and column indices for an n dimensional
    // triadiagonal matrix if stored as a vector
    // also store the type information for each term
    int nz=3*n-2;
    imatrix M(1,3,1,nz);
    ivector& ia=M(1);
    ivector& ja=M(2);
    ivector& type=M(3);
    int ii=0;
    for (int j=1;j<=n;j++)
    {
      int imin=max(1,j-1);
      int imax=min(n,j+1);
      for (int i=imin;i<=imax;i++)
      {
        ii++;
        ia(ii)=i;
        ja(ii)=j;
        if(i!=j) 
          type(ii)=1;
        else if (i==1 || i==n)
          type(ii)=2;
        else
          type(ii)=3;
      }
    }
    return M;
  }
  
  
