#  Diet and heart disease

Filed under:  [-gh (Gauss Hermite integration)][1], [Social science][2], [Transformations of RE][3], [non-gaussian random effect][4], [Skrondal and Rabe-Hesketh (2004)][5]

Example where the observations are of mixed type: continuous and discrete. Also and example of skewed random effects.

A description of the model and data is given here: [skewed_re.pdf][6]


It is customary to assume that random effects are normally distributed. Skrondal and Rabe-Hesketh (2004, Section 14.2) consider a measurement error problem, and compare the following two models:

1. Random effects normally distributed
2. Non-parametric model for the random effects
A description of the model and data is given here: [skewed_re.pdf][6]. The non-parametric model 2) indicates that the random effects distribution is skewed to the right.


In this example we show: 
1) how to implement the model with normal random effects in ADMB-RE ([diet.tpl][7]) and 
2) how to modify the the program to obtain skewed random effects ([diet_sk.tpl][8]). Only a small number of changes are needed to modify the ADMB-RE code to implement the skewed random effects.

### Results

By looking at the result files (diet.par and diet_sk.par) we observe the following:

1. The estimated parameters under the normal model match very closely the estimates in Table 14.1 of Skrondal and Rabe-Hesketh (2004).
2. The log-likelihood value for the normal model is -1372.35, while the log-likelihood for the model with skewed random effects is -1326.49. Hence, given that the skewed model only contains one extra parameter, it gives a much better fit to data.

### Files
* [skewed_re.pdf][6]
* [diet.tpl][7]
* [diet.dat][9]
* [diet.pin][10]
* [diet_sk.tpl][8]
* [diet_sk.dat][11]
* [diet_sk.pin][12]

### References
Skrondal and Rabe-Hesketh (2004), Generalized Latent Variable Modeling: Multilevel, Longitudinal and Structural Equation Models. Chapman & Hall

[1]: https://github.com/admb-project/examples/search?utf8=%E2%9C%93&q=-gh+%28Gauss+Hermite+integration%29
[2]: https://github.com/admb-project/examples/search?utf8=%E2%9C%93&q=Social+science
[3]: https://github.com/admb-project/examples/search?utf8=%E2%9C%93&q=Transformations+of+RE
[4]: https://github.com/admb-project/examples/search?utf8=%E2%9C%93&q=non-gaussian+random+effect
[5]: https://github.com/admb-project/examples/search?utf8=%E2%9C%93&q=Skrondal+and+Rabe-Hesketh+%282004%29
[6]: ./skewed_re.pdf
[7]: .diet.tpl
[8]: ./diet_sk.tpl
[9]: ./diet.dat
[10]: ./diet.pin
[11]: ./diet_sk.dat
[12]: ./diet_sk.pin
