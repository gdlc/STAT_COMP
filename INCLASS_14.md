

### Type-I error and power in a linear model

The following code, simulateds data for a linear model of the form `Y=mu+xb+e`.

```r
 N=100
 R2=0.1
 
 x=rnorm(N)
 b=sqrt(R2)
 signal=x*b # var(xb)=var(x)*var(b)=var(x)b^2=R2
 error=rnorm(sd=sqrt(1-R2),n=N) 
 y=signal+error
 
```

**1) Conduct 5,000 Monte Carlo Simulations to estimate the power to detect b!=0.**

Hints:

  - Create a vector (e.g., `reject`) where to store whether you reject/do not reject H0, the length of the vector should be 5,000
  - Inside of a loop, from 1:5000:
     - Simulate a sample (see code above)
     - Fit a linear model y~x using lm
     - Extract the p-value
     - Set `reject[i]=pVal<0.05`
   - The estimated power is the proportion of times you rejected, (i.e., `mean(reject)`).
   
**Proposed solution

```r
 N=100
 R2=0.1
 nReps=5000
 reject=rep(NA,nReps)
 
 for(i in 1:nReps){
  x=rnorm(N)
  b=sqrt(R2)
  signal=x*b # var(xb)=var(x)*var(b)=var(x)b^2=R2
  error=rnorm(sd=sqrt(1-R2),n=N) 
  y=signal+error
 
  fm=lm(y~x)
  reject[i]=summary(fm)$coef[2,4]<0.05
 }
 mean(reject)
 
```
Power is about 88-90%.

**2) Repeat problem 1, using b=0, the proportion of rejections is an estimate of type-I error rate, if p-values (and your code) are correct you should reject ~5% of the times**

Same as above using b=0. Type-I erro rate is approximately correct (we reject at 0.05 and Type-I error rate is 5%) which is not surprising considering that the simulation is conducted under the assumptions required (normality) for the p-value be correct. Note: even if data were not normal the p-values would be approximtely correct if N is large enough (CLT).


