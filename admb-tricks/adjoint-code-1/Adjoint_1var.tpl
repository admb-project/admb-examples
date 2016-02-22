DATA_SECTION
PARAMETER_SECTION
  init_number x
  !! x=2;
  objective_function_value f;

PROCEDURE_SECTION
  f=square(errf(x));

GLOBALS_SECTION
  #include <admodel.h>
  dvariable errf(const prevariable& x)
  {
   dvariable y;
   value(y)=exp(-0.5*square(value(x)));
   double dfx=-value(x)*value(y);
   AD_SET_DERIVATIVES1(y,x,dfx); // 1 dependent variable
   return y;
  }
