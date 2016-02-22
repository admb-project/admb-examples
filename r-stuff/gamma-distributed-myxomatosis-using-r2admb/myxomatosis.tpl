DATA_SECTION
	init_int nobs
	init_vector titer(1,nobs)
	init_vector day(1,nobs)
PARAMETER_SECTION
	init_number a
	init_number b
	init_number s
	vector m(1,nobs)
	objective_function_value nll
PROCEDURE_SECTION
	m=Ricker(day, a, b);
	nll=dgamma(titer, s, s/m);//shape=s, rate=s/m
GLOBALS_SECTION
	#include <statsLib.h>
	#include <ecolib.h>
	