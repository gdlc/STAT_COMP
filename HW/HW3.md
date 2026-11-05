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

P-values are estimates of type-I error rate. Thus, if p-values are correct and we reject at p-value<0.05 the probability of falsely rejecting the null when the null holds is <0.05.

The derivation of p-values often rely on assumptions. Violations of such assumptions may lead to inflated type-I error. In some cases, type-I error inflation may decline with same size. For instance, in OLS regression, non-normal errors may lead to inflation of type-I error with small sample size but this may diminish as sample size increases, an instance of the Central Limit Theorem. 

The following functions simulate data with heteroskedastic error (simData1

```{r}
 N=c(10, 20, 50, 100,50,1000)

 nRep=20000
 
simData1 <- function(n, b = 0, k = 2) {
  X <- runif(n)
  y <- X * b + scale(rnorm(n, sd = sqrt(exp(k * X))),center=TRUE,scale=TRUE) # we have heteroskedasticity
  data.frame(x = X, y = y)
}
 
simData2 <- function(n, b = 0, shape = 0.5) {
  X <- rexp(n) 
  y <- X * b +scale(exp(rnorm(n)),center=TRUE,scale=FALSE)
  data.frame(x = X, y = y)
}

```

1.2) Present a barplot with Type-I error rate by sample size and a horizontal 
