# Generates data from negative binomial spatial model

source("ADMButils.s")

# True parameter values
a = 0.9			# Correlation parameter (in exponential correlation function)
sigma = 1.0             # Standard deviation of random field u
tau=3			# Overdispersion of negbin
beta = 0   		# Fixed effects

# Generate correlation matrix M
n = 30               	# Sample size
Z = matrix(runif(2*n,0,10),nrow=n,ncol=2)   # Locations uniformly on [0,10]x[0,10]
Mx = outer(Z[,1],Z[,1],function(x1,x2) x1-x2)
My = outer(Z[,2],Z[,2],function(y1,y2) y1-y2)
d = sqrt(Mx^2+My^2)    # Distance matrix
M = exp(-a*d)      # Correlation matrix

# Simulate data
z = rnorm(n)            # iid N(0,1) variates
u = t(chol(M))%*%z      # Random effects
mu = exp(beta+sigma*u)
theta = mu/(tau-1)	# rnegbin-parameterizaiton of Poisson-gamma mixture
Y  = rnegbin(n,mu=mu,theta=theta)           # Data
dat_write("spatial_negbin",list(n=n,Y=Y,Z=Z))
