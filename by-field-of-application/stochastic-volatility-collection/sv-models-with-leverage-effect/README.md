#  SV models with leverage effect
      
 The leverage effect is the phenomenon that volatility tends to rise following a drop in returns. In SV models the leverage effect is modeled by letting the noise terms in the two equations be correlated. SV models with leverage effect can be written as:  
 
  X<sub>t</sub> = σ<sub>X</sub> exp(h<sub>t</sub>/2)ε<sub>t</sub>,      (1)
  h<sub>t+1</sub> = ϕh<sub>t</sub> + ση<sub>t</sub>,          (2) 
  
 where the pairs (ε<sub>t</sub>, η<sub>t</sub>) are iid with E(ε<sub>t</sub>) = E(η<sub>t</sub>) = 0, Var(ε<sub>t</sub>) = Var(η<sub>t</sub>) = 1 and  corr(ε<sub>t</sub>, η<sub>t</sub>) = ρ.   
 
 If ρ < 0, which is the standard case, a drop in returns at time t then tends to give increased volatility at time t+1. 

 Due to correlated noise terms, the structure in SV models with leverage effect is (slightly) more complicated than in the models without leverage effect. It is therefore also more difficult to find an expression for the joint density function, p(<strong>X</strong>, <strong>h</strong>|θ), in this case.  SV models on the form (1-2) can be represented graphically as: 
 
 ![Fig_1][1]
 
All paths to  X<sub>t</sub> and h<sub>t+1</sub> goes via/through h<sub>t</sub>, so the pair (X<sub>t</sub>, h<sub>t+1</sub>) is conditionally independent of previous variables given h<sub>t</sub>. 
   
  This leads to the following expression for the joint density: 
  
 p(X,h|θ) = p(h<sub>1</sub>|θ) Πp(X<sub>t</sub>, h<sub>t+1</sub>|h<sub>t</sub>, θ) 
 
 This expression may be further simplified by factorizing p(Xt, ht+1|ht, θ). This can be done in two ways: 
 
 a. We can use that p(X<sub>t</sub>, h<sub>t+1</sub>|h<sub>t</sub>, θ) = p(X<sub>t</sub>|h<sub>t+1</sub>, h<sub>t</sub>, θ)p(h<sub>t+1</sub>|h<sub>t</sub>, θ) and write the joint density as p(X,h|θ) = p(h<sub>1</sub>|θ) Πp(X<sub>t</sub>|h<sub>t+1</sub>, h<sub>t</sub>, θ)p(h<sub>t+1</sub>|h<sub>t</sub>, θ) This is represented in the folowing graph  
   ![Fig_2][2] 
  
  b. Alternatively we can use p(X<sub>t</sub>, h<sub>t+1</sub>|h<sub>t</sub>, θ) = p(X<sub>t</sub>|h<sub>t</sub>, θ)p(h<sub>t+1</sub>|X<sub>t</sub>, h<sub>t</sub>, θ), which gives the following expression p(X,h|θ) = p(h<sub>1</sub>|θ) Πp(X<sub>t</sub>|h<sub>t</sub>, θ)p(h<sub>t+1</sub>|X<sub>t</sub>, h<sub>t</sub>, θ). 
  
  The graphical representation for this form is given by 
  
 ![Fig_3][3]
 The two forms should be equivalent, so it should in principle be possible to use both. However, as we shall see, it might be reasons to prefer one over the other.    
 
