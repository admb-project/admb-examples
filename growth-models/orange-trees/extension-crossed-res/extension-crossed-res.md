#  Extension: crossed RE's

Adds a "day effect" following Millar (2004, Aust NZ J. Stat, 46, p. 543-554)

The following example was considered by Millar (2004, Aust NZ J. Stat, 46, p. 543-554). A "day effect" (_v_) was added to the original model formulation, yielding

    

_yij_ = f1,_ij_ /(1 exp[-(_t_-f2)/f3]) ] e_ij_,

f1,_ij_ = f1 _ui_ _vj_

_  
_

where _u_ is a tree-effect and _v_ is a day-effect. This is an example of a model where the random effects _u_ and _v_ are crossed. Millar (2004) used simulated likelihood to evaluate the marginal likelihood. 