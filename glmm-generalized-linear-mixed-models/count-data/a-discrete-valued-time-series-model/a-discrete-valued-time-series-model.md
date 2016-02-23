#  A time series of Poisson counts; Polio data

Filed under:  [State space model][1], [Medical/Biometrics][2], [Count data][3]

A serially correlated time series of Poisson counts using a GLMM framework

### **Model description**

As an example of a discrete valued time series we use the 'polio data' considered by [Kuk & Cheng (1999)][4]. It is assumed that _yi_ has a Poisson (lambdai) distribution, where

  
log(lambdai) = _**X**i_**b** _ui_.

 

Here, _**X**i_ is a covariate vector, **b** is a vector of regression parameters and _ui_

is a first order autoregressive process.

 

### Details   

[polio.pdf][5]

 

### Files

See "Navigation" box to the left.

* .tpl:  Model file
* .dat: Data file
* .pin: Starting values for the numerical optimizer  
* .par: Result file (what you get when you compile and run your model)  

 

[1]: http://www.admb-project.org/@@search?Subject:list=State space model
[2]: http://www.admb-project.org/@@search?Subject:list=Medical/Biometrics
[3]: http://www.admb-project.org/@@search?Subject:list=Count data
[4]: citations.html#kuk:chen:1999
[5]: a-discrete-valued-time-series-model/polio.pdf "polio.pdf"
