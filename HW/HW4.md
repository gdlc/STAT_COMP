# HW4: Multiple Testing and Cross-validation

**Due:** Tuesday Nov 24

This homework uses a prostate cancer dataset from Stamey et al. (J. of Urology, 1989), also analyzed in *The Elements of Statistical Learning* (Hastie, Tibshirani, and Friedman, 2009).

---

## 1. Data Setup

You can read the dataset into R as follows:

```r
fname = 'https://hastie.su.domains/ElemStatLearn/datasets/prostate.data'
DATA = read.table(fname, header = TRUE)
head(DATA)
```

Example output:

```
##     lcavol  lweight  age   lbph  svi   lcp  gleason  pgg45   lpsa  train
## 1  -0.5798  2.7695   50  -1.3863   0  -1.3863   6      0  -0.4308   TRUE
## 2  -0.9943  3.3196   58  -1.3863   0  -1.3863   6      0  -0.1625   TRUE
## 3  -0.5108  2.6912   74  -1.3863   0  -1.3863   7     20  -0.1625   TRUE
## ...
```


---

## Q1: Determining Significance Accounting for Multiple Testing


Fit the full model

```r
 fmFull = lm(lpsa ~ ., data = DATA)
```

### (1.1) Bonferroni Correction

Identify variables that are significant at 0.01 for three methods: (i) raw p-values, (ii) Bonferroni adjusted p-values, and (iii) Holm adjusted p-values.

Note: do not use the intercept for the p-value adjustments.


### (1.2) Permutation-Based FWER Control

Use permutation analysis to determine the p-value threshold that controls the FWER < 0.05.


## Q2: Evaluation of Prediction Accuracy

Estimate the prediction MSE ($PMSE = \frac{1}{n} \sum_{i=1}^{n} (y_i - \hat{y}_i)^2$ in testing data for each of these models


| Model | Formula |
|-------|----------|
| M1 | `lpsa ~ lcavol` |
| M2 | `lpsa ~ lcavol + lweight` |
| M3 | `lpsa ~ lcavol + lweight + svi` |
| M4 | `lpsa ~ lcavol + lweight + svi + lbph` |
| M5 | `lpsa ~ lcavol + lweight + svi + lbph + age` |
| M6 | `lpsa ~ lcavol + lweight + svi + lbph + age + lcp` |
| M7 | `lpsa ~ lcavol + lweight + svi + lbph + age + lcp + gleason` |
| M8 | `lpsa ~ lcavol + lweight + svi + lbph + age + lcp + gleason + pgg45` |


Estimate the PMSE for each model using 100 training testing partitions, assigning, in each training testing partition 67 randomly sampled observations to training and 60 to testing. 

Report a table with PMSE +/- SD by model.


---

## Q3: Conclusions

- **Predictors with strong evidence of association:** Based on corrected p-values and permutation analysis, identify which predictors show strong statistical significance.  
- **Best predictive model:** Recommend the model (M1–M8) that minimizes PMSE and provides the best predictive performance on the testing set.

---

### References
- Stamey et al. (1989). *Journal of Urology*
- Hastie, Tibshirani & Friedman (2009). *The Elements of Statistical Learning*
- https://hastie.su.domains/ElemStatLearn/
- https://rdrr.io/cran/ElemStatLearn/man/prostate.html
