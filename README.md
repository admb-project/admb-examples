
[Source](copy_of_new-examples "Permalink to All examples — ADMB Project")

# All examples — ADMB Project

All examples currently available in the website

["Maximum likelihood estimation and inference" by Russell Millar][1]

[A discrete valued time series model; Polio data][2]
:  Illustrate how a time series of count data can be modelled as a GLMM with a Poisson response

[A discrete valued time series model; Polio data][3]
:  Illustrate how a time series of count data can be modelled as a GLMM with a Poisson response

[A fisheries model with random effects][4]
:  Catch-age model from Schnute and Richards (1995) with annual recruitments as random effects.

[A standard CJS model][5]
:  Fitting Cormack-Jolly-Seber (CJS) Models to Capture-Recapture Data using R2admb

[Adjoint code][6]
:  Why to write adjoint code and alternative approaches to do it.

[Baranov catch equation][7]
:  Example by Steven Martell of writing adjoint code in ADMB to numerically solve the Baranov catch equation. A simple simulation model is used to generate simulated catch and relative abundance data with observation error only. The assessment model is then conditioned on the simulated catch data.

[BCB bowheads][8]
:  Abundance estimation of BCB bowhead whales

[Beta-binomial model][9]
:  Binomial response with random effects having beta distribution. Comparison to Winbugs and h-GLM

[By field of application][10]

[Categorical data][11]

[CJS Individual Heterogeneity ][12]
:  Mixed Effects Cormack-Jolly-Seber Models for Analysis of Capture-Recapture Data

[ CJS Models][13]
:  Cormack-Jolly-Seber (CJS) models in different variations

[Comparison of approaches][14]
:  Three different implementations of the same model with separable spatial covariance function in a fully Gaussian situation: i) Plain ADMB (non-random effect) ii) Geostatistical formulation iii) Hybrid approach.

[Count data][15]
:  Poisson, negative binomial counts in various variants

[Covariance Calculations][16]
:  A short document with accompanying R code that details (1) the functions used to bound parameters, (2) the method for calculating a bounded covariance matrix, and (3) what is stored in the binary admodel.hes and admodel.cov files and how the user can utilize this information to gain more control over an MCMC chain.

[Covariance in RE models][17]

[Covariance matrices][18]
:  How to parameterize a covariance matrix

[Delta smelt life cycle model ][19]
:  A state-space multistage model to evaluate population impacts in the presence of density dependence.

[Diet and heart disease][20]
:  Continuous and discrete observation sharing being influenced by a latent random variable

[Differential equations][21]

[Eilers &amp; Marx parameterization][22]
:  Parameterization of the spline from Eilers &amp; Marx (1996)

[Estimation of detection function ][23]
:  Illustrates the likelihood based estimation of the detection function (perpendicular distance)

