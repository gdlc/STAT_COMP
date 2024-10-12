 ### IN-CLASS 17: Permutation analysis in multiple testing problems 

Many problems involve testing multiple hypothesis. For example, in a linear model of the form;

```math
Y = a + X_1b_1 + X_2b_2 + X_3b_3 + \epsilon
```

We may want to test: $`H_{01}: b_1 = 0`$ vs $`H_{A1}: b_1!=0, H_{02}: b_2=0`$ vs $`H_{A2}: b_2!=0`$, and $`H_{03}: b_3=0`$ vs $`H_{A3}: b_3!=0`$ (note that here we are testing three hypothesis, this is different than testing  $`H_0: b_1=b_2=b_3=0`$ vs $`H_A`$: at least one of the b's different than zero).

A Type-I error rate occurs when we reject a null that holds. In multiple testing, a standard approach is to control the probability of making at least one mistake (i.e., wrongly rejecting one ore more null that holds). 

How do we use permutations to control the probability of making at least one mistake? 

One possible approach is as follows

  1) Generate a permutation data set,
  2) Extract the pvalues for each of the tests,
  3) Store the minimum pvalue (note: since this is a permutation data set, the minimum p-value would be the one that if you use it as your threshold would lead to 1 mistake beacuse indeed in the permuted data all the nulls hold).
  4) Repeat 1-3 a large number of times, always saving the lowest pvalue.

After completing the above steps you will have a vector holding values of the minimum pvalue. If you want to control the probability of making one mistake at the 0.05 level, then choose the 0.05 empirical percentile of the minimum pvalues as your threshold for rejection.

## 1) Permutation Analysis

Use the following symulated data set to estimate the threshold using permutations that you should use to control the probability of making at least 1 mistake smaller or equal than 0.1.

```r 
 set.seed(1950)
 X=matrix(nrow=1000,ncol=3,rbinom(size=2,n=3000,prob=0.2))
 b=c(1,0,1)
 signal=scale(X%*%b)*sqrt(0.1)
 error=rnorm(nrow(X),sd=sqrt(0.8))
 y=signal+error
 fm=lm(y~X)
```

- Our objective is to test for the three coefficients (not the intercept) using a pvalue threshold that will control the probability of making at least one mistake at a level of 0.05.
- Use the above simulation and  10,000 permuations to estimate the threshold.
- Hints:
     - Create a vector with 10,000 entries `permPval=rep(NA,10000)`
     - For each permutation, store the minimum p-value of three coeffiecnts in the corresponding entry of `permPval`. (do not inlcude the pvalue for the intercept, e.g., use `min(summary(lm(permY~X))$coef[-1,4])`)
     - To obtain a permuatation pvalue cutoff, find the 0.05 quantile of `permPval` and store it in `pvalThreshold` .
     - Is the threshold you found larger, similar, or smaller than the nominal threhsold 0.05? Why?

## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case).

Your script should contain the `permPVal` vector and a variable named `pvalThreshold` which if used for testing, controls the probability of making at least 1 mistake at most 0.05.



