


### INCLASS 5: OLS

Create an R-function that will fit a linear model via least-squares, use the example below to compare your results with `lm()`. In your function you can use all the matrix operations that we discussed in class. However, you cannot use `lm()` or similar built functions to fit OLS.

Recall that in a linear model **y=Xb+e**, the least-squares estimate of **b** is the solution to the following system **X'Xb=X'y**.


```r
 n=300
 x1=rbinom(size=1,n=n,prob=.5)
 x2=rnorm(n)
 mu=100
 b1=2
 b2=-3
 
 signal=mu + x1*b1 + x2*b2
 error=rnorm(n)
 y=signal+error
 
 summary(lm(y~x1+x2))
 
```
Our final goal is to implement `summary(lm(y~X))` using our own functions. Build the following functions one by one:

**1)** `getXy`: this function receives the formula and data, and outputs a list with two elements `X` and `Y`:

```
DATA = data.frame(y=y,z1=x1,z2=x2)
tmp = getXy(y~z1+z2,DATA)
```
Then `tmp$X` is a matrix with three columns `(Intercept)`, `z1` and `z2`, and `tmp$Y` is a vector containing the response `y`.

**Hint:** Inside `getXy()` consider using `model.matrix()`.

**2)** `fitXy`: this function receives the two outputs from `getXy`, and outputs the summary of coefficient estimates which exactly match the output table of `summary()`.

**3)** `fitOLS`: this function receives the formula and data, uses `getXy` to process the data, and uses `fitXy` to obtain the output table.

## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case) answering the questions shown below. If you have multiple files to submit, at least one of them is named as `assignment.R`.  You may submit your answer to Gradescope as many times as needed.

  - Include in your script the declaration of the three functions mentioned above. We will test the functions with arbitrary examples.




### IN-CLASS 16: Bootstrap

## Using Bootstrap to produce confidence bands for logistic regression, compare with confidence bands produced by inverting a CI for the linear predictor

**Objective:** To predict risk of develping gout by serum urate levels.

The example below fits a logistic regression for gout as a function of serum urate.

```R
   DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/goutData.txt',
                    header=TRUE)
   DATA$y=ifelse(DATA$gout=="Y",1,0)
   fm=glm(y~su,data=DATA,family='binomial')
   summary(fm) 
```

**Prediction**

Recall that in logistic regression,the predicted probability is `theta=exp(x'b)/(1+exp(x'b))`, see [handout](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/LogisticRegression.pdf) for details. We use this to predict the probability of developing gout as a function of SU. 

```r
 su.grid=seq(from=4,to=10,by=.1)
 phat=predict(fm,type='response',newdata=data.frame(su=su.grid))
 plot(phat~su.grid,col=2,xlab='Serum urate',ylab='P(Gout)',type='l',ylim=c(0,.5))
 ```

**Confidence bands using methods previoulsy discussed in class**

We discuss how to produce confidence bands for predictions by:

   - Producing a CI for the linear predictor
   - Mapping that CI into a probability scale using the inverse-logit (`theta=exp(x'b)/(1+exp(x'b))`).

The following code produces confidence bands using that approach

```r
  LP=predict(fm,newdata=data.frame(su=su.grid),se.fit=TRUE)
  CI.LP=cbind('LB'=LP$fit-1.96*LP$se.fit ,'LB'=LP$fit +1.96*LP$se.fit) 
  CI.PROB=exp(CI.LP)/(1+exp(CI.LP))
  plot(phat~su.grid,col=2,xlab='Serum urate',ylab='P(Gout)',type='l',ylim=c(0,.5))
  lines(CI.PROB[,1],x=su.grid,col='blue',lty=2)
  lines(CI.PROB[,2],x=su.grid,col='blue',lty=2)
  
```
   
   
**Confidence bands using Bootstrap**

Use 5000 Bootstrap samples to create a 95% confidence band for predicted risk for `su.grid=c(4,7,10)`.

