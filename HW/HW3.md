# HW3: Power Analysis and Bootstrap  
**Due:** Fri, Nov 14, at 5:00pm  

---

## Preliminaries

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

---

### A simple test

```r
DATA = simXY(10000, -0.5)
head(DATA)
```

```
## x          y
## 1 -0.3589  8.8674
## 2 -0.3194 11.2340
## 3 -0.4475  9.4431
## 4 -0.9402  9.9133
## 5 -0.8773 10.8570
## 6 -0.0693 10.0783
```

```r
dim(DATA)
```

```
## [1] 10000 2
```

```r
cor(DATA)
```

```
## x y
## x  1.0000000 -0.4983969
## y -0.4983969  1.0000000
```

---

## 1) Power Analysis

We now use the `simXY()` function to simulate 30 IID pairs setting `rho = 0.1`.

```r
set.seed(120549)
DATA_1 = simXY(n = 30, rho = 0.1)
head(DATA_1)
```

```
## x           y
## 1 -0.3738 12.4124
## 2 -0.7558  8.6537
## 3 -0.7723 11.5981
## 4  1.7386 10.6279
## 5 -0.1816  9.2842
## 6 -0.0399  9.8541
```

The sample correlation estimate is:

```r
cor(DATA_1$x, DATA_1$y)
```

```
## [1] -0.2520449
```

If we generate another sample, we will obtain a different point estimate.

```r
set.seed(195021)
DATA_2 = simXY(n = 30, rho = 0.1)
cor(DATA_2$x, DATA_2$y)
```

```
## [1] 0.1147978
```

This illustrates how estimates vary over repeated sampling.  
To make inferences about population parameters, we need to attach measures of uncertainty (e.g., SEs) and perform formal hypothesis testing.

The function `cor.test()` can be used for inferences about correlations. It can obtain CIs and test hypotheses such as:

$$
H_0: \rho_{x,y} = 0 \quad \text{vs} \quad H_A: \rho_{x,y} \neq 0
$$

The function uses Fisher’s *z*-transform.

```r
test = cor.test(DATA_2$x, DATA_2$y)
print(test)
```

```
## Pearson's product-moment correlation
##
## data: DATA_2$x and DATA_2$y
## t = 0.6115, df = 28, p-value = 0.5458
## alternative hypothesis: true correlation is not equal to 0
## 95 percent confidence interval:
## -0.2560616 0.4561995
## sample estimates:
## cor
## 0.1147978
```

You can get CI and p-values using:

```r
test$conf.int
test$p.value
```

```
## [1] -0.2560616 0.4561995
## [1] 0.5458048
```

With a p-value ≈ 0.5458, we do **not** reject H₀ — though the true ρ = 0.1.  
With this sample size and ρ value, what power do we have to reject the null?

---

### Using Monte Carlo (MC) simulations to estimate power

Estimate the power to detect a non-zero correlation at significance level 0.05  
for ρ = {0.1, 0.2, 0.5} and n = {10, 20, 50, 100, 300}.

#### Suggestions

- Simulate data using the provided `simXY()` function.  
- Instead of two loops, consider using `expand.grid()`.

```r
RES = expand.grid(
  rho = c(0.1, 0.2, 0.5),
  sample_size = c(10, 20, 50, 100, 300),
  replicate = 1:1000,
  pValue = NA
)
```

Then store the p-values for each Monte Carlo replicate:

```r
for(i in 1:nrow(RES)){
  # simulate data using n = RES$sample_size[i], rho = RES$rho[i]
  # test correlation using cor.test()
  # store p-value in RES$pValue[i]
}
```

Decision rule:

```r
RES$reject = RES$pValue < 0.05
```

Estimate power by the proportion of times you rejected H₀.

```r
library(doBy)
summaryBy(reject ~ rho + sample_size, data = RES)
```

```
## rho sample_size reject.mean
## 1 0.1 10 NA
## 2 0.1 20 NA
## 3 0.1 50 NA
## 4 0.1 100 NA
## 5 0.1 300 NA
## 6 0.2 10 NA
## 7 0.2 20 NA
## 8 0.2 50 NA
## 9 0.2 100 NA
## 10 0.2 300 NA
## 11 0.5 10 NA
## 12 0.5 20 NA
## 13 0.5 50 NA
## 14 0.5 100 NA
## 15 0.5 300 NA
```

---

### Report

1.1) Report a table with your power estimates by ρₓ,ᵧ and sample size.  
1.2) For each value of ρₓ,ᵧ, recommend a sample size that achieves power ≥ 0.8.

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

