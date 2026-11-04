# HW3: Power Analysis and Bootstrap  
**Due:** Fri, Nov 14, at 5:00pm  

---
## 1) Power Analysis

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
for ρ = {0.1, 0.2, 0.5} and n = {10, 20, 50, 100, 300}.

**Report**

1.1) A table with your power estimates by ρₓ,ᵧ and sample size.  
1.2) A power plot with Power in the vertical axis, sample size in the horizontal axis and one curve per value of ρ.
1.3) For each value of ρₓ,ᵧ, recommend a sample size that achieves power ≥ 0.8.

---

## 2) Bootstrap CIs (Percentile Method)

Consider:

```r
set.seed(195021)
DATA = simXY(n = 100, rho = 0.3)
COR = cor(DATA$x, DATA$y)
```

Approximate SE for correlation:

```r
n = nrow(DATA)
SE = sqrt((1 - COR^2) / (n - 2))
SE
```

```
## [1] 0.09883397
```

95% CI assuming normality:

```r
CI = COR + c(-1.96, 1.96) * SE
CI
```

```
## [1] 0.01297567 0.40040484
```

Alternatively, Fisher’s z-transform:

```r
cor.test(DATA$x, DATA$y)$conf.int
```

```
## [1] 0.01070681 0.38738157
```

---

### Task

Use **5000 Bootstrap samples** to estimate an approximate 95% CI  
for each of the datasets below:

```r
set.seed(195021)
DATA_30  = simXY(n = 30, rho = 0.5)

set.seed(195021)
DATA_300 = simXY(n = 300, rho = 0.5)
```

#### Report

- Bootstrap 95% CI for each sample size  
- Effect of sample size on CIs  
- Does bootstrap CI align more with:
  - `cor.test()` Fisher transform CI, or  
  - normality-based CI?  
- Do the differences among the three methods diminish with sample size?

