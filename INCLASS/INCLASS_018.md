
## INCLASS 18: Bias of Bootstrap estimates

Use the following code to simulate three data sets 

```r
 
n=c(10,30,50,100,1000)
set.seed(12345)
DATA=sapply(FUN=rnorm,X=n)

set.seed(1349494) # Set your own seed here

```

For each data set in DATA, generate `R=10000` bootstrap samples, for each bootstrap samples calculate the variance, 
and then compute the average bootstrap estimate. Use that to fill this table
```r

DF=data.frame(n=n,vX=NA,bootsMean=NA,bias=NA)
rownames(DF)=n


## Write here your bootstrap code to fill DF$bootsMean

DF$bias=DF$bootsMean-DF$vX
```

## Submission 


For your submission to grade scope provide an R-script named `assignment.R` (match case) your code should generate the `DF` data frame.
