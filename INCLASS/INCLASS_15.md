

### Type-I error and power in a linear model

The following code, simulateds data for a linear model of the form `Y=mu+xb+e`.

```r
 N=100
 b=1
 signal_to_noise_ratio=0.1
 x=rnorm(N)
 signal=100+x*b 
 vE=var(signal)/signal_to_noise_ratio
 error=rnorm(sd=sqrt(vE),n=N) 
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
   


**2) Evaluating the effect of sample size and of the signal_to_noise ratio on power

Estimate power for the following scenarios

```r
  SCEN=expand.grid(n=c(10,30,50,100,200),SNR=c(.05,.1,.15),b=1,power=NA) # SNR=signal_to_noise_ratio
```

Hint: 
 
 - Add an outter loop to the code you developed for Question 1. 
 - In each of the round of the loop set N, b, and SNR to the values corresponding to the scenario.
 - Save the estimated power in SCEN$pwr
 - To plot your results you can use this code

```r
 library(ggplot2)
 p=ggplot(SCEN,aes(x=n,y=power,group=SNR))+
     geom_point(aes(color=SNR))+
     geom_line(aes(color=SNR,linetype=SNR))+
     ylim(c(0,1))

 plot(p)
```

