####  Multiple Testing

In our discussion about [Type-I error rate]() we focus on problems involving a single-hypothesis (e.g., y=mu+xb+e, H0: b=0; Hab!=0).

In practice we test multiple hypothesis simultaneously (e.g., y=mu+x1*b1+x2*b2+e, H01:b1=0; H02: b2=0).

In this context, we define the family-wise (or experiment-wise) error rate as the probability of making at least 1 mistake (e.g., rejecting
H01 or H02 or both, given that H01 and H02 hold).

If the two tests are independent and our goal is to keep the experiment-wise error rate at a level equal to a (e.g, a=0.05), then we should
use a/2 to reject. 

### Bonferroni 

If we conduct `q` indpendent tests and want to achieve a family-wise error rate equal to `alpha`, then each test
must be rejected at a significance level equal to `alpha`/`q`.

**Example 1**

```r

q=3
nRep=10000
n=100
PVALUES=matrix(nrow=nRep,ncol=q,NA)

for(i in 1:nRep){
  X=matrix(nrow=n,ncol=q,data=rnorm(n*q))
  y=rnorm(n)
  fm=lsfit(y=y,x=X)
  PVALUES[i,]=ls.print(fm,print.it=F)[[2]][[1]][,4][-1]
  if(i%%100){ message(i) }
}
mean(PVALUES[,1]<.05)
mean(PVALUES[,2]<.05)

mean(PVALUES[,1]<.05 | PVALUES[,2]<0.05 | PVALUES[,3]< 0.05)
mean(PVALUES[,1]<.05/3 | PVALUES[,2]<0.05/3 | PVALUES[,3]< 0.05/3)

```
#### False Discovery Rate

Many modern statistical analyses requires conducting a very large number of tests. For instance, in genomic studies we may need to test the assocition between a phenotype and potentially millions of genetic markers (e.g., single nucleotide polymorphisms, SNPs). When the number of tests is very large, controlling Falily-Wise Error Rate (FWER, i.e., targeting a very low probability of making at most 1 mistake) leads to overly conservative tests, thus reducing power.

An alternative is to develop decision rules that control the proportion of mistakes among the discoveries. Recall the following table



|           | Do not reject H0  | Reject H0          |
|-----------|-------------------|---------------------|
| H0 holds  | N1 | N2 |
| Ha holds  | N3 | N4  |


The **False Discovery Proportion** is `FDP=N2/(N2+N4)`, and the **False Discovery Rate (FDR)** is the expected value of the FDP over conceptual repeated sampling, that is `FDR=E[N2/(N2+N4)]`.

The  `p.dadjust()` R-function can be used to estimate the false discovery rate from raw p-values. This is illustrated in the following example.

```r
  load('~/Dropbox/STATCOMP/DATA.RData')
  RESULTS=matrix(nrow=ncol(W),ncol=4)
  
  for(i in 1:ncol(W)){
    x=W[,i]
    fm=lsfit(y=y,x=x) # equivalent, but faster than, lm(y~x)
    RESULTS[i,]=ls.print(fm,print.it=F)[[2]][[1]][2,] 
    if(i%%1000==0) message(i)
  }
  
  head(RESULTS)
  
  pValue=RESULTS[,4]
  pB=p.adjust(pValue,method='bonferroni')
  pFDR=p.adjust(pValue,method='fdr')
  
  sum(pB<0.05)
  sum(pFDR<.05)
  
  par(mfrow=c(2,1))
  tmp=pB<0.05
  plot(-log10(pValue),cex=.5,col=ifelse(tmp,2,4))
  
  tmp=pFDR<0.05
  plot(-log10(pValue),cex=.5,col=ifelse(tmp,2,4)) 
```



[DATA](https://www.dropbox.com/s/kf7r72wvqria3r1/DATA.RData?dl=0)


[Main](https://github.com/gdlc/STAT_COMP/blob/master/README.md)
