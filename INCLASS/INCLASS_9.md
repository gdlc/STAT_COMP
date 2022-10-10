### 9A: Logistic Regression

The [gout data set](https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/goutData.txt) contain information on gout (a common form of inflammatory arthritis) sex, race, age and other covariates.

**  Use `glm()` to fit a logistic regression of the form `gout~race+sex+age`**:
  - Fit the model
  - Summarize your findings
  - Test each of the factors (race/sex/age) separately using likelihood ratio test. To do this, for each factor, fit the model without that factor (H0), extract the log-likelihood (logLik(H0)), determine the DF (difference in the number of paramters between H0 and HA (the full model that you fitted before) and compute a p-value using `pchisq()`, compare your results with: (i) the pvalues from summary(HA), and with those of (ii) anova(H0,HA) which implements likelhood ratio test (the pvalues from anova() should be identical, up to rounding errors, to the ones you obtained. 

Suggestions: 
 - Convert the gout variable (Y/N) into (1 if Yes, 0 if No gout).
 - Don't forget to specify family='binomial'! 

#### 9B: Fit the logistic regression model using optim()

Your goal would be to produce a table similar tot he one returned by summary(glm()) using optim()

Suggestions:

 - Center all the columns of the incidence matrix (X), except the first one. This makes all predictors orthogonal to the vector of 1s (incidence vector for the intercept)
and thus, it facilitates convergence (not centering predictors do not affect regression coefficients).
 - Initialize the intercetp to `mu=log(mean(y)/(1-mean(y))` and all the other regression coefficients to zero.
