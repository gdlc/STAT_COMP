## INCLASS-9: F test

Create a function `anova2(H0,Ha)` that can be used to test two nested models fitted with `lm()`. 

Your function must take  two models (`H0` and `Ha`) fitted with `lm()` as the inputs and return a list with the three entries

 - `$RSS` a matrix or data frame with two rows (one per model) and two columns, one with RSS-df and RSS for each of the models.
 - `$MS` a model with the mean-squared errors needed to compute the F-statistic, the model MS (`[RSS(H0)-RSS(Ha)]/(pA-p0)` and the residual MS (`RSS(Ha)/RSS-DF(Ha)`).
 - `$FTest` a vector with the F-statistic and the corresponding p-value.


Feel free to use this template. 

```r
anova2=function(H0,Ha){
 ANS=list()
 ANS$RSS_DF=data.frame(DF=rep(NA,2),RSS=rep(NA,2),row.names=c('H0','Ha'))
 ANS$MS_DF=data.frame(DF=rep(NA,2),MS=rep(NA,2),row.names=c('Numerator','Denominator'))
 ANS$FTest=c('FStat'=NA,'pValue'=NA)

 # ....

 return(ANS)
}

```


