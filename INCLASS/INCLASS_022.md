### IN-CLASS 22: Forward Regression


Review sections 1-4 of the [handout on high dimensional regression](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/penalizedRegressions.pdf).

Task: Compute and report the prediction R-sq. in testing data for:

 - Full model (i.e., a model regressing `lpsa~.`),
 - Forward regression (i.e., the final model chosen by the `step()` function), and
 - A model accounting for just the effects of the predictors in the Full model that were significant at the `0.05` significance level.
 
To read the data in the R-environment and to partition the data into traing and testing sets use the code presented in the [handout on high dimensional regression](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/penalizedRegressions.pdf).

Return your results in these two objects.

```r
 RES=data.frame(Model=c('Full','Significant','Forward'),RSq=NA)
 bestModel='' # name the best model here, either Full or Significant, or Forward.
```
