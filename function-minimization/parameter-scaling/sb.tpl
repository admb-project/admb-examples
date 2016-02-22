// Example of how to scale parameters so that they
// are of the same magnitude. This improves convergence in the 
// function minimizer.

DATA_SECTION
PARAMETER_SECTION
  init_bounded_number a(-2.,2.)
  init_bounded_number b(-200.,200.)
  
  // The following makes the optimizer work
  // internally with b_internal = 0.01*b
  // which is on the same scale as "a".
  !! b.set_scalefactor(0.01); 
  
  random_effects_vector u(1,1)
  objective_function_value f
PROCEDURE_SECTION
  f=square(a-.2)+square(u(1)-a)+square(b);
GLOBALS_SECTION 
