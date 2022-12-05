### Assigment 22

Using the following training-testing partition

```r
 library(BGLR)
  data(wheat)
  head(wheat.Y)
  dim(wheat.X)
  
  X=scale(wheat.X,center=TRUE,scale=TRUE)
  y=wheat.Y[,2] # picks one phenotype
  
  N<-nrow(X) ; p<-ncol(X)
  
  set.seed(12345)
 tst<-sample(1:N,size=150,replace=FALSE)
 XTRN<-X[-tst,]
 yTRN<-y[-tst]
 XTST<-X[tst,]
 yTST<-y[tst]

```

Fit Ridge Regression using the default approach implemented in glmnet.

```r
  library(glmnet)
  fm=glmnet(y=yTRN,x=XTRN,alpha=0) # alpha=0 for Ridge Regression
  B=as.matrix(fm$beta)
```

The object `B` contains the solutions for each of the values of lambda (see fm$lambda) in columns.

To obtain predicitons for a paritcular value of lambda (say the 3rd one) you can use:

```r
  yHatTST=XTST%*%B[,3]
  cor(yTST,yHatTST)
  
```

Task:
  - Compute predictions for every solution (by default 100 values of lambda)
  - Produce a plot of prediction accuracy (correlation in testing in the y-axis) versus the logarithm of the value of lambda (x-axis).




