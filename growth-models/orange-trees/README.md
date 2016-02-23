#  Orange trees

Filed under:  [Growth models][1]

Simple growth curve example with individual effects (random effects) from Pinheiro & Bates (2000)

A growth curve model fitted to the "orange tree" data by [Pinheiro & Bates (2000, Ch.8.2)][2] as an illustration of the [R][3] (S-Plus) routine nlme(). The logistic growth curve is given as

 

_y_ = f1 /(1 exp[-(_t_-f2)/f3]) ] e,

 

where _y_ is the response and _t_ is the age of the tree. The regression parameters to be estimated are: f1, f2 and f3, and e is the residual error term. A random effect _u_ is added to the parameter f1.

 

### Details

[orange.pdf][4]

 

### Extension of the model

See subfolders to the left 

### Files

See list to the left

 

 

[1]: http://www.admb-project.org/@@search?Subject:list=Growth models
[2]: citations.html#pinh:bate:2000
[3]: http://www.r-project.org/
[4]: ./orange.pdf "orange.pdf"
