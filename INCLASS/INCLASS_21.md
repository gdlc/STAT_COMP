### IN-CLASS 21: Lasso, Ridge Regression, and Elastic Net

For this in-class assignment we will use the prostate cancer data set (the script provided below can be used to read the data into an R environment).


Tasks: 

  - (i) Compute and report the prediction R-sq. in testing data for Lasso, Ridge Regression, and Elatic Net (with alpha=0.5) over the regularizaiton path.
  - (ii) Report the maximum prediction R-sq. for each of these models.
 
To read the data in the R-environment and to partition the data into traing and testing sets use this code

```r
 DATA=read.csv('https://raw.githubusercontent.com/gdlc/STAT_COMP/refs/heads/master/DATA/prostate.csv',header=TRUE,row.names=1)

 train=DATA[,'train']
  DATA=DATA[,-ncol(DATA)]

 ## Training and testing data
  DATA.TRN=DATA[train,]
  DATA.TST=DATA[!train,]
```

To use glmnet you need to provide the response vector (`y`, in our case `lpsa`) and the incidence matrix for predictors (`x`). The following script creates the response vector and incidence matrices for the training and testing data sets.


```r
 yTRN=DATA.TRN$lpsa
 yTST=DATA.TST$lpsa
 XTRN=model.matrix(~lcavol +lweight+age +lbph + svi + lcp + gleason + pgg45,data=DATA.TRN)[,-1]
 XTST=model.matrix(~lcavol +lweight+age +lbph + svi + lcp + gleason + pgg45,data=DATA.TST)[,-1]
```

The following script shows how to fit a Lasso regression using glmnet (use `alpha=0` for Ridge Regression, and `apha=0.5` for Elastic Net)


```r
 fmL=glmnet(y=yTRN,x=XTRN,alpha=1)
```

By default `glmnet` fits a lasso regression over a grid of values of the regularization parameter (lambda). You can find how many values of lambda were evaluated using

```r
 length(fmL$lambda)
```

To predict in the testing data set you can use the `predict` function

```r
 YHatL=predict(fmL,newx=XTST)
```

You can use the above-matrix (and `yTST`) to compute the prediction R-sq. in the testing set for each value of `lambda`, you can do that by simply looping over columns of `YHatL`.

To report on task (i) use the followin objects

```r
 R2.TST_LASSO=rep(NA,length(fmL$lambda))
 R2.TST_RIDGE=rep(NA,length(fmR$lambda)) # here I assume you stored the fitter Ridge Regression model in fmR
 R2.TST_ENET=rep(NA,length(fmEN$lambda)) # here I assume you stored the fitter Elastic Net model in fmEN
```

To report on taks (ii) use the follwoing objects (all scalars, can be obtained by calling `max()` on the vector with the prediction R-sq. of each of the models. 

```r
 
 R2.TST.MAX_LASSO
 R2.TST.MAX_RIDGE
 R2.TST.MAX_ENET
```


## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case) answering the questions shown below.  Your script should generate the objects listed above. 

