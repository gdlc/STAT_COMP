
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

# OLS Regressiom

1) Fit the OlS model for ```r lpsa ~.``` in the training data (DATA.TRN), use that model to predict log-psa for the testing data (DATA.TST) and compute the correlation between lpsa and predicted lpsa.

# Forward Regression

2) Fit the best forward regression (smallest AIC) using lm() applied to DATA.TRN, then use the fitted OLS model to predict log-psa for the testing data (DATA.TST) and compute the correlation between lpsa and predicted lpsa.

# Lasso Regression

C) For each value of lambda of the lasso regression, predict log-psa for the testing data (DATA.TST) and compute the correlation between lpsa and predicted lpsa.

