

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

**3) Let's create our own function to generate draws from MVN**.

Recall that if **Z** is a MVN random vecto, **X**=**a**+**BZ** follows a MVN distribution with mean E[**X**]=**a**+**B**E[**Z**], 
and (co)variance matrix Cov[**X**]=**B**Cov[**Z**]**B**'. Thus, if **Z** is a vector of IID standard normal, i.e., N(0,1), then E[**Z**]=**0** is a vector of zeroes, and Cov(**Z**)=**I** (where **I** is a pxp identity matrix, 1's in the diagonals, representing the variances, and 0's in the off-diagonals, representing (co)variances); Thus, E[**X**]=**a** and Cov[**X**]=**BB**'. Thus, if we take **B=chol(S)**, then the covariance matrix of **X**=**a**+**BZ**=**BB**'=**S**.

