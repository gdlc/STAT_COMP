## HW: Simulation of Random Variables (RVs)

Due on D2L Mond 7th @ noon. 1 file per sumbission (please sumbit either doc, pdf or html from R-markdown) showing the code, 
results and your interpretation of results, all in the same file. Printed copy in my EPI Mailbox (6th floor West Fee Hall).

#### 1. Inverste probability method

Generate 50,000 samples from a gamma distributed RV with rate=2 and shape=2. Display a histogram with veritcal lines indicating: (1) 
empirical quantiles (in read for prob 0.1,0.2,...,0.9) and the true quantiles for the distribution (in blue can use `qgamma`) for the same probabilities.


#### 2. Composition Sampling (the t-distribution)

Let (xi,yi) follow a bi-variate distribution such that p(xi)=dchisq(df=4) and p(yi|xi)=dmean(mean=0,sd=sqrt(1/xi)). 

2.1. Use composition sampling to generate 50,000 samples for the pair.

2.2. Present a density plot of y, overlap over it a density plot of a normally distributed RV with mean equal to 0 and variance equalt to var(y). What differences do you see?


#### 3. Composition Sampling in the Multivariate Normal (MVN) distribution.

Let `x=(x1,x2,x3)` be a MVN random vector with mean E[x1]=1, E[x2]=2, E[x3]=0 and (co)variance matrix


| 1 | 0.2 | 0.3|
| 0.2| 1.2 | 0.1 |
| 0.3 | 0.1 | 2 |

 Tables        | Are           | Cool  |
| ------------- |-------------| -----|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |

