
Draw 100,000 samples from the bi-varaite Bernoulli in the Table in section 2.1 of the [handout](https://github.com/gdlc/STAT_COMP/blob/master/SimulatingRandomVariables.pdf) on sampling
random variables, using the algorithms described in Box 1 and Box 2 of the handout.


### Compostion sampling

We find the marginal distribution of X and the conditional distribution of Y|X. Because both X and Y are {0,1} both distributions must be Bernoulli.

  - P(X=1)=P(X=1|Y=0)+P(X=1|Y=1)
  - P(Y=1|X=0)=p(Y=1 & X=0)/P(X=0) ;  P(Y=1|X=1)=p(Y=1 & X=1)/P(X=1)
  



### Gibbs sampler

We first find the fully-conditionals P(Y|X) and P(X|Y)

 - P(X=1|Y=0)=p(Y=1 & Y=0)/P(Y=0) ;  P(X=1|Y=1)=p(X=1 & Y=1)/P(Y=1)
 - P(Y=1|X=0)=p(Y=1 & X=0)/P(X=0) ;  P(Y=1|X=1)=p(Y=1 & X=1)/P(X=1)
 
Then we sample recursively usinge these distributions.

