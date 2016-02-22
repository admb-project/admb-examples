DATA_SECTION
  vector lengths(1,10)
  vector ages(1,10)
  !! lengths.fill_seqadd(1,1);
  !! ages.fill_seqadd(1,1);
  !! lengths=sqrt(lengths);

PARAMETER_SECTION
  init_bounded_number linf(0,10)
  init_bounded_number rho(0,1)
  objective_function_value f;

PROCEDURE_SECTION
  for (int i=1;i<=10;i++)
  f+=square(lengths(i)-vb_growth(linf,rho,ages(i)));

GLOBALS_SECTION
  #include <admodel.h>
  dvariable vb_growth(const prevariable& linf, const prevariable& rho, double t)
  {
   double clinf=value(linf);
   double crho=value(rho);
   dvariable len;
   value(len)=clinf*(1-pow(crho,t));
   double dflinf=1-pow(crho,t);
   double dfrho=-clinf*t*pow(crho,t-1);
   AD_SET_DERIVATIVES2(len,rho,dfrho,linf,dflinf); // 3 dependent variable
   return len;
  }
