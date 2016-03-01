#  Eilers & Marx parameterization

Filed under: [Generalized Linear Mixed Models][3], [GAMs as Mixed Models][4]

Parameterization of the spline from Eilers & Marx (1996)

### **Model description**

Since their introduction by Hastie & Tibshirani in the late 80ies, GAM's have become very popular. This example shows how to fit a GAM using penalized splines. The reason why GAM's can easily be handled in ADMB-RE is that penalized splines are a special case of random effects. ADMB-RE automatically estimates the degrees of freedom for each spline component, as this only amounts to estimate the variance of the random effects. A more detailed discussion of the model and the estimation approach can be found here: [union.pdf][1]

 

The data, which are available from Statlib (lib.stat.cmu.ed), contain information for each of 534 workers about whether they are members (y=1) of a workers union or not (y=0). The goal is to model the probability of membership as a function of various covariates.

 

### Details   

[union.pdf][2]

 

### Files

See "Navigation" box to the left.

* .tpl:  Model file
* .dat: Data file
* .pin: Starting values for the numerical optimizer  
* .par: Result file (what you get when you compile and run your model)  

[1]: union.pdf
[2]: union.pdf "union.pdf"
[3]: ./../../
[4]: ./../
