#  GAMs as mixed models

Filed under [Generalized Linear Mixed Models][1]

Generalized additive models (GAMs) refers to the simplifying assumption that the response variable depends additively on a set of covariates, as in linear regression, but each covariate can act nonlinearly. We thus have a model 

         response = some-transformation[  b1(x1) b2(x2) ... bk(xk)  ]

where the b(x)'s are taken to be smoothing splines (see <http/en.wikipedia.orwikSmoothing_spline>). This "smoothing" aspect is basically that some restriction is put on the flexibility of the spline, controlled by a smoothing parameter which is estimated from data.

 

### Spline models as mixed models

It is widely recognized that spline models can be fit with mixed-model software. In this framework the smoothing parameter is estimated as a "variance". These examples illustrate how ADMB-RE can be used to fit such models. There are different ways of paramerizing the splines.

 

Often the penalty is put on the second derivative of the spline (wiggliness), which means that no penalty is put on the linear part. In mixed model terminiology this means that the linear part are "fixed effects" while the higher order terms are "random effects".

 

### Examples
* [generalized-additive-models][2]
* [mean-and-variance][3]
* [wood-2006-parameterization][4]
* 
[1]: ./../
[1]: ./
[1]: ./
