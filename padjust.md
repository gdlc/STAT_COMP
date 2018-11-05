## P-value adjustments

We have seen that when multiple test are perforemed rejecting if p-value is smaller than the desired Type-I errror rate would lead to a (potentially much)
larger Family-Wise Error Rate (see [this entry](https://github.com/gdlc/STAT_COMP/edit/master/multiple_testing.md ).


Thereofre, when we performed multiple test we often "adjust" the p-values and based our rejection decisions based on adjusted-pvalues. The functio
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
