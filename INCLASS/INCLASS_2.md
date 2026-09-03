**In-class assignment 2**

For this assignment you will use a prostate cancer data set available in the  following `https://hastie.su.domains/ElemStatLearn/datasets/prostate.data`.

**1)** Read: use `read.table()` to read into the R-environment the prostate data set.

**2)** Compute the summary statistics described below for the variables `[lcavol,	lweight,	age,	lbph,	svi,	lcp,	gleason, pgg45, lpsa]`. F


## Submission to Gradescope

For your submission to grade scope provide an R-script named `assignment.R` (match case) answering the questions shown below. If you have multiple files to submit, at least one of them is named as `assignment.R`.  You may submit your answer to Gradescope as many times as needed.

  - Store in vectors named `Q3.mean` and `Q3.median` the mean and median of each of the following variables `[lcavol,	lweight,	age,	lbph,	svi,	lcp,	gleason, pgg45, lpsa]`.
  - Store in  a vector named `COR` the correlation of each of these variables `[lcavol,	lweight,	age,	lbph,	svi,	lcp,	gleason, pgg45]` with `lpsa`, name the vector with the variable names. Your vector should have a length of 8, each entry corresponding to the correlation between one predictor and `lpsa`.
  - Store in a variable named `top_predictor` the variable name of the top predictor of lpsa.
