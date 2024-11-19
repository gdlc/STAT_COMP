
### IN-CLASS 19: Evaluating prediction accuracy of OLS, Forward, and LASSO

We will use the [prostate data](https://github.com/gdlc/STAT_COMP/blob/master/DATA/prostate.csv) for this assignment. Download the data and read it using the following syntax into your code. 

```r
DATA = read.csv('prostate.csv',header=TRUE)
DATA = DATA[,-1]
```

Partition the data into training and testing sets using the following syntax.

```r
train=DATA[,'train']
DATA=DATA[,-ncol(DATA)]

DATA.TRN=DATA[train,]
DATA.TST=DATA[!train,]
dim(DATA.TRN)
```
### (I) Task

Compute the correlation between `lpsa` (log-psa) and predicted `lpsa` for each the regression methods below.

#### OLS Regressiom

1) Fit the OlS model for `lpsa` (log-psa) using all other variables in the training data (DATA.TRN), use that model to predict log-psa for the testing data (DATA.TST). Store the computed correlation in `COR.OLS_FULL`.

#### Forward Regression

2) Fit the best forward regression model (smallest AIC) using `lm(lpsa ~ 1)` applied to DATA.TRN, then use the fitted model to predict log-psa for the testing data (DATA.TST). Store the result computed using forward regression in `COR.FWD`.

#### Lasso Regression

3) Calculate the Incidence matrix with predictor variables and then fit the model using `glmnet` package. For each value of lambda in the lasso regression, predict log-psa for the testing data (DATA.TST) and then compute the correlation between `lpsa` and predicted lpsa for the testing data. Store the results in the vector `COR.LASSO`, where it can be initialized as;

```r
COR.LASSO=rep(NA,length(fmLASSO$lambda))
```

Observe the results using the following plot.

```r
plot(COR.LASSO,type='o',ylim=range(c(COR.LASSO,COR.OLS_FULL,COR.FWD),na.rm=TRUE)*c(.98,1.02))
abline(h=COR.OLS_FULL,col='blue',lty=2,lwd=1.5);text(label='OLS-FULL',col='blue',x=20,y=COR.OLS_FULL+.01)
abline(h=COR.FWD,col='red',lty=2,lwd=1.5);text(label='Forward',col='red',x=60,y=COR.FWD+.01)
abline(v=which(diff(fmLASSO$df)>0),col='grey',lty=2)
```

## Submission to Gradescope

For your submission to grade scope, provide an R-script named `assignment.R` (match case) answering the above questions. You may submit your answer to Gradescope as many times as needed before the due date.

Your script should include the variables `COR.OLS_FULL`, `COR.FWD` and the vector `COR.LASSO`, which corresponds to the correlations computed for the log-psa and predicted log-psa using OLS, Forward and Lasso regression methods respectively.
