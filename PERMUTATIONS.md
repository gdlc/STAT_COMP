## Permutation tests

We have considered before how to estimate type-I error rate husing simulations. However, the examples we discuss required us to simulate data. Simulating data reuires making assumptions that may or may not hold when analyzing real data. In this entry we will consider how to use permutations to esitmate the thershold we should use to reject H0 and achieve a given type-I erro rate. Permutation analysis is done using real data; thus, there is no need to make any assumptions.

The goal in a permutation analysis is to estimate the distirbution of a test statistic under the null hypothesis. To simulate data under the null hypothesis we break the association between response and predictor by permuting the response (or in some cases the predictor). Here is an example.


```r
 Y=

```



[Back](https://github.com/gdlc/STAT_COMP/)
