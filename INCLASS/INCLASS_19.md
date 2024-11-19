
### IN-CLASS 19: Evaluating prediction accuracy of OLS, Forward, and LASSO

We will use the [prostate data](https://github.com/gdlc/STAT_COMP/blob/master/DATA/prostate.csv) for this assignment. Download the data and read it using the following syntax into your code. 

```r
DATA=read.csv('prostate.csv',header=TRUE)
```

Partition the data into training and testing sets using the following syntax.

```r
train=DATA[,'train']
DATA=DATA[,-ncol(DATA)]

DATA.TRN=DATA[train,]
DATA.TST=DATA[!train,]
dim(DATA.TRN)
```
##### Task

Compute the correlation between `lpsa` (log-psa) and predicted `lpsa` for each the regression methods below.

#### OLS Regressiom

1) Fit the OlS model for `lpsa` (log-psa) using all other variables in the training data (DATA.TRN), use that model to predict log-psa for the testing data (DATA.TST).

#### Forward Regression

2) Fit the best forward regression model (smallest AIC) using `lm(lpsa ~ 1)` applied to DATA.TRN, then use the fitted model to predict log-psa for the testing data (DATA.TST).

#### Lasso Regression

3) For each value of lambda of the lasso regression, predict log-psa for the testing data (DATA.TST) and compute the correlation between lpsa and predicted lpsa.

