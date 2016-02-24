#  Mineralization of terbuthylazine

**This example is part of the [NCEAS non-linear modelling project][1]**

**By Anders Nielsen**

Terbuthylazine is a herbicide used in agriculture. It is a so-called s-triazin like atrazine, which has been banned in Denmark after suspicion of causing cancer.  
Terbuthylazine can be bound to the soil, but free terbuthylazine can be washed into the drinking water. Some bacteria can mineralize it. This data is part of a larger experiment to determine the ability of certain bacteria to mineralize terbuthylazine, and to estimate the mineralization rate.

This is a fairly straightforward nonlinear least-squares problem, with normally distributed residuals and no random effects or latent variables. The deterministic part of the model is the solution to a set of coupled ordinary differential equations (ODEs) for the concentrations in different compartments. Because the ODEs are linear, the deterministic solution can be found directly in terms of a matrix exponential, for which functions exist in all three of ADMB, BUGS, and R. From there it is simply a matter of defining a normal likelihood, or equivalently a least-squares expression, and minimizing it. The main differences appear in the speed and robustness of the matrix exponential formulations in different software tools.

[Documentation][2]

[Source code][3]

 

[1]: https/groups.nceas.ucsb.ednon-linear-modelinprojects
[2]: https/groups.nceas.ucsb.ednon-linear-modelinprojectmiWRITEUmin.pdf
[3]: https/groups.nceas.ucsb.ednon-linear-modelinprojectmin
