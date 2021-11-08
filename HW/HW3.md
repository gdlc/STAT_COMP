
## HW3: Power Analysis

Due Tr Nov 19th in D2L. One file per sumbission (please sumbit either doc, pdf or html from R-markdown) showing the code, results and your interpretation of results, all in the same file.

### 1. Power analysis: main effects

**Research Goal**:  to estimate the effect of Body Mass Index (BMI) on Systolic Blood Pressure (SBP), while accounting by sex differences.

Sex differences can take the form of a main effect of sex on SBP or an interaction between sex and BMI.


Baseline model:  SBP~BMI+SEX

Design: a total of N subjects (N/2 men and N/2 women) will be recruited, for each subject SBP and BMI will be measured.


**Task**: to produce power curves (power versus sample size) by effect size (see below).

**Simulation setting**.
  * Equal proportion in the sample of male and female.
  * Simulate BMI assuming `p(BMI|Sex=Female)=normal(mean=26.5,variance=30)` and `p(BMI|Sex=Male)=normal(mean=27.4,variance=16.7)`. 
  * Simulate your response using `SBP=mu+M*b1+Z*b2+error` where mu=120, M is a dummy variable for Male,  b1=-3, Z =BMI-mean(BMI) (note since there are equal numbers of male and female, mean(BMI) is just the average BMI of male and female).
  * Aassume an error variance of 300.
	
**Estimation**: For estimation purposes use `lm()` to regress SBP on Sex and centered BMI. Consider rejection consider a Type-I error rate of 0.05.

**1.1.** Use Monte Carlo Methods (at least 5000 replicates) to estimate power curves (power versus sample size, N=30,50,100,200,500,1000,3000) by effect size (b2=0,0.2, 0.3 and 0.5 ).
 
**1.2.** What is the minimum sample size needed to achieve a power of at least 80% if the effect size is 0.3?

### 2. Power Analysis: interaction effects

Assume that the effect of BMI on SBP is higher (0.4) in male than in female (0.2). Develop a MC estudy to estimate the power
to detect this interaction as a function of sample size (go up to N=10,000). Suggestion: extend the baseline model by adding a sex by BMI interaction and assess the power to detect an interaction of the size above-specified.

**Q**: Can a power of at least 50% be achieved with a sample size <= 10,000?


**Tips**:

  - To generate all possible combinations of scenarios you can use `expand.grid()`

```r
 N=c(30,50,100,200,500,1000,3000)
 b=c(0,0.2, 0.3, 0.5)
 PAR=expand.grid(N=N,b=b)
 PAR
```

 - Then, you can add a clumn to save the estimated rejection rate for each scenario

```r
 PAR$rejRate=NA
```

 - To conduct your MC study, you will loop over scenarios, with an inner loop for MC replicates, here is a template

```r
 for(s in 1:nrow(PAR)){
   n=PAR$N[s]
   b2=PAR$b[s]
   
   rejects=rep(NA,nRep)
   for(i in 1:nRep){
      # Simulate data using the parameters for the s-scenario
      # Apply the decision rule
      rejects[i]=pVal<0.05
   }
   
   # Estimate rejection rate
   PAR$rejRate[s]=mean(rejects)
 
 }

```
