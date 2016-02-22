//Fits a binomial gam via maximum likelihood based on methods described in Section 6.6.1 of
//Wood, S. N. 2006. Generalized additive models: an introduction with R.

GLOBALS_SECTION

 #include "c:\work\getbigs.cpp"
 
DATA_SECTION
 init_int nobs
 init_int ncol_X
 init_vector n(1,nobs)
 init_vector y(1,nobs)
 // X and S are provided by gam(fit = FALSE) in mgcv library
 init_matrix X(1,nobs,1,ncol_X) //cubic spline basis matrix, first column is intercept
 init_matrix S(1,ncol_X,1,ncol_X) //cubic spline penalty matrix, padded with zeros for unpenalized intercept
 init_matrix U(1,ncol_X,1,ncol_X) //eigenvectors of S
 init_vector u(1,ncol_X) //eigenvalues of S
 init_int betas_phase //when to estimate fixed effects
 init_int smooth_reff_phase //when to estimate random effects
 init_int lambda_par_phase //when to estimate smoothing parameter
 int n_F
 int n_R
 LOCAL_CALCS
  n_F = 0;
  n_R = 0;
  for(int i = 1; i <= ncol_X; i++){
   if(u(i) < 1e-10) n_F +=1;
   else n_R += 1;
  }
  cout << "n_F: " << n_F << endl; //number of fixed effects, intercept and n_F-1 for smoother
  cout << "n_R: " << n_R << endl; //number of random effects for smoother
 END_CALCS
 matrix U_F(1,ncol_X,1,n_F)
 matrix U_R(1,ncol_X,1,n_R)
 matrix X_F(1,nobs,1,n_F)
 matrix X_R(1,nobs,1,n_R)
 vector D_plus(1,n_R) 
 int jj
 LOCAL_CALCS
  jj = 0;
  for(int i = 1; i <= ncol_X; i++){
   if(u(i) < 1e-10) {
    jj += 1;
    U_F.colfill(jj,column(U,i));
   }
   else {
    U_R.colfill(i-jj,column(U,i));
    D_plus(i-jj) = u(i); //non-zero eigenvalues of S are known variance components for random effects
   }
  }
  X_R = X * U_R;
  X_F = X * U_F;

 END_CALCS
  
PARAMETER_SECTION
 
 init_vector betas(1,n_F,betas_phase) //fixed effects (intercept and fixed effects portion of smoother)
 init_number lambda_par(lambda_par_phase)  //log smoothing parameter
 random_effects_vector smooth_reff(1,n_R,smooth_reff_phase) // random effects portion of smoother
 sdreport_vector transformed_betas(1,ncol_X) //betas for X that match mgcv results, small differences due to diffferent estimation methods
 objective_function_value nll

PROCEDURE_SECTION
	
	//prior distribution of smoother random effects
	nll -= -0.5*(n_R*(log(2.0*M_PI) - lambda_par) - sum(log(D_plus)) + mfexp(lambda_par)* 
		sum(elem_prod(smooth_reff, elem_prod(D_plus, smooth_reff))));
	
	dvar_vector eta(1,nobs); //linear predictor
	dvar_vector mu(1,nobs); //inverse link
	
	eta = X_F * betas + X_R * smooth_reff;
	mu = mfexp(-1.0*log(1 + mfexp(-eta))); //expit = inverse of logit link
	
	//binomial log-likelihood conditional on random effects
	nll -= sum(gammln(n + 1.0) - gammln(y + 1.0) - gammln(n - y + 1.0)) + y*log(mu) + (n-y)*log(1-mu);
	
	if(sd_phase()) {
		transformed_betas = U_F * betas + U_R * smooth_reff;
	}		
