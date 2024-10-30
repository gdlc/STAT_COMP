## IN-CLASS 14: Transformations of RVs

From the network of distributions included in Figure 1 of the [handout](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/SimulatingRandomVariables.pdf) we have that:
  - We can generate exponential random variables by transforming a uniform RV `Y=-log(X)/lambda`.
  - The sum of *r* IID exponential RVs with rate parameter *lambda* follows a Gamma distribution with shape equal to *r* and rate parameter equal to *lambda*.
 
Develop a function 

```r
  rgamma2=function(n,shape,rate){
     ... your code
     return()
  }
```

that will generate *n* IID gamma distributed RVs with the specified shape and rate parameters. Your function should generate the draws from gamma distribution starting from draws from a uniform distribution.


To test your function we recommend the following:

 - Use your function to generate 100,000 draws of a Gamma RV with shape=5,rate=2.
 - Present a histogram of your draws, print the mean and variance of the draws.
 - Generate another set of 100,000 draws using `rgamma(n=100000,rate=2,shape=5)`, produce a histogram for these draws, print the mean and variance of the draws. Compare with the mean and variance of the draws generated using your function.
 




## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case) answering the questions shown below. If you have multiple files to submit, at least one of them is named as `assignment.R`.  You may submit your answer to Gradescope as many times as needed.

Include in your script the definition of the functions `rgamma2()`.

----------------------------

## Suggested extra practice (not included in the in-class assigment)


#### Composition Sampling 

Create a function named `rBivBernoulli.CS=function(PROB,n){ ...return(samples) }` that will generate `n` samples from the bi-variate Bernoulli distribution defined by the obect PROB (a 2x2 matrix with the joint probabilities see table in Example 1 of the [handout](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/SimulatingRandomVariables.pdf) as an example). The function should return a matrix with n rows and 2 columns, column 1 should have the samples of X1 and column 2 the samples of X2.

**Hint**: To implement composition sampling you need to first find (from `PROB`) the marginal distribution of one of the variables, and then the conditional distribution of the other variable. Because both X and Y are {0,1} both distributions must be Bernoulli.

  - P(X=1)=P(X=1|Y=0)+P(X=1|Y=1)
  - P(Y=1|X=0)=p(Y=1 & X=0)/P(X=0) ;  P(Y=1|X=1)=p(Y=1 & X=1)/P(X=1)
  
##### Gibbs sampler

Create a function named `rBivBernoulli.GS=function(PROB,n){ ...return(samples) }` that perform the same task that you implemented in `II` using in this case a Gibbs sampler. 

**Hint**: To implement a Gibbs sampler you will need to find the fully-conditionals P(Y|X) and P(X|Y)

 - P(X=1|Y=0)=p(Y=1 & Y=0)/P(Y=0) ;  P(X=1|Y=1)=p(X=1 & Y=1)/P(Y=1)
 - P(Y=1|X=0)=p(Y=1 & X=0)/P(X=0) ;  P(Y=1|X=1)=p(Y=1 & X=1)/P(X=1)
 
Initialize samples[1,2]=0 (or 1 it should not matter) and then sample samples[1,2], and samples[2,1].....samples[n,2] recursively from the fully conditionals. 



