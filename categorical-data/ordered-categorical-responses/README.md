#  Ordered categorical responses

Filed under:  [Social science][1]

The SOCATT data set is used in the comparison of different software packages for multilevel modelling, conducted by the [Centre for Multilevel Modelling][2]. The SOCATT data consist of the responses to a set of dichotomous items on a woman's right to have an abortion. The outcome variable (_yij_) is a score constructed from these items ranging from 1 to 7, with a higher score corresponding to stronger support for abortion. Each of 264 respondents was asked the same set of questions on four occasions, 1983-1986, and _yij_ denotes the response from individual _i_ in year _j_

. We consider one categorical covariate (religion) with 4 categories. A random intercept ordered logit model was fitted:

 

logit[ P(_yij < s_) ] = _ks b1xi1 b2*xi2 b3*xi3_ _ui_,

_ui_ ~ N(0,_s2_)

where _x1i_, _x2i_ and _x3i_ are dummy variables coding for the different levels of the categorical covariates, and _ks_ are threshold parameters. A full description of the model can be found here: [socatt.pdf][3]

 

 

 

 

 

[1]: http/www.admb-project.or@@search?Subject:list=Social science
[2]: http/multilevel.ioe.ac.usoftreindex.html
[3]: socatt.pdf "socatt.pdf"
