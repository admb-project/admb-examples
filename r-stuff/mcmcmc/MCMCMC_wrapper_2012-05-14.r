
#####################
#
# Functions
#
#####################

# Loglikelihood for the model in R
LogLikeFn = function(x,y){
  LL1 = dmvnorm(c(x,y), mean=Mean1, sigma=Cov1, log=TRUE)
     #-0.5 * ( log(2*3.141592) + log(det(Cov1)) + c(c(x,y)-Mean1) %*% Inv1 %*% c(c(x,y)-Mean1));
  LL2 = dmvnorm(c(x,y), mean=Mean2, sigma=Cov2, log=TRUE)
  LL = log( Mix[1]*exp(LL1) + Mix[2]*exp(LL2) )
  return(LL)
}

# Write DAT file for the model in ADMB
WriteDat = function(Loc, Heat){
  write("#Heat", file=paste(Loc,"mix.dat",sep=""))
  write.table(Heat, file=paste(Loc,"mix.dat",sep=""), append=TRUE, row.names=FALSE, col.names=FALSE)
  write("#Mean1", file=paste(Loc,"mix.dat",sep=""), append=TRUE)
  write.table(Mean1, file=paste(Loc,"mix.dat",sep=""), append=TRUE, row.names=FALSE, col.names=FALSE)
  write("#Mean2", file=paste(Loc,"mix.dat",sep=""), append=TRUE)
  write.table(Mean2, file=paste(Loc,"mix.dat",sep=""), append=TRUE, row.names=FALSE, col.names=FALSE)
  write(c("#LnDet1",log(det(Cov1))), file=paste(Loc,"mix.dat",sep=""), append=TRUE)
  write(c("#LnDet2",log(det(Cov2))), file=paste(Loc,"mix.dat",sep=""), append=TRUE)
  write("#Inv1", file=paste(Loc,"mix.dat",sep=""), append=TRUE)
  write.table(Inv1, file=paste(Loc,"mix.dat",sep=""), append=TRUE, row.names=FALSE, col.names=FALSE)
  write("#Inv2", file=paste(Loc,"mix.dat",sep=""), append=TRUE)
  write.table(Inv2, file=paste(Loc,"mix.dat",sep=""), append=TRUE, row.names=FALSE, col.names=FALSE)
  write(c("#Mix",Mix), file=paste(Loc,"mix.dat",sep=""), append=TRUE)
}

####################
#
# Example using 2-component mixture of bivariate normal distributions
#
####################

File = "C:\\Users\\James Thorson\\Desktop\\UW Hideaway\\MCMCMC\\"

source(paste(File,"Fn_AdmbMc3_2012-05-14.r",sep=""))
library(mvtnorm)

# Params
Mean1 = c(6,6)
  Cov1 = matrix(c(1,-0.7,-0.7,1),ncol=2)
  Inv1 = solve(Cov1)
Mean2 = c(-6,-6)
  Cov2 = matrix(c(1,-0.7,-0.7,1),ncol=2)
  Inv2 = solve(Cov2)
Mix = c(0.5, 0.5)

# Exploratory plot
A = seq(-10,10,by=0.1)
B = seq(-10,10,by=0.1)
Z = array(NA, dim=c(length(A),length(B)))
for(aI in seq_along(A)){
for(bI in seq_along(B)){
  Z[aI,bI] = LogLikeFn(A[aI],B[bI])
}}

# Fit model using ADMB MCMC
PrelimFile = paste(File,"Prelim\\",sep="")
  dir.create(PrelimFile)
  file.copy(from=paste(File,"mix.exe",sep=""), to=paste(PrelimFile,"mix.exe",sep=""), overwrite=FALSE)

