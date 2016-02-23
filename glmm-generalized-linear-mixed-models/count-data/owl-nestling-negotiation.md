#  Owl nestling negotiation

**This example is part of the [NCEAS non-linear modelling project][1]**

**Authors: Ben Bolker, Mollie Brooks, Beth Gardner, Cleridy Lennert, Mihoko Minami**

The data for this example, taken from Zuur et al. (2009) and ultimately from Roulin and Bersier (2007), quantify the number of vocalizations (sibling negotiations) by owl chicks in different nests as a function of food treatment (deprived or satiated), the sex of the parent, and arrival time of the parent at the nest.

This problem is basically a zero-inflated generalized linear mixed model, where numbers of negotiations are the response variable, food treatment/arrival time/parental sex are the fixed-effect predictors, and sites are a random effect. The presence of zero-inflation puts the problem beyond standard GLMM implementations. In R, the MCMCglmm package allows for zero-inflation, or one can implement an expectation-maximization function. The problem is relatively straightforward in JAGS, or in ADMB, and one can also use the glmmADMB package in R.

[Documentation][2]

[Source code][3]

[1]: https://groups.nceas.ucsb.edu/non-linear-modeling/projects
[2]: https://groups.nceas.ucsb.edu/non-linear-modeling/projects/owls/WRITEUP/owls.pdf
[3]: https://groups.nceas.ucsb.edu/non-linear-modeling/projects/owls
