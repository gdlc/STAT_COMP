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

The following example illustrates how to use permutation analysis to chose a p-value cutoff that will yield a target Type-I error rate. In the simulation we use the following [genotypes](https://www.dropbox.com/s/jm546thq1jmvgpp/X_100_1K.RData?dl=0).


**Simulating Data**
```r
  load("X_100_1K.RData")
  
  nHA=10
  R2=0.1
  n=nrow(X)
  p=ncol(X)
  
  HAs=sample(1:p,size=nHA)
  b=rep(0,p)
  b[HAs]=rnorm(mean=.2,sd=.1,n=nHA)
  
  signal=X%*%b
  signal=scale(signal)*sqrt(R2)  
  error=rnorm(n,sd=sqrt(1-R2) ) 
  y=signal+error

```


**Task:**

  - Obtain p-values by regressing the simulated phenotype on each of the markers, one at a time, using lm().
  
  - Make a histogram of the p-values.
  
  - Count how many test you would reject at 0.05 if you: (i) do not adjust the p-values, (ii) adjust using Bonferroni and, (iii) adjust using FDR.
  
  - Produce for each critera a table (H0/Ha By Reject/do not Reject).
  


[Back](https://github.com/gdlc/STAT_COMP/)
