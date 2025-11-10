# HW4: Multiple Testing and Prediction Modelling

**Due:** Wed Nov 26

This homework uses a prostate cancer dataset from Stamey et al. (J. of Urology, 1989), also analyzed in *The Elements of Statistical Learning* (Hastie, Tibshirani, and Friedman, 2009).

---

## 1. Data Setup

You can read the dataset into R as follows:

```r
fname = 'https://raw.githubusercontent.com/gdlc/STAT_COMP/refs/heads/master/DATA/prostate.csv'
DATA = read.csv(fname, header = TRUE, row.names = 1)
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

We will use the variable `train` to split the data into **training** and **testing** sets:

```r
DATA.TRN = DATA[DATA$train, -ncol(DATA)]
DATA.TST = DATA[!DATA$train, -ncol(DATA)]
```

---

## 2. Linear Model Using All Predictors

Fit the model to the training data:

```r
fm0 = lm(lpsa ~ ., data = DATA.TRN)
summary(fm0)
```

Example summary output:

```
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)
## (Intercept)  0.42917   1.55359   0.276   0.783
## lcavol       0.57654   0.10744   5.366  1.47e-06 ***
## lweight      0.61402   0.22322   2.751  0.00792 **
## age         -0.01900   0.01361  -1.396  0.16806
## lbph         0.14485   0.07046   2.056  0.04431 *
## svi          0.73721   0.29856   2.469  0.01651 *
## lcp         -0.20632   0.11052  -1.867  0.06697 .
## gleason     -0.02950   0.20114  -0.147  0.88389
## pgg45        0.00947   0.00545   1.738  0.08755 .
```

---

## Q1: Determining Significance Accounting for Multiple Testing

### (1.1) Bonferroni Correction

Identify variables significantly associated with `lpsa` after applying Bonferroni’s correction (Family-wise error rate = 0.05).

```r
pvals = summary(fm0)$coef[-1, 4]
pvals.adj = p.adjust(pvals, method = "bonferroni")
pvals.adj
signif_vars = names(pvals.adj[pvals.adj < 0.05])
signif_vars
```

### (1.2) Permutation-Based FWER Control

Use permutation analysis to determine the p-value threshold that controls the FWER < 0.05.

Steps:

```r
nPerm = 1000
minP = numeric(nPerm)

for (i in 1:nPerm) {
  y_perm = sample(DATA.TRN$lpsa)
  fm_perm = lm(y_perm ~ ., data = DATA.TRN)
  minP[i] = min(summary(fm_perm)$coef[-1, 4])
}

threshold = quantile(minP, 0.05)
threshold
```

Report:
- The selected **p-value threshold**
- The variables significant under this threshold

---

## Q2: Evaluation of Prediction Accuracy

Prediction Mean Squared Error (PMSE):

\(
PMSE = \frac{1}{n} \sum_{i=1}^{n} (y_i - \hat{y}_i)^2
\)

### Models to Compare

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

Compute PMSE for each:

```r
models = list(
  M1 = lpsa ~ lcavol,
  M2 = lpsa ~ lcavol + lweight,
  M3 = lpsa ~ lcavol + lweight + svi,
  M4 = lpsa ~ lcavol + lweight + svi + lbph,
  M5 = lpsa ~ lcavol + lweight + svi + lbph + age,
  M6 = lpsa ~ lcavol + lweight + svi + lbph + age + lcp,
  M7 = lpsa ~ lcavol + lweight + svi + lbph + age + lcp + gleason,
  M8 = lpsa ~ lcavol + lweight + svi + lbph + age + lcp + gleason + pgg45
)

PMSE = sapply(models, function(formula) {
  fm = lm(formula, data = DATA.TRN)
  yhat = predict(fm, newdata = DATA.TST)
  mean((DATA.TST$lpsa - yhat)^2)
})

PMSE
```

Report the PMSE for each model in a table and identify which model performs best.

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
