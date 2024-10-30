

### The Multivariate Normal (MVN) Distribution

For a discussion about this distribution please see the following [handout](https://github.com/gdlc/STAT_COMP/blob/master/SimulatingRandomVariables.pdf).

Here we illustrate how draw samples using the `mvrnorm()` function of the MASS R-package.

We also compare `mvrnorm()` with a code that uses the Cholesky factorization of the (co)variance matrix to generate MVN random draws from IID standard normal draws.


**1)** Defining a MVN distribution**

The distribution has two parmeters, the mean vector (mu below) and the covariance matrix (S) below.

```r
 mu=c(2,10,3) # mean vector
 S=diag(c(1,2,1.2))  # variances
 S[1,2]=S[2,1]=.5    # covariance 1,2
 S[1,3]=S[3,1]=.2    # covariance 1,3
 S[3,2]=S[2,3]=.4    # covariance 2,3  
 
```

**2)** Generating samples from a MVN distribution using `mvrnorm()`

```r
 library(MASS)
 # 10 samples, each row contains an (IID) draw from MVN(mu,S)
 mvrnorm(Sigma=S,mu=mu,n=10)
 
 # Lets compare the sample mean with mu and the sample (co)variance matrix with S
 
 X=mvrnorm(Sigma=S,mu=mu,n=100000)
 
 cbind(mu,colMeans(X))
 
 round(cov(X),4)
 
 S
 
```
