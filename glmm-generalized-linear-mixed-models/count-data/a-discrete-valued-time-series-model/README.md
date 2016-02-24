#  A time series of Poisson counts; Polio data

Filed under:  [State space model][1], [MedicaBiometrics][2], [Count data][3]

A serially correlated time series of Poisson counts using a GLMM framework

### **Model description**

As an example of a discrete valued time series we use the 'polio data' considered by [Kuk & Cheng (1999)][4]. It is assumed that _yi_ has a Poisson (lambdai) distribution, where

  
log(lambdai) = _**X**i_**b** + u<sub>i</sub>.



Here, _**X**i_ is a covariate vector, **b** is a vector of regression parameters and u<sub>i</sub> is a first order autoregressive process.



### Details   

[polio.pdf][5]

 

### Files

See "Navigation" box to the left.

* [polio.tpl]:  Model file
* [polio.dat]: Data file
* [polio.pin]: Starting values for the numerical optimizer  
* [polio.par]: Result file (what you get when you compile and run your model)  

 

[1]: http/www.admb-project.or@@search?Subject:list=State space model
[2]: http/www.admb-project.or@@search?Subject:list=MedicaBiometrics
[3]: http/www.admb-project.or@@search?Subject:list=Count data
[4]: .citations.html#kuk:chen:1999
[5]: polio.pdf
[6]: polio.tpl
[7]: polio.dat
[8]: polio.pin
[9]: polio.par
