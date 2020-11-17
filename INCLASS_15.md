

### Power analysis

**Goal**: Estimate the power to detect an effect as a function of effect size and sample size.

**Simulation**: Use the following code to simulate data. Simulate data for 

   - `R2=[0,1/100,1/50,1/30,1/20,1/10]` and 
   - `N=[100,500,1000]`

```r
 
 x=rnorm(n) # note, here dependening of the scenario you will need to change n
 b=sqrt(r2) # same for R2
 signal=x*b 
 if(r2>0){
   error=rnorm(sd=sqrt(1-R2),n=n) 
 }else{
   error=rnorm(n)
 }
 y=signal+error

```

**Output**: Produce a plot with effect size (i.e., `R2`) in the horizontal axis, power in the vertical axis, and different lines by sample size.


**Suggestions**:
  - First prepare your code to estimate rejection rate for one scenario (e.g., `R2[2]`, `N[2]`) using, say, 5000 MCReps.
  - Once you solve the problem of estimating rejection rate for one scenario:
     - Initialize a matrix (e.g., `REJ_RATE`) with as many rows as `length(R2)` and as many columns as `length(N)`.
     - Embed the code you have into two loops, one for R2 and one for N, save the results of the inner loop in `REJ_RATE[i,j]`.
     
 **Possible solution**
 
```r
nReps=10000
R2=c(0,1/100,1/50,1/30,1/20,1/10)
N=c(100,500,1000)


COUNTS=matrix(nrow=length(N),ncol=length(R2),0)
rownames(COUNTS)=N
colnames(COUNTS)=round(R2,2)


for(i in 1:length(N)){
	for(j in 1:length(R2)){
		n=N[i]
		rSq=R2[j]
		
		for(k in 1:nReps){
		
		     # Simulating the data
			 x=rnorm(n) # note, here dependening of the scenario you will need to change n
 			 b=sqrt(rSq) # same for R2
 			 signal=x*b 
 			if(rSq>0){
   				error=rnorm(sd=sqrt(1-rSq),n=n) 
 			}else{
   				error=rnorm(n)
 			}
 			y=signal+error
			
			fm=lm(y~x)
			
			COUNTS[i,j]=COUNTS[i,j] +(summary(fm)$coef[2,4]<0.05)
		
		}
		print(paste(i,'-',j))
	}
}


plot(0,xlab='R-q',ylab='Rejection rate',ylim=c(0,1),xlim=c(0,max(R2)),col='white')
 RR=COUNTS/nReps
lines(x=R2,y=RR[1,],type='o',col=1)
lines(x=R2,y=RR[2,],type='o',col=2)
lines(x=R2,y=RR[3,],type='o',col=4)

```
  
  
