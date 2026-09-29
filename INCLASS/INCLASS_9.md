## INCLASS-9: F test

Create a function `anova2(H0,Ha)` that reproduces the results of `anova()`. 

The function should take two models (`H0` and `Ha`) fitted with `lm()` and return a list with the three entries, one with `DF` and `RSS` for each of the models, one with denominator and numerator `MS` and `DF`, and one with `F-statistic` and `p-value`.

Use this template

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


