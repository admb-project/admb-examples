# Prepare data for Lidar example in Chp. 14 in Ruppert, Wand, Carrol, 2003)Generate data for L (2003)
# Read data
data <- read.table("lidar.txt")
names(data) <- c("x","y")
n <- nrow(data)

if(F)
{

cat("# n\n",n,"\n",file="lidar.dat")
cat("# y\n",data$y,"\n",file="lidar.dat",append=T)
cat("# x\n",data$x,"\n",file="lidar.dat",append=T)

minmaxindex <- function(x) 
{
  x <- c(0,x,0)
  tmp <- x!=0
  c((1:length(x))[tmp & (c(0,diff(tmp))!=0)],(1:length(x))[tmp & (c(diff(tmp),0)!=0)])-1
}

# Generate spline basis
  x1 <- min(data$x)
  x2 <- max(data$x)
  B1 <- splineDesign(knots=c(rep(x1,3),seq(x1,x2,l=20),rep(x2,3)),x=data$x)

  cat("# m1\n",ncol(B1),"\n# B1\n",file="lidar.dat",append=T)
  write.table(B1,file="lidar.dat",append=T,col=F,row=F,quote=F)

  # Writes start and stop indexes in B1
  cat("# min,max index in B1 m\n",file="lidar.dat",append=T)
  write.table(t(apply(B1,1,minmaxindex)),file="lidar.dat",append=T,col=F,row=F,quote=F)

  ord2 <- 3
  B2 <- splineDesign(knots=c(rep(x1,ord2-1),seq(x1,x2,l=20),rep(x2,ord2-1)),x=data$x,ord=ord2)

  cat("\n# m2\n",ncol(B2),"\n# B2\n",file="lidar.dat",append=T)
  write.table(B2,file="lidar.dat",append=T,col=F,row=F,quote=F)

  # Writes start and stop indexes in B2
  cat("# min,max index in B2 m\n",file="lidar.dat",append=T)
  write.table(t(apply(B2,1,minmaxindex)),file="lidar.dat",append=T,col=F,row=F,quote=F)

} 

# Plotting routines
if(F)
{
  tt <- scan("lidar.rep")
  par(mfrow=c(2,1))
  plot(data$x,data$y,main="LIDAR data",xlab="x",ylab="y",pch=".")
  lines(data$x,tt[1:n])
  plot(data$x,tt[n+1:n],main="sigma(x)",xlab="x",ylab="sigma",pch=".",type="l",ylim=1.1*c(0,max(tt[n+1:n])))
}

# Plot til Finland
if(F)
{
  tt <- scan("lidar.rep")
  plot(data$x,data$y,main="LIDAR data (Ruppert et al., 2003)",xlab="x",ylab="y")
  lines(data$x,tt[1:n])
}

# Til senimarserie MI
if(T)
{
  tt <- scan("lidar.rep")
  plot(data$x,data$y,main="LIDAR data (Ruppert et al., 2003)",xlab="x",ylab="y",cex.main=1.5,cex.lab=1.5)
  lines(data$x,tt[1:n],col=2,lwd=2)
  f0 = lm(y~x,data=data)
  lines(data$x,predict(f0,newdata=data),col=3,lwd=2)
  legend("bottomleft",legend=c("Lineær regresjon","Semiparametrisk mod."),col=c(3,2),lty=c(1,1),lwd=c(3,3),cex=1.5)

}
if(F)
{
  tt <- scan("lidar.rep")
  par(mfrow=c(2,1))
  plot(data$x,data$y,main="LIDAR data",xlab="x",ylab="y",pch=".")
  lines(data$x,tt[1:n],col=2,lwd=2)
  plot(data$x,tt[n+1:n],main="sigma(x)",xlab="x",ylab="sigma",pch=".",type="l",ylim=1.1*c(0,max(tt[n+1:n])))
}



