## Permutation tests

In previous classes we discuss how to estimate rejection rates using Monte Carlo simulations. When we simulate data from H0, the estimate rejection rate is an estimate of the Type-I error rate (i.e., the proability of rejecting the H0 when H0 holds(. When the data is simulated under Ha, the estimated rejection rate is an estimate of power (i.e., the probability of rejecting Ha when H0 holds).

However, simulating data requires making assumptions (e.g., data is normally distributed) that may or may not hold. Here, we will use permutations to approximate the distribution of a test statistics under the null hypothesis. Permutation analysis is done using real data; thus, there is no need to make any assumptions.


#### What should we permute?

Suppose that we have a model of the form $y=\mu+X_1b_1+X_2b_2+e$, and assume we want to test $H_0: b_2=0$ Vs $H_a b_2\neq0$. Assume that our test statistic is the absolute value of the t-statistic.

Our goal is to generate samples for the distribution about the test statistic under the null. Should we permute $y$, $x_2$ or do something else.

Permuting $y$ breaks the association between $y$ and $X_2$ but also breaks the association between $y$ and $X_2$ which is not what we want because hour null says nothing about $b_1$. Permuting $X_2$ alone is better in that it does not break the association between $y$ and $X_2$; however, it breaks the association between $X_1$ and $X_2$.

[Freedman and Lane (1983)](https://www.jstor.org/stable/1391660) proposed an alternative approach. The algorithm is as follows:

  - Fit the full model to obtain the test statistic of interest (this will be later used to compute the permutation p-value).
  - Fit a reduced model, excluding from the model the predictors whose effects you wish to test ($X_2$ n our case). Extract residuals from this model predictions ($yHat_R$) and residuals ($\hat{e}$).
  - Repeat this process a large number of times
    - Permute $\hat{e}$ (let's label it as $\hat{e}_p$, form the data $y^*=$yHat_R$+$\hat{e}_p$.
    - Fit the full model, and extract the test-statistic.
  - Compute a permutation p-value by calculating the proportion of times the test statistic from the full fit ($T$) is greater than the permutation test statistics.

#### Example 1
In the following example we use the [gout data set](https://github.com/gdlc/STAT_COMP/blob/master/DATA/goutData.txt) to approximate the distribution of the absolute value of the z-statistic for age, in a model where we regress serum urate on race sex and age.

```r
fname = 'https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/goutData.txt'
DATA = read.table(fname, header = TRUE)

# Keep complete cases so residual length matches the data
DATA = DATA[complete.cases(DATA[, c("su", "race", "sex", "age")]), ]
n = nrow(DATA)

# Full model
fmF = lm(su ~ race + sex + age, data = DATA)
t_obs = summary(fmF)$coef["age", "t value"]

# Reduced model (H0: coefficient of age = 0)
fmR = lm(su ~ race + sex, data = DATA)
yHatR = fitted(fmR)
eHatR = residuals(fmR)

# Permutation
set.seed(1)
nPerm = 10000
t_perm = rep(NA_real_, nPerm)

for (i in 1:nPerm) {
  DATA$ystar = yHatR + eHatR[sample.int(n)]
  fmP = lm(ystar ~ race + sex + age, data = DATA)
  t_perm[i] = summary(fmP)$coef["age", "t value"]
}
```

**Permutation p-value (two-sided)**


```r
p_perm = mean(abs(t_perm) >= abs(t_obs)) 
p_perm2 = (1 + sum(abs(t_perm) >= abs(t_obs))) / (1 + nPerm) # this can be used to get 0 p-value
summary(fmF)
```


Note that in Example 1 we permuted the response. This breaks the relationship between the response an all the predictors. An alternative it to simply permute 
### Permutation test for tests involving more than 1 DF

Consider the following logistic regression model where we regresse gout (0/1) on serum urate (su), sex, race, and age.

```r
 fname='https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/goutData.txt'
 DATA=read.table(fname,header=T)
 DATA$gout=ifelse(DATA$gout=='Y',1,0)

 # fitting the model without doing any permutation
 fmA=glm(gout~su+race+sex+age,data=DATA,family='binomial')
 summary(fmA)
```

Suppose we want to test H0: neither sex nor race have an effect Vs Ha: either sex, or race, or both have an effect on the probability of developing gout. Formally, in the above model H0: b2=b3=0 Vs Ha: either b2 or b3, or both are different than zero. This test involves 2 parameters (i.e., 2DF) because the null imposes two restrictions. We can test these hypothesis using a liklihood ratio test. To implement this, we fit the model under H0 (`gout~su+age`) and under HA (`gout~su+race+sex+age`). 

**Asymptotic null distribution of the LRT statistic**: The likelihood ratio test statistic is 2*(logLik(HA)-logLik(H0)). In large samples, and under regularity conditions, when H0 holds the LRT statistic follows a chi-square distirbution with DF equal to the number of restrictions imposed by the null (2DF in this case).

```r
 fm0=glm(gout~su+age,data=DATA,family='binomial')
  
 LRT_stat=2*(logLik(fmA)-logLik(fm0))
 pchisq(df=2,q=LRT_stat,lower.tail=FALSE)
  
 # or use...
  anova(fmA,fm0,test='Chisq')
```

**Permutation-based pvalue for more than 1 DF**

The same approach can be used dropping, in the reduced model, all the predictors we are testing, then repeating the process described above saving likelihood ratio test or F-tst from the full vs short model and comparing it with the permutation F-statistic (this is a one-sided test).


**Logistic regression**

In logistic regression and other models we cannot form $y^*$ by adding predictions plus residuals. In this case we can use an alternative approach which replaces the predictors whose effects we want to test (e.g. age) with residuals from the regression of that predictor on all the other predictors. 

**Some useful references**

 - Freedman, D., & Lane, D. (1983). A nonstochastic interpretation of reported significance levels. Journal of Business & Economic Statistics, 1(4), 292-298.
 - Anderson, M. J., & Robinson, J. (2001). Permutation tests for linear models. Australian & New Zealand Journal of Statistics, 43(1), 75-88.
 - Winkler, A. M., Ridgway, G. R., Webster, M. A., Smith, S. M., & Nichols, T. E. (2014). Permutation inference for the general linear model. NeuroImage, 92, 381-397.
 - Hemerik, J., Goeman, J. J., & Finos, L. (2020). Robust testing in generalized linear models by sign flipping score contributions. Journal of the Royal Statistical Society: Series B, 82(3), 841-864.



[Back](https://github.com/gdlc/STAT_COMP/)
