#  Parameter scaling

Filed under: [Function Minimization][1]

Shows how to scale parameters so that they become of the same magnitude, as seen from the perspective of the function minimizer

Numerical minimizing algorithms are more stable if the parameters are of the same magnitude. A typically printout (when running the program) indicating that scaling is needed is:

    Var   Value    Gradient   |Var   Value    Gradient   |Var   Value    Gradient   
      1-114.2917 -1.01971e-03 |  2  0.68496 -1.61913e-03 |  3 19.44854 -8.88731e-03
      4  7.13834 -1.42007e-03 |  5  2.92391  1.48536e-03 |  6 -3.05878 -8.16281e-03
      7  0.43921 -8.80460e-03 |  8 -0.71284 -6.23123e 00 |
    Function minimizer not making progress ... is minimum attained?
    Minimprove criterion =   0.0000e 00

We see that variable 8 has a much higher gradient than the other parameters. We need to "scale" that parameter.

 

## Example

In the following we see that the range of  _b_  is 1000 times larger than that of  _a_:

      init_bounded_number a(-2.,2.)
      init_bounded_number b(-2000.,2000.)

That could yield convergence problems. To counteract this we can use

      !! b.set_scalefactor(0.001);

which makes the function minimizer work internally with b_internal = 0.001*b.  From the user's perspective nothing has happened (b will be correct in .par and .std files).

 

### Which parameters to scale?

 

1. Make your program converge so that you get the printout on the top of this page where you see which parameters do not have a good gradient.
2. Apply set_scalefactor(10)  to these parameters, and gradually increase until the gradient is reduced.

 

### Availablity

This feature will become available for random effects model (admb -r) from release VERSION to 11.1.

[1]: ./../
