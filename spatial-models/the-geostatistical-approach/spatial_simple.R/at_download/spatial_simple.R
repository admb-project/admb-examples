# Generates data from spatial model

source("ADMButils.s")

# True parameter values
a = 0.5			# Correlation parameter (in exponential correlation function)
sigma = 0.5             # Standard deviation of random field u
tau = 0.5		# Standard deviation of measurement error term
beta = 0   		# Fixed effects

# Generate correlation matrix M
n = 20               	# Sample size
Z = matrix(runif(2*n,0,10),nrow=n,ncol=2)   # Locations uniformly on [0,10]x[0,10]
Mx = outer(Z[,1],Z[,1],function(x1,x2) x1-x2)
My = outer(Z[,2],Z[,2],function(y1,y2) y1-y2)
d = sqrt(Mx^2+My^2)    # Distance matrix
M = exp(-a*d)      # Correlation matrix

if(F)
{
  X = matrix(c(rep(1,n),runif(n*(p-1),-2,2)),nrow=n)  # Covariate matrix for fixed effects
}


# Simulate data
z = rnorm(n)                   # iid N(0,1) variates
u = t(chol(M))%*%z     # Random effects
Y  = rnorm(n,mean=beta+sigma*u,sd=tau)           # Data

dat_write("spatial_simple",list(n=n,Y=Y,Z=Z))
