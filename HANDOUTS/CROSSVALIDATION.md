## Quantifying prediction accuracy and model comparison using cross-validation

So far we have focused mostly on statistical inference (estimation, hypothesis testing, and confidence intervals). In this note we will focus on quantifying the ability of a model to predict data that was not used to fit the model (i.e., out-of-sample prediction accuracy).

**Definitions**

Consider a linear model of the form

$$\mathbf{y}=\mathbf{X}\mathbf{\beta}+\mathbf{\varepsilon}$$

The proportion of variance of the oucome explained by the model is

$$R^2_0=\frac{\Sigma_i{(y_i-\mu_y)^2}-\Sigma_i{(y_i-\Sigma_j{X_{ij}\beta_j})^2} }{\Sigma_i{(y_i-\mu_y)^2}}$$

where $\mu_u$ is the mean of $y$, $\Sigma_i{(y_i-\mu_y)^2}$ is the sum of squares of $y$, and $\Sigma_i{(y_i-\Sigma_j{X_{ij}\beta_j})^2}$ is a sum of squares of the error terms.  

Above,  we assumed that we know the mean of the data  ($\mu_y$) and the vector of effects ($\mathbf{\beta}$) with certainty.

In a prediction problem, we use a model trained using a data set (aka a **training data set**) to predict data that was not used to fit the model (aka **testing data set**). The prediction mean-squared error is defined

$$PMSE(\hat{\mathbf{\beta}})=\frac{\Sigma_i{(y_i-\Sigma_j{X_{ij}\hat{\beta}_j})^2}}{n}$$

where $\hat{\mathbf{\beta}}$ is a vector of estimated effects, and $\\{ \mathbf{y},\mathbf{X}\\}$ is a testing data set not used to obtain  $\hat{\mathbf{\beta}}$.

The proportion of variance of the outcome explained by the fitted model (or prediction R-squared) is defined as


$$R^2(\hat{\mathbf{\beta}})=\frac{ \Sigma_i{(y_i-\bar{y})^2}  - \Sigma_i{(y_i-\Sigma_j{X_{ij}\hat{\beta}_j})^2}  }{\Sigma_i{(y_i-\bar{y})^2}}=\frac{SSy-PSS}{SSy}=1-\frac{PSS}{SSy}$$

where:

   - $SSy=\Sigma_i{(y_i-\bar{y})^2}$ is the total sum of squares of $y$, and
   - $PSS=\Sigma_i{(y_i-\Sigma_j{X_{ij}\hat{\beta}_j})^2}$ is the sum of squares of the prediction errors.

**Factors affecting prediction accuracy**

The predictive ability of a model (e.g., the prediction R-squared) depends on two main factors: 

  - The proportion of variance of the outcome that the model explains in the population (i.e., $R^2_0$), and,
  - The accuracy of the estimated effects (i.e., how good $\hat{\mathbf{\beta}}$ is as an estimate of $\mathbf{\beta}$).
  
The first factor depends on how good are the predictors (Do we have in $X$ most the factors that affect $y$? Are our predictors subject to measurment error?) 

The second factor depends on how accurately we can estimate effects which depends sample size ($n$), the number of effects ($p$) that we need to estimate, and $R^2_0$, mainly.

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

In the above example, the fitted model explaines ~19% of the variance of the wages in A **testing data set**.

*Godness of fit to the training data set*

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

In a cross-validation (CV) we assing each data point to a fold (e.g., in a 5-fold CV we assing each data point to one of 5 disjoint sets). For each fold, the data assigned to the fold is used for model testing  and the remaining data is used for model training. Thus, a k-fold CV (e.g., k=5) produces k estimates of prediction accuracy. The follwoing example illustrates how to implement a 5-fold CV.

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
  SSy=mean((TST.DATA$wage-mean(TST.DATA$wage))^2)
  R2.TST[i]=1-PSS/SSy
  
 }
R2.TST
```

To fully account for uncertainty, we may want to repeat the CV many times; for example, you may repeat the above 5-fold CV 100 times and report estimates based on the average R2. This is illustrated in the following example.


[INCLASS 18](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS/INCLASS_18.md)

