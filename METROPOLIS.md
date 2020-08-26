

### Metropolis Algorithm: a very simple example


Here we show how the Metropolis algorithm can be used to draw samples from a target distribution (`p()`) generating candidates 
from another distribution (q`(x)`). For the metropolis algorithm `q(x)` must be symmetric and have the same support than that of `p(x)`.

In the example below `x~N(0,1)`; we draw `n` samples from this distribution and use these samples for comparison with samples drawn
with a Metropolis algorithm.

```r
 n=100000    # number of samples we want to draw
 D=5        # controls the support of the uniform distribution used to generate candidates
 x=rnorm(n)  # samples from the target distribution (used for comparison only).
 
 z= rep(NA,n) 
 z[1]=-1
 for(i in 2:n){
 	candidate=runif(min=-D,max=D,n=1)# symmetric candidate generator (note, uniform is not strictly correct because it does not have the same support as that of th normal, but N(0,1) won't generate samples outside of [-5,5], so this is almost correct
 	r=dnorm(candidate)/dnorm(z[i-1])
 	accept<-runif(1)<r
 	if(accept){
 		z[i]=candidate
 	}else{
 		z[i]=z[i-1]
 	}
 	print(i)
 	
 }
 
 plot(density(x),col=4)
 tmp=density(z)
 lines(x=tmp$x,y=tmp$y,col=2)
 
```

For an application of the use of Metropolis to sample from the posterior distribtuion of a Logistic Regression Model follow this [link](https://github.com/gdlc/STT465/blob/master/logisticRegression.md) implements that.
