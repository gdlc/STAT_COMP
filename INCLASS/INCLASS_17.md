### Model Comparison using AIC/BIC/Adjusted R-2 and out-of-sample prediction proportion of variance explaineds.



Recall the wages data set

```r
 DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/wages.txt',header=TRUE)
 
```

Consider these two competing hypotheses:   

  - H1: `Wage~Sex+Education+Experience`, 
  - H2: `Wage~.`

We want to compare these models using:

  1. F-test `anova(fm1,fm2)`
  2. Within-sample R-squared `summary(fm)$r.squared`
  3. Adjusted R-sq ` summary(fm)$adj.r.squared`
  4. AIC 
  5. BIC 
  6. Out-of-sample proportion of variance explained (PVE) estimated using 100 training testing partitions, each time use a randomly selected testing set with 100 observations.

  - Fit the two models to the full data set, evaluate the first four model comparison criteria
  - Conduct 100 training-testing evaluations (nTesting=100) to estimate PVE for H1 and H2 (6).
  - Report a table with AIC,BIC,Training R-sq., Training adj-Rsq. and PVE for each of the models.
  - Which model do you choose? Why?

