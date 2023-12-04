The following code simulates data for 3,000 observations and 1,000 predictors.
10 of the 1,000 predictors have non-zero effects. These 10 predictors explain 25% of the variance of the response (y).

```r
# Parameters
 n=3000
 p=1000
 RSq=.25
 q=10 # &nbsp;number of predictors with non-zero effects

# One Monte Carlo replicate
 X=matrix(nrow=n,ncol=p,rnorm(n*p))
 X=scale(X,center=TRUE,scale=FALSE)
 causal=sample(1:p,size=q,replace=FALSE)

 signal=X[,causal]%*%rexp(q)
 noise=rnorm(n,sd=sqrt(var(signal)*(1-RSq)/RSq))
 y=signal+noise
# end of Monte Carlo replicate
```

And the following code fits LASSO over a pre-determined grid of values of the regularization parameter (lambda).

```r
 fm=glmnet(y=y,x=X,lambda=lambda)
```

The estimated effects are returned in `fm$beta` (I recommend you conver it to matrix `B=as.matrix(fm$beta)`. Each column of the matrix gives the estimated effects of each predictor for a value of lambda. For any value of lambda, the discovery set (i.e., the set of active predictors) can be found using `which(B[,j]!=0)`. Of these discoveries some are true (i.e., are predictors that have non-zero effect in the simulation) and others are false.

For one Monte Carlo simulation you can caluclate the proportion of false discoveries over the grid of values of lambda, as well as the proportion of effects with non-zero effect that are part of the discovery set. Averagin these results over several Monte Carlo replicates produces estimates of the power and FDR for each value of lambda.&nbsp;


**Ojbective**: To create power-fdr curves over the regularization path (values of lambda) of the LASSO regression. To create these curves use at least 50 Monte Carlo Simulations.&nbsp;

Hint: you can create a matrix `FDP=matrix(nrow=length(lambda),ncol=nRep,NA)` and a similar matrix for power, and, store in columns the results of each Monte Carlo Simulation. To get your estimates of FDR by value of lambda you can use `fdr=rowMeans(FDP,na.rm=TRUE)` and you can use a similar strategy to get estimates of power. &nbsp;Then, you can use `plot(power~fdr,type='o')` to display your results.

**Question 1**: Provide plots showing power-fdr curves for the following scenarios

 - RSq=0.25,n=3000
 - RSq=0.4, n=3000
 - RSq=0.25, n=5000
 - RSq=0.4, n=5000

The following code shows how to fit LASSO for one Monte Carlo Replicate


**Question 2:** For each scenario report the FDR you need to tolerate to achieva a power of at least 0.5. For each scenario, report the power for an FDR smaller or equal than 0.1.