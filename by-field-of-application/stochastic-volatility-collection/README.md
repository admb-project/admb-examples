#  Stochastic volatility models

Stochastic volatility models are used to model financial time series with time-varying volatility.

An important property of financial time series is that volatility, defined as the standard deviation of log-returns, is time-varying. There are two types of models used for analyzing time series with varying volatility: GARCH models and stochastic volatility (SV) models. In GARCH models the conditional volatility is a deterministic function of previous returns and volatilities, while in SV-models volatility is assumed to follow a latent stochastic process. Although SV-models have favorable properties compared to GARCH, they are less used in practice. The reason for this is that they are much harder to fit. The problem is that due to non-linear dependence between returns and latent volatilities, it is not possible to find a closed form expression for the likelihood function for SV models. Much work has been done to overcome this problem, but most approaches are either inefficient or hard to implement. Here it is shown how several SV-models can be easily fit to financial returns using ADMB-RE.

1. [**The basic SV-model and simple extensions**.][1] In this section the basic SV-model is introduced, and it is shown how simple modifications can produce models that also can capture skewness and higher kurtosis than the basic model. 
2. [**SV-models with leverage effect**. ][2]We often see an increase in volatility after a drop in returns. This phenomenon is called leverage effect and seems to be particularly important for stocks. Leverage effect can be modeled by correlated noise terms in the retun and the volatility equations. Models with correlated noise terms have a more complicated structure, and are therefore treated in a separate section.

 

 

 

 

 

[1]: the-basic-sv-model-and-simple-extensions-modeller.html "The basic SV model and simple extensions"
[2]: sv-models-with-leverage-effecsv-models-with-leverage-effect.html "SV models with leverage effect"
