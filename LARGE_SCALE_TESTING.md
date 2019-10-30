####  Multiple Testing

In our discussion about [Type-I error rate]() we focus on problems involving a single-hypothesis (e.g., y=mu+xb+e, H0: b=0; Hab!=0).

In practice we test multiple hypothesis simultaneously (e.g., y=mu+x1*b1+x2*b2+e, H01:b1=0; H02: b2=0).

In this context, we define the family-wise (or experiment-wise) error rate as the probability of making at least 1 mistake (e.g., rejecting
H01 or H02 or both, given that H01 and H02 hold).

If the two tests are independent and our goal is to keep the experiment-wise error rate at a level equal to a (e.g, a=0.05), then we should
use a/2 to reject. 

**Bonferroni correction**: If we conduct `q` indpendent tests and want to achieve a family-wise error rate equal to `alpha`, then each test
must be rejected at a significance level equal to `alpha`/`q`.



