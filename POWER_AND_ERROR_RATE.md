### Power & Error Rates


Consider testing a hypothesis (e.g, in a linear model `y=mu+b*x+e`, H0: b=0 Vs Ha: b!=0). 

This hypothesis may or may not hold  (rows in the table below), and our decision may be to reject it or not to reject it (columns). The table below classifies each of the four possible cases we can encounter regarding the state of nature and our decision:


|           | Do not reject H0  | Reject H0          |
|-----------|-------------------|---------------------|
| H0 holds  | True Negative  | False Positive |
| Ha holds  | False Negative | True positive  |


Suppose we conduct N tests(N=N1+N2+N3+N4) with the following outcome

|           | Do not reject H0  | Reject H0          |
|-----------|-------------------|---------------------|
| H0 holds  | N1 | N2 |
| Ha holds  | N3 | N4  |


From the above table we can define the following (empirical) proportions

 -  Proportion of false discoveries given that H0 holds: N2/(N1+N2)
 - (FDP) Proportion of false discoveries among the discoveries: N2/(N2+N4)
 - (TDP) Proportion of true discoveries given that HA holds: N4/(N3+N4)

**Definitions**:

The expected value of these proportions gives the Type-I error rate, false discovery rate and power of our experiment/test, resepectively:
 
   - **Type-I error rate**: P(reject|H0 holds)=E[N2/(N1+N2)]
   - **Power**:  P(Reject|Ha)=E[N4/(N3+N4)]
   - **False discovery rate** (FDR): E[N2/(N2+N4)]

In simple cases (e.g., comparison of two means) power and Type-I error rate can be computed anlythically. 
However, for more involved tests, anlythical derivations are not always available. 
In these cases we can estimate the above quantities using Monte Carlo simulations. 
The underlying idea is to replicate the process of (conceptual) repeated sampling from the population for a very large number of times so that the empirical proportions provide a good approximation to the underlying probabilities (or expected rates). 

The example below illustrates how to estimate power, FDR and type-I error rate for a simpe linear regression model.

