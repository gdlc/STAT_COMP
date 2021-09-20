## Homework 1


Recall the [Gout](https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/goutData.txt) data set and consider a regression of the form: `fm1: su~race+sex+age`.

**1)** Fit the model, report results, and summarize in no more than three sentences your conclusions.

**2)** Consider now expanding the model to inclue race-by-sex interactions. What is the interaction modeling? Fit the model (`fm2<-lm(su~race+race*sex+age)`), report your results and conclusions.

**3)** Consider now testing the hypothesis that sex has any effect on su, that is whether sex has an effect that is the same for white and black people, or an effect that is different in black and white people. To test this hypothesis, you should compare the model `fm2` with a null model that does not include sex, e.g., `fm0: su~race+age`. This test involves 2df because we impose the restriction that the main and interaction effects involving sex are equal to zero. You can test this hypothesis using `anova(fm0,fm2)`. Conduct the test, report the results, and summarize your conclusions in no more than 2 sentences directly related to the hypothesis being tested.

**4)** Reproducing the results of the F-test: Review the F-statistic in the [class notes](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/OLS.pdf) and develop a function that takes as input two `lm` objects and return a table identical to the one produced by `anova()`.

**5)** Wald's test (also a test for contrasts)

Wald's test can also be used for testing tests involving 1 or more than 1 df. The general form of the test is as follows:

  - **Ha**: **y=Xb+e** (for this case use the model fitted in 1.3). Here, **y** is a nx1 vector (the *response*), **X** is an nxp incidence matrix for the pxy vector of effects **b**, and **e** is an nx1 error vector.
  - **Ho**:  **Tb=a**, where  **T** is a contrast matrix of dimensions qxp, and **a** is a qx1 vector (often **a=0**.

The covariance matrix of the contrast (**Tb**) is **TCov(b)T'**, where **Cov(b)** is the (co)variance matrix of estimates (vcov(fm), where fm is the fitted alternative hypothesis). Under the CLT, **TbHat** follows a multivariate normal distribution with (co)variance amtrix **TCov(b)T'**. Under the null, assuming **a=0**, the expected value of **Tb=0**. Therefore, undre the null, **bHat'[K]bHat** follows a chi-square distribution with df equal to the rank of **T**. Here, **S** is the inverse of **TCov(b)T'**.

Implement Wald's test for the test in 1.3, compare your p-value with that of the F-test.





