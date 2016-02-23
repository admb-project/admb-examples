#  One-compartment open model

Filed under:  [Differential equations][1], [PK/DK][2]

Fit mixed effects model to the classical "phenopharbital" model

Pinheiro & Bates (2000, Ch. 6.4) fitted a so-called 'one-compartment open model' to a dataset known as the 'phenopharbital data'. A patient is given a dose _D_ at time _t_d, giving rise to a phenopharbital concentration _ct_ at a later time _t_:

  

_ct_ = _D/V_ exp[-_Cl/V_(_t_-_t_d)],

 

where _V_ and _Cl_ are parameters (the so-called 'Volume of concentration' and the 'Clearance', respectively). Doses given at different time points contribute additively to _ct_.

  
Pinheiro & Bates (2000) fitted a model with a linear predictor (and a log-link) for each of the paramere _V_ and _Cl_. Each of the linear predictors contained one covariate _Wt_ and one random effect. A full description of the model can be found here [pheno.pdf][3] (quite old, so timing results mentioned are outdated).

###   

Note: In this model the underlying ODE has an analytical solution, but in more general models it will not.

 

### References

Pinheiro, J., Bates, D.M.  (2000), _Mixed-Effects Models in S and S-PLUS_. Statistics and Computing, Springer.

[1]: http://www.admb-project.org/@@search?Subject:list=Differential equations
[2]: http://www.admb-project.org/@@search?Subject:list=PK/DK
[3]: ./pheno.pdf "pheno.pdf"