Suggestions:

 1. Create a matrix PHAT, with `nrow=length(su.grid)`, and `ncol=5000`
 2. In a loop from 1:5000:
     - Generate a bootstrap sample `TMP=DATA[sample(1:nrow(DATA),replace=TRUE),]`
     - Fit the model using the bootstrap data (`TMP`)
     - Use the fited model and `su.grid` to predict probability of gout by level of serum urate (e.g., `predict(fm,type=response,newdata=data.frame(su=su.grid),type='response')`
     - Save those predictions in the ith column of the PHAT matrix
 3. Estimate the 0.025 and 0.975 quantiles by applying, the `quantile` function to the rows (`MARGIN=`1) of `PHAT`)
 4. Store the estimated CI in this object

```r
 CI=matrix(nrow=length(su.grid),ncol=2,NA)
 rownames(CI)=grid
 colnames(CI)=c('Lower','Upper')

```

 ### IN-CLASS 17: Permutation analysis in multiple testing problems 

Many problems involve testing multiple hypothesis. For example, in a linear model of the form `Y=a+X1b1+X2b2+X3b3+E` we may want to test: H01: b1=0 vs HA1: b1!=0, H02: b2=0 vs HA2: b2!=0, and H03: b3=0 vs HA2: b3!=0 (note that here we are testing three hypothesis, this is different than testing  H0: b1=b2=b3=0 vs HA: at least one of the b's different than zero).

A Type-I error rate occurs when we reject a null that holds. In multiple testing, a standard approach is to control the probability of making at least one mistake (i.e., wrongly rejecting one ore more null that holds). 

How do we use permutations to control the probability of making at least one mistake? 

One possible approach is as follows

  1) Generate a permutation data set,
  2) Extract the pvalues for each of the tests,
  3) Store the minimum pvalue (note: since this is a permutation data set, the minimum p-value would be the one that if you use it as your threshold would lead to 1 mistake beacuse indeed in the permuted data all the nulls hold).
  4) Repeat 1-3 a large number of times, always saving the lowest pvalue.

After completing the above steps you will have a vector holding values of the minimum pvalue. If you want to control the probability of making one mistake at the 0.05 level, then choose the 0.05 empirical percentile of the minimum pvalues as your threshold for rejection.

## Task

Use the following symulated data set to estimate using permutations the threshold that you should use to control the probability of making at least 1 mistake smaller or equal than 0.1.

**Simulation**

```r 
 set.seed(1950)
 X=matrix(nrow=1000,ncol=3,rbinom(size=2,n=3000,prob=0.2))
 b=c(1,0,1)
 signal=scale(X%*%b)*sqrt(0.1)
 error=rnorm(nrow(X),sd=sqrt(0.8))
 y=signal+error
 fm=lm(y~X)
```

- Our objective is to test for the trhee coefficients (not the intercept) using a pvalue threshold that will control the probability of making at least one mistake at a level of 0.05.
- Use the above simulation and  10,000 permuations to estimate the threshold that you should use to control the probability of making at least  one mistake smaller or equal than 0.05. 
- Hints:
     - Create a vector with 10,000 entries `permPval=rep(NA,10000)1`
     - For each permutation, store in the corresponding entry of `permPval` the minimum p-value of three coeffiecnts (do not inlcude the pvalue for the intercept, e.g., use `min(summary(lm(permY~X))$coef[-1,4])`)
     - To obtain a permuatation pvalue cutoff, find the 0.05 quantile of `permPval`.
     - Is the threshold you are finding larger, similar, or smaller than the nominal threhsold 0.05? Why?
 
### Gradescope 

Your script should generate the `permPVal` vector and a variable named `pvalThreshold` which if used for testing controls the probability of making at least 1 mistake at most 0.05.



### IN-CLASS 18: Multiple-testing

The following script is from Example 2 of the [Multiple Testing Handout](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/MultipleTesting.pdf)

