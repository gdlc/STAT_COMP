

## Estimating FDR using simulations

**Goal**: use Monte Carlo methods to estimate false-discovery rate (FDR).

We will consider two decision rules

  - Reject if p-value<0.05
  - Reject if fdr-adjusted p-value<0.1

Where pv-alues will be obtained by regressing the simulated phenotype on each predictor, one predictor at a time (`y~X[,i]`).

*Data**:

```r

  n=100
  p=100
  withEffects=c(10,50,70,80,100)
  effects=.2+rnorm(length(withEffect),sd=.5)
  
  X=matrix(nrow=n,ncol=p,rnorm(n*p))
  signal=X[,withEffects]%*%effects
  error=rnorm(sd=sqrt(var(signal)*9),n=n)
  y=signal+error
  
```
**Outline of the algorithm**:
   - Develop code to get p-values (and fdr-adjusted p-values) for each predictor in `X` by regressing `y~X[,i]`, for each *i*.
   - Store the p-values in a vector
   - Create a vector of fdr-adjusted p-values
   - Using the two vectors of p-values, the decision rules presented above, and your knowledge o which hypothesis were true, compute the number of discoveries and the number of false discoveries.
   - Compute the false-discovery proporition for each of the rules. 
   
 
 The above-outline produces results for 1 Monte Carlo replicate. Once you succeed running 1 MC replicate, embeed the code in a loop
 to produce 100 MC replicates, each time generate a new data set.
 
 Report the average FDP for each rule.
