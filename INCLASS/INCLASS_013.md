## INCLASS 13: Non-linear least squares using optim

Create a function that:

   - Estimates the parameters of a logistic growth curve by least squares using optim
   - Retutn a table similar to that of `summary(nls())`
   - Your function should take three arguments {y, x, data }.
      

Suggestions:

  - First, create a function to evaluate the logistic growth model `logisCurve=function(x,Asym,xmid,scal){}`
  - Create a function to evaluate the RSS, `RSS=function(y,x,Asym, xmid,scal){}`
  - Create a function to fit the model, `fitLogisCurve=function(y,x){}`
  
Internally, consider using `getInitial()` to obtain initial values.
