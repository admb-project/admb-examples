# Adjoint code — ADMB Project

Filed under: [ADMB Tricks][8]

### Why to write adjoint code?

When you write code for variable objects in ADMB, all the derivatives are calculated for you. To accomplish this, ADMB must save derivative information for variable objects, which can take a lot of memory and be time consuming for functions that are called many times. The purpose of writing adjoint code is to reduce the amount of derivative information that must be calculated and stored in order to speed up the process. 

### Approach for simple functions

Chapter 13 of the [ADMB manual][1] describes how to write and debug adjoint code for simple functions that take between 1 and 4 independent variables. The .tpl files are included below.

[1 independent variable][2]

[2 independent variables][3]

[4 independent variables][4] 

### Structured approach for more complex functions

For more complicated functions the previous approach becomes untenable and a more structured approach to calculate the derivatives is taken in the following example. Notice that to calculate the derivatives, every line of code in the function is repeated in the opposite order and the corresponding derivatives are calculated.

[4 independent variables with structured calculation of derivatives][5] 

### General adjoint code

In the previous examples the adjoint code has been used for a simple function which has from 1 to 4 independent variables. When functions can take any number of independent variables and return any number of dependent variables a more general approach is required. Steve Martell provided an example of writing adjoint code to numerically solve the Baranov catch equation and both its .tpl and its documentation are included below.

[Baranov example documentation][6]

[Baranov example][7]

 

[1]: http://www.admb-project.org/documentation/manuals/admb-user-manuals "ADMB User Manuals"
[2]: Adjoint_1var.tpl "Adjoint_1var.tpl"
[3]: Adjoint_2var.tpl "Adjoint_2var.tpl"
[4]: Adjoint_4var.tpl "Adjoint_4var.tpl"
[5]: Adjoint_4var_str.tpl "Adjoint_4var_str.tpl"
[6]: AdJointCodeBaranov.pdf "AdJointCodeBaranov.pdf"
[7]: barnov.tpl "barnov.tpl"
[8]: ./../
  
