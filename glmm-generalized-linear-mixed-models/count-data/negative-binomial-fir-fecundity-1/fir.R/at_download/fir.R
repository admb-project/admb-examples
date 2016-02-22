library(R2admb)
setup_admb()
library(emdbook)
data(FirDBHFec)
X=na.omit(FirDBHFec[,c("TOTCONES", "DBH", "WAVE_NON")]) 
X$TOTCONES=round(X$TOTCONES)

compile_admb("fir0", verbose=TRUE)
write_dat("fir0", L=list(nobs=nrow(X), totcones=X$TOTCONES, dbh=X$DBH ))
write_pin("fir0", L=list(a=1, b=1, k=10))
run_admb("fir0", verbose=TRUE)
m0_admb=read_admb("fir0", checkterm=FALSE)
summary(m0_admb)
coef0=coef(m0_admb)

compile_admb("fir_ab", verbose=TRUE)
write_dat("fir_ab", L=list(nobs=nrow(X), totcones=X$TOTCONES, dbh=X$DBH, wave_non=model.matrix(~WAVE_NON, data=X) ))
write_pin("fir_ab", L=list(c(coef0['a'],0, coef0['b'],0, coef0['k'])))
run_admb("fir_ab", verbose=TRUE)
mab_admb=read_admb("fir_ab", checkterm=FALSE)
summary(mab_admb)

compile_admb("fir_abk", verbose=TRUE)
write_dat("fir_abk", L=list(nobs=nrow(X), totcones=X$TOTCONES, dbh=X$DBH, wave_non=model.matrix(~WAVE_NON, data=X) ))
write_pin("fir_abk", L=list(c(coef0['a'],0, coef0['b'],0, coef0['k'],0)))
run_admb("fir_abk", verbose=TRUE)
mabk_admb=read_admb("fir_abk", checkterm=FALSE)
summary(mabk_admb)


nbfit.0 = mle2(TOTCONES ~dnbinom(mu = a * DBH^b, size = k), 
		start=list(a=1,b=1,k=1),data=X)
start.ab = as.list(coef(nbfit.0))
nbfit.ab = mle2(TOTCONES ~ dnbinom(mu = a * DBH^b,size = k), 
		start = start.ab, data = X, 
		parameters = list(a ~ WAVE_NON, b ~ WAVE_NON))
		
logLik(m0_admb)
logLik(mab_admb)
logLik(mabk_admb)
logLik(nbfit.0)
logLik(nbfit.ab)
		
all.equal(coef(m0_admb), coef (nbfit.0))
all.equal(coef(m_admb), coef (nbfit.ab))

head(FirDBHFec)		