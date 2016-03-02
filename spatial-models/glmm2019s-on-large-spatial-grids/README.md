#  Separable covariance function

Filed under: [Spatial Models][19]

Poisson GLMM on large spatial grid

It has for a long time been possible to fit GLMMs (Generalized Linear Mixed Models) in ADMB-RE. A typical example is correlated count data with Poisson distribution. However, when the observation are located on a spatial grid the number of latent variables (random effects in the ADMB-RE terminology) grows quadratically in the number of grid points in each geographical direction. The large number of random effects causes a computational challenge.

###Files:
* [admb_files.zip][1]
* [model_description.pdf][2]
* [newsletter.pdf][3]

[1]: ./admb_files.zip
[2]: ./model_description.pdf
[3]: ./newsletter.pdf
[19]: ./../
