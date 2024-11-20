
### IN-CLASS 19: Estimation of prediction accuracy in a 5-fold Cross Validation

For today's assigment we will use the [prostate data](https://github.com/gdlc/STAT_COMP/blob/master/DATA/prostate.csv).

The objective is to compare the prediction performance of 3 models in a 5-fold CV.

First, read the data set using the following code.

```r
 fname='https://raw.githubusercontent.com/gdlc/STAT_COMP/refs/heads/master/DATA/prostate.csv'
 DATA = read.csv(fname,header=TRUE,row.names=1)
```

Assign data point to folds using the following code (include this code in your submission).

```r
 nFolds=5
 set.seed(12455)
 n=nrow(DATA)
 DATA$fold=sample(1:nFolds,size=n,replace=TRUE)
```

**Task**

Estimate the prediction R-sq. in CV for each of the following models

  - M1: lpsa~lcavol
  - M2: lpsa~lcavol+lweight+svi+lbph
  - M3: lpsa~lcavol+lweight+svi+lbph+age+lcp+gleason+ pgg45

Submit your results using a table like this one

```r
 nModels=3
 PRED.R2=matrix(nrow=nFolds,ncol=nModels,NA)
 rownames(PRED.R2)=paste0('fold_',1:5)
 colnames(PRED.R2)=paste0('M',1:3)
```
## Submission to Gradescope

For your submission to grade scope, provide an R-script named `assignment.R` (match case). You may submit your answer to Gradescope as many times as needed before the due date.

Your script should include the vtable `PRED.R2`, include in variable called `bestModel` the model you recommend (i.e., `bestModel="M1"` or `bestModel="M2"` or `bestModel="M3"`)
