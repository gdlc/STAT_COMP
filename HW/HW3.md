# HW3: Power Analysis and Bootstrap  
**Due:** Fri, Nov 13, at 5:00pm  

---
## 1) Power Analysis to detect a non-zero correlation coefficient

The following function simulates data from a bi-variate distribution for pairs of RVs `[Xi, Yi]`.  
Here `Xi` is exponentially distributed, and the probability of `Yi` given `Xi = xi` is  

$$
P(Y_i | X_i = x_i) = N(\mu + x_i \rho, \sigma^2)
$$

By construction, the correlation between `Xi` and `Yi` is `ρ`.

```r
simXY = function(n, rho, mu = 10){
  x = scale(rexp(n),center=TRUE,scale=TRUE)
  y = mu + x * rho + rnorm(n, sd = sqrt(1 - rho^2))
  return(data.frame(x, y))
}
```

The function `cor.test()` can be used to get an estimate of the correlation between two variables (by default it computes Pearson's correlation coefficient), a SE, CI, and a p-value for the following

$$
H_0: \rho_{x,y} = 0 \quad \text{vs} \quad H_A: \rho_{x,y} \neq 0
$$


**Task**: Estimate the power to detect a non-zero correlation at significance level 0.05  
for ρ = {0.1, 0.2, 0.5} and n = {10, 20, 50, 100, 300,100}.

**Report**

1.1) A table with your power estimates by ρₓ,ᵧ and sample size.  
1.2) A power plot with Power in the vertical axis, sample size in the horizontal axis and one curve per value of ρ.
1.3) For each value of ρₓ,ᵧ, recommend a sample size that achieves power ≥ 0.8.

---

## 2) Type I error rate

P-values are estimates of type-I error rate. If a p-value is correct and we reject using p-value<0.05 as decision rule, then, the probability of falsely rejecting the null when the null holds should be smaller than 0.05.

The derivation of p-values often rely on assumptions. Violations of assumptions may lead to inflated type-I error (e.g., we reject at 0.05 but the actual type-I error rate is 0.08). In some cases, type-I error inflation may decline with same size. For instance, in OLS regressions, non-normal errors may lead to inflation of type-I error with small sample size but this typically vanishes as sample size increases because of the Central Limit Theorem. However, some violations of assumptions have consequences that are not fixed by a large sample size. 

The following functions simulate data with heteroskedastic error (`simData1()`) and one with non-gaussian errors (`simData1()`).

**Task** Estimate the type-I error rate using simulations for `N=c(10, 20, 50, 100,50,1000)` using `simData1()` and `simData2()` for a decision rule that rejects the null if p-value<0.05.

Use at least 20,000 Monte Carlo replicates (Hint: test your code with less replicates!)

**2.1** Report a bar plot with sample size (as a factor) in the x-axis, Rejection rate in the horizontal axis, and bars with different colors for the heteroskedastic and non-gaussian data.

**2.2** Summarize your conclusions in no more than 4 sentences.
 
```{r}
 N=c(10, 20, 50, 100,50,1000)


 simData1 <- function(n, b ,k=2) {
  X <- runif(n)
  y <- X * b + scale(rnorm(n, sd = sqrt(exp(k * X))),center=TRUE,scale=TRUE) # we have heteroskedasticity
  data.frame(x = X, y = y)
}
 
simData2 <- function(n, b ) {
  X <- rexp(n) 
  y <- X * b +scale(exp(rnorm(n)),center=TRUE,scale=FALSE)
  data.frame(x = X, y = y)
}

```
## 3) Bootstrap 95% CI for correlation coefficients.


Use the library `boot` to generate 10,000 Bootstrap samples of Pearson's correlation coefficients  for each of these data sets


```{r}
 set.seed(1930021)
 DATA_20=simXY(n=20,rho=.5)

 set.seed(1930021)
 DATA_300=simXY(n=300,rho=.5)
```

Report 

**3.1)** A histogram of the bootstrap samples for each data set (use `hist(samples,50)` to have enough bins).

**3.2)** Two tables (one per data set, both rounded to 3 decimal places) with 95% CI for the correlation coefficients using the following methods:

  - Standard percentile (i.e., quantile, applied to the bootstrap samples).
  - Mean-bias corrected, subtract the average bootstrap estimates from the sample and add to that the estimate derived from the original data. Then apply the standard percentile method to the *de-biased* bootstrap samples,
  - Median-bias corrected. Same as Mean-bias correction, subtracting in this case the median bootstrap estimate instead of the mean.
  - The `perc` and `bca` methods implemented in boot.ci.


Comment on similarities and differences in the CIs for each of the sample sizes. 



