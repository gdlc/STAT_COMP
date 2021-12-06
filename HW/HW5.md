# HW5 (to be completed during in-class time)

In In-class assigments 18 and 19 (see solutions [here](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS/INCLASS_SOL.md#inclass-18) and [here](https://github.com/gdlc/STAT_COMP/blob/master/INCLASS/INCLASS_SOL.md#inclass-19)) we used
Forward Regression (FWD), Ridge Regression (RR), and LASSO to derive a model to predict wheat grain yield using DNA markers. 

In all cases, a sequence of models of increasing complexity was fitted (e.g., from 1 to 200 DF in FWD, or over 100 values of the regularization parameter for the case of RR and LASSO).

For each case, we suggested selecting the model (DF (FWD) or lambda value (RR, LASSO)) that maximized prediction accuracy in the testing set. As we discussed many times in this class, the curves relating prediction accuracy with model complexity are point estimates derived from a single training and a single testing set. To account for sampling variability, we can repeat the excercise over, say 50 training-testing partitions. 

Task:

   - Adapt the code for FWD and LASSO to be fitted over 50 training testing paritions.
   - For each partition, save the curves, the maximum testing correlation, and the number of active predictions (DF in FWD, the number of non-zero effects in LASSO) that leads that maximum.
   - Present:
       - Boxplots of maximum prediction correlation by method,
       - Boxplot of optimal number of active predictors by method.
       - Scatter-plot of the prediction correlation for the FWD and for the LASSO method (each point corresponding to one partition). Add to this plot veritcal lines with the average and the 0.2 and 0.8 quantiles.


