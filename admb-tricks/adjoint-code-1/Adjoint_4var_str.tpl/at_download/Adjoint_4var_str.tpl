DATA_SECTION
  vector lengths(1,10)
  vector ages(1,10)
  !! lengths.fill_seqadd(1,1);
  !! ages.fill_seqadd(1,1);
  !! lengths=sqrt(lengths);

PARAMETER_SECTION
  init_bounded_number linf(0,10)
  init_bounded_number rho(0,1)
  init_number t0
  init_bounded_number gamma(.1,1.9)
  objective_function_value f;

PROCEDURE_SECTION
  for (int i=1;i<=10;i++)
  f+=square(lengths(i)-vb_growth(linf,rho,t0,gamma,ages(i)));

GLOBALS_SECTION
  #include <admodel.h>
  dvariable vb_growth(const prevariable& linf, const prevariable& rho,
  const prevariable& t0, const prevariable gamma,double t)
  {
   double clinf=value(linf);
   double ct0=value(t0);
   double crho=value(rho);
   double cgamma=value(gamma);
   dvariable len;
   double u1=pow(crho,t-ct0);
   double u2=clinf*(1-u1);
   value(len)=pow(u2,cgamma);
   double dflen=1.0;
   //value(len)=pow(u2,cgamma);
   double dfu2=dflen*cgamma*pow(u2,cgamma-1.0);
   double dfgamma=dflen*value(len)*log(u2);
   //double u2=clinf*(1-u1);
   double dflinf=dfu2*(1-u1);
   double dfu1=-dfu2*clinf;
   //double u1=pow(crho,t-ct0);
   double dfrho=dfu1*(t-ct0)*pow(crho,t-ct0-1.0);
   double dft0=-dfu1*u1*log(crho);
   AD_SET_DERIVATIVES4(len,t0,dft0,rho,dfrho,linf,dflinf,gamma,dfgamma);
   // 4 dependent variable
   return len;
  }
