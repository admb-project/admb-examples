#  The basic SV model and simple extensions

The basic SV model can be written as (alternative versions are also used):

Xt = σX exp(ht/2) εt ,      (1)

ht 1 = φht σηt ,          (2)

where εt and ηt are iid standard normal, Xt is return and ht log-variance, both centralized, at time t. 

 

The model captures important properties of financial returns like volatility clustering and heavy tailed distribution of returns. Still, the basic model is not always able to fully capture the high kurtosis often found in practice. In the SV-t model a standardized t-distribution (with ν > 2 degrees of freedom), rather than a normal distribution, is used for  epsilon in (1). This allows for heavier tails in returns. In order to also model skewness, a skewed distribution can be chosen for epsilon. In the SV-st model a skewed t-distribution is used. This distribution has an extra parameter, lambda, compared to the t-distribution. When lambda is negative, the distribution is negatively skewed.

 

In order to fit the models to data using ADMB-RE we have to find an expression for the log of the joint density function for returns and latent variables, p(**X**,**h**|θ), where θ is a parameter vector. It is then useful to find a graphical representation for the models. This makes it easier to uncover the dependence structure in the models so that we may find simple expessions for the joint density functions. The SV models considered so far can be represented graphically as: 

![Fig_1][1]  
  
  
Note that:  
\- Xt is separated from the other variables by ht. This implies that Xt is conditionally independent of all other variables given ht.   
\- The only path to ht goes via ht-1. Then ht is conditionally independent og all previous variables given ht-1.

These considerations leads to the folowing expression for the joint density:  
p(**X**,**h**|θ) = p(h1|θ)prod p(ht 1|ht,θ) prod p(Xt|ht,θ).  
  
hT 1 is not strictly needed here, but will be needed in later models and is for consistency also included here.   
  
For the models considered so far h1~N(0,σ2/(1-ϕ2)) and ht 1|ht~N(ϕht, σ2), while the distribution of Xt|ht depends on the distribution used for εt.    
  
It is then easy to specify log p(**X**, **h**|θ), see tpl files for how this can be done for the three models:

> [sdv_plain.tpl][2]
>
> [sdv_t.tpl][3]
>
> [sdv_t_skw.tpl][4]

  
The par-files contain estimated parameters and volatilities. (Comments...)

> [sdv_plain.par][5]
>
> [sdv_t.par][6]
>
> [sdv_t_skw.par][7]

 

 

  
  

[1]: the-basic-sv-model-and-simple-extensions-1/Figur_1.jpg/image_preview.jpg "Fig_1"
[2]: the-basic-sv-model-and-simple-extensions-1/sdv_plain.tpl "sdv_plain.tpl"
[3]: the-basic-sv-model-and-simple-extensions-1/sdv_t.tpl "sdv_t.tpl"
[4]: the-basic-sv-model-and-simple-extensions-1/sdv_t_skw.tpl "sdv_t_skw.tpl"
[5]: the-basic-sv-model-and-simple-extensions-1/sdv_plain.par "sdv_plain.par"
[6]: the-basic-sv-model-and-simple-extensions-1/sdv_t.par "sdv_t.par"
[7]: the-basic-sv-model-and-simple-extensions-1/sdv_t_skw.par "sdv_t_skw.par"
