#  Item response theory

## Original model formulation

Item response theory (IRT) refers to statistical models for data from questionnaires and tests as a basis for measuring abilities, attitudes, or other variables in psychometrics (<http://en.wikipedia.org/wiki/Item_response_theory>). Doran et al (2007) fitted multilevel Rasch model, which is a special instance of an IRT, using the R function "lmer". This example shows how the model from Doran et al (2007) can simply be implemented using random effects in ADMB. It also shows how the model can easily can be expanded in ways not possible in other other sofwtare package than ADMB.   
  

### Data and Model  

2042 soldiers responded to a total of 19 items, all of which with a dichotomous outcome (0 or 1). The 19 items were grouped into 3 categories, which were modelled as fixed effects (variable "itcoff" in irt_doran.tpl). Further, the soldiers were grouped into 49 companies, which taken to be random effects (v). Similarly, there was a random effect associated with each individual soldier (u) and one with each item (w).  
  
A logistic regression with

_       Prob(x=0) = 1/(1 exp(bx)) , Prob(x=1) = 1-Prob(x=0)_

(the Rasch model) and the linear predictor

_       bx = itcoff sigma1*u sigma2*v sigma3*w;_

was used. The sigma's are standard deviations of the random effects.

 

### Running the model  

All files needed to run the model are available in a zip file in the box to the left. In order for the model to run efficiently, use the command line

      irt_doran -shess -ndi 45000

However, for a data set of this size some of the default settings of the software can be modified to obtain maximum speed of execution:

      irt_doran -iprint 1 -mno 50000 -ams 3000000 -gbs 50000000 -cbs 25000000 -noinit -shess -ndi 45000

This yields the following result (.par) file, which matches the results from "lmer" exactly (but differs somewhat from what was reported in Doran et al, 2007). 

    # Number of parameters = 6  Objective function value = 20354.9  Maximum gradient component = 6.12735e-005
    # itcoff:
     -1.67737 0.492791 0.135192
    # sigma1:
    1.51846121232
    # sigma2:
    0.504141856912
    # sigma3:
    0.612277839339

The ADMB program runs much slower than "lmer" for this model, because the structure of the model is hard-coded into lmer. ADMB on the other hand targets a much larger class of models, and is thus not as efficient. However, the benefit of using ADMB is that you can change the model in the way you like, as is exemplified next. This is not currently possible in any other model package.

## Extention: changing the asymptotes  

 

Given that we think that Pr(x=0) can never be exactly 0 or 1, the following extention of the logistic regression is useful: 

  _     Prob(x=0) =a (b-a)/(1 exp(bx)),_

where _a_ and _b _are parameters to be estimated. Two special cases are considered

1. irt1_doran: only a is estimated (b=0).
2. irt1_doran: both a and b are estimated.

Files for both these models are provided in boxes to the left.

 

### Comparison of results

A comparison of (log) likelihood values are given in the following table

| Name       | log-like | Comment               | # pars | AIC     |
| ---------- | -------- | --------------------- | ------ | ------- |
| irt_doran  | -20354.9 | Doran et al.          | 6      | 40721.8 |
| irt1_doran | -20326.0 | _a_ estimated         | 9      | 40670   |
| irt2_doran | -20320.0 | _a_ and _b_ estimated | 12     | 40664   |

 

Note that the are 3 parameters associated with each of _a_ and _b_: one of each level of the fixed effect "itcoff". According to the AIC criterion, both _a_ and _b _are significant parameters for these data.

###

## Conclusion  

Allthough 

## References  
  

Doran, H., Bates, D., Bliese, P., Dowling, M. Estimating the Multilevel Rasch Model: With the lme4 Package. _Journal of Statistical Software_, 20, 2007. (<http://www.jstatsoft.org/v20/i02/paper>)