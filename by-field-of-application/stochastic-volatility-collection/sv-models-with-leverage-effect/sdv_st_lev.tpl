// SV-model with skewed t-distribution and leverage

DATA_SECTION

  init_number C                 // Scale in weight

  init_int n                    // Length of time series
  int n1
  !! n1 = n+1;                  // Number of states
  init_vector y(1,n)                // Time series

PARAMETER_SECTION

  init_bounded_number phi(-.9999,.9999,2)//3)   // Autoregressian parameter
  init_bounded_number log_sigma(-3.0,3.0,2)//3) // log(sigma)
  init_bounded_number log_sigma_x(-10,3,1)  // log(sigma)   
  init_bounded_number nu(2.001,50.0,1)      // D.F. in t-distribution
  init_bounded_number lambda(-.9999,.9999,2)    // Skw parameter
  init_bounded_number rho(-0.9999,.999,2)	// Correlation coefficient

  sdreport_number sigma2
  
  sdreport_number sigma
  sdreport_number sigma_x

  random_effects_vector h(1,n1,2)       // State variable

  objective_function_value g

PRELIMINARY_CALCS_SECTION
  cout << setprecision(4);

GLOBALS_SECTION

  //#include <df1b2fun.h>
  
PROCEDURE_SECTION

  int i;    

  // Likelihood contribution from h(1)
  sf1(log_sigma,phi,h(1));

  // Likelihood contribution from h(2),...,h(n)
  for (i=2;i<=n+1;i++)
  {
    sf2(log_sigma,log_sigma_x,rho,phi,h(i),h(i-1),i);
  }

  // Likelihood contribution from data
  for (i=1;i<=n;i++)
  {
    sf3(h(i),log_sigma_x,nu,lambda,i);
  }
  
  if (sd_phase())
  {
    sigma = exp(log_sigma);
    sigma_x = exp(log_sigma_x);
  }  

  if(mceval_phase())
    mcmc_out(phi,log_sigma,log_sigma_x,nu,lambda);
    

SEPARABLE_FUNCTION void sf1(const dvariable& ls,const dvariable& Phi,const dvariable& h_1)
  g -= -0.9189385332046727 -ls + 0.5*log(1-square(Phi))  - 0.5*square(h_1/mfexp(ls))*(1-square(Phi));


SEPARABLE_FUNCTION void sf2(const dvariable& ls,const dvariable& ls_x,const dvariable& Rho,const dvariable& Phi,const dvariable& h_i,const dvariable& h_i1,int i)

  dvariable sigma = mfexp(ls);
  dvariable c1 = mfexp(ls_x + 0.5*h_i1);
  dvariable c2 = Rho*sigma/c1;
  dvariable c3 = Phi*h_i1;
  dvariable EhIyh = c3 + c2*y(i-1);

  dvariable SD_hIyh = sigma*sqrt(1-square(Rho));

  g -= -0.9189385332046727 - log(SD_hIyh) - .5*square((h_i - EhIyh)/SD_hIyh);


SEPARABLE_FUNCTION void sf3(const dvariable& h_i, const dvariable& ls_x, const dvariable& Nu, const dvariable& Lambda, int i)
  dvariable SD_yIh = mfexp(ls_x + 0.5*h_i);
  dvariable t = y(i)/SD_yIh;                    // Quantity which has skw_t-distribution

  // Constants in Hansen paper
  dvariable log_c = gammln(0.5*(Nu+1.0)) - gammln(0.5*Nu) - 0.5*log(Nu-2.0) - 0.5723649429;
  dvariable a = 4.0*Lambda*mfexp(log_c)*(Nu-2.0)/(Nu-1.0);      
  dvariable b = sqrt(1.0+3.0*square(Lambda)-square(a));     

  // The following code is a trick to avoid non-differentialbility
  dvariable log_g1, log_g2;
  dvariable tmp;
  tmp = 1.0 - Lambda;
  log_g1 = -0.5*(Nu+1.0)*log(1.0 + 1/(Nu-2.0)*square((b*t+a)/tmp));
  tmp = 1.0 + Lambda;
  log_g2 = -0.5*(Nu+1.0)*log(1.0 + 1/(Nu-2.0)*square((b*t+a)/tmp));

  dvariable w = mfexp(-C*(t+a/b));
  w /= 1.0 + w;                         // Logistic weight


  g -=  - (ls_x + 0.5*h_i);                     // Log-contribution from Jacobian term
  g -=  log(b) + log_c;                     // log(bc) 
  g -=  w*log_g1 + (1.0-w)*log_g2;                  // Difficult part


SEPARABLE_FUNCTION void  mcmc_out(const prevariable& phi,const prevariable& log_sigma, const prevariable& log_sigma_x, const prevariable& nu, const prevariable& lambda)
    cout << phi << " " << exp(log_sigma) << " " << exp(log_sigma_x) << " " << nu << " " << lambda<< endl;


REPORT_SECTION

TOP_OF_MAIN_SECTION
  arrmblsize = 4000000L;
  gradient_structure::set_GRADSTACK_BUFFER_SIZE(300000);
  gradient_structure::set_CMPDIF_BUFFER_SIZE(20000);
  gradient_structure::set_MAX_NVAR_OFFSET(50850);