[Extension: correlated RE's][25]
:  Add random effects to all 3 phi's, and attempt to estimate correlations

[Extension: crossed RE's][26]
:  Adds a "day effect" following Millar (2004, Aust NZ J. Stat, 46, p. 543-554)

[Fisheries][27]
:  Different uses of ADMB in fisheries stock assessments or other fisheries work

[Flexible negative binomial][28]
:  Explores non-standard relationships between mean and variance in the NB model

[Function minimizer][29]
:  Various tricks and techniques related to the function minimizer to improve convergence

[Gamma distributed myxomatosis using R2admb][30]

[GAMs as mixed models][31]
:  Generalized Additive Models

[Gaussian models][32]
:  Models where both the response and latent random variable are Gaussian. For such models the covariance matrix of the observations can be worked out analytically, but still the latent variable (random effect) formulation can be beneficial.

[Geostatistical approach][33]
:  The approach to spatial modeling where you explicitly model the covariance function/matrix. First used in geology/mining (hence the name). Can be used with both Gaussian and non-Gaussian response for data.

[GLM/GLMM/GAM][34]

[glmmADMB][35]

[Growth models][36]

[Item response theory][37]
:  The multilevel Rasch model can be implented using random effects in ADMB. As an example we use data on the responses of 2042 soldiers to a total of 19 items (questions), taken from Doran et al (2007). This illustrates the use of crossed random effects in ADMB. Further, it is shown how the model easily can be generalized in ADMB. These more general models cannot be fitted with standard GLMM software such as "lmer" in R.

[Line transect methods][38]
:  Line transect methods are commonly used to estimate animal abundance, and is a special case of distance sampling.

[lmer() comparison][39]
:  Application of ADMB to the simulated datasets in Zhang et al. (2011) with emphasis on comparison to the R function lmer()

[Mark-recapture][40]

[Math][41]
:  Various undocumented techniques and tricks useful for developing ADMB programs

[MCMCMC][42]
:  This presents generalized code for conducting Metropolis Coupled MCMC using ADMB called within R

[Mean and variance][43]
:  Both mean and variance vary smoothly as functions of a covariate

[MGRF: simple CAR model][44]
:  CAR model for the Scottish Lip Cancer Data

[Mineralization of terbuthylazine][45]
:  A simple nonlinear least-squares problem, with normally distributed residuals and no random effects or latent variables. Example from the NCEAS non-linear modelling working group.

[Miscellaneous][46]
:  Stuff that is hard to categorize, but still is useful

[Mixed response][47]
:  Models with responses of different types

[Negative Binomial Fir Fecundity][48]
:

[Negative binomial serially correlated counts][49]
:  Compares a negative binomial response to Poisson responses for the polio data

[Non Gaussian random effects][50]
:  ADMB allows non-Gaussian random effects via transformation of a normal variate

[Occupancy model][51]
:  Comparison of ADMB and WinBUGS modelling approach for simple occupancy model. This is also a comparison of Bayesian and frequentist modelling.

[One-compartment open model][52]
:  Fit mixed effects model to the classical "phenopharbital" model

[Orange trees][53]

[Ordered categorical responses][54]
:  Ordered categorical responses with application to SOCATT data

[Owl nestling negotiation][55]
:  Zero-inflated generalized linear mixed model example from the NCEAS non-linear modelling working group.

[Parameter scaling][56]
:  Shows how to scale parameters so that they become of the same magnitude

[Parameterization][57]
:  Examples of how to (and not to) parameterize mathematical functions and statistical models

[Pella-Tomlinson basic model][58]
:  Pella-Tomlinson by Arni Magnusson with user interface and formatted MCMC output. Repeats and extends the analysis of Polacheck et al. (1993).

[Pella-Tomlinson from ADMB manual][59]
:  Pella-Tomlinson example by Dave Fournier from the ADMB manual. Demonstrates several innovative modelling approaches: 6 month time step, time-varying K and q.

[PK/DK ][60]
:  Pharmacokinetics (PK) &amp; Pharmacodynamics(DK)


[Poisson GLMM][61]
:  An example of the geostatistical approach to spatial modelling. The response distribution is Poisson with an isotropic correlation function r(d), where "d" is the distiance between two locations.

[R - ADMB interface for mixed models][62]
:  Explains how to set up a general mixed model interface between R and ADMB used for instance in glmmADMB

[R stuff][63]

[Random scale][64]
:  Distance Sampling with Random Scale Detection Function

[Sampling][65]
:  Survey sampling related examples

[Separable: Method explanation][66]
:  It has for a long time been possible to fit GLMMs (Generalized Linear Mixed Models) in ADMB-RE. A typical example is correlated count data with Poisson distribution. However, when the observation are located on a spatial grid the number of latent variables (random effects in the ADMB-RE terminology) grows quadratically in the number of grid points in each geographical direction. The large number of random effects causes a computational challenge.

[Simple examples][67]

[Skate mortality: Bayesian state-space model][68]
:  Bayesian state-space model example from the NCEAS non-linear modelling working group

[Spatial models][69]
:  ADMB supports both the geostatistical approach and Gaussian Markov random field approach to spatial modelling

[Splines][70]
:  Different aspects of spline models

[Splines I][71]
:  notes and examples related to cubic splines

[State-space models][72]

[Stochastic volatility collection][73]

[Stochastic volatility models for financial time series][74]
:  Stochastic volatility models are used in mathematical finance to describe the evolution of asset returns, which typically exhibit changing variances over time.

[Survival analysis][76]
:  Lifetime data and survival analysis

[SV models with leverage effect][77]

[Tadpole mortality as a function of size][78]
:  A maximum likelihood estimation problem with a binomial response variable, example from the NCEAS non-linear modelling working group.

[Text books][79]
:  Collections of examples taken from text books

[The basic SV model and simple extensions][80]
:  Beskrivelse av innhold. Kan droppes?

[Theta-logistic population growth model][81]
:  State-space model from the NCEAS non-linear modelling working group

[Variance calculations][82]
:  How variance is calculated in ADMB

[Weibull regression with censoring][83]

[Wildflowers][84]
:  A binomial generalized linear mixed model example from the NCEAS non-linear modelling working group.

[WinBUGS][85]
:  Comparison with the software package WinBUGS

[Wood (2006) parameterization][86]
:  Parameterization via the eigen vectors of the penalty matrix (Wood 2006, Section 6.6.1).

  
[1]: text-books/maximum-likelihood-estimation-and-inference-by-russell-millar
[2]: glmm-generalized-linear-mixed-models/count-data/a-discrete-valued-time-series-model
[3]: state-space-models/a-discrete-valued-time-series-model
[4]: http://otter-rsch.com/admbre/examples/caest/caest.html
[5]: mark-recapture/cormack-jolly-seber-models/fitting-cormack-jolly-seber-models-to-capture-recapture-data-using-r2admb.md
[6]: admb-tricks/adjoint-code-1
[7]: fisheries/a-fisheries-model-solving-the-baranov-catch-equation-using-adjoint-code
[8]: glmm-generalized-linear-mixed-models/gaussian-models/bcb-bowheads
[9]: glmm-generalized-linear-mixed-models/non-gaussian-random-effects/beta-binomial-model
[10]: by-field-of-application
[11]: categorical-data
[12]: mark-recapture/cormack-jolly-seber-models/cjs-individual-heterogeneity
[13]: mark-recapture/cormack-jolly-seber-models
[14]: spatial-models/separable-different-implementation
[15]: glmm-generalized-linear-mixed-models/count-data
[16]: admb-tricks/covariance-calculations
[17]: admb-tricks/variance-calculations/variance-in-re-models
[18]: admb-tricks/parameterization/covariance-matrices
[19]: state-space-models/delta-smelt-life-cycle-model
[20]: glmm-generalized-linear-mixed-models/mixed-response/diet-and-heart-disease
[21]: differential-equations
[22]: glmm-generalized-linear-mixed-models/gams-as-mixed-models/generalized-additive-models
[23]: sampling/line-transect-methods/estimation-of-detection-function
[25]: growth-models/orange-trees/extension-correlated-res
[26]: growth-models/orange-trees/extension-crossed-res
[27]: fisheries
[28]: glmm-generalized-linear-mixed-models/count-data/flexible-negative-binomial-model
[29]: function-minimization
[30]: r-stuff/gamma-distributed-myxomatosis-using-r2admb
[31]: glmm-generalized-linear-mixed-models/gams-as-mixed-models
[32]: glmm-generalized-linear-mixed-models/gaussian-models
[33]: spatial-models/the-geostatistical-approach
[34]: glmm-generalized-linear-mixed-models
[35]: r-stuff/glmmadmb.md
[36]: growth-models
[37]: categorical-data/item-response-theory-irt-and-the-multilevel-rasch-model-1
[38]: sampling/line-transect-methods
[39]: r-stuff/lmer-comparison
[40]: mark-recapture
[41]: admb-tricks
[42]: r-stuff/mcmcmc
[43]: glmm-generalized-linear-mixed-models/gams-as-mixed-models/mean-and-variance
[44]: spatial-models/mgrf-car-model-for-the-scottish-lip-cancer-data
[45]: differential-equations/mineralization-of-terbuthylazine.md
[46]: miscellaneous
[47]: glmm-generalized-linear-mixed-models/mixed-response
[48]: glmm-generalized-linear-mixed-models/count-data/negative-binomial-fir-fecundity-1
[49]: glmm-generalized-linear-mixed-models/count-data/negative-binomial-serially-correlated-counts
[50]: glmm-generalized-linear-mixed-models/non-gaussian-random-effects
[51]: winbugs/occupancy-model
[52]: differential-equations/pk-dk/one-compartment-open-model
[53]: growth-models/orange-trees
[54]: categorical-data/ordered-categorical-responses
[55]: glmm-generalized-linear-mixed-models/count-data/owl-nesting-negotiation.md
[56]: function-minimization/parameter-scaling
[57]: admb-tricks/parameterization
[58]: fisheries/pella
[59]: fisheries/pella-t
[60]: differential-equations/pk-dk
[61]: spatial-models/glmm-with-spatial-structure-described-in-terms-of-covariance-function
[62]: r-stuff/a-general-r-admb-interface-for-mixed-models
[63]: r-stuff
[64]: sampling/line-transect-methods/random-scale.md
[65]: sampling
[66]: spatial-models/glmm2019s-on-large-spatial-grids
[67]: simple-examples
[68]: state-space-models/skate-mortality-bayesian-state-space-model
[69]: spatial-models
[70]: admb-tricks/splines-1
[71]: admb-tricks/splines-1/splines
[72]: state-space-models
[73]: by-field-of-application/stochastic-volatility-collection
[74]: state-space-models/stochastic-volatility-models-for-financial-time-series
[76]: survival-analysis
[77]: by-field-of-application/stochastic-volatility-collection/sv-models-with-leverage-effect
[78]: simple-examples/tadpole-mortality-as-a-function-of-size.md
[79]: text-books
[80]: by-field-of-application/stochastic-volatility-collection/the-basic-sv-model-and-simple-extensions-1
[81]: state-space-models/theta-logistic-population-growth-model
[82]: admb-tricks/variance-calculations
[83]: survival-analysis/weibull-regression-with-censoring
[84]: glmm-generalized-linear-mixed-models/non-gaussian-random-effects/wildflowers.md
[85]: winbugs
[86]: glmm-generalized-linear-mixed-models/gams-as-mixed-models/wood-2006-parameterization
  
  
