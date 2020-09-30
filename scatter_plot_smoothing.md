
In this entry we discuss the problem of estimating a conditional expectation function, E[y|x]=f(x,b).

For that purpouse we will use the following simulation

```r
 x<-seq(from=0, to=2*pi,by=0.05)
 f0<-function(x){ 100+sin(2*x)+cos(x/2) }
 R2<-2/3
 y<-f0(x)+rnorm(n=length(x),sd=sqrt(var(f0(x))*(1-R2)/R2))
 plot(y~x)
 lines(x=x,y=f0(x),col='red',lwd=2)
```

#### Linear model

Obviously in this problem a linear aproximation does not work very well...

```r
 fmL=lm(y~x)
 plot(y~x)
 lines(x=x,y=f0(x),col='red',lwd=2)
 lines(x=x,y=predict(fmL),col='blue',lwd=2)

 ```
 
 #### Linear regression on non-linear basis functions
 
 We can use non-linear functions of `x` to define much more general classes of functions. 
 
 **Polynomials**
 ## Polynomials

```r
 fmPoly=lm(y~x+I(x^2)+I(x^3)+I(x^4))
 lines(x=x,y=predict(fmPoly),col='blue',lwd=2,lty=2)
```

**Using more general basis functions**

```r
 x1=x
 x2=log(x+1)
 x3=sin(x)
 x4=sin(x/2)
 fm2=lm(y~x1+x2+x3+x4)
 lines(x=x,y=predict(fm2),col='green',lwd=2,lty=2)
```

#### Step-function

We can `cut` x into ranges, and fit the mean within each range. 

```r
   z=cut(x,breaks=0:7,right=F)
   fmStep=lm(y~z)
	 lines(x=x,y=predict(fmStep),col='blue',lwd=2)  

```

What happens when we increase the number of bins?

```r
  DF=round(seq(from=4,to=40,length=9))
  par(mfrow=c(3,3))
  
  for(i in 1:length(DF)){
	 plot(y~x,col='grey',cex=.5)
	 lines(x=x,y=f0(x),col='red',lwd=2)
	
	 z=cut(x,breaks=seq(from=min(x),to=max(x+.01),length=DF[i]),right=F)
   fmStep=lm(y~z)
	 lines(x=x,y=predict(fmStep),col='blue',lwd=2)  
  }
 ```
