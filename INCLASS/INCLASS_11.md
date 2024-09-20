### IN-CLASS 11: Univariate distributions

Produce R-code to compute the probabilities indicated 

**1)** X follows a Normal distribution with mean 10 and variance 4. Evaluate the following probabilities:
   - Q1.1=P(X<8)
   - Q1.2=P(X>11)
   - Q1.3=P(8<X<11)
  

**2)** For the same RV X, we produce a linear transformaton Z=(X-10)/2. Compute the following probabilities
   - Q2.1=P(Z< -1)
   - Q2.2=P(Z> 1/2)
   - Q2.3=P( -1 < Z < 1/2)
 


**3)** Let Z1, Z2,...,Zp be IID Bernoulli random variables with success probability 0.07. Now let X=Z1+Z2+...+ZP. Compute and report the following probabilities for `p=[10,20,30]`

  - Q3.1=P(X=3)
  - Q3.2=P(X>3)
  - Q3.3=P(X<3)
  - Q3.4=P(X<=3)
  - To verify your result, you check that P(X<=3)+P(X>3)=1

Hint: remember to add argument ``lower.tail=FALSE`` for Q3.3 and Q3.4 when calculating the probabilities.

## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case).

Your script should include variables named Q1.1, Q1.2,....Q3.4, each assigned the value corresponding to the expression on the right-hand side of each of them.
