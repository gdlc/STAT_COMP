## Permutation tests

In previous classes we discuss how to estimate rejection rates using Monte Carlo simulations. When we simulate data from H0, the estimate rejection rate is an estimate of the Type-I error rate (i.e., the proability of rejecting the H0 when H0 holds(. When the data is simulated under Ha, the estimated rejection rate is an esitmate of power (i.e., the probability of rejeccting Ha when H0 hodls).

However, simulating data requires making assumptions (e.g., data is normally distributed) that may or may not hold. Here, we will use permutations to approximate the distribution of a test statistics under the null hypothesis. Permutation analysis is done using real data; thus, there is no need to make any assumptions.

In the following example we use the [gout data set](https://github.com/gdlc/STAT_COMP/blob/master/DATA/goutData.txt) to approximate the distribution of the absolute value of the z-statistic for age, in a model where we regress serum urate on race sex and age.

#### Example 1

```r
fname='https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/goutData.txt'
DATA=read.table(fname,header=T)

nPerm=10000 # number of permuations
z_stat=rep(NA,nPerm)
n=nrow(DATA)
TMP=DATA

for(i in 1:nPerm){
	# permutation index
	  permIndex=sample(1:n,size=n,replace=FALSE)
          TMP$su=TMP$su[permIndex]
	# estimate
	  fm=lm(su~race+sex+age,data=TMP)	  
	# store the test-statistic
	 z_stat[i]=summary(fm)$coef[4,3]
}

hist(z_stat,30)

plot(density(z_stat),main="Permutation distribution of a z-statistic")
x=seq(from=-4,to=4,length=100)
lines(x=x,y=dnorm(x,mean=0,sd=1),col=4,lty=2) # as expected, with this sample size, the z-statistic follows approximately a N(0,1)

```

**Empirical (permutation-based) p-value**

```r
 fm=lm(su~race+sex+age,data=DATA)
 summary(fm)$coef
 
 2*mean(z_stat>summary(fm)$coef[4,3])
```

### Permutiation test for tests involving more than 1 DF

Consider the following logistic regression model where we regresse gout (0/1) on serum urate (su), sex, race, and age.

```r
 fname='https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/goutData.txt'
 DATA=read.table(fname,header=T)
 DATA$gout=ifelse(DATA$gout=='Y',1,0)

 # fitting the model without doing any permutation
 fmA=glm(gout~su+race+sex+age,data=DATA,family='binomial')
 summary(fmA)
```

Suppose we want to test H0: neither sex nor race have an effect Vs Ha: either sex, or race, or both have an effect on the probability of developing gout. Formally, in the above model H0: b2=b3=0 Vs Ha: either b2 or b3, or both are different than zero. This test involves 2 parameters (i.e., 2DF) because the null imposes two restrictions. We can test these hypothesis using a liklihood ratio test. To implement this, we fit the model under H0 (gout~su+age) and under HA (gout~su+race+sex+age). 

**Asymptotic null distribution of the LRT statistic **: The likelihood ratio test statistic is 2*(logLik(HA)-logLik(H0)). In large samples, and under regularity conditions, when H0 holds the LRT statistic follows a chi-square distirbution with DF equal to the number of restrictions imposed by the null (2DF in this case).

```r
 fm0=glm(gout~su+age,data=DATA,family='binomial')
  
 LRT_stat=2*(logLik(fmA)-logLik(fm0))
 pchisq(df=2,q=LRT_stat,lower.tail=FALSE)
  
 # or use...
  anova(fmA,fm0,test='Chisq')
```

**Pemrutation-based pvalue for more than 1 DF**

We can approximate the distribution of the LRT statistic under the null using permutations. 

### Example 2
```r
fname='https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/goutData.txt'
DATA=read.table(fname,header=T)
DATA$gout=ifelse(DATA$gout=='Y',1,0)
# fitting the model without permuting the data
 fmA=glm(gout~su+age+race+sex,data=DATA,family='binomial')
 fm0=glm(gout~su+age,data=DATA,family='binomial')
 
 nRep=10000
 LRT_stat=rep(NA,nRep)
 n=nrow(DATA)
 TMP=DATA

 for(i in 1:nRep){
   permIndex=sample(1:n,size=n,replace=F)
   
   # shuffling data
   TMP$gout=DATA$gout[permIndex]
   tmp=glm(gout~su+race+sex+age,data=TMP,family='binomial')
   LRT_stat[i]=2*(logLik(tmp)-logLik(fm0))
 }

 mean(LRT_stat> (logLik(fmA)-logLik(fm0)))

 anova(fm0,fmA,test='Chisq')

```

### Multiple testing

Suppose that instead of testing one 2DF hypothesis we want to test two hypotheses: 
  
   - H01: sex has no efffect Vs Ha1: sex has an effect on the probability of developing gout
   - H02: ethnicity is not associated to the probabiliyt of developing gout Vs Ha2: there is an association between ethnicity and the probability of developing gout.

The Family-wise error rate (aka experiment wise error rate) is the probability of making at least one mistake (i.e., rejecting H01 when H01 hold or rejecting H02 when H02 hold, or rejecting both H01 and H02 when both nulls hold).

In [today's in-class assigment](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS/INCLASS_17.md) we discuss how to control family-wise error rate in multiple testing problems.

[Back](https://github.com/gdlc/STAT_COMP/)
