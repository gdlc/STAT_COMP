## This folder contains un-edited scripts developed in class

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

**Two solutions to In-class assigment 1**
```r
 P=rbind(c(0.1,0.1),c(0.2,0.6))
 rownames(P)=paste0('X=',0:1)
 colnames(P)=paste0('Y=',0:1)
 
 pX=sum(P[2,]) # marginal success probability of X
 pYgX=c(P[1,2]/sum(P[1,]),P[2,2]/sum(P[2,])) # (conditional) success probabilyt of Y|X

 # Solution using a loop
 N=100000
 X=rep(NA,N)
 Y=rep(NA,N)
 for(i in 1:N){
   X[i]=rbinom(n=1,size=1,p=pX)
   Y[i]=rbinom(n=1,size=1,p=pYgX[X[i]+1])
 }
 table(X,Y)/N
 
 # Solution using ielse
 X=rbinom(n=N,size=1,p=pX)
 Y=rbinom(n=N,size=1,p=pYgX[X+1])
 table(X,Y)/N
```
