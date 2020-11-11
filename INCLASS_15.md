

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


Hints:
  - Initialize a matrix (e.g., REJ_RATE) with as many rows as `length(R2)` and as many columns as `length(N)`.
  - Conduct your simulation with 3 nested loops, one for `R2`, one for `N` (these two are the outter loops), and one for MC reps.
  - The inner loop (for MC-reps) will conduct the simulation for one scenario (`R2[i]`, `N[j]`), store the estimated rejection rate in `REJ_RATE[i,j]`.
  
  
  
