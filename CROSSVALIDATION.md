## Quantifvying prediction accuracy and model comparison using cross-validation

So far we have focused mostly on statistical inference (hypothesis testing,
  estimates, and confidence intervals). In this entry, we will focus on quantifying the ability of a model to predict data that was not used to fit the model (i.e., out-of-sample prediction accuracy).

The predictive ability of a model depends on two main factors: (i) The proportion of variance of the outcome that the model explains in the population (i.e., if we knew the population effects), and, (ii) The accuracy of the estimated effects (we use a finite sample to estimate effects; thus, in practice, our predictions use estimated effects instead of true effects).The first factor depends on the joint distribution of the outcome and the predictors; this distribution defines population effects and the proportion of variance of the response variable that can be explained by predictors. The second factor, however, depends on sample size, the estimation procedure, and other factos that may affect the accuracy of estimated effects. The mean-squared error of estimates (MSE=E[(b-bHat)^2]) in turn depends on the variance of estimates and the squared of the bias, specifically MSE(bHat)=Variance+Sq.-Bias. Unbiased estimators (e.g., OLS, method of moments) often have large sampling variance; thus, to obtain accurate estimates one needs  to adequately balance bias and variance.  Some bias can be tolerated if the resulting estimate has considerably lower variance than a competing unbiased estimator.

#### 1) Estimating out-of-sample prediction accuracy

Our goal is to assess the ability of a fitted model to predict future data. Several metrics could be used to evaluate prediction accuracy; we will focus on proportion of variance explained, that is R2=[PRSS0-PRSSA]/PRSS0, where PRSS0 is the prediction sum of squares of a null hypothesis (e.g., an intercept model) 
and PRSSA is the prediction sum of squares of the model of interest. 

A standard approach to assess accuracy is to partition our data set into training and testing data sets. We fit them model to the training data and evaluate
prediction R-sq. in the testing data. The following example illustrates this using the [wages](https://github.com/gdlc/STAT_COMP/blob/master/wages.txt) data set.

```r
  DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/wages.txt',header=T)
  n=nrow(DATA)
  nTst=100
  set.seed(195021) 
  tst=sample(1:n,size=nTst)
  TRN.DATA=DATA[-tst,]
  TST.DATA=DATA[tst,]
  
  fm0=lm(Wage~1,data=TRN.DATA) # our 'baseline' model
  fmA=lm(Wage~.,data=TRN.DATA) # note: Wage~. means regress Wage on all the other variables in 'data'
  yHat0=predict(fm0,newdata=TST.DATA)
  yHatA=predict(fmA,newdata=TST.DATA)

  PRSS0=sum((TST.DATA$Wage-yHat0)^2)
  PRSSA=sum((TST.DATA$Wage-yHatA)^2)
  R2.tst=(PRSS0-PRSSA)/PRSS0

  # R-sq. in the training sample
  trnSS0=sum(residuals(fm0)^2)
  trnSSA=sum(residuals(fmA)^2)
  R2.trn= ( trnSS0-trnSSA)/trnSS0
  summary(fmA)
  
```

#### 2) Quantifying uncertainty about prediction R-sq.

The example presented above  provides a point-estimate of prediction R-sq. This estimate is subject to sampling variability. We can assess sampling variability by estimating prediction R-sq. over many training-testing partitions. The variabiity that we will observe will be due to sampling variability of estimates (originating from the sampling of the testing set) as well as sampling variability aoriginated from the sampling of the testing set. The following example illustrates this using 1,000 training-testing partitions.

```r
 DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/wages.txt',header=T)
 n=nrow(DATA)
 nTst=100
 nRep=1000
 R2.TST=rep(NA,nRep)
 
 for(i in 1:nRep){
  tst=sample(1:n,size=nTst)
  TRN.DATA=DATA[-tst,]
  TST.DATA=DATA[tst,]
 
  fm0=lm(Wage~1,data=TRN.DATA) # our 'baseline' model
  fmA=lm(Wage~.,data=TRN.DATA) # note: Wage~. means regress Wage on all the other variables in 'data'
  yHat0=predict(fm0,newdata=TST.DATA)
  yHatA=predict(fmA,newdata=TST.DATA)

  PRSS0=sum((TST.DATA$Wage-yHat0)^2)
  PRSSA=sum((TST.DATA$Wage-yHatA)^2)
  R2.TST[i]=(PRSS0-PRSSA)/PRSS0
 }
 
 hist(R2.TST,30);abline(v=quantile(R2.TST,prob=c(.025,.5,.975)),col=2,lwd=2,lty=2)
 
```


#### Cross-validation

In a cross-validation (CV) we assing each data point to a fold (e.g., in a 5-fold CV we assing each data point to one of 5 disjoint sets). For each fold, the data assigned to the fold is used for model testing  and the remaining data is used for model training. Thus, a k-fold CV (e.g., k=5) produces k estimates of prediction accuracy. The follwoing example illustrates how to implement a 5-fold CV.



```r
 DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/wages.txt',header=T)
 n=nrow(DATA)
 nFolds=5
 folds=rep(1:nFolds,ceiling(n/nFolds))[1:n] # this gives approximately balanced counts per fold
 R2.TST=rep(NA,nFolds)
 
 for(i in 1:nFolds){
  folds=sample(folds, size=n,replace=F) # randomizing the fold assigment
  tst=which(folds==i)
  TRN.DATA=DATA[-tst,]
  TST.DATA=DATA[tst,]
 
  fm0=lm(Wage~1,data=TRN.DATA) # our 'baseline' model
  fmA=lm(Wage~.,data=TRN.DATA) # note: Wage~. means regress Wage on all the other variables in 'data'
  yHat0=predict(fm0,newdata=TST.DATA)
  yHatA=predict(fmA,newdata=TST.DATA)

  PRSS0=sum((TST.DATA$Wage-yHat0)^2)
  PRSSA=sum((TST.DATA$Wage-yHatA)^2)
  R2.TST[i]=(PRSS0-PRSSA)/PRSS0
 }
 R2.TST 
 
```

To fully account for uncertainty, we may want to repeat the CV many times.


[INCLASS 17](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS_17.md)

