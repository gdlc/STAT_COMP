
Family wise error rate with correlated tests:

Modify the three-predictor example discussed in class by making the three predictors correlated accoridng to 
the following correlation matrix (do not use `mvrnorm()`):


```
rho=.5
COR=matrix(nrow=3,ncol=3,rho)
diag(COR)=1
COR

```

Hint: see our discussion about sampling from multivariate normal distributions.

Estimate and report the type-I error rate when you reject using `alpha=0.05`, `alpha=0.05/3`.
