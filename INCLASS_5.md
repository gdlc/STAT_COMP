

## Estimating FDR using simulations

**Goal**: use Monte Carlo methods to estimate false-discovery rate (FDR).

We will consider reject if fdr-adjusted p-value<0.1

Where pv-alues will be obtained by regressing the simulated phenotype on each predictor, one predictor at a time (`y~X[,i]`).

*Data**:

```r

getData=function(n,p,R2=.5,nHA=10){ 
  HA=rep(FALSE,p)
  HA[sample(1:p,size=nHA)]=TRUE
  
  effects=rnorm(.3,sd=.2,n=nHA)
  X=matrix(nrow=n,ncol=p,rnorm(n*p))
  
  signal=X[,HA]%*%effects
  
  error=rnorm(sd=sqrt(var(signal)*(1-R2)/R2),n=n)
  y=signal+error
  DATA=list(y=y,signal=signal,error=error,X=X,HA=HA)
  return(DATA)
}

DATA=getData(n=300,p=500,R2=.4,nHA=15)

var(DATA$signal)/var(DATA$y)
table(DATA$HA)
  
```
**Outline of the algorithm**:
   - Develop code that:
          - Will simulate a data set using the function provided above (use n=300,p=500,R2=.5)
          - For that data set, produce p-values for each predictor in `X` by regressing `y~X[,i]`, for each *i*.
          - Create a vector of fdr-adjusted p-values
          - Using the fdr-adjusted p-values, determine rejections (fdr-adjusted p-vale<0.05)
          - Count how many of those discoveries are false (hint: use DATAS$HA)
          - Compute the false-discovery proporition: number of false discoveries/total discoveries.
   
 
 The above-outline produces results for 1 Monte Carlo replicate. Once you succeed running 1 MC replicate, embeed the code in a loop to produce 100 MC replicates, each time generate a new data set.
 
 Report the average FDP for each rule.
