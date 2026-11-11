## INCLASS 19: Permutation p-values

This code simulates a data set with 50 observations and 3 variables, y, X1, and X2.

Data is simulated under a linear model $y=X_1b_1+e$ that has an R-sq of 10%.

X1 and X2 are highly correlated.


```r
set.seed(12343)
COV=diag(2)
COV[2,1]=0.9
COV[1,2]=COV[2,1]
n=50
X=matrix(nrow=n,ncol=2,rnorm(2*n))%*%(chol(COV))
b=c(0,1)

signal=X%*%b
vM=var(signal)
R2=0.1
error=(as.vector(scale(exp(rnorm(n)),scale=TRUE,center=TRUE)))
error=error*sqrt(vM*(1-R2)/R2)[1,1]

y=signal+error

X1=X[,1]
X2=X[,2]

set.seed(10000) # change this seed to any integer value
```

**Task**: Develop a script that will estimate permutation p-values for X2 under three plans:

 - permuting Y
 - permuting X2
 - permuting residuals from the linear regression `y~X1`.

Your code should generate these variables

 - pValLM The p-value for X2 on the un-permuted model.
 - pValPY The permutation p-value for X2 when you permuted Y
 - pValPX2 The permutation p-value for X2 when you permuted X2
 - pValPRes The permutation p-value for X2 when you permuted residuals from the null model `y~X1`.

