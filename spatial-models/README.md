#  Spatial models

Spatial

There are two traditions (and a hybrid approach) in spatial modeling, both of which are supported in ADMB: 

1. The geostatistical approach where you specify the spatial covariance matrix (or equivalently the covariogram). This is your only option if you have data that are not on a grilattice, or if your spatial locations do not naturally form a "neighbourhood" structure. If you are not familiar with spatial modelling you should start with "Geostatistical approach" which takes you through a lot of features.  

2. GMRF (Gaussian Markov random field) models for data on grids, or where at least there is some way of defining the "neighbours" of each observational position. The most prominent example is the conditionally autoregressive (CAR) model for the random field where you specify the distribution of each spatial point as a function of the neighbouring values.   GMRF are computationally efficient when used in combination with the sparse matrix functionality in ADMB ("-shess" command line option). _Your first example_: MGRF: simple CAR model   

3. Separable: Hybrid between 1) and 2) with _separable covariance function _where you specify the model in terms of the covariance function, similar to 1). However, it turns out that using a  separable covariance function_ _is equivalent to specifying a neighbourhood structure. Hence, you get the best of two worlds at the cost of accepting separability (which imply non-isotropy of the covariance function).   

The example "Comparison of approaches" illustrates the differences between these approaches in a simple Gaussian situation.

## A note on modeling philosophy

All the methods discussed here view the spatial surface as a Gaussian random field. This field is implemented using the random effects module ADMB-RE.

###Examples
* [Geostatistical Approach][1]

* [Poisson GLMM][2]

* [MGRF: sipmle CAR model][3]

* [Separable: Method Explanation][4]

* [Comparison of Approaches][5]

[1]: ./the-geostatistical-approach
[2]: ./glmm-with-spatial-structure-described-in-terms-of-covariance-function
[3]: ./mgrf-car-model-for-the-scottish-lip-cancer-data
[4]: ./separable-different-implementation
[5]: ./separable-different-implementation
