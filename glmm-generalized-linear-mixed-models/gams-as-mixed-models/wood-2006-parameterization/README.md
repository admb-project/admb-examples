#  Wood (2006) parameterization

Filed under:  [Splines][1], [Generalized Linear Mixed Models][5], [GAMs as Mixed Models][6]

The following example shows how the parameterization of the smoothing spline, based on eigen decomposition, can be implemented in ADMB. Comparison is made to gmcv. An advantage offered by ADMB is that uncertainty in the smoothing parameter is incorporated into the uncertainty of the GAM fit.

###Model description:

[binom_gam_ML_example.pdf][2]

### Files
* [binom_gam_ML_example.dat][3]
* [binom_gam_ML_example.tpl][4]
* [run_analysis.R][5]
* [example_data.csv][6]

[1]: ./../../../admb-tricks/splines-1
[2]: ./binom_gam_ML_example.pdf
[3]: ./binom_gam_ML_example.dat
[4]: ./binom_gam_ML_example.tpl
[5]: ./run_analysis.R
[6]: ./example_data.csv
