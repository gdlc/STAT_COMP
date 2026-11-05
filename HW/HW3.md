# HW3: Power Analysis and Bootstrap  
**Due:** Fri, Nov 13, at 5:00pm  

---
## 1) Power Analysis 1: Correlation Coefficient

The following function simulates data from a bi-variate distribution for pairs of RVs `[Xi, Yi]`.  
Here `Xi` is exponentially distributed, and the probability of `Yi` given `Xi = xi` is  

$$
P(Y_i | X_i = x_i) = N(\mu + x_i \rho, \sigma^2)
$$

By construction, the correlation between `Xi` and `Yi` is `ρ`.

```r
simXY = function(n, rho, mu = 10){
  x = scale(rexp(n))
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

Modify the code from problem 1 to estimate type-I error rate for n = {10, 20, 50, 100, 300},



More to come soon....
