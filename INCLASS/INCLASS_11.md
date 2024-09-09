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


**4)** The estimated regression coefficient for the effect of education in wages in a linear model (b) that included an intercept and 5 other predictors was 0.83 and the SE was 0.45. Compute the p-value for testing the following hypothes

   - H0: b=0 Vs Ha: b different than 0
   - H0: b=0.5 Vs Ha: b>0.5
   
Counduct the test assuming that b follows a normal distribution first, and then using a t-distribution for (b-b0)/SE using df=20.
 - Store the test statistics and p-value in two vectors `Q4_1` and `Q4_2` for the two hypothesis testings respectively.

**5)** Following **4)**, create a function `test=function(b,b_test,se,df)` and outputs the test statistics and the p-value in a vector.

