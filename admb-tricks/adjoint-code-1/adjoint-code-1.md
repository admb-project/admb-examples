<h1 class="documentFirstHeading" id="parent-fieldname-title">
                    Adjoint code
                </h1><div class="" id="parent-fieldname-text-7112b712-3412-4557-befe-926d372a3ca0">
<h3>Why to write adjoint code?</h3>
<p>When you write code for variable objects in ADMB, all the derivatives are calculated for you. To accomplish this, ADMB must save derivative information for variable objects, which can take a lot of memory and be time consuming for functions that are called many times. The purpose of writing adjoint code is to reduce the amount of derivative information that must be calculated and stored in order to speed up the process. </p>
<h3>Approach for simple functions</h3>
<p>Chapter 13 of the <a class="internal-link" href="http://www.admb-project.org/documentation/manuals/admb-user-manuals" title="ADMB User Manuals">ADMB manual</a> describes how to write and debug adjoint code for simple functions that take between 1 and 4 independent variables. The .tpl files are included below.</p>
<p><a class="internal-link" href="adjoint-code-1/Adjoint_1var.tpl" title="Adjoint_1var.tpl">1 independent variable</a></p>
<p><a class="internal-link" href="adjoint-code-1/Adjoint_2var.tpl" title="Adjoint_2var.tpl">2 independent variables</a></p>
<p><a class="internal-link" href="adjoint-code-1/Adjoint_4var.tpl" title="Adjoint_4var.tpl">4 independent variables</a> </p>
<h3>Structured approach for more complex functions</h3>
<p>For more complicated functions the previous approach becomes untenable and a more structured approach to calculate the derivatives is taken in the following example. Notice that to calculate the derivatives, every line of code in the function is repeated in the opposite order and the corresponding derivatives are calculated.</p>
<p><a class="internal-link" href="adjoint-code-1/Adjoint_4var_str.tpl" title="Adjoint_4var_str.tpl">4 independent variables with structured calculation of derivatives</a> </p>
<h3>General adjoint code</h3>
<p>In the previous examples the adjoint code has been used for a simple function which has from 1 to 4 independent variables. When functions can take any number of independent variables and return any number of dependent variables a more general approach is required. Steve Martell provided an example of writing adjoint code to numerically solve the Baranov catch equation and both its .tpl and its documentation are included below.</p>
<p><a class="internal-link" href="adjoint-code-1/AdJointCodeBaranov.pdf" title="AdJointCodeBaranov.pdf">Baranov example documentation</a></p>
<p><a class="internal-link" href="adjoint-code-1/barnov.tpl" title="barnov.tpl">Baranov example</a></p>
<p> </p>
</div>