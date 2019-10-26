## HW: Simulation of Random Variables (RVs)

**(Due Sat Nov. 2nd in D2L)**

Please upload a single file containing the code, outputs and comments (preferable a pdf or html created using R Markdown).

#### 1. Inverste probability method

Generate 50,000 samples from a gamma distributed RV with rate=2 and shape=2. Display a histogram with veritcal lines indicating: (1) 
empirical quantiles (in read for prob 0.1,0.2,...,0.9) and the true quantiles for the distribution (in blue can use `qgamma`) for the same probabilities.


#### 2. Composition Sampling (the t-distribution)

Let (xi,yi) follow a bi-variate distribution such that p(xi)=dchisq(df=4) and p(yi|xi)=dnorm(mean=0,sd=sqrt(1/xi)). 

2.1. Use composition sampling to generate 50,000 samples for the pair.

2.2. Present a density plot of y, overlap over it a density plot of a normally distributed RV with mean equal to 0 and variance equalt to var(y). What differences do you see?

2.3. Repat 2.1 and 2.2 with df=100. Compare your results with those obtained with df=4.

#### 3. Composition Sampling in the Multivariate Normal (MVN) distribution.

Let `x=(x1,x2,x3)` be a MVN random vector with mean E[x1]=1, E[x2]=2, E[x3]=0 and (co)variance matrix

|   |   |   |
| ------------- |-------------| -----|
| 1.0 | 0.2 | 0.3|
| 0.2| 1.2 | 0.1 |
| 0.3 | 0.1 | 2.0 |


3.1. Compute and report E[X2|X1=x1] and Var[X2|X1=x1], and E[X3|X1=x1,X2=x2] and Var[X3|X1=x1,X2=x1].

3.2. Use the above results to generate a composition sampling algorithm to generate 30,000 samples of `x=(x1,x2,x3)`. Report the empirical mean and empirical (co)variance matrix and compare it with the tarteg mean and (co)variance matrix.


