### Estimating a 95% confidence band for predicted probabilities from logistic regression using bootstrap


   1. Using the [gout data set](https://raw.githubusercontent.com/gdlc/STAT_COMP/master/goutData.txt) fit a logistic regression `gout~serum urate`
   2. Use the fitted model to produce a curve predicting probability of developing gout for `su=seq(from=3,to=12,by=.05)`. Hint: use `predict(fm,newdata=data.frame(su=seq(from=3,to=12,by=.05)),type='response')`
   3. Plot Predicted probability versus serum urate levels (hint: sort both predictions and su by su using order(su) as indexing variable.
   4. Generate 1000 bootstrap samples of the predicted curve and use this to generate as 95% confidence band for the predicted probability of developing gout.
   5. Report a plot with the estimated curve (from #2) and the 95% confidence band.
