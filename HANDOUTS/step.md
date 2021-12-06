The step function can be used for stepwise regression (forward regression, backward elimination, and both directions).

The function takes three main arguments:

  - An initial model (e.g., an intercept-only model)
  - Scope: this model defines the upper bound ont he search, step will search models in between the initial one and the upper bound.
  - Direction: whether to search forward, backawrd, or both.
    
    
 Here is an example with the gout data set.
 
 
 ```r
   DATA=read.table('https://raw.githubusercontent.com/gdlc/STAT_COMP/master/DATA/goutData.txt',header=T)
   head(DATA)
   
   fm0=lm(su~1,data=DATA) # intercept
   
   #Say the most complex model we want is su~ sex + race + age + sex*race + sex*age + race*age 
   
   upperBound=as.formula(su~ sex + race + age + sex*race + sex*age + race*age )
   
   FMStep=step(fm0,direction='forward',scope=upperBound)
 ```
 
 In this case step will search forward, trying to minimize AIC (see help(step) argument scale for more options).
 
 `fm0` had an AIC equal to 390.04
 
 It tried adding one predictor at a time, and the one that gave the highest reduction in AIC was race, then, the second model in the path was su~race, the BIC of
 this model was 300.29 (a sizable reduction relative to fm0, thus a very good improvment for AIC).
 
 Starting from the second model (su~race) it tried adding one predictor at a time, and it found that the best choice was to add age. Thus, the
 third model in the search was su~race+age.
 
 It then evaluated adding sex, and the interaction sex:race, it found that adding sex gave the lowest AIC, it added sex. Thus, the fourth model was surace~sex+age.
 
 Finally, it tried added other interactions and none of the interactions reduced the AIC.
 
 Thus, the final model was:  `su~sex+age+race` (see FMStep object).
 
 Note: it appears that the `step()` function evaluates including interactions only among predictors that were already included in the  model (i.e., it did not consider adding interactions wtihout main effects).
 
 
