DATA_SECTION
	init_int nobs;
	init_vector totcones(1,nobs);
	init_vector dbh(1,nobs);
PARAMETER_SECTION
	init_number a;
	init_number b;
	init_bounded_number k(0.01,1000);
	vector mu(1,nobs); //store predictions in here
	objective_function_value nll;
PROCEDURE_SECTION
	mu=a*pow(dbh, b);
	nll=dnbinom(totcones, mu, k);
