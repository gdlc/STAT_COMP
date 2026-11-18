## Quantifying prediction accuracy and model comparison using cross-validation

So far we have focused mostly on statistical inference (estimation, hypothesis testing, and confidence intervals). In this note we will focus on quantifying the ability of a model to predict data that was not used to fit the model (i.e., out-of-sample prediction accuracy).

### Model

Consider a model of the form

$$y_i= f(\boldsymbol{x}_i,\boldsymbol{\theta})+\varepsilon_i$$

where $y_i$ is an outcome,$f()$ is a regression function, $\boldsymbol{x}_i$ is a vector of predictors, $\boldsymbol{\theta}$ is a parameter vector and $\varepsilon_i$ is an error term with $E[\varepsilon_i|\boldsymbol{x}_i]=0$ such that $E[y_i| \boldsymbol{x}_i]=f(\boldsymbol{x}_i,\boldsymbol{\theta})$.

###  Predictive ability

In a prediction problem, we use a model trained using a data set (aka a **training data set**) to predict data that was not used to fit the model (aka **testing data set**). 

Let $\boldsymbol{\hat{\theta}})$ be model parameters estimated with a training data set. 

The **prediction mean squared error (PMSE)** is is the average squared deviation of a prediction from the actual observation. 

$$PMSE=\frac{\Sigma_i^n (y_i-f(\boldsymbol{x}_i,\boldsymbol{\hat{\theta}}))^2}{n}$$

And the **proportion of variance explained by the model** is

$$R^2=\frac{MSE_y-PMSE}{MSE_y}$$

where $MS_y$ is the average squared deviation of $y$ from its mean, in the sample $MS_y=\frac{(y_i=\bar{y_i})^2}{n}$,

When we want to assess the ability of a model to predict future data we typically evaluate PMSE and $R^2$ in data (aka testing data) that was not used to train the model. 

In this handout we will review the factors that affect the ability of a model to predict future data and various ways to estimate it. 

### Factors affecting prediction accuracy

The predictive ability of a model (e.g., the prediction R-squared) depends on two main factors: 

  - The proportion of variance of the outcome that the model explains in the population (i.e., if we knew $\boldsymbol{\theta}$), and,
  - The accuracy of parameter estimates (i.e., how good $\hat{\mathbf{\theta}}$ is as an estimate of $\mathbf{\theta}$).
  

#### 1) Estimating out-of-sample prediction accuracy using a training-testing approach

To estimate prediction accuracy we typically use a training data set to estimate parameters and then evaluate the ability of the model to predict future data in a separate data set that was not used to train our model.