```r
 pH0=0.95
 nTests=5000
 n=1000 # sample size
 pVals=rep(NA,nTests)
 isHA=runif(nTests)>pH0
 varB=.03 #  variance explained if Ha holds
 
 for(i in 1:nTests){
   x=rnorm(n)
   y=rnorm(n)
   if(isHA[i]){
     y=y+x*rnorm(1,sd=sqrt(varB)) # adding an effect if Ha
   }
   pVals[i]=summary(lm(y~x))$coef[2,4]
 }
 
 pADJ.Bonf=p.adjust(pVals,method='bonferroni')
 pADJ.Holm=p.adjust(pVals,method='holm')
 pADJ.FDR=p.adjust(pVals,method='fdr')
 

```

Using the results generated by the example, compute the False-discovery proportion (FDP), and the proportion of Ha's that were discovered for each of the  following decision rules:

  - Reject if Bonferroni-adjusted pvalues< 0.05 
  - Reject if Holm's-adjusted pvalues< 0.05
  - Reject if FDR-adjusted pvalues<  0.05


See handout for details.



### IN-CLASS 19: Evaluating prediction accuracy of OLS, Forward, and LASSO



### IN-CLASS 19: Evaluating prediction accuracy of OLS, Forward, and LASSO

We will use the [prostate data](https://github.com/gdlc/STAT_COMP/blob/master/DATA/prostate.csv) for this assignment. Download the data and read it using the following syntax into your code. 

```r
DATA = read.csv('prostate.csv',header=TRUE)
DATA = DATA[,-1]
```

Partition the data into training and testing sets using the following syntax.

```r
train=DATA[,'train']
DATA=DATA[,-ncol(DATA)]

DATA.TRN=DATA[train,]
DATA.TST=DATA[!train,]
dim(DATA.TRN)
```
### (I) Task

Compute the correlation between `lpsa` (log-psa) and predicted `lpsa` for each the regression methods below.

#### OLS Regressiom

1) Fit the OlS model for `lpsa` (log-psa) using all other variables in the training data (DATA.TRN), use that model to predict log-psa for the testing data (DATA.TST). Store the computed correlation in `COR.OLS_FULL`.

#### Forward Regression

2) Fit the best forward regression model (smallest AIC) using `lm(lpsa ~ 1)` applied to DATA.TRN, then use the fitted model to predict log-psa for the testing data (DATA.TST). Store the result computed using forward regression in `COR.FWD`.

#### Lasso Regression

3) Calculate the Incidence matrix with predictor variables and then fit the model using `glmnet` package. For each value of lambda in the lasso regression, predict log-psa for the testing data (DATA.TST) and then compute the correlation between `lpsa` and predicted lpsa for the testing data. Store the results in the vector `COR.LASSO`, where it can be initialized as;

```r
COR.LASSO=rep(NA,length(fmLASSO$lambda))
```

Observe the results using the following plot.

```r
plot(COR.LASSO,type='o',ylim=range(c(COR.LASSO,COR.OLS_FULL,COR.FWD),na.rm=TRUE)*c(.98,1.02))
abline(h=COR.OLS_FULL,col='blue',lty=2,lwd=1.5);text(label='OLS-FULL',col='blue',x=20,y=COR.OLS_FULL+.01)
abline(h=COR.FWD,col='red',lty=2,lwd=1.5);text(label='Forward',col='red',x=60,y=COR.FWD+.01)
abline(v=which(diff(fmLASSO$df)>0),col='grey',lty=2)
```

## Submission to Gradescope

For your submission to grade scope, provide an R-script named `assignment.R` (match case) answering the above questions. You may submit your answer to Gradescope as many times as needed before the due date.

Your script should include the variables `COR.OLS_FULL`, `COR.FWD` and the vector `COR.LASSO`, which corresponds to the correlations computed for the log-psa and predicted log-psa using OLS, Forward and Lasso regression methods respectively.


