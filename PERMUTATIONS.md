## Permutation tests

#### (1) Single Test

We have considered before how to estimate type-I error rate husing simulations. However, the examples we discuss required us to simulate data. Simulating data requires making assumptions that may or may not hold when analyzing real data. In this entry we will consider how to use permutations to esitmate the thershold we should use to reject H0 and achieve a given type-I erro rate. Permutation analysis is done using real data; thus, there is no need to make any assumptions.

The goal in a permutation analysis is to estimate the distirbution of a test statistic under the null hypothesis. To simulate data under the null hypothesis we break the association between response and predictor by permuting the response (or in some cases the predictor). Here is an example.


```r

DATA=read.table("~/Desktop/gout.txt",header=T)

nPerm=10000 # number of permuations
myStat=rep(nPerm)
n=nrow(DATA)
TMP=DATA

for(i in 1:nPerm){
	# permute
	  TMP$age=sample(DATA$age,size=n)	  
	# estimate
	  fm=lm(su~race+sex+age,data=TMP)	  
	# store the test-statistic
	 myStat[i]=summary(fm)$coef[4,3]
}

tmp=quantile(myStat,p=c(.025,.975))
fm=lm(su~race+sex+age,data=DATA)
```




**Suggested problem:** Modify the code to estimate the distribution of the t-statistic for the effect of race
in a logistic regression for gout~race+age+sex+su.



#### (2) Multiple Tests

Suggested reading:  [Sham, Saun & Purcell (2014) and references therein](http://zzz.bwh.harvard.edu/library/statistical-power-NRG-2014-Sham-Purcell.pdf)

The following example illustrates how to use permutation analysis to chose a p-value cutoff that will yield a target Type-I error rate. In the simulation we use the following [genotypes](https://www.dropbox.com/s/muynadym8ojjaf1/X_1K_2K.RData?dl=0). The matrix contains genotypes at 2,000 SNPs (in columns) for 1,000 subjects (rows). We will simulate a phenotype using these genotypes.




**Simulating Data**

The following example simulates a simple phenotype which is affected by 4 of the SNPs (columns 500, 1000, 1500 and 1800). The first two SNPs have large effect (1) and the last two smaller effect (0.3). The phenotype is simualted so that the proportion of variance of the phenotype explained by these 4 SNPs is 10%.


```r
  set.seed(195021)
  load("X_1K_2K.RData")
  
  R2=0.2
  n=nrow(X)
  p=ncol(X)
  
  HAs=c(250,500,1000,1500) # position of the SNPs with causal effects
  isHA=rep(F)
  isHA[HAs]=TRUE
  
  nHA=length(HAs)
  
  
  b=rep(0,p)
  b[HAs]=c(1,1,.5,.5)
  
  signal=X%*%b
  vY=var(signal)/R2
  
 
  error=rnorm(n,sd=sqrt(1-R2)*vY ) 
  y=signal+error

```


**Task:**

  - Obtain p-values by regressing the simulated phenotype on each of the markers, one at a time, using lm().
  
  - Make a histogram of the p-values.
  
  - Count how many test you would reject at 0.05 if you: (i) do not adjust the p-values, (ii) adjust using Bonferroni and, (iii) adjust using FDR.
  
  - Produce a Manhattan plot of the raw-pvalues and add as horizontal lines the rejection criteria for nominal/Bonferroni-adjusted and FDR. `plot(-log10(pValue),cex=.5,col=4,type='o')` and then add as horizontal lines the raw-p-value that is used as threshod under each of the criteria.
  


[Back](https://github.com/gdlc/STAT_COMP/)
