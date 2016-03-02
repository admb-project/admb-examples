#  GMRF: CAR model for the Scottish Lip Cancer Data

Example of conditionally autoregressive (CAR) model applied to 56 geographical Scottish regions.

If you google "Scottish Lip Cancer Data" you will find that these data are used in many textbooks on spatial modelling, also as examples for statistical software (e.g. Winbugs). We use the notation from <http/www.biostat.umn.ed~ph744pubh744slideLips.pdf>

The main ingredients of the model are:

1. Counts are Poisson distributed
2. A spatially smooth term (phi) affects the expected number of counts. This is the CAR part of the model. "phi" for one particular region is normally distributed (mean,sigma^m), where mean is the average of the neighbouring phi's, and m is the number of neighbour for this region. The specification of such a distribution for each region collectively constitute the CAR prior.
3. There is a heterogeneity effect  theta  associate with each region, assumed to be independent between regions.

## Specifying the CAR prior

In this example the neighbourhood structure is specified in a separate file (_scotlandgraph.dat_). The first part of this file looks as:

    1 3 5 9 19
    2 2 7 10
    3 1 12
    4 3 18 20 28
    5 3 1 12 19
    6

The first line means: for region "1", the neighbours are: 3,5,9,19. Region "6" (an island) has no neighbours, and no CAR prior can be assigned to it.

In the tpl file the rugged array W holds the neighboorhood information. In a loop over all regions, the CAR prior for the i'th region is calculated by the call

    car_prior(phi(W(i)),i)

which invokes the code

      dvariable mean = sum(phi(1,m(i))m(i);
      g -= -0.5*square(phi(0)-mean)*m(i);

 where "mean" is the average of the neighbouring values. The variance is set to be m (m=number of neighboors),  which phi is scaled by "sigma" in the Poisson likelihood.

##  Running the program

CAR models should be run with the -shess" command line option. For this small example the run time is anyway small, but for large datasets this is crucial.

###Files
* [car_scottish.dat][1]
* [car_scottish.tpl][2]
* [scotlandgraph.dat][3]

[1]: ./car_scottish.dat
[2]: ./car_scottish.tpl
[3]: ./scotlandgraph.dat
