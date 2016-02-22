temp <- read.csv('example_data.csv')
library(mgcv)
x <- gam(cbind(y,n-y)  ~s(z, bs = 'cr', k = 10), family = binomial,
     data = temp, fit = FALSE, control = list(scalePenalty=FALSE))
x <- list(X = x$X, S = cbind(0,rbind(0,x$smooth[[1]]$S[[1]])))
x$eigs <- eigen(x$S)
x$eigs$vec <- x$eigs$vec[,order(x$eigs$val)]
x$eigs$val <- x$eigs$val[order(x$eigs$val)]
dat.file <- '../admbre/binom_gam_ML_example.dat' #file to write in admb 
directory
write('# nobs', file = dat.file, append = FALSE)
ind <- which(temp$n >0) #real data is first 1009 rows, others are for 
plotting predicted smoother
write(length(ind), file = dat.file, append = TRUE)
write('# ncol_X', file = dat.file, append = TRUE)
write(dim(x$X)[2], file = dat.file, append = TRUE)
write('# n', file = dat.file, append = TRUE)
write(temp$n[ind], file = dat.file, append = TRUE)
write('# y', file = dat.file, append = TRUE)
write(temp$y[ind], file = dat.file, append = TRUE)
write('# X', file = dat.file, append = TRUE)
write.table(x$X[ind,], file = dat.file, append = TRUE, row.names = 
FALSE, col.names = FALSE)
write('# S', file = dat.file, append = TRUE)
write.table(x$S, file = dat.file, append = TRUE, row.names = FALSE, 
col.names = FALSE)
write('# U', file = dat.file, append = TRUE)
write.table(x$eigs$vec, file = dat.file, append = TRUE, row.names = 
FALSE, col.names = FALSE)
write('# u', file = dat.file, append = TRUE)
write(x$eigs$val, file = dat.file, append = TRUE)
write('# betas_phase', file = dat.file, append = TRUE)
write(1, file = dat.file, append = TRUE)
write('# smooth_reff_phase', file = dat.file, append = TRUE)
write(2, file = dat.file, append = TRUE)
write('# lambda_par_phase', file = dat.file, append = TRUE)
write(2, file = dat.file, append = TRUE)

#then run admb model


ind <- which(temp$n == 0) #rows for prediction
betas <- read.table(file = '../admbre/binom_gam_ml_example.std', skip = 
1)[12:21,3]
smooth_hat <- x$X[ind,][,-1] %*% cbind(betas[-1])

bgs.file <- '../admbre/binom_gam_ml_example.bgs' #binary covariance 
matrix, more digits than .cor file
cov.bin <- file(bgs.file, 'rb')
np <- readBin(cov.bin, what = integer(), n=1)
covs <- readBin(cov.bin, what = numeric(), n=np*np)
cov.mat <- matrix(covs, np, np)
close(cov.bin)
cov.mat <- x$eigs$vec %*% cov.mat[c(1:2,4:11),c(1:2,4:11)] %*% 
t(x$eigs$vec) #have to transform
SE_smooth_hat <- sqrt(diag(x$X[ind,-1] %*% cov.mat[-1,-1] %*% 
t(x$X[ind,-1]))) #just the smoother coefficients
pdf(file = '../tex/comparison_example.pdf')
temp.mgcv.fit <- gam(cbind(y,n-y)  ~s(z, bs = 'cr', k = 10), family = 
binomial,
     data = temp, fit = TRUE, control = list(scalePenalty=FALSE), method 
= 'ML')
plot(temp.mgcv.fit, rug = FALSE, ylab = "s(z)", xlab = "z")
lines(temp$z[ind], smooth_hat, col = 'red')
lines(temp$z[ind], smooth_hat + qnorm(0.975)*SE_smooth_hat, col = 'red', 
lty = 2)
lines(temp$z[ind], smooth_hat - qnorm(0.975)*SE_smooth_hat, col = 'red', 
lty = 2)
rug(jitter(temp$z[which(temp$n>0)], factor = 2))
dev.off()


