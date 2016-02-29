#  Skate mortality: Bayesian state-space model

Filed under:  [Fisheries][1], [State space model][2]

**This example is part of the [NCEAS non-linear modelling project][3]**

**Authors: Trevor Davies and Steve Martell**

The goal of the model was to obtain decadal mortality estimates of three different size classes of winter skates (_Leucoraja ocellata_) on the eastern Scotian Shelf. The time series are largely non-informative for several of the model parameters (catchability, recruitment rate, and stage transition probability), so informative Bayesian priors are used.

The model described here is a Bayesian state-space model implemented in both JAGS and AD Model Builder. The model description and alternative model formulations are fully described in Swain et al. (2009).

[Documentation][4]

[Source code][5]

[1]: ./../fisheries/
[2]: ./
[3]: https/groups.nceas.ucsb.ednon-linear-modelinprojects
[4]: https/groups.nceas.ucsb.ednon-linear-modelinprojectskatWRITEUskate.pdf
[5]: https/groups.nceas.ucsb.ednon-linear-modelinprojectskate
