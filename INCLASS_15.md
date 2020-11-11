

### Power analysis

**Goal**: Estimate the power to detect an effect as a function of effect size and sample size.

**Simulation**: Use the following code to simulate data. Simulate data for 

   - `R2=[0,1/100,1/50,1/30,1/20,1/10]` and 
   - `N=[100,500,1000]`

```r
 
 x=rnorm(n) # note, here dependening of the scenario you will need to change n
 b=sqrt(r2) # same for R2
 signal=x*b 
 if(R2>0){
   error=rnorm(sd=sqrt(1-R2),n=N) 
 }else{
   error=rnorm(N)
 }
 y=signal+error

```

**Output**: Produce a plot with effect size (i.e., `R2`) in the horizontal axis, power in the vertical axis, and different lines by sample size.


**Suggestons**:
  - First prepare your code to estimate rejection rate for one scenario (e.g., `R2[2]`, `N[2]`) using, say, 5000 MCReps.
  - Once you solve the problem of estimating rejection rate for one scenario:
     - Initialize a matrix (e.g., REJ_RATE) with as many rows as `length(R2)` and as many columns as `length(N)`.
     - Embed the code you have into two loops, one for R2 and one for N, save the results of the inner loop in `REJ_RATE[i,j]`.
  
  
  
