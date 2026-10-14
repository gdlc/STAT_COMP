## INCLASS 13: Non-linear least squares using optim

Create a function that:

   - Estimates the parameters of a logistic growth curve by least squares using optim
   - Retutn a table similar to that of `summary(nls())`
   - Your function should take three arguments {y, x, data }.
      

Suggestions:

  - First, create a function to evaluate the logistic growth model `logisCurve=function(x,Asym,xmid,scal){}`
  - Create a function to evaluate the RSS, `RSS=function(y,x,theta){}` where `theta=c(Asym,xmid,scal)` is a vector with the parameters of the model. 
  - Create a function to fit the model, `fitLogisCurve=function(y,x){}`
  - Within that function you will need to get initial values and pass it to optim as starting values `optim(fn=,y=y,x=x, par=start)`
  - Consider using `getInitial()` to obtain initial values. Here is an example of getInitials

  - In your optim call use `hessian=TRUE`
  - Once you get the Hessian, and invert it, you will need to scale it by multiplying it by `2*varE`, ` V = 2 * varE * solve(fm$hessian)`
  - To estimate  `varE`, you can get the RSS from optim, and divide it by n-p where p is the number of paramters, that is `varE`=fm$value/(n-p`.
  

**Submission to Gradescope**

For your submission to grade scope provide an R-script named `assignment.R` (match case) answering the questions shown below.

Include in your script the definition of the functions `fitLogisCurve()` and all the functions that are interally used. We will test your function with an arbitrary example. 




