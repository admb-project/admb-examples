#  Covariance matrices

Parameterization via the Cholesky factor (Incomplete example)

If you want to estimate the parameters of a covariance matrix S you must ensure that the resulting matrix is:

1) symmetric and 

2) positive definite. 

To achieve this you do not parameterize S directly, but rather its Cholesky factor L, i.e. S = LL', see <http/en.wikipedia.orwikCholesky_decomposition>

 

The following two step procedure is recommended:

1) Parameterize the correlation matrix C via the Cholesky factor as explained here [Correlation matrix][1]

2) Scale C with the standard deviations to obtained S.

Complete example given in [C.tpl][3] and [C.dat][4].

**Constrained covariance matrices**

Sometimes you want elements in the C (or S) to be zero, say S(1,2) = 0, meaning the element 1 and 2 are uncorrelated. An example of how to achieve this is provided here:

[constrained_cor.tpl][4]

[constrained_cor.dat][5]


[1]: "correlation_matrix.pdf" "Correlation matrix"
[2]: C.tpl
[3]: C.dat
[4]: constrained_cor.tpl "constrained_cor.tpl"
[5]: constrained_cor.dat "constrained_cor.dat"
