

We will consider fitting a model to Gausian right-censored data. 

The marginal distribution of the data is N(mu,V).

Simulating Gaussian right censored data

```r
 set.seed(195021)
  n=100
  mu=4
  v=2
  y=rnorm(n,mean=mu,sd=sqrt(v))
  
  isCensored=runif(n)<.2
  
  yCen=y
  yCen[isCensored]=y[isCensored]+runif(min=-1,max=-.02,n=sum(isCensored)) 
  head(cbind(isCensored,y,yCen),20)
 
```

**Outline of the algorithm**
    - Initialize vectors to store the values of the mean and variance paramters (e.g., `M=rep(NA,1000)` and `V=rep(NA,1000)`)
    - Create a vector where you will hold the complete data (e.g., `yComplete=yCen`)
    - Initialize the mean and variance ignoring censoring (i.e., `M[1]=mean(yCen)` ; `V[1]=var(yCen)`).
    - Iterate (from 1:1000)
        - M-step: set `M[i]` and `V[i]` equalt the the maximum likelihood estimates of the mean and variance using the complete data.
        - E-step: impute the entries of `yComplete` corresponding to the censored points using E[yi|yi>ci], where ci is the censored time point.
        
 **Note**: The conditional distribution `p[yi|yi>ci]` is a [truncated normal distribution](https://en.wikipedia.org/wiki/Truncated_normal_distribution), you can find
     the expected value following the link.
        
