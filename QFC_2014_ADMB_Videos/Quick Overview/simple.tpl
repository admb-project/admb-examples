

DATA_SECTION
  init_int nobs
  init_vector Y(1,nobs)
  init_vector X(1,nobs)
PARAMETER_SECTION
  init_number a
  init_number b
  vector pred_Y(1,nobs)
 
  objective_function_value f

PROCEDURE_SECTION
  pred_Y=a*X+b;
  f=(norm2 (pred_Y-Y));
  f=nobs/2.*log(f);
