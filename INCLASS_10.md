

We will consider fitting a model to Gaussian right-censored data. 

The marginal distribution of the data is N(mu,V).

Simulating Gaussian right censored data

```r

### Simulation
set.seed(195021)
  n=10000
  mu=2
  v=1
  y=rnorm(n,mean=mu,sd=sqrt(v))
  
  isCensored=runif(n)<.5
  
  yCen=y
  D=runif(max=2,min=0.5,n=sum(isCensored))  
  yCen[isCensored]=yCen[isCensored]-D     # a little displacement to the left
  head(data.frame(isCensored,y,yCen),20)
 ###
```
Ignoring censoring leads biased estimates. Checking this in just a single sample...


```r
  plot(yCen~y);abline(a=0,b=1,col=2,lwd=2)
  abline(v=mean(y),col=4,lwd=2)
  abline(h=mean(yCen),col=4,lwd=2)
  
  mean(yCen)
  var(yCen)
 
```

**Outline of the algorithm**

  - Initialize vectors to store the values of the mean and variance paramters (e.g., `M=rep(NA,1000)` and `V=rep(NA,1000)`)
  - Create a vector where you will hold the complete data (e.g., `yComplete=yCen`)
  - Initialize the mean and variance ignoring censoring (i.e., `M[1]=mean(yCen)` ; `V[1]=var(yCen)`).
  - Iterate (e.g., from 1:1000)
      - **M-step**: set `M[i]` and `V[i]` equal to the the maximum likelihood estimates of the mean and variance using the complete data (hint: in this case the MLE are also the method of moment estimates).
      - **E-step**: impute the entries of `yComplete` corresponding to the censored points using `E[yi|yi>ci]`, where ci is the censored time point (i.e., `ci=yCen[i]`).
        
 **Note**: The conditional distribution `p[yi|yi>ci]` is a [truncated normal distribution](https://en.wikipedia.org/wiki/Truncated_normal_distribution), you can find
     the expected value following the link. In our case, since data is right-censored, the minimum value (`a`) is the censoring point (`ci`)  and the maximum value (`b`) is infinite. You can also try the [truncnorm](https://cran.r-project.org/web/packages/truncnorm/index.html) R-package. The function `etruncnorm(a=-Inf, b=Inf, mean=0, sd=1)` returns the expectd value of a truncated normal distribution.
