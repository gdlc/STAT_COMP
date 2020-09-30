
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

      `f(x)=mu+b1*log(x+1)+b2*sin(x)+b3*cos(x/2)`
      
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

### Linear splines

### Cubic spline


### Knot selection


