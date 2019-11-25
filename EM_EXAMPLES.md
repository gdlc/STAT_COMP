
## Expectation-Maximization (EM) algorithm
  - [Handout](https://github.com/gdlc/STAT_COMP/blob/master/EMAlgorithm.pdf)
  - [Dempster, Laird & Rubin, 1977](https://github.com/gdlc/STAT_COMP/blob/master/EM_DempsterLairdRubin1977.pdf)



### Examples from the handout (expanded)



#### (1) Estimating the rate parameter of an exponential distribution using right-censored data


**Simulating right-censored exponential data**

```r
set.seed(195021)
 n=100
 y=rexp(n=n,rate=4)
 # let's consider fixed censoring time
 d=y<0.3 # TRUE here indicate event and FALSE right-censored
 
 yCen=y; yCen[!d]=0.3 # this is the data we observe 
```

**EM-algorithm**

```r
lambda=rep(NA,10) # a vector to store estimates iterations
 lambda[1]=1/mean(y[d]) # initial value (estimate ignoring censoring)
 completeData=y  # this vector stores the 'complete' data
 for(i in 2:length(lambda)){
    # E-step
    completeData[!d]=y[!d]+1/lambda[i-1]
    # M-step
    lambda[i]=1/mean(completeData)
 }
 round(1/lambda,3)

```
#### (2) Using the EM-algorithm to fit a Gausian model with censored data

[INCLASS 10](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS_10.md)

#### (3) Mixed-effects model

 See [handout](https://github.com/gdlc/STAT_COMP/blob/master/EMAlgorithm.pdf) for a derivation of the E and M step in the case of linear mixed effects models 

[INCLASS 11](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS_11.md)
