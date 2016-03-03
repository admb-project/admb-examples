#  Separable covariance function

Filed under: [Spatial Models][19]

Poisson GLMM on large spatial grid

It has for a long time been possible to fit GLMMs (Generalized Linear Mixed Models) in ADMB-RE. A typical example is correlated count data with Poisson distribution. However, when the observation are located on a spatial grid the number of latent variables (random effects in the ADMB-RE terminology) grows quadratically in the number of grid points in each geographical direction. The large number of random effects causes a computational challenge.

###Example:
* [admb_files.zip][1]

tpl-file and data files needed for running the example. gmrf10.dat contains a 10x10 grid, and should run fast. gmrf100.dat contains a 100x100 grid, and will require >8Gb of memory. In addition you should use the command line 
```
./gmrf -est -ilmn 5 -ind gmrf100.dat -shess -ndi 10000000 -noinit -gbs 100000000 
```

Note: Current research on the ADMB source code has shown that relatively small modifications will make it feasible to fit a 200x200 grid on a 1.5 Gb machine. These improvements will find their way into the official ADMB source soon.

###Files:
* [admb_files.zip][1]
* [model_description.pdf][2]
* [newsletter.pdf][3]

[1]: ./admb_files.zip
[2]: ./model_description.pdf
[3]: ./newsletter.pdf
[19]: ./../
