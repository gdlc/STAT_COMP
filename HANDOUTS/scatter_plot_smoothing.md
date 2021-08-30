
In this entry we discuss the problem of estimating a conditional expectation function, E[y|x]=f(x,b).

For that purpouse we will use the following simulation

```r
 set.seed(195021)
 x<-seq(from=0, to=2*pi,by=0.2)
 f0<-function(x){ 100+sin(2*x)+cos(x/2) }
 R2<-2/3
 y<-f0(x)+rnorm(n=length(x),sd=sqrt(var(f0(x))*(1-R2)/R2))
 plot(y~x)
 lines(x=x,y=f0(x),col='red',lwd=2)
```

#### Linear model

Let's start with a linear approximation...

```r
 par(mfrow=c(2,2)) # creates 2x2 panel of plots
 fmL=lm(y~x)
 plot(y~x,main='Linear')
 lines(x=x,y=f0(x),col='red',lwd=2)
 lines(x=x,y=predict(fmL),col='blue',lwd=2)

 ```
 
 #### Linear regression on non-linear basis functions
 
 We can use non-linear functions of `x` to define much more general classes of functions; for example, polynomials. 
 
 **Polynomials**

```r
 fmPoly=lm(y~x+I(x^2)+I(x^3)+I(x^4))
 plot(y~x,main='Cubic Polynomial')
 lines(x=x,y=f0(x),col='red',lwd=2)
 lines(x=x,y=predict(fmPoly),col='blue',lwd=2)

```

**Other global basis functions**

In this example, we build a linear space by combining several linearly-independent, non-linear functions of `x` such as the sine, cosine, and logarithm.

```r
 x1=x
 x2=log(x+1)
 x3=sin(x)
 x4=cos(x/2)
 fm2=lm(y~x1+x2+x3+x4)
 plot(y~x,main='Several non-linear functions')
 lines(x=x,y=f0(x),col='red',lwd=2)
 lines(x=x,y=predict(fm2),col='blue',lwd=2)
```

#### Local Basis Functions

In the previous examples we use global basis functions to build a linear space and made our approximation to the conditional expectation an linear combination of these basis functions, that is

    f(x)=mu+b1*log(x+1)+b2*sin(x)+b3*cos(x/2)
      
With the above approach, each of the coefficients of the function (mu, b1, b2,...) affect the fitness of the function to the data over the entire input space. 

We will consider next **local basis functions**, thse are basis functions that will affect the fitness of the function to the data within nieghborhoods in the space of x.

#### Step-function

We can `cut` x into ranges, and fit the mean within each range.

```r
   z=cut(x,breaks=0:7,right=F)
   fmStep=lm(y~z)
   plot(y~x,main='Step function')
   lines(x=x,y=f0(x),col='red',lwd=2)
   lines(x=x,y=predict(fmStep),col='blue',lwd=2)
```

What happens when we increase the number of bins?

```r
  DF=round(seq(from=4,to=40,length=9))
  par(mfrow=c(3,3))
  
  for(i in 1:length(DF)){
	 plot(y~x,col='grey')
	 lines(x=x,y=f0(x),col='red',lwd=2)
	
	 z=cut(x,breaks=seq(from=min(x),to=max(x+.01),length=DF[i]),right=F)
         fmStep=lm(y~z)
	 lines(x=x,y=predict(fmStep),col='blue',lwd=2)  
  }
 ```
### The bias-variance tradeoff

The step function predicts the conditional mean using the sample mean of the response variable wihtin each of the windows defined by `cut()`. Recall that the variance of the mean is `Var(X)/n`, as we reduce the window size (increase the DF of the model) the step function gains flexibility to approximate higly non-linear patterns; thus reducing the bias that the model may induce. However, at the same time, small windows lead to small local cample size and thus larger sampling variance. Recall that the mean-squared error equals variance plus squared bias, `MSE=E[(f-fHat)^2]=Var(fHat)+Bias(fHat)^2`; thus, as we make the windows smaller we face the standard bias-variance tradeoff.


### A continous piece-wise linear function

The step function is discontinous at the edge of each of the windows (aka knots). We can build a continous piece-wise linear function aided by a set of knots (tau1, tau2,...) using the following basis functions.

```r
 knots=seq(from=pi/2,to=2*pi,by=pi/2)
 # a threhsolding operator
 a=function(x,tau){ 
    ifelse(x>=tau, x-tau,0)
 }
 n=length(x)
 X=rep(1,n)
 for(i in 1:length(knots)){
  X=cbind(X,a(x,knots[i]))
 }
 fm=lm(y~X-1)
 dev.off()
 plot(y~x,col=8)
 lines(x=x,y=f0(x),col=2,lwd=2)
 lines(x=x,y=predict(fm),col=4,lty=2,lwd=2)
 
```
Above `a(x,tau)` is a thresholding operator that returns 0 if x<tau, or `x-tau` for `x>=tau`.


### Splines

Splines are smooth pice-wise polynomial functions defined by a set of knots and a degree. For a spline of degree K, the funciton as well as its 1st,2dn,...,(K-1)th derivatives are guaranteed to be continous. How do we create the basis functions of a cubic spline? To do this, form our basis functions by including the incidence vector for the interctp (1) and x (1st degree) and then add the thresholding function to x^2.

```r
  X=cbind(1,x)
 for(i in 1:length(knots)){
   X=cbind(X,a(x,knots[i])^2)
 }
 fm=lm(y~X-1)
 dev.off()
 plot(y~x,col=8)
 lines(x=x,y=f0(x),col=2,lwd=2)
 lines(x=x,y=predict(fm),col=4,lty=2,lwd=2)
 
```

### The `splines` package

A spline is defined by the degree of the polynomials, the set of knots, and the choice o basis functions. The broken-polynomial functions discussed in the previous example are easy to understand but may not be numerically stable. Other basis functions that are commonly used are the B-Splines and the Natural spline (which is a cubic spline with boundary knots). The `splines` package can be used to evaluate these basis functions.


```r
 library(splines)
 Z.BS=bs(x=x,df=6,degree=3,intercept=TRUE) 
 Z.NS=ns(x=x,df=6,intercept=TRUE)
 fmBS=lm(y~Z.BS-1)
 fmNS=lm(y~Z.NS-1)
 
 par(mfrow=c(2,1))
 
 plot(y~x,col=8,main='Cubic B-Spline')
 lines(x=x,y=f0(x),col=2,lwd=2,lty=2)
 lines(x=x,y=predict(fmBS),col=4,lty=2,lwd=2)
 
  
 plot(y~x,col=8,main='Natural spline')
 lines(x=x,y=f0(x),col=2,lwd=2,lty=2)
 lines(x=x,y=predict(fmNS),col=4,lty=2,lwd=2)
 
```


