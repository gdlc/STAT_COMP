
## Bootstrap

For a reference on this topic, I suggest [Efron & Gong, AmStat, 1983](https://www.jstor.org/stable/2685844?Search=yes&resultItemClick=true&searchText=A+Leisurely+Look+at+the+Bootstrap%2C+the+Jackknife%2C+and+Cross-Validation&searchUri=%2Faction%2FdoBasicSearch%3FQuery%3DA%2BLeisurely%2BLook%2Bat%2Bthe%2BBootstrap%252C%2Bthe%2BJackknife%252C%2Band%2BCross-Validation%26acc%3Don%26wc%3Don%26fc%3Doff%26group%3Dnone&ab_segments=0%2Fbasic_search_SYC-5462%2Ftest&refreqid=fastly-default%3A231cd43e9ce0dcb0a2cebd09df5ed1cd&seq=1#metadata_info_tab_contents).

#### Example 1: estimating the SE of the mean (& 95% CI) using Bootstrap

```r
n=50
nRep=5000

## Variance of the sample mean
 y=rnorm(n,mean=10)
 SD=sd(y)
 SE=sqrt(var(y)/n)
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
