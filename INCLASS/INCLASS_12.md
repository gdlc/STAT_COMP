### IN-CLASS 12: 

## I: Transformations of RVs

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

 - Use your function to generate 100,000 draws of a Gamma RV with shape=5,rate=2.
 - Present a histogram of your draws, print the mean and variance of the draws.
 - Generate another set of 100,000 draws using `rgamma(n=100000,rate=2,shape=5)`, produce a histogram for these draws, print the mean and variance of the draws. Compare with the mean and variance of the draws generated using your function.
 

## II: Composition Sampling and Gibbs Sampling

Draw 100,000 samples from the bi-varaite Bernoulli in the Table in section 2.1 of the [handout](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/SimulatingRandomVariables.pdf) on sampling
random variables, using the algorithms described in Box 1 and Box 2 of the handout.


#### Compostion sampling

We find the marginal distribution of X and the conditional distribution of Y|X. Because both X and Y are {0,1} both distributions must be Bernoulli.

  - P(X=1)=P(X=1|Y=0)+P(X=1|Y=1)
  - P(Y=1|X=0)=p(Y=1 & X=0)/P(X=0) ;  P(Y=1|X=1)=p(Y=1 & X=1)/P(X=1)
  



#### Gibbs sampler

We first find the fully-conditionals P(Y|X) and P(X|Y)

 - P(X=1|Y=0)=p(Y=1 & Y=0)/P(Y=0) ;  P(X=1|Y=1)=p(X=1 & Y=1)/P(Y=1)
 - P(Y=1|X=0)=p(Y=1 & X=0)/P(X=0) ;  P(Y=1|X=1)=p(Y=1 & X=1)/P(X=1)
 
Then we sample recursively usinge these distributions.
