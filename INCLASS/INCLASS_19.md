
## In-class assigment 19

Using the example presented in the penalized regression [handout](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/penalizedRegressions.pdf) perofrm the following analyses:

  - Split the data into a training and a testing set using the `train` variable.
  - Fit forward regression to the training data, for each model in the sequence evaluate the squared correlation between predictions and lpsa in the testing set.
  - Fit lasso to the training data, for each value of the penalization parameter evaluate the squared correlation between predictions and lpsa in the testing set.
  - Select the best forward regression and the best lasso model based on prediction accuracy. Which model performed better?
