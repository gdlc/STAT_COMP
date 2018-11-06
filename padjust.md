## P-value adjustments

We have seen that when multiple test are perforemed rejecting if p-value is smaller than the desired Type-I errror rate would lead to a (potentially much)
larger Family-Wise Error Rate (see [this entry](https://github.com/gdlc/STAT_COMP/edit/master/multiple_testing.md)).


Thereofre, when we performed multiple test we often "adjust" the p-values and based our rejection decisions based on adjusted-pvalues. The function
`p.adjust()` in adjusts p-values using methods that control for FWER (e.g., Bonferroni) as well as False Discovery Rate.



**Bonferroni**

This adjustment is very simple, the p-value is adjusted by dividing the nominal p-values by the number of tests. Rejecction based on the adjusted p-values
would lead a FWER equal to the  chosen significance level, provided that the tests are independent. Otherwise, this would lead to over-conservative test that would have lower power
than what could be achieved if rejecting at a less conservative level.

```r
   # to illustrate I simulate p-values from a mixture of a uniform dist and a beta dist with a 'spike' at small p-values
   nTest=1000
   pValues=ifelse(runif(nTest)<.1,rbeta(n=nTest,shape1=1.1,shape2=1000),runif(n=nTest))
   hist(pValues,30)
   pAdjustBonf=p.adjust(pValues,method="bonferroni")
   
   # note Boferroni just multiplies by the number of tests
   
   tmp=which(pAdjustBonf<1)
   plot(pAdjustBonf[tmp],pValues[tmp]*nTest)
   
```

**FDR adjustment**

When the number of tests performed is large, controlling for FWER (i.e., the probability of making at least one mistake) leads to over-conservative tests. An alternative is to control for the proportion of false rejections, or False Discovery Rate. This apporach was first proposed by  [Benjamini and Hochberg (1995)](https://www.jstor.org/stable/2346101?seq=1#page_scan_tab_contents) and has become very popular for analyses involving large numbers of tests. `p.adjust` implements FDR correction based on the method proposed by Benjamini and Hochberg as well as similar methods proposed by other authors.

```
   pAdjustFDR=p.adjust(pValues,method="fdr")
   
```

**Comparison of various types of adjustmens**

This example is taken from `help(p.adjust)`.

```r
   require(graphics)
     
     set.seed(123)
     x <- rnorm(50, mean = c(rep(0, 25), rep(3, 25)))
     p <- 2*pnorm(sort(-abs(x)))
     
     round(p, 3)
     round(p.adjust(p), 3)
     round(p.adjust(p, "BH"), 3)
     
     ## or all of them at once (dropping the "fdr" alias):
     p.adjust.M <- p.adjust.methods[p.adjust.methods != "fdr"]
     p.adj    <- sapply(p.adjust.M, function(meth) p.adjust(p, meth))
     p.adj.60 <- sapply(p.adjust.M, function(meth) p.adjust(p, meth, n = 60))
     stopifnot(identical(p.adj[,"none"], p), p.adj <= p.adj.60)
     round(p.adj, 3)
     ## or a bit nicer:
     noquote(apply(p.adj, 2, format.pval, digits = 3))
     
     
     ## and a graphic:
     matplot(p, p.adj, ylab="p.adjust(p, meth)", type = "l", asp = 1, lty = 1:6,
             main = "P-value adjustments")
     legend(0.7, 0.6, p.adjust.M, col = 1:6, lty = 1:6)
     
```

### Comparing FDR and Bonferroni adjustments using (simulated) genomic data


**Simulating Data**

The following example simulates a simple phenotype which is affected by 4 of the SNPs (columns 500, 1000, 1500 and 1800). The first two SNPs have large effect (1) and the last two smaller effect (0.7). The phenotype is simualted so that the proportion of variance of the phenotype explained by these 4 SNPs is 10%.


```r
  set.seed(195021)
  load("X_1K_2K.RData")
  
  R2=0.05
  n=nrow(X)
  p=ncol(X)
  
  HA=c(250,600,900,1200,500,1900) # position of the SNPs with causal effects
  isHA=rep(F)
  isHA[HA]=TRUE
  
  nHA=length(HAs)
  
  b=rep(0,p)
  b[HA]=c(6:1)
  
  signal=X%*%b
  vY=var(signal)/R2  
  
 
  error=rnorm(n,sd=sqrt((1-R2)*vY) ) 
  y=signal+error
  var(signal)/var(y)
```


**Tasks:**

  (i) Obtain p-values by regressing the simulated phenotype on each of the markers, one at a time, using lm().

  (ii) Produce a Manhattan plot (-log10(p-values) versus position of the DNA marker)
  
  (ii) Add as horizontal lines the -log10(pvalue) threshold that you would choose: without pre-correcting, with 
  Bonferroni and FDR adjustments (all at 0.05).
  
  
**(i) Obtaining p-values**
```r
  pValues=rep(NA,p)
  for(i in 1:p){
    fm=lm(y~X[,i])
  	pValues[i]=summary(fm)$coef[2,4]
  }

```

**(ii) Manhattan Plot**

```r
   isHA=rep(FALSE,p)
   isHA[HA]=TRUE
   
   plot(-log10(pValues),cex=.5,col=8,type='o')
   points(x=HA,y=-log10(pValues[HA]),col=2,pch=19)
   
```

**(iii) Thresholds**

```r
  pAdj_Bonf=p.adjust(pValues,method="bonferroni")
  pAdj_FDR=p.adjust(pValues,method="fdr")
  
  abline(h= -log10(0.05),col="magenta") #unadjusted
  abline(h= -log10(max(pValues[pAdj_Bonf<.05])),col="red") #bonferroni
  abline(h= -log10(max(pValues[pAdj_FDR<.05])), col="blue")  #fdr 5%
  
```


[Back](https://github.com/gdlc/STAT_COMP/)

