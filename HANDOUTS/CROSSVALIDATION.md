## Quantifying prediction accuracy and model comparison using cross-validation

So far we have focused mostly on statistical inference (hypothesis testing, estimates, and confidence intervals). In this note we will focus on quantifying the ability of a model to predict data that was not used to fit the model (i.e., out-of-sample prediction accuracy).

**Definitions**

Consider a linear model of the form

$$\mathbf{y}=\mathbf{X}\mathbf{\beta}+\mathbf{\varepsilon}$$

Consider a linear model of the form **y=Xb+E** and two data sets, a training data set that we will use to estimate effects (**b**) and a testing data set where we evaluate the model's ability to predict data. $\beta$.

The proportion of variance of the oucome explained by the model is

$$\frac{(\mathbf{y}-\mathbf{X}\mathbf{\beta})'(\mathbf{y}-\mathbf{X}\mathbf{\beta})}{(\mathbf{y}-\mathbf{1}\mu_y)(\mathbf{y}-\mathbf{1}\mu_y}$$

Above, $(\mathbf{y}-\mathbf{X}\mathbf{\beta})'(\mathbf{y}-\mathbf{X}\mathbf{\beta})$ is a sum of squares of the error terms. Here, we are assuming we know the effects ($\mathbf{\beta}$) with certainty.

In a prediction problem we used a model trained using a data set (aka the training data set) to predict data that was not used to fit the model (aka testing data set). The prediction mean-squared error is defined

$$PMSE(\hat{\mathbf{\beta}})=\frac{(\mathbf{y}-\mathbf{X}\hat{\mathbf{\beta}})'(\mathbf{y}-\mathbf{X}\hat{\mathbf{\beta}})}{n}$$

where $\hat{\mathbf{\beta}}$ is a vector of estimated effects, and $\{ \mathbf{y},\mathbf{X}\}$ is a testing data set not used to obtain  $\hat{\mathbf{\beta}}$.

We can also express the PMSE relative to the total variance of the outcome, thus defining a model R-squared, or proportion of variance of the outcome explained by the fitted model.


$$R^2(\hat{\mathbf{\beta}})=\frac{(\mathbf{y}-\mathbf{X}\hat{\mathbf{\beta}})'(\mathbf{y}-\mathbf{X}\hat{\mathbf{\beta}})}{(\mathbf{y}-\mathbf{\bar{y}})'(\mathbf{y}-\mathbf{\bar{y}})}$$


The predictive ability of a model depends on two main factors: 

  - The proportion of variance of the outcome that the model explains in the population (i.e., if we knew the population effects), and,
  - The accuracy of the estimated effects which largely depend on sample size and the number of effects that we need to estimate.

The first factor depends on the joint distribution of the outcome and the predictors; this distribution defines population effects and the proportion of variance of the response variable that can be explained by predictors. The second factor, however, depends on sample size, the estimation procedure, and other factos that may affect the accuracy of estimated effects. The mean-squared error of estimates (MSE=E[(b-bHat)^2]) in turn depends on the variance of estimates and the squared of the bias, specifically MSE(bHat)=Variance+Sq.-Bias. Unbiased estimators (e.g., OLS, method of moments) often have large sampling variance; thus, to obtain accurate estimates one needs  to adequately balance bias and variance.  Some bias can be tolerated if the resulting estimate has considerably lower variance than a competing unbiased estimator.

#### 1) Estimating out-of-sample prediction accuracy
The average squared prediction error (PMSE) is defined as `PMSE=mean((y-yHat)^2)`. This statistic depends on both the variance of the data and how well prediction fit the data. The proportion of variance explained by predictions can be defined as `PVE=(MSy-PMSE)/MSEy`, where `MSy=mean((y-mean(y))^2)`. We can use either `PMSE` or `R2` to asses prediction accuracy. But, recall, our focus is on out-of sample prediction accuracy; thus, we need to estimate these quantities using data that was not used to fit the model. A standard approach for doing this is to partition the data into training and testing data sets. We fit them model to the training data and evaluate `PMSE` or `PVE` in the testing set.  The following example illustrates this using the [wages](https://github.com/gdlc/STAT_COMP/blob/master/wages.txt) data set.

```r
  DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/wages.txt',header=T)
  n=nrow(DATA)
  nTst=100
  set.seed(195021) 
  tst=sample(1:n,size=nTst)
  TRN.DATA=DATA[-tst,]
  TST.DATA=DATA[tst,]
  
  fm0=lm(wage~1,data=TRN.DATA) # our 'baseline' model
  fmA=lm(wage~.,data=TRN.DATA) # note: wage~. means regress Wage on all the other variables in 'data'
  yHat0=predict(fm0,newdata=TST.DATA)
  yHatA=predict(fmA,newdata=TST.DATA)

  PMSE0=sum((TST.DATA$wage-yHat0)^2)
  PMSEA=sum((TST.DATA$wage-yHatA)^2)
  PVE=(PMSE0-PMSEA)/PMSE0

  # R-sq. in the training sample
  trnSS0=mean(residuals(fm0)^2)
  trnSSA=mean(residuals(fmA)^2)
  PVE.TRN= ( trnSS0-trnSSA)/trnSS0
  summary(fmA)
  
```

#### 2) Quantifying uncertainty about PVE

The example presented above  provides a point-estimate of the proportion of variance explained (PVE) by predictions. This estimate is subject to sampling variability. We can assess sampling variability by estimating prediction PVE over many training-testing partitions. The variabiity that we will observe will be due to sampling variability of estimates (originating from the sampling of the testing set) as well as sampling variability originated from the sampling of the testing set. The following example illustrates this using 1,000 training-testing partitions.

```r
 DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/wages.txt',header=T)
 n=nrow(DATA)
 nTst=100
 nRep=1000
 PVE=rep(NA,nRep)
 
 for(i in 1:nRep){
  tst=sample(1:n,size=nTst)
  TRN.DATA=DATA[-tst,]
  TST.DATA=DATA[tst,]
 
  fm0=lm(wage~1,data=TRN.DATA) # our 'baseline' model
  fmA=lm(wage~.,data=TRN.DATA) # note: Wage~. means regress Wage on all the other variables in 'data'
  yHat0=predict(fm0,newdata=TST.DATA)
  yHatA=predict(fmA,newdata=TST.DATA)

  PMSE0=mean((TST.DATA$wage-yHat0)^2)
  PMSEA=mean((TST.DATA$wage-yHatA)^2)
  PVE[i]=(PMSE0-PMSEA)/PMSE0
 }
 
 hist(PVE,30);abline(v=quantile(PVE,prob=c(.025,.5,.975)),col=2,lwd=2,lty=2)
 
```


#### Cross-validation

In a cross-validation (CV) we assing each data point to a fold (e.g., in a 5-fold CV we assing each data point to one of 5 disjoint sets). For each fold, the data assigned to the fold is used for model testing  and the remaining data is used for model training. Thus, a k-fold CV (e.g., k=5) produces k estimates of prediction accuracy. The follwoing example illustrates how to implement a 5-fold CV.

```r
 DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/wages.txt',header=T)
 n=nrow(DATA)
 nFolds=5
 folds=sample(1:5,size=n,replace=TRUE) # assigning rows to folds
 PVE=rep(NA,nFolds)
 
 for(i in 1:nFolds){
  tst=which(folds==i)
  TRN.DATA=DATA[-tst,]
  TST.DATA=DATA[tst,]
 
  fm0=lm(wage~1,data=TRN.DATA) # our 'baseline' model
  fmA=lm(wage~.,data=TRN.DATA) # note: Wage~. means regress Wage on all the other variables in 'data'
  yHat0=predict(fm0,newdata=TST.DATA)
  yHatA=predict(fmA,newdata=TST.DATA)

  PMSE0=mean((TST.DATA$wage-yHat0)^2)
  PMSEA=mean((TST.DATA$wage-yHatA)^2)
  PVE[i]=(PMSE0-PMSEA)/PMSE0
 }
 PVE
```

To fully account for uncertainty, we may want to repeat the CV many times; for example, you may repeat the above 5-fold CV 100 times and report estimates based on the averag PVE. This is illustrated in the following example.


```r
 DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/wages.txt',header=T)
 n=nrow(DATA)
 nFolds=5
 nReps=1000
 
 folds=sample(1:5,size=n,replace=TRUE) # assigning rows to folds
 PVE=rep(NA,nFolds)
 
 for(j in 1:nReps){
  # shuffle the folds
  folds=sample(folds, size=length(folds),replace=FALSE)
  for(i in 1:nFolds){
    tst=which(folds==i)
    TRN.DATA=DATA[-tst,]
    TST.DATA=DATA[tst,]
 
    fm0=lm(wage~1,data=TRN.DATA) # our 'baseline' model
    fmA=lm(wage~.,data=TRN.DATA) # note: Wage~. means regress Wage on all the other variables in 'data'
    yHat0=predict(fm0,newdata=TST.DATA)
    yHatA=predict(fmA,newdata=TST.DATA)

    PMSE0=mean((TST.DATA$wage-yHat0)^2)
    PMSEA=mean((TST.DATA$wage-yHatA)^2)
    PVE[j,i]=(PMSE0-PMSEA)/PMSE0
 }
}
colMeans(PVE)


```

[INCLASS 17](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS/INCLASS_17.md)

