# Orange trees
Simple growth curve example with individual effects (random effects) from Pinheiro & Bates (2000)

A growth curve model fitted to the "orange tree" data by [Pinheiro & Bates (2000, Ch.8.2)](http://www.admb-project.org/examples/growth-models/citations.html#pinh:bate:2000) as an illustration of the [R](http://www.r-project.org/) (S-Plus) routine nlme(). The logistic growth curve is given as

_y_ = f<sub>1</sub> /(1 + exp[-(_t_-f<sub>2</sub>)/f<sub>3</sub>]) ] + e,

where _y_ is the response and _t_ is the age of the tree. The regression parameters to be estimated are: f<sub>1</sub>, f<sub>2</sub> and f<sub>3</sub>, and e is the residual error term. A random effect _u_ is added to the parameter f<sub>1</sub>.

### Details

[orange.pdf](http://www.admb-project.org/examples/growth-models/orange-trees/orange.pdf "orange.pdf")

### Extension of the model
See sub files.

### Files
