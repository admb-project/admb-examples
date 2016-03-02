#  Tadpole mortality as a function of size

**This example is part of the [NCEAS non-linear modelling project][1]**

**Author: Ben Bolker**

 

The data are originally from Vonesh and Bolker (2005), describing the numbers of reed frog (_Hyperolius spinigularis_) tadpoles killed by predators as a function of size in a small-scale field trial. Our main interest is in a quantitative description of the "window of vulnerability", defined as the unimodal pattern of proportion killed as a function of size. In various contexts, we can use this description either to describe and test differences among treatments (e.g., does the window of vulnerability differ by predator size, or with tadpoles exposed to different predator cues?) or to project the effects of growth and mortality rates through a life stage. See the reference above and McCoy et al. (2011) for more details and examples.

This basic example is essentially a maximum likelihood estimation problem with a binomial response variable. The data set is small, there are no random effects or latent variables, and the problem is low-dimensional, with only a single predictor and a single response variable and only three parameters in the statistical model used.

 

[Documentation][2]

[Source code][3]

 

[1]: https/groups.nceas.ucsb.ednon-linear-modelinprojects
[2]: https/groups.nceas.ucsb.ednon-linear-modelinprojecttadpolWRITEUtadpole.pdf
[3]: https/groups.nceas.ucsb.ednon-linear-modelinprojecttadpole
