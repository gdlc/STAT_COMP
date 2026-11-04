
## INCLASS 17: Estimating power using Monte Carlo methods

The following function, simulateds data for a linear model of the form `Y=mu+Xb+Zc+e`.

```r

simData=function(N,R2){
  X=rnorm(N)
  b=sqrt(R2)
  signal=100+X*b
  error=rnorm(sd=sqrt(1-R2),n=N) 
  y=signal+error
  return(data.frame(y=y,X=X))
}

```
*Example*

```r
 DATA=simData(10000,0.1)
 fm=lm(y~X,data=DATA)
 summary(fm)
 
```

**Task: Power Estimation using Monte Carlo Simulations**

Using the function provided above, estimate the power to detect an association between x and y for `R2=c(0.05,0.1)` and `N=c(10,20,50,100)` using Monte Carlo simulations.

Hints:

  - Create a matrix (e.g., `REJECT`) with 5,000 rows (MC simulations) and 4 columns (values of N).
  - Then, to run your Monte Carlo Simulations, use two loops

```r
 nRep=5000
 N=c(10,20,50,100)
 R2=c(0.05,0.1)

 # An object to store decisions, rows represent scenarios and replicates
 PAR=expand.grid(Rep=1:nRep,N=N,R2=R2,reject=NA)

 for(i in 1:nrow(PAR)){
   n=PAR$N[i]
   R2=PAR$R2[i]
    # Simulate your data
    # fit a linear model y~x to the simulated data
    # extract the p-value for X2
    # store in PAR$reject[i]= a boolean indicating whether the p-value is smaller than 0.05
   }
 }
```


Your final results should be formatted as follows

```{r}
 PWR=expand.grid(N=N,R2=R2,Power=NA)
 # Fill the power with the corresponding rejection proportions.

```


## Submission 

## Since the generation involves randomness, if your code is correct, please try to submit several times to pass all test cases in a single submission.

For your submission to grade scope provide an R-script named `assignment.R` (match case) answering the questions shown below. Your submission script should perform the simulations and generate the `PWR` data frame as indicated above. 

