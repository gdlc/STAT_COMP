## Quantifvying prediction accuracy and model comparison using cross-validation

Most of our work has so far concentrated on statistical inference including hypothesis testing
and estimation of effects (both point estimates and confidence intervals).
In this module, we will focus on assessing the ability of a model to predict data that was not used to fit the model.

The predictive ability of a model depends on two main factors: 

    i) The proportion of variance of the outcome that the model explains in the population (i.e., if we knew the population effects), and
    ii) The accuracy of the estimated effects (we use a finite sample to estimate effects; thus, in practice, our predictions use estimated effects instead of true effects).
    
The first factor depends on the joint distribution of the outcome and the predictors; this distribution defines population effects and the proportion of variance of the response variable that can be explained by predictors.
The second factor, however, depends on sample size, the estimation procedure, and other aspects that affect the accuracy of estimated effects. The mean-squared error of estimates (MSE=E[(b=bHat)^2]) in turn depends on the variance of estimates and the squared of the bias, that is MSE(bHat)=Var(bHat)+E[b-bHat]^2. Thus, to get accurate estimates of effects we need  to adequately balance bias and variance, in some contexts, some bias can be tolerated if the resulting estimate has considerably lower variance than a competing unbiased estimator.

#### 1) Estimating out-of-sample prediction R-sq.

Our goal is to assess the ability of a fitted model to predict future data. Several metrics could be used to evaluate prediction accuracy; we will focus on proportion of variance explained, that is R2=[PRSS0-PRSS]/PRSS0, where PRSS0 is the prediction sum of squares of a null hypothesis, e.g., an intercept model, 
and PRSS is the prediction sum of squares of the model of interest. 

A standard approach to assess accuracy is to partition our data set into a training and a testing data set. We fit them model to the training data and evaluate
prediction R-sq. in the testing data. The following example illustrates this using the [wages]() data set.

