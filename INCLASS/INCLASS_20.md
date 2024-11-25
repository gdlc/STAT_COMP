### IN-CLASS 20: Forward Regression


Review sections 1-4 of the [handout on high dimensional regression](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/penalizedRegressions.pdf).

Task: Compute and report the prediction R-sq. in testing data for each of the models along the forward regression search path and the full model.

To read the data in the R-environment and to partition the data into traing and testing sets use this code

```r
 DATA=read.table('https://hastie.su.domains/ElemStatLearn/datasets/prostate.data',header=TRUE)
  head(DATA)
  train=DATA[,'train']
  DATA=DATA[,-ncol(DATA)]

 ## Training and testing data
  DATA.TRN=DATA[train,]
  DATA.TST=DATA[!train,]
```

You can find code illustrating how to fit the full model and models along a forward regression path in the [handout](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/penalizedRegressions.pdf).

After fitting the full model and each of the models along the forward path (from simplest, i.e., just 1 predictor, to the most complex one), estimate the prediction R-sq. of each model and report it in a vector like this one.

```r
R2.TST=rep(NA,length(models))
names(R2.TST)=c(paste0('DF',1:5),'Full')
```

In the first fvie entries of `R2.TST` you will reprot the testing prediction R-sq. of the first five models reported by the forward regression analysis, report the prediction R-sq. of the full model in the 6th entry.


## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case) answering the questions shown below.  Your script should generate a vector `R2.TST` and populate the entries of it (see code provided above).
