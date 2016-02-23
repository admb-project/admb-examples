#  lmer() comparison

Application of ADMB to the simulated datasets in Zhang et al. (2011) with emphasis on comparison to the R function lmer()

 

 

Comparison by David Fournier:

 

A few days ago there was a posting

<https://stat.ethz.ch/pipermail/r-sig-mixed-models/2011q4/006887.html>

indicating that a reviewer considered lmer less reliable than SAS NLMIXED. The source of this distrust was pehaps the results of the paper Zhang et al. (2011)

Zhang et al. simulated data from a simple mixed model and used the Wald statistic to test the hypothesis that the value of one of  the fixed effects parameters was equal to 1.0. (the true value in the simulations.) They claimed that the type 1 error rate for lmer was much higher for lmer than for NLMIXED and much higher than the correct value of 5%.

Type 1 error is when one incorrectly rejects the hypothesis that the true parameter value is 1.0.

The test consists of taking the parameter estimate -1 divided by its estimated std dev and looking at this value squared. If the value is too large the hypothesis is rejected.  Zhang et al. concluded that the main source of the large type 1 error for lmer was due to systematic underestimation of the std dev of the parameter estimate in lmer.

The ensuing discussion raised several issues.

1. SAS is closed source. (This seems to be a religious problem, but it was taken seriously by some.)
2. Is it due to the Laplace approximation (LA) not being accurate enough so that adaptive Gauss-Hermite quadrature (AGQ) will solve the problem.
3. If 2.) is true since AGQ can only be used for nested models this poses a problem with crossed random effects.  

It was interesting that while there was a lot of discussion, no one seemed to want to simply run the simulation and verify or disprove the results reported in Zhang et al. I  think this is important since  for better or worse a lot of people use the std dev estimate for calculating p values.

To deal  with 1.) I compared lmer to AD Model Builder's random effects package. This is open source software so it should be free from religious objections. AD Model Builder can do both LA and AGQ so that one can get results comparing the improvement of say 5 point AGQ over LA.

 

For the simulations I picked the N=500 case from Zhang et al with the std dev tau=2 (large variance case).

 

I simulated 1000 data sets using an R script supplied by Ben Bolker. I used a small bash shell script to run R 1000 times. This approach makes it easy to feed the simulated data either into R or the ADMB program. A random nunber seed was kept in a file named seed to make it easy to replicate the results. Initially seed=1000.

 

For the first set of runs the Laplace approximation was used in both lmer and ADMB. The result for R were 24.7% type 1 error.  The mean of b1 was 0.978, the std dev of the estimate for b1 was 0.203 and the mean of the estimated std devs from lmer was 0.118. For ADMB the type 1 error rate was 10.2% the mean of b1 was 0.971. The std dev of the estimates was 0.164 and the mean of the estimated std devs was 0.140.  So ADMB performed better than lmer. There appears to be a slight negative bias in the estimates for b1 and the type 1 error rate is about twice the theoretical value of 5%. This would appear to support the findings of Zhang et al that lmer underestimates the std dev of the parameter estimate in this case.

 

Can these results be improved with adaptive Gauss-Hermite quadrature?

For the second set of 1000 runs 5 point AGQ was used. For lmer the type 1 error rate was larger, 31.7%. The mean of b1 was 0.879 so that there appears to be significant bias. The std dev of the estimates was 0.156 and the mean of the estimated std devs was 0.107.  This seems to indicate that there is some bug in the implementation of  AGQ in lmer. For ADMB the type 1 error rate was 4.7%. The mean of b1 was 0.971. The std dev of the estimates was 0.132 and the mean of the estimated std devs was 0.139. This is close to the estimates reported for NLMIXED in Zhang et al.

 

### Code to run lmer()

This is the bash shell script (found on linux) used to run the R simulations.

    for i in {1..1000}
    do
     R CMD BATCH ./bolker-par.r
    done

where the R script [_bolker-par.r_][1] must be located in the current directory.

 

### Code to run ADMB

This is the R script for the simulator modifed to write out the simulated data for analysis by ADMB is given here: [_write2admb.r_][2] The following ADMB must be used to fit the model using ADMB: [_analyzer.tpl_][3]

 

### References

Zhang et al. (2011) On fitting generalized linear mixed-effects models for binary responses using different  statistical packages. _Statistics in Medicine_, 30, p. 1097-0258.

[1]: lmer-comparison/bolker-par.r "bolker-par.r"
[2]: lmer-comparison/write2admb.r "write2admb.r"
[3]: lmer-comparison/analyzer.tpl "analyzer.tpl"
