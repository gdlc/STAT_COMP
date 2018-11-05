## P-value adjustments

We have seen that when multiple test are perforemed rejecting if p-value is smaller than the desired Type-I errror rate would lead to a (potentially much)
larger Family-Wise Error Rate (see [this entry](https://github.com/gdlc/STAT_COMP/edit/master/multiple_testing.md ).


Thereofre, when we performed multiple test we often "adjust" the p-values and based our rejection decisions based on adjusted-pvalues. The functio
`p-adjust()` in adjusts p-values using methods that control for FWER (e.g., Bonferroni) as well as False Discovery Rate.



**Bonferroni**

This adjustment is very simple, the p-value is adjusted by dividing the nominal p-values by the number of tests. Rejecction based on the adjusted p-values
would lead a FWER equal to the  chosen significance level, provided that the tests are independent. Otherwise, this would lead to over-conservative test that would have lower power
than what could be achieved if rejecting at a less conservative level.

```r
   # to illustrate I simulate p-values from a mixture of a uniform dist and a beta dist with a 'spike' at small p-values
   nTest=1000
   pValues=ifelse(runif(nTest)<.1,rbeta(n=nTest,shape1=4,shape2=1000),runif(n=nTest))
   hist(pValues,30)
   pAdjust=p.adjust(pValues,method="bonferroni")
```
