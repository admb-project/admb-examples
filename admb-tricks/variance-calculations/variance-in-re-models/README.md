# Covariance in RE models — ADMB Project

Filed Under: [ADMB Tricks][3], [Variance Calculations][4]

In RE (random effects) models there are two types of parameters, x (parameter in the ordinary sense) and u (random effect). This documents tries to shed some light on how the variance of x and u are calculated. The covariance matrix of the x vector is based on the (marginal) likelihood, obtained via the Laplace approximation, and corresponds to the way covariance matrices are calculated in non-RE models in ADMB.

##Theory
Here is what the user manual says about the variance of u (the manual talks about "theta" instead of "x"): [usermanual.pdf][1] A few words can be added to this.

The formula is based on the [Law of total variance][2]:

In our context this says:

Var(u) = Ex[var(u|x)] + varx(E(u|theta)

The expectation "Ex" is obtained simply by inserting the point estimate of x into "var(u|x)". The second term is based on the "delta method" which is used elsewhere in ADMB, in combination with the covariance matrix of x (described above). Everything in these calculations are conditional on "data".

##Example: simple & hierarchical model

Consider the following simple Gaussian hierarchical model:

     Prior on x: x = e1
       u|x: u = x + e2
       y|u: y = u + e3
    				// where e1, e2, e3 are all distributed N(0,1)

R code for the covariance matrix

    S = matrix(0,3,3,row=c("x","u","y"),col=c("x","u","y"))
    S[,]=1
    S[2:3,2:3]=2
    S[3,3]=3
    S12_3 = S[1:2,1:2] - S[1:2,3]%*%solve(S[3,3])%*%S[3,1:2]

We are interested in the conditional variance of x and u given data (y).

    > sqrt(diag(S12_3))
            x         u
    0.8164966 0.8164966
    > cov2cor(S12_3)
        x   u
    x 1.0 0.5
    u 0.5 1.0

 

##Corresponding quantities in ADMB

An implementation of this model in ADMB is:

     DATA_SECTION
       number y
       !! y=10.0;
    PARAMETER_SECTION
       init_number x
       random_effects_vector u(1,1)
       objective_function_value f
    PROCEDURE_SECTION
       f = 0.0;
       f -= -0.5*square(x);	 	// Prior on x: x = e1
       f -= -0.5*square(u(1)-x);    // u|x: u = x + e2
       f -= -0.5*square(y-u(1));    // y|u: y = u + e3
    				// where e1, e2, e3 are all distributed N(0,1); standard normal
    GLOBALS_SECTION
      #include "getbigs.cpp"

NOTE: as of Nov 29 2012 you need to include "getbigs.cpp" due to a recently discovered bug in ADMB.

The result you get when you run ADMB matches those from R:

    D:tmptmp>more simple_variance.cor
     The logarithm of the determinant of the hessian = 0.405465
     index   name    value      std dev       1
         1   x 3.3335e+000 8.1650e-001   1.0000
         2   u 6.6668e+000 8.1650e-001   0.5000  1.0000

[1]: usermanual.pdf "usermanual.pdf"
[2]: https://en.wikipedia.org/wiki/Law_of_total_variance
[3]: ./../../
[4]: ./../
