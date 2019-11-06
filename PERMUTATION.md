## Permutation tests

We have considered before how to estimate type-I error rate husing simulations. 
However, simulating data requires making assumptions that may or may not hold. Here, we will consider how to use permutations to esitmate the thershold we should use to reject H0 and achieve a given type-I erro rate. Permutation analysis is done using real data; thus, there is no need to make any assumptions.

The goal in a permutation analysis is to estimate the distirbution of a test statistic under the null hypothesis. To simulate data under the null hypothesis we break the association between response and predictor by permuting the response (or in some cases the predictor). 

In the following example we use the [gout data set]() to approximate the distribution of an statistic (the absolute value of the z-statistic for age, in a model where we regress serum urate on race sex and age).

```r

DATA=read.table("~/Desktop/gout.txt",header=T)

nPerm=10000 # number of permuations
z_stat=rep(NA,nPerm)
n=nrow(DATA)
TMP=DATA

for(i in 1:nPerm){
	# permute
	  TMP$age=sample(DATA$age,size=n) # permuting age while keeping the other variables un-touched.
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

**Suggested problem:** Modify the code to estimate the distribution of the x-statistic for the effect of race
in a logistic regression for gout~race+age+sex+su.


[Back](https://github.com/gdlc/STAT_COMP/)
