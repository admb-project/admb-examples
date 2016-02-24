<h1 class="documentFirstHeading" id="parent-fieldname-title">
                    Covariance in RE models
                h1><div class="" id="parent-fieldname-text-48768352-ac5f-48bb-acc8-aa954cd47dcc">
<p>In RE (random effects) models there are two types of parameters, x (parameter in the ordinary sense) and u (random effect). This documents tries to shed some light on how the variance of x and u are calculated. The covariance matrix of the x vector is based on the (marginal) likelihood, obtained via the Laplace approximation, and corresponds to the way covariance matrices are calculated in non-RE models in ADMB.p>
<p> p>
<p><strong>Theorystrong>p>
<p>Here is what the user manual says about the variance of u (the manual talks about "theta" instead of "x"): <a class="internal-link" href="usermanual.pdf" title="usermanual.pdf">usermanual.pdfa> A few words can be added to this.p>
<p> p>
<p>The formula is based on the Law of total variance: <a class="external-link" href="http/en.wikipedia.orwikLaw_of_total_variance">http/en.wikipedia.orwikLaw_of_total_variancea>p>
<p>In our context this says: p>
<p>  Var(u) = E<sub>xsub>[var(u|x)] + var<sub>xsub>(E(u|theta)p>
<p>The expectation "E<sub>xsub>" is obtained simply by inserting the point estimate of x into "var(u|x)". The second term is based on the "delta method" which is used elsewhere in ADMB, in combination with the covariance matrix of x (described above). Everything in these calculations are conditional on "data".p>
<p> p>
<p> p>
<p> p>
<p><strong>Example: simple hierarchical modelstrong>p>
<p>Consider the following simple Gaussian hierarchical model:p>
<pre> Prior on x: x = e1
   u|x: u = x + e2
   y|u: y = u + e3
			/ where e1, e2, e3 are all distributed N(0,1)pre>
<p>R code for the covariance matrixp>
<pre>S = matrix(0,3,3,row=c("x","u","y"),col=c("x","u","y"))
S[,]=1
S[2:3,2:3]=2
S[3,3]=3
S12_3 = S[1:2,1:2] - S[1:2,3]%*%solve(S[3,3])%*%S[3,1:2]pre>
<div>We are interested in the conditional variance of x and u given data (y).div>
<pre>&gt; sqrt(diag(S12_3))
        x         u 
0.8164966 0.8164966 
&gt; cov2cor(S12_3)
    x   u
x 1.0 0.5
u 0.5 1.0pre>
<div> div>
<div><strong>Corresponding quantities in ADMBstrong>div>
<div>An implementation of this model in ADMB is:div>
<pre> DATA_SECTION
   number y
   !! y=10.0;
PARAMETER_SECTION
   init_number x
   random_effects_vector u(1,1)
   objective_function_value f
PROCEDURE_SECTION
   f = 0.0;
   f -= -0.5*square(x);	 / Prior on x: x = e1
   f -= -0.5*square(u(1)-x);   / u|x: u = x + e2
   f -= -0.5*square(y-u(1));   / y|u: y = u + e3
			/ where e1, e2, e3 are all distributed N(0,1); standard normal
GLOBALS_SECTION
  #include "getbigs.cpp"pre>
<p>NOTE: as of Nov 29 2012 you need to include "getbigs.cpp" due to a recently discovered bug in ADMB.p>
<p>The result you get when you run ADMB matches those from R:p>
<pre>D:\tmp\tmp&gt;more simple_variance.cor
 The logarithm of the determinant of the hessian = 0.405465
 index   name    value      std dev       1
     1   x 3.3335e+000 8.1650e-001   1.0000
     2   u 6.6668e+000 8.1650e-001   0.5000  1.0000pre>
div>