### IN-CLASS 15: MVN Distribution

Create a function, named `rMVN(mu,COV,n)` that will simulate n IID samples from MVN(mu,COV), where `mu` is the mean vector, `COV` is the covariance matrix and `n` is the number of samples.

The computations required for sampling from MVN distributions are detailed in section 2.3 of the [handout](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/SimulatingRandomVariables.pdf) on sampling random variables. 

**Additional hints:**


Recall that if **Z** is a MVN random vector of IID standard normal, i.e., N(0,1), then the expected value vector is E[**Z**]=**0** and the covariance matrix is Cov(**Z**)=**I** (here, **I** is a pxp identity matrix, 1's in the diagonals, representing the variances, and 0's in the off-diagonals, representing (co)variances).


Furthermore, if **Z** is a MVN random vector of IID standard normal, i.e., N(0,1), from the properties of the MVN distribution (see [handout](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/SimulatingRandomVariables.pdf) ), we know that **X**=**mu**+**BZ** follows a MVN distribution with mean E[**X**]=**mu**, and (co)variance matrix Cov[**X**]=**B**Cov[**Z**]**B**'=**BB**', because Cov[**Z**]=**I**. 

Thus, to sample from MVN(**mu**,**S**) we need to:

   - Sample an IID N(0,1) random vector (Z)
   - Find the matrix **B** such that **BB**'=**S**, then generate
   - **X**=**mu**+**BZ**.

 Some options to find **B** are: Cholesky, QR, and Eigenvalue decompositions of **S**, you can find more about this in a previous [handout](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/LinearAlgebra.md#matrix-factorization) that we discussed.
 


## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case) answering the questions shown below. If you have multiple files to submit, at least one of them is named as `assignment.R`.  You may submit your answer to Gradescope as many times as needed.

Include in your script the definition of the function `rMVN(mu,COV,n)`, we will test it by sampling using a similar algorithm.




 

