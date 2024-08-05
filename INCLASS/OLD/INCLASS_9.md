### 9A: Logistic Regression

The [gout data set](https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/goutData.txt) contain information on gout (a common form of inflammatory arthritis) sex, race, age and other covariates. Alternative link: https://github.com/gdlc/STAT_COMP/raw/master/DATA/gout.Rdata . You may directly download `gout.Rdata` and load it. In GradeScope, we will provide this file.

**Use `glm()` to fit a logistic regression of the form `gout~race+sex+age`**:
  - Fit the model
  - Convert the gout variable (Y/N) into (1 if Yes, 0 if No gout).
  - Summarize your findings
  - Test each of the factors (race/sex/age) separately using likelihood ratio test. To do this, for each factor, fit the model without that factor (H0), extract the log-likelihood (logLik(H0)), determine the DF (difference in the number of paramters between H0 and HA (the full model that you fitted before) and compute a p-value using `pchisq()`, compare your results with: (i) the pvalues from summary(HA), and with those of (ii) anova(H0,HA) which implements likelhood ratio test (the pvalues from anova() should be identical, up to rounding errors, to the ones you obtained. 

Store all the results into dataframe `gout_glm`. There are three rows and the following columns:
 - factor: name of the facros to be removed from H0.
 - p_value_summary: p-value of the summary.
 - p_value_lrt: p-value of the likelihood ratio test.
 - p_value_anova: p-value of the anova test.

**Hint**
 - Don't forget to specify family='binomial'! 

#### 9B: Fit the logistic regression model using optim()

Your goal would be to produce a table similar tot he one returned by summary(glm()) using optim()

(1) Create a function `neglog = function(beta, Data, y_indx, x_indx)` which calculates and outputs the negative log-likelihood of the data given current parameter `beta`. 
 - `beta`: During the optimization, we search the update for `beta` given the `beta` in the current training iteration.
 - `Data`: the data matrix.
 - `y_indx`: the column index of y in `Data`.
 - `x_indx`: the vector of column index of x to be used in the likelihood calculation in `Data`.
 - We assume that there is no intercept term (i.e., a column with all 1) in the matrix `Data`.

(2) Then, create a function `glm_optim = function(Data, y_indx)` which performs optimization to maximize the log-likelihood, and outputs a dataframe with the following outputs:
 - `estimate`: coefficient estimates.
 - `std.error`: standard error.
 - `z_value`: test statistics.
 - `p_value`: p-value.

Notes:
 - Center all the columns of the incidence matrix (X), except the first one. This makes all predictors orthogonal to the vector of 1s (incidence vector for the intercept) and thus, it facilitates convergence (not centering predictors do not affect regression coefficients).
 - Initialize the intercetp to `mu=log(mean(y)/(1-mean(y))` and all the other regression coefficients to zero.
