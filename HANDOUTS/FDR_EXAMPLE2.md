
```r
 pH0=0.92
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
 
 ```r
