
Family wise error rate with correlated tests:

Modify the three-predictor[example discussed in class today](https://github.com/gdlc/STAT_COMP/edit/master/LARGE_SCALE_TESTING.md) by making the three predictors correlated accoridng to 
the following correlation matrix (do not use `mvrnorm()`):

|----|----|----|
|1|0.5|0.5|
|0.5|1|0.5|
|0.5|0.5|1|


Hint: see our discussion about sampling from multivariate normal distributions.

Estimate and report the type-I error rate when you reject using `alpha=0.05`, `alpha=0.05/3`.
