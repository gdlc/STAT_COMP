### IN-CLASS 18: Multiple-testing

The following script is from Example 2 of the [Multiple Testing Handout](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/MultipleTesting.pdf)

```r
 set.seed(12345)
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

Using it as an example, Compute the False-discovery proportion (FDP) and the proportion of Ha's that were discovered for each of the  following decision rules:

  - Reject if Bonferroni-adjusted pvalues< 0.05 
  - Reject if Holm's-adjusted pvalues< 0.05
  - Reject if FDR-adjusted pvalues<  0.05

## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case).

Report your result in a matrix like the following

```r
 FDP_PWR=data.frame(FDP=rep(NA,3),PWR=rep(NA,3))
 rownames(FDP_PWR)=c('BONF','HOLM','FDR')
```

Above, `FDP` and `PWR` are the estimated proportion sof false and true discoveries. 
