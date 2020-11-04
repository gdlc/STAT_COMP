

 1) Read over the section of the Multivariate Normal distribution of the Handout
 2) Create a function that will generate samples from a MVN using the Cholesky decomposition (see example in the handout)
 3) Generate 10,000 samples with your function and check whether the empirical mean and empirical covariance matrix matches closely the true parameter values.


```r
 mu=c(2,10,3) # mean vector
 S=diag(c(1,2,1.2))  # variances
 S[1,2]=S[2,1]=.5    # covariance 1,2
 S[1,3]=S[3,1]=.2    # covariance 1,3
 S[3,2]=S[2,3]=.4    # covariance 2,3  

 n=1e6
 
 L=t(chol(S))        # lower-triangular Cholesky S=LL’
   
 z=rnorm(length(mu))
 x=mu+L%*%z  # note E[x]=mu+LE[z]=mu and Cov(x)=LCov(z)L'=LL'=X
   
 # Now let’s generate 5000 IID samples
  Z=matrix(nrow=5000,ncol=length(mu),rnorm(5000*length(mu)))
  X=matrix(nrow=nrow(Z),ncol=ncol(Z),NA)
  for(i in 1:nrow(X)){ 
      X[i,]=mu+ L%*%Z[i,] 
  }
  colMeans(X) # compare with mu    
  cov(X)      # compare with S

 # to avoid a loop you can also use this 
  W=Z%*%t(L)
  for(i in 1:length(mu)){ W[,i]=W[,i]+mu[i] }

  var(W) 
  colMeans(W) 


```
