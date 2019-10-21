## This folder contains un-edited scripts used in class

**Oct. 21st (Simulation of RVs)**

```r

## sampling Bernoulli from uniform  (in R can use rbinom(size=1,prob=p,n=...)
 p=.2
 N=1e6
 U=runif(N)
 X=ifelse(U<p,1,0)
 mean(X)

## sampling Binomial from IID uniforms
 q=5 # number of bernulli trials
 X=matrix(ncol=q,data=ifelse(runif(N)<p,1,0))
 
 # using rowsums
 Y1=rowSums(X)
 
 # using apply
  Y2=apply(FUN=sum,X=X,MARGIN=1)
  cbind(dbinom(p=theta,x=0:5,size=q),table(Y1)/length(Y))
  

# Inverse probability method
 U=runif(N)
 Z=qnorm(U)
 hist(Z,50)


```