write("#Heat", file=paste(PrelimFile,"mix.dat",sep=""))
  write.table(1, file=paste(PrelimFile,"mix.dat",sep=""), append=TRUE, row.names=FALSE, col.names=FALSE)
  write("#Mean1", file=paste(PrelimFile,"mix.dat",sep=""), append=TRUE)
  write.table(Mean1, file=paste(PrelimFile,"mix.dat",sep=""), append=TRUE, row.names=FALSE, col.names=FALSE)
  write("#Mean2", file=paste(PrelimFile,"mix.dat",sep=""), append=TRUE)
  write.table(Mean2, file=paste(PrelimFile,"mix.dat",sep=""), append=TRUE, row.names=FALSE, col.names=FALSE)
  write(c("#LnDet1",log(det(Cov1))), file=paste(PrelimFile,"mix.dat",sep=""), append=TRUE)
  write(c("#LnDet2",log(det(Cov2))), file=paste(PrelimFile,"mix.dat",sep=""), append=TRUE)
  write("#Inv1", file=paste(PrelimFile,"mix.dat",sep=""), append=TRUE)
  write.table(Inv1, file=paste(PrelimFile,"mix.dat",sep=""), append=TRUE, row.names=FALSE, col.names=FALSE)
  write("#Inv2", file=paste(PrelimFile,"mix.dat",sep=""), append=TRUE)
  write.table(Inv2, file=paste(PrelimFile,"mix.dat",sep=""), append=TRUE, row.names=FALSE, col.names=FALSE)
  write(c("#Mix",Mix), file=paste(PrelimFile,"mix.dat",sep=""), append=TRUE)

Time = system.time({
  setwd(PrelimFile)
  shell("mix -mcmc 10000")
  shell("mix -mcnoscale -mcr -mcmc 10000000 -mcsave 10000")  # 10 million runs, 1000 saved values
})

Mcmc = ReadPsv(fn=paste(PrelimFile,"mix.psv",sep=""))
  file.remove(paste(PrelimFile,"mix.psv",sep=""))

jpeg(paste(File,"ADMB_MCMC.jpg",sep=""),width=6,height=6,res=200,units="in")
  contour(x=A, y=B, z=exp(Z), levels=c(0.5,0.1,0.01,0.001,0.0001))
  points(Mcmc)
  #text(x=-8,y=8, labels=Time[3],cex=0.5)
dev.off()

################
#
# Apply MC3
#
################

Heat = c(1,6)   # Tuned manually to achieve adequate mixing and have a swap rate of ~20%
Ntot = 1000000 # 1 million samples with 1000 saves
Nsweep = 1001

#File=File; AdmbName="mix"; Heat=Heat; Ntot=Ntot; Nsweep=Nsweep; Intern=TRUE; AdditionalAdmbArgs=""
Return = AdmbMc3(File=File, AdmbName="mix", Heat=Heat, Ntot=Ntot, Nsweep=Nsweep, Intern=TRUE, AdditionalAdmbArgs="")

# Save results
Save = list(Mcmc1=Return$Mcmc1, Mcmc2=Return$Mcmc2, Mcmc=Mcmc, Accept=Return$Accept, A=A, B=B, Z=Z) 
  save(Save, file=paste(File,"Save.RData",sep=""))

# Remove burn-in
Sample = Return$Mcmc1[(nrow(Return$Mcmc1)/2+1):nrow(Return$Mcmc1),]

# Thin (to have the same number as ADMB)
Sample = Sample[seq(1,nrow(Sample),length=1000),]

# Plot samples
jpeg(paste(File,"ADMB_MCMCMC.jpg",sep=""),width=6,height=6,res=200,units="in")
  contour(x=A, y=B, z=exp(Z), levels=c(0.5,0.1,0.01,0.001,0.0001))
  points(Sample)
dev.off()

# Plot trace
jpeg(paste(File,"ADMB_MCMCMC_Trace.jpg",sep=""),width=8,height=4,res=200,units="in")
  par(mfrow=c(1,2), mar=c(3,3,2,0), mgp=c(1.25,0.25,0), tck=-0.02)
  matplot(Return$Mcmc1,type="l",lty="solid")
  matplot(Return$Mcmc2,type="l",lty="solid")
dev.off()
  