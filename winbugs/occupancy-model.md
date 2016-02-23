#  Occupancy model

Comparison of ADMB and WinBUGS modelling approach for simple occupancy model. This is also a comparison of Bayesian and frequentist modelling.

![bugs-admb code][1]

 

The presence of animals (or some other object) at a site is determined by a  latent indicator variable z:

  z = 1 presence of animlas

  z = 0 absence

Conditioinally on z = 1, the number of animals y follows a binomial distribution

 

The following annotated code show how such a model is implemented in WinBUGS and ADMB, and highlights differences.  

 

 

 

 

 

[1]: occupancy-model/occupancy.jpg/image_preview.jpg "bugs-admb code"
