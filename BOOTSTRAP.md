
## Bootstrap

For a reference on the topic I suggest [Efron & Gong, AmStat, 1983](http://www.tandfonline.com/doi/pdf/10.1080/00031305.1983.10483087?needAccess=true).

#### Example 1: estimating the SE of the mean (& 95% CI) using Bootstrap

```r
n=50
nRep=5000

## Variance of the sample mean
 y=rnorm(n,mean=10)
 SD=sd(y)
 SE=var(y)/n
 means=rep(NA,nRep)
 for(i in 1:nRep){ means[i]=mean(sample(y,size=n,replace=T) )}
 var(means)
 
 quantile(means,p=c(.025,.975))
 
 mean(y)+c(-1,1)*1.96*SE
 
```



#### Example 2: estimting the variance-covariance matrix of OLS estimats


```r

## V-COV matrices of estimated effects
  n=500
  nRep=50000
  
  X=matrix(nrow=n,ncol=3)
  X[,1]=1
  X[,2]=rexp(n)
  X[,3]=rbinom(n=n,size=1,p=0.3)
  b=c(100,2,3)
  
  signal=X%*%b
  vE=var(signal)*2
  error=rnorm(n=n,sd=sqrt(vE))
  y=signal+error
  
  fm0=lm(y~X-1) # '-1' means do not include intercept, we do this because it is already included in X
  
  # Linear models theory
  COV1=vcov(fm0)
  COV2=solve(crossprod(X))*sum(residuals(fm0)^2)/(nrow(X)-ncol(X))
  max(abs(COV1-COV2))
  
  # bootstrap
  B=matrix(nrow=nRep,ncol=ncol(X))
  
  for(i in 1:nRep){
  	# creating a bootstrap sample
  	# (note: the match between y and X is preserved)
  	tmp=sample(1:n,size=n,replace=T)
  	tmpY=y[tmp] 
  	tmpX=X[tmp,]
  	fm=lm(tmpY~tmpX-1) 
  	B[i,]=coef(fm)
  }
  
  COV3=cov(B)
  plot(as.vector(COV3)~as.vector(COV1),xlab='LM-Theory',ylab='Bootstrap');abline(a=0,b=1)
```
