### Inference in ML


 (1) Create a function `optim_glm_summary=function(Data,y_indx)` which outputs the output with the same format as `summary(fm1)`: For the model that you fit in [INCLASS-9](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS/INCLASS_SOL.md#INCLASS_9), compute the SEs, p-values, and t-statistic using the point estimates obtained with optim, and the Observed Information matirx. Your output should be a table like the one produced by `summary(fm1)` (i.e., the one produced when the summary function is applied to a glm object).

Hints: (i) Review the Inference section in the note on Maximum Likelihood in the Logistic Regression, (ii) You can get the matrix of 2nd order derivatives of the log-likelihood at the MLEs, specifying `hessian=TRUE` in your call to optim. After the model is fitted, you can retrieve the Hessian matrix using `$fm2$hessian`.

 (2) Obtain a p-value for the effect of race (H0 no race effect) using: (i) a Likelihood ratio test, and (ii) Wald's test.


