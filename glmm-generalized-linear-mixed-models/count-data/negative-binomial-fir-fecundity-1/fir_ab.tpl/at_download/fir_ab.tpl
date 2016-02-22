DATA_SECTION
	init_int nobs;
	init_vector totcones(1,nobs);
	init_vector dbh(1,nobs);
	init_matrix wave_non(1,nobs,1,2);
PARAMETER_SECTION
	init_vector a_coeffs(1,2);
	init_vector b_coeffs(1,2);
	init_bounded_number k(0.01,1000);
	vector a(1,nobs);
	vector b(1,nobs);
	vector mu(1,nobs); //store predictions in here
	objective_function_value nll;
PROCEDURE_SECTION
	a=wave_non*a_coeffs;
	b=wave_non*b_coeffs;
	mu=elem_prod(a, pow(dbh, b));
	nll=dnbinom(totcones, mu, k);
