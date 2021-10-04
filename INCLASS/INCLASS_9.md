### Maximum Likelihood: Estimation and Inference

The [gout data set](https://raw.githubusercontent.com/gdlc/STAT_COMP/master/goutData.txt) contain information on gout (a common form of inflammatory arthritis) sex, race, age and other covariates.

**1)** Use `optim()` to fit a logistic regression of the form `gout~race+sex+age`. Compare your estimates with those reported by `glm()` for the same regression.

Suggestions: 
 - Convert the gout variable (Y/N) into (1 if Yes, 0 if No gout). 
 - Center all the columns of the incidence matrix (X), except the first one. This makes all predictors orthogonal to the vector of 1s (incidence vector for the intercept)
and thus, it facilitates convergence (not centering predictors do not affect regression coefficients).
 - Initialize the intercetp to `mu=log(mean(y)/(1-mean(y))` and all the other regression coefficients to zero.

**2)** Use optim to obtain estimates and SEs, t-statistics and p-values. Compare your results with those of `summary(glm(gout~race+sex+age,family='binomial',...))`.

Suggestion: see [inference](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/LogisticRegression.md/#inference) section.

**3**) What are the log-odds for sex and race?


