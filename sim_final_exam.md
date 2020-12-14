 ```R
 
 set.seed(12345)
 p=2^5
 n=150
 
 X=matrix(nrow=n,ncol=p)
 tmp=0.8
 X[,1]=rnorm(n)
 for(i in 2:p){ X[,i]=X[,i-1]*tmp+rnorm(n,sd=sqrt(1-tmp^2)) }
 
 # True effects
  beta=rep(0,p)
  beta[c(5,15,14,25)]=1
 
  signal=X%*%beta
 
  vE=var(signal)/2
  error= rnorm(n=n,sd=sqrt(vE)) 
  y=123+error+signal
 
  mean(y)
  
  ```
