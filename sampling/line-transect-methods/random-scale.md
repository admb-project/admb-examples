#Random scale

Filed under: [R2admb][1], [Distance sampling]2

####Distance Sampling with Random Scale Detection Function

###Theory
That code fits detection functions with fixed effects for the scale parameter of  a half-normal function. The model is described here: https://github.com/jlaake/ADMB-Examples/blob/master/distance_random_effect.pdf

 

###Files
https://github.com/jlaake/RandomScale 

The files constitute an R package. You can use it without R but the mixed effect part will be more challenging because the data file includes a design matrix for the fixed effect portion of the model. On the page for the code link there are links that will take you to the TPL and example DAT files. Other detection functions may follow.

 

_How to install the R package_:

 https://github.com/jlaake/RandomScale/blob/master/Readme.md

 

###ADMB techniques: likelihood weighting
This model uses a feature which currently is not part of ADMB: weighting. The weights are used to form a numerator (weight 1) denominator (weights -1) in the conditional probabilities described in the pdf. The part of the code that relates to the weighting is 

DATA_SECTION

   vector w(1,2*n+2)

   !! w=1.0;

   !! w(2*n+2)=-n;

 

PARAMETER_SECTION 

   random_effects_vector u(1,n+1);

   !!set_multinomial_weights(w);

When these features gets incorporated into ADMB in the future they will get better documented.
