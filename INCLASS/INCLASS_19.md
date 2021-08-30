### Assigment 19 (for you to practice, no need to turn it in)

The function `cv.glmnet()` performs k-fold cross-validation for the models implemented in `glmnet()`. Use the Training data set generated below and the 
function `cv.glmnet()` to choose an optimal value of the regularization parameter (lambda) for `Lasso`, `Rdige Regression`, and `Elastic Net`.

Note, after you call `cv.glmnet()` if you `plot()` the resulting object it will display the prediction mean-squared error in CV (and confidence bands) by value of
lambda. 

1) What value of `lambda` do you recommend for each model?
2) Evaluate prediction mean-squared error `mean((yTST-yHatTST)^2)` in the left-out testing set for each of the values of lambda. In this single testing set, do you get an answer similar to the one that you got in question 1?

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


**Solution**

**1)**

```r
  library(glmnet)
  fmCV=cv.glmnet(y=yTRN,x=XTRN,nfolds=5) # performs 5-fold cross-validation
   
  plot(fmCV)
  fmCV$lambda[which.min(fmCV$cvm)]
   
   
  # optimal lambda
  fmCV$lambda[which.min(fmCV$cvm)]
  plot(fmCV) 

```

**2)**
```r
  fm=glmnet(y=yTRN,x=XTRN,lambda=fmCV$lambda)
  YHat=XTST%*%fm$beta
  PMSE.TST=colMeans((yTST-YHat)^2)
  lines(x=log(fm$lambda),y=PMSE.TST,col=4)
```