The following example illustrates how to estimate PMSE in testing data useing the [wages](https://github.com/gdlc/STAT_COMP/blob/master/wages.txt) data set.


```r
  DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/wages.txt',header=T)
  n=nrow(DATA)
  nTst=100 # number of observations left out for testing
  set.seed(195021) 
  tst=sample(1:n,size=nTst)
  TRN.DATA=DATA[-tst,]
  TST.DATA=DATA[tst,]
  
  
  fm=lm(wage~.,data=TRN.DATA) # note: wage~. means regress Wage on all the other variables in 'data'

  yHatTST=predict(fm,newdata=TST.DATA)
  yTST=TST.DATA$wage
  meanY=mean(TST.DATA$wage)

  PMSE=mean((yTST-yHatTST)^2)
  MSy=mean((yTST-meanY)^2)
  R2=1-PMSE/MSy
  
```

In the above example, the fitted model explaines ~19% of the variance of the wages in a testing data set.

### Godness of fit to the training data set

Typically, the model R-sq. is higher in the training data set than in the testing data set, because parameter estimates are obtained by maximizing model's fit to the training data. 

However, the training set R-sq. of a model is not a good estimate of the model's ability to predict future data. To see this, compare the testing R2 (above) with the training R2 (calculated in the script below).

```r
 summary(fm)$r.squared
 yTRN=TRN.DATA$wage

# Rsq in the training data set
 1-sum((yTRN-predict(fm))^2)/sum((yTRN-mean(yTRN))^2)
```

#### 2) Quantifying uncertainty testing prediction accuracy

The example presented above  provides a point-estimate of the proportion of variance explained by predictions. This estimate is subject to sampling variability. We can assess sampling variability by estimating prediction testing set R-sq. over many training-testing partitions. 

The following example illustrates this using 1,000 training-testing partitions.

```r
 DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/wages.txt',header=T)
 n=nrow(DATA)
 nTst=100
 nRep=1000
 R2.TST=rep(NA,nRep)
 R2.TRN=R2.TST

 for(i in 1:nRep){
  tst=sample(1:n,size=nTst)
  TRN.DATA=DATA[-tst,]
  TST.DATA=DATA[tst,]
 
  
  fm=lm(wage~.,data=TRN.DATA) # note: Wage~. means regress Wage on all the other variables in 'data'
  yHat=predict(fm,newdata=TST.DATA)

  PSS=mean((TST.DATA$wage-yHat)^2)
  SSy=mean((TST.DATA$wage-mean(TST.DATA$wage))^2)
  R2.TST[i]=1-PSS/SSy
  R2.TRN[i]=summary(fm)$r.sq
 }

mean(R2.TRN)
mean(R2.TST)
hist(R2.TST,30);abline(v=quantile(R2.TST,prob=c(.025,.5,.975)),col=2,lwd=2,lty=2)
 
```


#### Cross-validation

In a cross-validation (CV) we assign each data point to a fold (e.g., in a 5-fold CV we assing each data point to one of 5 disjoint sets). For each fold, the data assigned to the fold is used for model testing  and the remaining data is used for model training. Thus, a k-fold CV (e.g., k=5) produces k estimates of prediction accuracy. The follwoing example illustrates how to implement a 5-fold CV.

```r
 DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/wages.txt',header=T)
 n=nrow(DATA)
 nFolds=5
 folds=sample(1:5,size=n,replace=TRUE) # assigning rows to folds
 R2.TST=rep(NA,nFolds)
 
 for(i in 1:nFolds){
  tst=which(folds==i)
  TRN.DATA=DATA[-tst,]
  TST.DATA=DATA[tst,]
 
 
  fm=lm(wage~.,data=TRN.DATA) # note: Wage~. means regress Wage on all the other variables in 'data'
  
  yHat=predict(fm,newdata=TST.DATA)
  PSS=mean((TST.DATA$wage-yHat)^2)
  MSy=mean((TST.DATA$wage-mean(TST.DATA$wage))^2)
  R2.TST[i]=1-PSS/MSy
  
 }
R2.TST
```

To fully account for uncertainty, we may want to repeat the CV many times; for example, you may repeat the above 5-fold CV 100 times and report estimates based on the average R2. This is illustrated in the following example.

### Model comparison using prediction R-sq

Suppose we want to find which of the following models predicts wages better

 - M1: `wage~region+ethnicity`
 - M2: `wage~region+ethnicity+sex`
 - M3: `wage~region+ethnicity+sex+education`
 - M4: `wage~region+ethnicity+sex+education+union`

To do this, consider implementing 100 training testing partitions

```r
 DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/wages.txt',header=T)
 n=nrow(DATA)

 nRep=100
 nTst=100

 R2=matrix(nrow=nRep,ncol=4,NA)
 colnames(R2)=paste0('M',1:4)

 for(i in 1:nRep){
  tst=sample(1:n,size=nTst)
  trn=(1:n)[-tst]
   
  DATA.TRN=DATA[trn,]

  M1=lm(wage~region+ethnicity,data=DATA.TRN)
  M2=lm(wage~region+ethnicity+sex,data=DATA.TRN)
  M3=lm(wage~region+ethnicity+sex+education,data=DATA.TRN)
  M4=lm(wage~region+ethnicity+sex+education+union,data=DATA.TRN)
  

  DATA.TST=DATA[tst,]
  My=mean(DATA.TRN$wage)

  MSy=mean((DATA.TST$wage-My)^2)
  y=DATA.TST$wage
  R2[i,'M1']=1- mean((y-predict(M1,newdata=DATA.TST))^2)/MSy
  R2[i,'M2']=1- mean((y-predict(M2,newdata=DATA.TST))^2)/MSy
  R2[i,'M3']=1- mean((y-predict(M3,newdata=DATA.TST))^2)/MSy
  R2[i,'M4']=1- mean((y-predict(M4,newdata=DATA.TST))^2)/MSy
 }
 colMeans(R2)
```
