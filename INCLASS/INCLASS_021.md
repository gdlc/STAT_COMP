### IN-CLASS 21

Using the code in [Example 4](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/CROSSVALIDATION.md#example-4-model-comparison) of today's class 
provide the following results

1) A table with models in row and the average prediction R-sq and the SD of the R-sq across training-testing partitions.

```r
 RES1=data.frame(Model=paste0('M',1:4),R2=NA,SD_R2=NA)
```

2) A 4x4 matrix having in each off-diagonal cell the proportion of times that the model in columns had an R-sq greater than the model in rows. Leave the diagonal entries empty.


```r
 RES2=matrix(nrow=4,ncol=4,NA)
 colnames(RES2)=paste0('M',1:4)
 rownames(RES2)=paste0('M',1:4)
```

3) A table similar to RES2 with a one-sided p-value from a paired t-test, testing whether the model in column has a higher R-sq than the model in row.

Hint: use one-sided `t.test()` for paired observations.

```r
 RES3=matrix(nrow=4,ncol=4,NA)
 colnames(RES3)=paste0('M',1:4)
 rownames(RES3)=paste0('M',1:4)
```

## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` he proportion of Ha that were discovered, respectively. 

Your submission should create and populate `RES1`, `RES2` and `RES3`.
