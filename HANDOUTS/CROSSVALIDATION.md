## Quantifying prediction accuracy and model comparison using cross-validation

So far we have focused mostly on statistical inference (hypothesis testing, estimates, and confidence intervals). In this note we will focus on quantifying the ability of a model to predict data that was not used to fit the model (i.e., out-of-sample prediction accuracy).

**Definitions**

Consider a linear model of the form

$$\mathbf{y}=\mathbf{X}\mathbf{\beta}+\mathbf{\varepsilon}$$

The proportion of variance of the oucome explained by the model is

$$R^2_0=\frac{(\mathbf{y}-\mathbf{X}\mathbf{\beta})'(\mathbf{y}-\mathbf{X}\mathbf{\beta})}{(\mathbf{y}-\mathbf{1}\mu_y)(\mathbf{y}-\mathbf{1}\mu_y)}$$

where $\mu_u$ is the mean of $y$ and $(\mathbf{y}-\mathbf{X}\mathbf{\beta})'(\mathbf{y}-\mathbf{X}\mathbf{\beta})$ is a sum of squares of the error terms. 

In the above expressions we assumed that we know the effects ($\mathbf{\beta}$) with certainty.

In a prediction problem we used a model trained using a data set (aka a **training data set**) to predict data that was not used to fit the model (aka **testing data set**). The prediction mean-squared error is defined

$$PMSE(\hat{\mathbf{\beta}})=\frac{(\mathbf{y}-\mathbf{X}\hat{\mathbf{\beta}})'(\mathbf{y}-\mathbf{X}\hat{\mathbf{\beta}})}{n}$$

where $\hat{\mathbf{\beta}}$ is a vector of estimated effects, and $\{ \mathbf{y},\mathbf{X}\}$ is a testing data set not used to obtain  $\hat{\mathbf{\beta}}$.

The proportion of variance of the outcome explained by the fitted model (or prediction R-squared) is defined as


$$R^2(\hat{\mathbf{\beta}})=\frac{ (\mathbf{y}-\mathbf{\bar{y}})'(\mathbf{y}-\mathbf{\bar{y}}) -(\mathbf{y}-\mathbf{X}\hat{\mathbf{\beta}})'(\mathbf{y}-\mathbf{X}\hat{\mathbf{\beta}})}{(\mathbf{y}-\mathbf{\bar{y}})'(\mathbf{y}-\mathbf{\bar{y}})}=\frac{1-PSS/SSy}$$

where:

   - $SSy=(\mathbf{y}-\mathbf{\bar{y}})'(\mathbf{y}-\mathbf{\bar{y}})$ is the total sum of squares of $y$, and
   - $PSS=(\mathbf{y}-\mathbf{X}\hat{\mathbf{\beta}})'(\mathbf{y}-\mathbf{X}\hat{\mathbf{\beta}})$ is the sum of squares of the prediction errors.

The predictive ability of a model (e.g., the prediction R-squared) depends on two main factors: 

  - The proportion of variance of the outcome that the model explains in the population (i.e., if we knew the population effects, $R^2_0$), and,
  - The accuracy of the estimated effects (i.e., how good $\hat{\mathbf{\beta}}$ is as an estimate of $\mathbf{\beta}$).
  
The first factor depends on how good are the predictors ($\mathbf{X}$, do we have in $X$ most the factors that affect $y$? Are our predictors subject to measurment error?) 

The second factor depends on how accurately we can estimate effects which depends sample size ($n$), the number of effects ($p$) that we need to estimate and $R^2_0$ mainly.

#### 1) Estimating out-of-sample prediction accuracy using a training-testing approach

The following example illustrates this using the [wages](https://github.com/gdlc/STAT_COMP/blob/master/wages.txt) data set.

In the example, we partition a data set into a training and a testing data set. We use the training data set to estiamte effects and evaluate prediction accuracy in the testing set.

```r
  DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/wages.txt',header=T)
  n=nrow(DATA)
  nTst=100
  set.seed(195021) 
  tst=sample(1:n,size=nTst)
  TRN.DATA=DATA[-tst,]
  TST.DATA=DATA[tst,]
  
  
  fm=lm(wage~.,data=TRN.DATA) # note: wage~. means regress Wage on all the other variables in 'data'

  yHatTST=predict(fm,newdata=TST.DATA)
  yTST=TST.DATA$wage
  meanY=mean(TST.DATA$wage)

  PMSE=mean((yTST-yHatTST)^2)
  MSEy=mean((yTST-meanY)^2)
  R2=1-PMSE/MSEy
  
```

In the above example, the fitted model explaines 81% of the variance of the wages in the testing data set.

*Godness of fit to the training data set*

```r
 summary(fm)
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

