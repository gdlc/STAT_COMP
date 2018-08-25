# Survival models

```r
library(survival)
rm(list=ls())
library(survival)
data(ovarian)

y=ovarian$futime
d=ovarian$fustat

# wrong model ignoring censoring
 fm0=lm(futime~1,data=ovarian)

# Parametric regression using survreg
 # survival object
 Y=Surv(time=y,event=d)

 fm=survreg(Y~1,dist='gaussian')
 summary(fm)

# Now with optim
 negLogLikCenNormal=function(y,d,theta){
     SD=sqrt(exp(theta[1]))
     mu=theta[2]
     logLikObs =sum(dnorm(x=y[d==1], mean=mu,sd=SD, log=TRUE))
     logLikRCen=sum(pnorm(q=y[d==0], mean=mu,sd=SD, log.p=TRUE,lower.tail=F))
     logLik=(logLikObs+logLikRCen)
     return(-logLik)
 }

 fm2=optim(fn=negLogLikCenNormal,y=y,d=d,par=c(mean(y),log(var(y))))

 fm2


```







[Back](https://github.com/gdlc/STAT_COMP/)
