## In-Class assigment 8

Using the following sumulation, estimate the mean-suqared error of estimation of the function f() at `x=[1,2,3,4]` for cubic splines with `DF=[2,4,6,10,20]`.

Recall that the Mean-squared error of an estimator (say fHat) is defined as `MSE=E[ (f-fHat)^2]`. In our case, we want to estimate the MSE at f(1), f(2),...,f(6).

You should report a table with MSE for each of the values of x listed above in rows, and DF in columns, e.g.,


| X  |  DF=2 | DF=4 |DF=6 |DF=10 | DF=20 |
|----- |-----    | -----  | ----- |-----   | -----      |
| 1  |       |      |     |      |       |
| 2  |       |      |     |      |       |
| 3  |       |      |     |      |       |
| 4  |       |      |     |      |       |

##### Suggested Monte Carlo Simulation

In a Monte-Carlo Simulation we simulate data (multiple-times) to approximate features of the sample distribution of an estimator. For example, here we suggest you use a Monte-Carlo 
simulation to estimate `MSE=E[(f-fHat)^2]`.

To do this, first develop a code that will estimate the squared-error `(f-fHat)^2` for one simulated data set. Once this code is working, embed your dode in a loop (say `for(mcRep in 1:1000){}`), add the squared
errors across Monte Carlo simulations, and divide by the number of simulations (e.g., `1000`), that would porvide a MC-estimate of the MSE.

Some ideas to help develop your simulation

 - Use the code provided below to simulate data.
 
```r
 x<-seq(from=0, to=2*pi,by=0.2)
 f0<-function(x){ 100+sin(2*x)+cos(x/2) }
 R2<-2/3
 y<-f0(x)+rnorm(n=length(x),sd=sqrt(var(f0(x))*(1-R2)/R2))
 plot(y~x)
 lines(x=x,y=f0(x),col='red',lwd=2) 
```
 - Fit natural splines with 2, 4, ...20DF. For example, for 4 DF you can use
 
 ```r
  library(splines)
  X=ns(x=x,df=4,intercept=TRUE)
  fm=lm(y~X-1)
 ```

 - For each of the splines compute the squared error (f-fHat)^2 using a code like the one provided here
 
 ```r
  # Note: here we evaluate the same spline used to fit the model at the points we want to predict x=1:4
  #       To do this we extract the paramters that defined the spline from `X`.
  XNew=ns(x=1:4,knots=attr(X,"knots"),Boundary.knots=attr(X,"Boundary.knots"),intercept=attr(X,"intercept"))
  fHat=XNew%*%coef(fm)
  
  # Squared-error
  (f0(x=1:4)-fHat)^2
 ```
 
 - At this point you have a point estimated of the MSE at f(1), f(2),... Repeat the process for each of the requested DF, store the squared error in a matrix.

 - Now repeat all the steps described above 1,000 times to compute the average squared-error for each spline and each point.
 
 
