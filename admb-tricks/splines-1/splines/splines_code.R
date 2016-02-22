getsplines <- function(runmodel=F,runmcmc=F,plot1=F,plot2=T,dopdf=T,wd="c:/admb/tests/splines/"){
  # a very quick and dirty function by Ian Taylor to go with the
  # splines ADMB example (which was quick and dirty itself)
  
  setwd(wd)
  if(runmodel) system('splines')
  if(runmcmc){
    system('splines -mcmc 10000 -mcsave 100')
    system('splines -mceval')
  }

  z = read.table("splines.rep",fill=T,col.names=1:3)

  nobs = z[2,1]
  Nknots = z[3,1]

  knots = z[3+1:Nknots,1:3]
  dat = z[3+Nknots+1:nobs,1:3]
  mat = z[3+Nknots+nobs+1:101,1:2]

  x <- mat[,1]
  
  if(dopdf) pdf("spline_example.pdf",width=6,height=9)

  mat$diff <- NA
  mat$diff[-1] = diff(mat[,2])/diff(x)
  mat$diff2 <- NA
  mat$diff2[-1] = diff(mat$diff)/diff(x)
  mat$diff3 <- NA
  mat$diff3[-1] = diff(mat$diff2)/diff(x)

  if(plot1){
    par(mfcol=c(4,1),mar=rep(2,4),oma=rep(2,4))
    plot(mat[,1:2],lwd=3,col=1,type='l',main='Cubic Spline fit to data',
         ylim=range(dat[,2],mat[,2],na.rm=T))
    points(dat)
    points(knots[,1:2],pch=16,cex=2)
    plot(x,mat$diff, lwd=3,col=2,type='l',main='First derivative')
    points(knots[,c(1,3)],pch=16,cex=2)
    plot(x,mat$diff2,lwd=3,col=3,type='l',main='Second derivative')
    plot(x,mat$diff3,lwd=3,col=4,type='l',main='Third derivative')
  }

  if(plot2 & file.exists("posteriors.rep")){
    post <- read.table("posteriors.rep",skip=1)

    N <- nrow(post)
    post0 <- post[, -(1:(nobs+2))]

    post1 <- NA*post0
    post2 <- NA*post0
    post3 <- NA*post0
    
    post1[,-1] = t(apply(post0,1,diff))/diff(x)
    post2[,-1] = t(apply(post1,1,diff))/diff(x)
    post3[,-1] = t(apply(post2,1,diff))/diff(x)

    par(mfcol=c(4,1),mar=rep(2,4),oma=rep(2,4))
    matplot(x, t(post0),type='l',pch=1,col=rgb(0,0,0,.1),main='Cubic Spline fit to data')
    lines(mat[,1:2],lwd=3,col=1)
    points(dat)

    matplot(x, t(post1),type='l',pch=1,col=rgb(0,0,0,.1),main='First derivative')
    lines(x,mat$diff, lwd=3,col=2)
    points(knots[,c(1,3)],pch=16,cex=2)

    matplot(x, t(post2),type='l',pch=1,col=rgb(0,0,0,.1),main='Second derivative')
    lines(x,mat$diff2,lwd=3,col=3)

    matplot(x, t(post3),type='l',pch=1,col=rgb(0,0,0,.1),main='Third derivative')
    lines(x,mat$diff3,lwd=3,col=4)
  }

  if(dopdf) dev.off()
}
