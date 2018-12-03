# Expectation-Maximization (EM) Algorithm examples


### (1) Estimating the rate parameter of an exponential distribution using right-censored data


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





[Back](https://github.com/gdlc/STAT_COMP/)
