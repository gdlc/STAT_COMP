
### IN-CLASS 19: Evaluating prediction accuracy of OLS, Forward, and LASSO

We will use the [Prostate data](https://github.com/gdlc/STAT_COMP/blob/master/DATA/prostate.csv) for this assignment. Download the data and read it using the following syntax into your code. 

```
DATA=read.csv('prostate.csv',header=TRUE)
```

Partition the data into training and testing sets using the following syntax.

```
train=DATA[,'train']
DATA=DATA[,-ncol(DATA)]

DATA.TRN=DATA[train,]
DATA.TST=DATA[!train,]
dim(DATA.TRN)
```

A) Use the fitted OLS model to predict log-psa for the testing data (DATA.TST) and compute the correlation between lpsa and predicted lpsa.

B) Fit the best forward regression (smallest AIC) using lm() applied to DATA.TRN, then use the fitted OLS model to predict log-psa for the testing data (DATA.TST) and compute the correlation between lpsa and predicted lpsa.

C) For each value of lambda of the lasso regression, predict log-psa for the testing data (DATA.TST) and compute the correlation between lpsa and predicted lpsa.

