Using the [gout](https://github.com/gdlc/STAT_COMP/blob/master/goutData.txt) produce 95% bootstrap CI for the following:

    - Male/Female OR
    - B/W OR
    - Probability of developing gout for each of the following cases
          - W/F/55
          - B/F/55
          - W/M/55
          - B/M/55
       
**Outline of the algorithm**:

    1. Create a bootstrap sample of the data (e.g., `tmpData`).
    2. Fit a logistic regression model to the bootstrap sample (fm=glm(gout2~sex+race+age,data=tmpData,family='binomial'))
    3. From the fitted model calculate the ORs and risk probabilities listed above. 
    4. Repeat 1-3 5,000 times, each time with a different bootstrap sampe. Store the odds and risk probabilities in a matrix or data frame.
    5. Compute 95% CI by applying the quantile function to the bootstrap estimates of odds and risk probabilities. 
    6. Compare the average of the bootstrap estimates with the estimates you obtined with the original data.