###<strong>The Gaussian leverage model</strong>
 In the Gaussian leverage model it is assumed that the pairs (ε<sub>t</sub>, η<sub>t</sub>) are iid bi-variate normally distributed, with standard normal marginals. This is the most popular leverage model and it is a discrete time version of models used in option pricing. 
 
 Then  ε<sub>t</sub>|η<sub>t</sub> ̴ N(ρη<sub>t</sub>, 1-ρ<sup>2</sup>) and we can write ε<sub>t</sub> =  ρη<sub>t</sub> + sqrt(1-ρ<sup>2</sup>)w<sub>t</sub>  where w<sub>t</sub> is standard normal and η<sub>t</sub> and w<sub>t</sub> are independent. Noting that η<sub>t</sub> = (h<sub>t+1</sub> – ϕh<sub>t</sub>)/σ, the model can be written as: 
 
 X<sub>t</sub> = σ<sub>X</sub> exp(h<sub>t</sub>/2)ρ(h<sub>t+1</sub> – ϕh<sub>t</sub>)/σ + σ<sub>X</sub> exp(h<sub>t</sub>/2) sqrt(1-ρ<sup>2</sup>)w<sub>t</sub>, 
 
 h<sub>t+1</sub> = ϕh<sub>t</sub> + ση<sub>t</sub>, where w<sub>t</sub> and η<sub>t</sub> are iid N(0,1).   On this form we may use the formulation a) for the joint density function, and we see that  h<sub>1</sub> ̴ N(0,σ<sup>2</sup>/(1-ϕ<sup>2</sup>)), 
 
 h<sub>t+1</sub>|h<sub>t</sub> ̴ N(ϕh<sub>t</sub>, σ<sup>2</sup>) and  X<sub>t</sub>|h<sub>t+1</sub>, h<sub>t</sub> ̴ N(σ<sub>X</sub>ρ exp(h<sub>t</sub>/2) (h<sub>t+1</sub> – ϕh<sub>t</sub>)/σ,

 σ<sub>X</sub><sup>2</sup> exp(h<sub>t</sub>) (1-ρ<sup>2</sup>)). 
 
 Thus it is easy to find an expression for log p(<strong>X</strong>, <strong>h</strong>|θ) here. See [sdv_lev_1.tpl][1] for how this can be done.   
 
 Alternatively we may use the other version. Noting that η<sub>t</sub>|ε<sub>t</sub> ̴ N(ρε<sub>t</sub>, 1-ρ<sup>2</sup>), we may write η<sub>t</sub> =  ρε<sub>t</sub> + sqrt(1-ρ<sup>2</sup>) v<sub>t</sub>, where v<sub>t</sub> ̴ N(0,1) and vt is independent of ε<sub>t</sub>. Then, using that   ε<sub>t</sub> = Xt exp(-h<sub>t</sub>/2)/σ<sub>X</sub>, the model may be written as: 
 
 X<sub>t</sub> = σ<sub>X</sub> exp(h<sub>t</sub>/2)ε<sub>t</sub> ,  
 
 h<sub>t+1</sub> = ϕh<sub>t</sub> + σρX<sub>t</sub> exp(-h<sub>t</sub>/2)/σ<sub>X</sub> + σ sqrt(1-ρ2) v<sub>t</sub> , 
 
 where ε<sub>t</sub> and v<sub>t</sub> are iid N(0,1) by assumption.  
 
 Here it is seen that h<sub>t+1</sub>|(X<sub>t</sub>, h<sub>t</sub>, θ) ̴ N(ϕh<sub>t</sub> + σρX<sub>t</sub> exp(-h<sub>t</sub>/2)/σX, σ2(1 - ρ2)) and  X<sub>t</sub>|(h<sub>t</sub>,θ) ̴ N(0, σ<sub>X</sub><sup>2</sup> exp(h<sub>t</sub>)), so we can easily find an expression for log p(<strong>X</strong>, <strong>h</strong>|θ), see [sdv_lev_2.tpl][2] for how this can be done.  
 
 The two specifications for the Gaussian leverage model should give the same results. Comparing the par files [sdv_lev_1.par][3] and [sdv_lev_2.par][4], we see that the results are practically identical, as they should. However, it seems that sdv_lev_1 runs somewhat faster and that the difference in run time is increasing in the size of the data set. This suggests that it might be preferable to use the parametrization given in sdv_lev_1, at least for large data sets. This version may be less intuitive than the other and is less commonly used, but it might actually be preferable because of the run time issue.   
 
###<strong>Leverage models with heavier tails and/or skewness</strong>
 
 The moments of returns in the Gaussian leverage model are the same as in the basic SV model. In order to model both leverage effect and heavier tails and/or skewness, the following specification is used: X<sub>t</sub> = σ<sub>X</sub> exp(h<sub>t</sub>/2)ε<sub>t</sub> , 
 h<sub>t+1</sub> = ϕh<sub>t</sub> + σρX<sub>t</sub> exp(-h<sub>t</sub>/2)/σ<sub>X</sub> + σ sqrt(1-ρ<sup>2</sup>) v<sub>t</sub>, 
 
 where v<sub>t</sub> ̴ N(0, 1)and ε<sub>t</sub> has some standardized continuous distribution. This looks like the formulation used to set up sdv_lev2, but here ε<sub>t</sub> is not necessarily normally distributed. In the SV_lev_t model a standardized t-distribution is used for ε<sub>t</sub>. This not only gives heavier tails in the returns, but also some tail thickness in the volatility process. This might actually be a favorable property. In SV_lev_st  ε<sub>t </sub>follows a skewed t-distribution, which captures skewness in returns, but also gives skewness in the volatility process. If ε<sub>t </sub>has negative skewness and ρ also is negative, which is the usual case, then there is positive skewness in the volatility process. This seems like a reasonable property, since big positive “jumps” in volatility are more likely to occur than large negative ones.   
 
 For models on this form h<sub>t+1</sub>|(X<sub>t</sub>, h<sub>t</sub>, θ) ̴ N(ϕh<sub>t</sub> + σρX<sub>t</sub> exp(-h<sub>t</sub>/2)/σ<sub>X</sub>, σ<sup>2</sup>(1 – ρ<sup>2</sup>)) no matter which distribution we choose for ε<sub>t</sub>. When ε<sub>t</sub>  is not normally distributed, the distribution of h<sub>1</sub>|θ is unknown, so strictly speaking we cannot find an exact expression for p(<strong>X</strong>,<strong>h</strong>|θ) here. However it is still the case that E[h<sub>1</sub>] = 0 and Var(h<sub>1</sub>) = σ<sup>2</sup>/(1-ϕ<sup>2</sup>), and by assuming that h<sub>1</sub>|θ ̴ N(0,σ<sup>2</sup>/(1-ϕ<sup>2</sup>)), we find an approximate expression for the joint density. Since p(h<sub>1</sub>|θ) is only a minor contributor to p(<strong>X</strong>,<strong>h</strong>|θ), the error is small. The distribution of X<sub>t</sub>|h<sub>t</sub> depends on the distribution used for ε<sub>t</sub>, as can be seen in the tpl-files, [sdv_t_lev.tpl][5] and [sdv_st_lev][6]. 


[1]: Figure-2.jpeg "Fig_1"
[2]: Figure-3.jpeg "Fig_2"
[3]: Figure-4.jpeg "Fig_3"
[4]: sdv_lev_1.tpl "sdv_lev_1.tpl"
[5]: sdv_lev_2.tpl "sdv_lev_2.tpl"
[6]: sdv_lev_1.par "sdv_lev_1.par"
[7]: sdv_lev_2.par "sdv_lev_2.par"
[8]: sdv_t_lev.tpl "sdv_t_lev.tpl"
[9]: sdv_st_lev.tpl "sdv_st_lev.tpl"
