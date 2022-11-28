These scripts were taken from the handout in [Multipel Testing](https://github.com/gdlc/STAT_COMP/edit/master/HANDOUTS/MultipleTesting.pdf).

**Example 1**

```r
  n=500
  Rsq=0 # use 0 (1) for two independent (perfectly correlated) tests
  nRep=100 # number of MC reps
  
  PVAL=matrix(nrow=nRep,ncol=2,NA)

  for(i in 1:nRep){
    x1=rnorm(n)
    x2=x1*sqrt(Rsq)+rnorm(n,sd=sqrt(1-Rsq))
    
    y=rnorm(n) # both nulls are true
    
    fm1=lm(y~x1)
    fm2=lm(y~x2)
    PVAL[i,1]=summary(fm1)$coef[2,4]
    PVAL[i,2]=summary(fm2)$coef[2,4]    
  }
  
```

Say our target FWER is 0.1, if we do not adjust by multiple testing, we have that the FWER is larger than 0.1

```r
 reject1=PVAL[,1]<0.1
 reject2=PVAL[,2]<0.1
 
 table(reject1,reject2)
 
 FWER=mean(reject1|reject2)
 FWER

```

However, if we use Bonferroni's method the FWER is controled at a level below 0.1.

```r
  reject1=PVAL[,1]<0.1/2
  reject2=PVAL[,2]<0.1/2
  FWER=mean(reject1|reject2)
  FWER
```

If we re-run the example, this time using postively correlated tests (Rsq between predictors of 0.8 in the example below), we have that the FWER is much lower than the target FWER (0.1), this implies that our test could be overly conservative.

**Example 1-B**

```r

 n=500
  Rsq=0.8 # use 0 (1) for two independent ((pefectly correlated) tests
  
  PVAL=matrix(nrow=nRep,ncol=2,NA)
  P.ADJ=PVAL
  P.ADJ.holm=PVAL
  for(i in 1:nRep){
    x1=rnorm(n)
    x2=x1*sqrt(Rsq)+rnorm(n,sd=sqrt(1-Rsq))
    
    y=rnorm(n) # both nulls are true
    
    fm1=lm(y~x1)
    fm2=lm(y~x2)
    PVAL[i,1]=summary(fm1)$coef[2,4]
    PVAL[i,2]=summary(fm2)$coef[2,4]    
    
    P.ADJ[i,]=p.adjust(PVAL[i,],method='bonferroni')
    P.ADJ.holm[i,]=p.adjust(PVAL[i,],method='holm')
  
  }
  
  reject1=PVAL[,1]<0.1/2
  reject2=PVAL[,2]<0.1/2
  FWER=mean(reject1|reject2)
  FWER
```

There are two equivalent ways of applying Bonferroni's method:

  - Used un-adjusted p-values and reject whenever $p-value < \tilde{\alpha}= \alpha/p$ 
  - Adjust the p-values using $pAdj=min(1,pval\times p)$ and reject if  $pAdj < \alpha$.
  
Both procedures are of-course equivalent. The second approachis implemented in the `p.adjust()` function. The use of this function is illustrated in the example presented above. 

#### Holm's method

This method is also implemented in `p.adjust(,method="holm")`.

```{r}
 pVals=c(.1,.2,.015,.01)
 cbind( p.adjust(pVals,method='bonferroni') , p.adjust(pVals,method='holm'))
 
 # Reject?
 cbind( p.adjust(pVals,method='bonferroni') , p.adjust(pVals,method='holm'))<0.05
```

### (3) False discovery rate

Many modern statistical analyses requires conducting a very large number of tests. For instance, in genetic studies we may need to test the association between a phenotype and potentially millions of genetic markers (e.g., single nucleotide polymorphisms, SNPs). When the number of tests is very large, controlling Family-Wise Error Rate (i.e., targeting a very low probability of making at most one mistake) leads to overly conservative tests, thus reducing power. Thus, an alternative is to use a decision rule for rejection that control the expected proportion of mistakes among the discoveries. 

Suppose we test $N=N_1+N_2+N_3+N_4$ hypothesis, and assume the number of true negatives, false positives, false negatives, and true positives are given by $N_1$, $N_2$, $N_3$, and $N_4$, respectively (see **Table 1**). The total number of discoveries is $N_2+N_4$, of these, $N_2$ are false discoveries; thereore, we can define the false discovery proportion as

 - **False Discovery Proportion** is $FDP=N_2/(N_2+N_4)$.
 
The false discovery rate, is the expected value of FDP over conceptual repeated sampling, that is

 - **False Discovery Rate (FDR)** $FDR=E[N_2/(N_2+N_4)]$.

For any given decision rule and data we can obsreve the total number of rejections $N_2+N_4$. At first glance, estimating how many of these are likely to be rejections of true nulls ($N_2$) is not straightoforward because we don't know the true state of nature. However, a simple procedure by [Benjaminy and Hocberg (1995)](https://www.jstor.org/stable/2346101?Search=yes&resultItemClick=true&searchText=Benjamini+Hochberg+1995&searchUri=%2Faction%2FdoBasicSearch%3FQuery%3DBenjamini%2BHochberg%2B1995%26sd%3D1995%26ed%3D1995&ab_segments=0%2Fbasic_SYC-5187_SYC-5188%2F5188&refreqid=fastly-default%3A02b3c43ecacbb777059bbf86c57b7e30&seq=1#metadata_info_tab_contents) can be used to define a decision rule with adequate FDR control.

**Benjamini-Hocberg** (BH) procedure:

 - Sort the p-values from smallest to highest.
 - For the sorted p-values compute $[i/p]\times \alpha$, where $i$ is the order of the p-value ($i=1$ for the smallest p-value), $p$ is the number of tests conducted and $\alpha$ is the FDR-threshold ($\alpha\in[0,1]$).
 - Reject if $pValue[i]<[i/p]\times \alpha$.
 
If all the tests conducted are independent and all originate from null hypothesis, the BH procedure controls FDR at the desired level ($\alpha$); in practice some proportion (typically a very small one when the number of hypothesis tested is very large) of the tests originate from alternative hypothesis. If the proportion of tests that originates from null hypothesis is $\pi_0$ and tests are independent, the BH procedure controls FDR at $\pi_0\alpha<\alpha$. The function `p.adjust(,method='fdr')` adjust p-values using the BH procedure, after adjustment we simply reject for all adjuste p-values $<\alpha$ (e.g., $q=0.05$). The following example illustrates the use of the BH procedure, in the example 5% of the hypothesis originate from $H_a$'s.
 
**Example 2**
 
```{r}
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

If we use a FDR for rejection equal to 0.05, then the false discovery proportion in the single monte carlo replicate was


```{r}
 mean((pADJ.FDR<0.05)[!isHA])
```

Recall that under the null hypothesis, the distribution of the p-values is uniform. What is the empirical distribution of the p-values when some proprotion of the tests originate from alternative hypotheses?  Instead of uniform in this case we see an increase in the frequency of low-pvalues, the majority of which originate from alternative hypothesis.



```{r}
 hist(pVals,30)
```

 
