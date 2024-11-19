
### IN-CLASS 19: Evaluating prediction accuracy of OLS, Forward, and LASSO

We will use the [prostate data](https://github.com/gdlc/STAT_COMP/blob/master/DATA/prostate.csv) for this assignment. Read the data using the following syntax into your code. 

```r
DATA=read.table('https://hastie.su.domains/ElemStatLearn/datasets/prostate.data',header=TRUE)
```

Partition the data into training and testing sets using the following syntax.

```r
train=DATA[,'train']
DATA=DATA[,-ncol(DATA)]

DATA.TRN=DATA[train,]
DATA.TST=DATA[!train,]
dim(DATA.TRN)
```
### Task

Compute the correlation between `lpsa` (log-psa) and predicted `lpsa` for each the regression methods below.

#### OLS Regressiom

1) Fit the OlS model for `lpsa` (log-psa) using all other variables in the training data (DATA.TRN), use that model to predict log-psa for the testing data (DATA.TST). Store the correlation computed in `COR.OLS_FULL`.

#### Forward Regression

2) Fit the best forward regression model (smallest AIC) using `lm(lpsa ~ 1)` applied to DATA.TRN, then use the fitted model to predict log-psa for the testing data (DATA.TST). Store the correlation computed using forward regression in `COR.FWD`.

#### Lasso Regression

3) Calculate the Incidence matrix with predictor variables and then fit the model using `glmnet` package. For each value of lambda in the lasso regression, predict log-psa for the testing data (DATA.TST) and then compute the correlation between `lpsa` and predicted lpsa. Store the result in the vector `COR.LASSO`.

```r
COR.LASSO=rep(NA,length(fmL$lambda))
```

Observe the results using the following syntax

```r
plot(COR.LASSO,type='o',ylim=range(c(COR.LASSO,COR.OLS_FULL,COR.FWD),na.rm=TRUE)*c(.98,1.02))
abline(h=COR.OLS_FULL,col='blue',lty=2,lwd=1.5);text(label='OLS-FULL',col='blue',x=20,y=COR.OLS_FULL+.002)
abline(h=COR.FWD,col='red',lty=2,lwd=1.5);text(label='Forward',col='red',x=60,y=COR.FWD+.002)
abline(v=which(diff(fmL$df)>0),col='grey',lty=2)
```

