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

Uniform=>Exponential=>Gamma


To test your function we recommend the following:

 - Use your function to generate 100,000 draws of a Gamma RV with shape=5,rate=2.
 - Compute empirical quantiles (e.g., `quantile(x, prob=c(.05,.3,.5,08,.95))` with the corresponding `qgamma()`.
 
## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case) with your function `rgamma2()` we will test it with arbitrary parameters.
