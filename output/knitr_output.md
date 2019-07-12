---
title: "Regression"
author: "Stephanie Avery-Gomm"
date: '2017-06-11'
output: html_document
---



### *If you could improve estimates for one parameter, which would it be?* 




## 
2007 PGT Fararo  matching protocls


## Simulation set
#### Recall high medium and low levels of uncertainty are introduced into Cost Benefit and Success (and every combination of these parameters), and the performance of the funded portfolio was assessed. For each of 100 loops for each simulation, the probability that a given project would be funded was evaluated. The question a decision maker might ask is "Can this PPP provide usefuld decision guidence if I'm concerned the estimates of Cost, Benefit and Feasibility may not be very?". to answer that question, we'd refer the decision maker to the probabilities of funding for each Recovery Plan, and encourage them to prioritise species that are funded 100% of the time (and avoid projects that are funded 0% of the time, unless they have some value/objective/priority other than cost-effectiveness). Species that are 'sometimes funded' (i.e., funded 1% - 99% of the time) repreresent a grey area where a decision maker must use their judgement. 

#### IF the question "which parameter should I improve the quality of the PPP" were asked, this could be answered by looking at whether uncertainty in cost, benefit and fesbility influence the NUMBER of species that are 'sometimes' funded. This is what we do here. 


What would my experiment look like in biological terms? 
The recovery plans are groups of mice. 
Each group is assigned a treatment (which drug they are given (BSCo)) and a dosage (uncertainty level) - which is why Uncertainty_B with numeric levels makes sense. Could also try 1, 2, 3.
This is repeated for 3 budget levels. 

The response variable is a count (sometimes funded)


<!-- Talking to Simon Blomberg -->
<!--  - check Uncertaitny_Co bc no medium  -->
<!--  - plot # somteimes funded vs uncertainty for B, S, Co make sure linear -->
<!--  - OK to use estimates from lm to figure out what BSCo having greatest imapct on Somtimes funded without worrying about multicolinearity bc not testint hypoth that differe from 0 -----  -->
<!--  - look at mag of Estimate / Std Error below to see that there main effects much stronger and interactions non issue -->
<!--  Call: -->
<!-- lm(formula = Sometimes_Funded ~ Uncertainty_Co + Uncertainty_B +  -->
<!--     Uncertainty_S + Budget + Budget * Uncertainty_Co + Budget *  -->
<!--     Uncertainty_B + Budget * Uncertainty_S, data = lmdataSrunif) -->

<!-- Residuals: -->
<!--     Min      1Q  Median      3Q     Max  -->
<!-- -22.363  -9.148  -3.898   6.835  51.901  -->

<!-- Coefficients: -->
<!--                              Estimate      Std. Error t value    Pr(>|t|)     -->
<!-- (Intercept)             36.2928578420    6.5602884700   5.532 0.000000905 *** -->
<!-- Uncertainty_Co         -54.4196221736  240.0273158379  -0.227      0.8215     -->
<!-- Uncertainty_B         5339.2769747790 4699.7101762634   1.136      0.2608     -->
<!-- Uncertainty_S         2973.8082808575 1122.5182936120   2.649      0.0105 *   -->
<!-- Budget                  -0.0000006925    0.0000003306  -2.095      0.0408 *   -->
<!-- Uncertainty_Co:Budget    0.0000009129    0.0000120962   0.075      0.9401     -->
<!-- Uncertainty_B:Budget    -0.0001006125    0.0002368431  -0.425      0.6726     -->
<!-- Uncertainty_S:Budget    -0.0000507538    0.0000565696  -0.897      0.3735    -->

<!-- - How to report? Not p values bc the magnitde dosn't amtter and im not trying to predict. It has to do with the relative difference. -->
<!-- - For the lm suggests using scale function to scale by standard deviation for the Uncertainty_BSCo -  -->


#### This table shows the simulations that were run. 


```
## [1] "/Users/stephanieavery-gomm/Dropbox/PhD/Brainstorming/PPP USA threatened species prioritisation/Stephanie Chp 5 Uncertainty Analysis/PPP-Uncertainty.git/R.analysis"
```

```
## PhantomJS not found. You can install it with webshot::install_phantomjs(). If it is installed, please make sure the phantomjs executable can be found via the PATH variable.
```

```
## Warning in normalizePath(f2): path[1]="./webshot759d56d469c6.png": No such
## file or directory
```

```
## Warning in file(con, "rb"): cannot open file './webshot759d56d469c6.png':
## No such file or directory
```

```
## Error in file(con, "rb"): cannot open the connection
```

# Success: 1 or runif(0.5, 0.95)? 

## Success: Runif


#### Plot data first


```
## [1] "Plot Sometimes Funded vs Uncertainty for each parameter, where Success is a random number (S_runif)"
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-1.png)

<!-- #### The first set of linear regression is run on the output, where S is originally set as a number selected from a uniform distribution ranging from 0.5 to 0.95. The number is scaled such that uncertainty can be introduced using a beta distribution.  -->

<!-- ```{r} -->

<!-- # 1) Specified all interactions - but that doesn't really make sense. None significant? Remove interactions. Some significantish, look at Estimates. As Uncertainty increases, you have a pos or negative impact on the SD on the Performance (or the number of the species which are sometimes funded) -->
<!-- lm1<-lm(Sometimes_Funded ~ Uncertainty_Co_scaled + Uncertainty_B_scaled + Uncertainty_S_scaled + Budget + Budget*Uncertainty_Co_scaled + Budget*Uncertainty_B_scaled + Budget*Uncertainty_S_scaled, data = lmdataSrunif)  -->
<!-- lm1 -->
<!-- summary(lm1) -->

<!-- # Check Assumptions -->
<!-- print("Check assumptions for S_runif WITH interactions") -->
<!-- par(mfrow=c(2,2)) -->
<!-- plot(lm1) -->

<!-- # 2) Take out interactions  -->
<!-- lm2<-lm(Sometimes_Funded ~ Uncertainty_Co_scaled + Uncertainty_B_scaled + Uncertainty_S_scaled + Budget, data = lmdataSrunif)  # add interaction terms -->
<!-- lm2 -->
<!-- summary(lm2) -->


<!-- # Check Assumptions -->
<!-- print("Check assumptions for S_runif WITHOUT interactions") -->
<!-- par(mfrow=c(2,2)) -->
<!-- plot(lm2) -->

<!-- print("Is there multicolinearity between predictor variables? Find out with vif on lm without interactions. Note, even if there is, bc we are only interested in the magnitude of the difference in parameter estimates and not hte standard deviations then it is OK (Simon/Frank E. Harrell, Jr. Regression Modelling Strategies).") -->
<!-- print(vif(lm2)) -->

<!-- ``` -->

<!-- #### Where S is runif(0.5,0.95): Regardless of budget level or uncertainty in the quality of cost, benefit or success estimates for Endangered Species Recovery, decision guidence from the Cost-Efficiency Analysis is clear (always, never) for the majority of species. -->
<!-- ```{r, echo = FALSE} -->
<!-- # Plot Always, Sometimes Never for S_runif -->

<!-- Table3.TidySrunif$Budget <- factor(Table3.TidySrunif$Budget, c("L", "M", "H")) -->
<!-- Table3.TidySrunif$Uncertainty <- factor(Table3.TidySrunif$Uncertainty, c("Low", "Medium", "High")) -->
<!-- Table3.TidySrunif$Treatment <- factor(Table3.TidySrunif$Treatment, c("B", "S", "BS", "Co", "BCo", "SCo", "BSCo")) -->
<!-- Table3.TidySrunif$Decision <- factor(Table3.TidySrunif$Decision, c("always","sometimes","never")) -->
<!-- # datatable(Table3.TidySrunif, rownames=FALSE) -->

<!-- ggplot(Table3.TidySrunif,aes(x = Budget, y = value , fill = Decision)) +  -->
<!--     geom_bar(position = "fill",stat = "identity") + -->
<!--     # or: -->
<!--     # geom_bar(position = position_fill(), stat = "identity")  -->
<!--     scale_y_continuous(labels = percent_format()) + -->
<!--     xlab("Budget") + -->
<!--     ylab("Proportion of Species in Funded Portfolio") + -->
<!--     ggtitle("Where S is runif(0.5,0.95): Decision guidence from the Cost-Efficiency Analysis is clear (always or never fund) for the majority of species.") + -->
<!--     theme_bw() + -->
<!--     facet_grid(Treatment ~ Uncertainty)  -->
<!-- ``` -->


<!-- ## Success: Set to 1 -->

<!-- #### Plot data first -->

<!-- ```{r} -->
<!-- # PLOT IT  -->

<!-- print("Plot Sometimes Funded vs Uncertainty for each parameter, where Success is a random number (S_runif)") -->
<!-- BU<- subset(lmdataS1, Treatment == "B") # data is lmdataS1 -->
<!-- SU<- subset(lmdataS1, Treatment == "S") -->
<!-- CU<- subset(lmdataS1, Treatment == "Co") -->

<!-- par(mfrow=c(1,3)) -->
<!-- plot(BU$Uncertainty_B, BU$Sometimes_Funded) -->
<!-- plot(SU$Uncertainty_S, SU$Sometimes_Funded) -->
<!-- plot(CU$Uncertainty_Co, CU$Sometimes_Funded) -->

<!-- ``` -->

<!-- #### The second set of linear regressions run on the output was where we set S to 1 for all species, add uncertainty then calculate the CEA. Initially we were setting S to 1 because we had no data on it, so potentially adding uncertainty is a bit bogus and the example above makes more sense.  -->

<!-- ```{r sim_df_S_is_1, echo = FALSE} -->

<!-- # 3) Specified all interactions - but that doesn't really make sense. None significant? Remove interactions. Some significantish, look at Estimates. As Uncertainty increases, you have a pos or negative impact on the SD on the Performance (or the number of the species which are sometimes funded) -->
<!-- lm3<-lm(Sometimes_Funded ~ Uncertainty_Co_scaled + Uncertainty_B_scaled + Uncertainty_S_scaled + Budget + Budget*Uncertainty_Co_scaled + Budget*Uncertainty_B_scaled + Budget*Uncertainty_S_scaled, data = lmdataS1)  -->
<!-- lm3 -->
<!-- summary(lm3) -->

<!-- # Check Assumptions -->
<!-- print("Check assumptions for S_runif WITH interactions") -->
<!-- par(mfrow=c(2,2)) -->
<!-- plot(lm3) -->


<!-- # 4) Take out interactions  -->
<!-- lm4<-lm(Sometimes_Funded ~ Uncertainty_Co_scaled + Uncertainty_B_scaled + Uncertainty_S_scaled + Budget, data = lmdataS1)  # add interaction terms -->
<!-- lm4 -->
<!-- summary(lm4) -->


<!-- # Check Assumptions -->
<!-- print("Check assumptions for S_runif WITHOUT interactions") -->
<!-- par(mfrow=c(2,2)) -->
<!-- plot(lm4) -->

<!-- print("Is there multicolinearity between predictor variables? Find out with vif on lm without interactions. Note, even if there is, bc we are only interested in the magnitude of the difference in parameter estimates and not hte standard deviations then it is OK (Simon/Frank E. Harrell, Jr. Regression Modelling Strategies).") -->
<!-- print(vif(lm4)) -->

<!-- ``` -->

<!-- #### Where S is set to 1: Regardless of budget level or uncertainty in the quality of cost, benefit or success estimates for Endangered Species Recovery, decision guidence from the Cost-Efficiency Analysis is clear (always, never) for the majority of species. -->
<!-- ```{r, echo = FALSE} -->
<!-- # Plot Always, Sometimes Never for S_runif -->

<!-- Table3.TidyS1$Budget <- factor(Table3.TidyS1$Budget, c("L", "M", "H")) -->
<!-- Table3.TidyS1$Uncertainty <- factor(Table3.TidyS1$Uncertainty, c("Low", "Medium", "High")) -->
<!-- Table3.TidyS1$Treatment <- factor(Table3.TidyS1$Treatment, c("B", "S", "BS", "Co", "BCo", "SCo", "BSCo")) -->
<!-- Table3.TidyS1$Decision <- factor(Table3.TidyS1$Decision, c("always","sometimes","never")) -->
<!-- # datatable(Table3.TidyS1, rownames=FALSE) -->

<!-- ggplot(Table3.TidyS1,aes(x = Budget, y = value , fill = Decision)) +  -->
<!--     geom_bar(position = "fill",stat = "identity") + -->
<!--     # or: -->
<!--     # geom_bar(position = position_fill(), stat = "identity")  -->
<!--     scale_y_continuous(labels = percent_format()) + -->
<!--     xlab("Budget") + -->
<!--     ylab("Proportion of Species in Funded Portfolio") + -->
<!--     ggtitle("Where S is 1: Decision guidence from the Cost-Efficiency Analysis is clear (always or never fund) for the majority of species.") + -->
<!--     theme_bw() + -->
<!--     facet_grid(Treatment ~ Uncertainty)  -->
<!-- ``` -->



<!-- ```{r} -->
<!-- #  -->
<!-- # library(car) -->
<!-- #  -->
<!-- # # BASIC DIAGNOSTICS:       -->
<!-- #         # Test model assumptions by checking the residuals -->
<!-- #         par(mfrow=c(2,2)) -->
<!-- #         plot(lm1)   # For interpretation see http://data.library.virginia.edu/diagnostic-plots/ -->
<!-- #                         # Residuals vs Fitted:  Ideal case: The residuals appear randomly spread around a more or less horizontal fitted line.  -->
<!-- #                         # Normal Q-Q: This plot shows if residuals are normally distributed. Ideal case: The residuals follow a straight line well. -->
<!-- #                         # Scale-Location: This is how you can check the assumption of equal variance (homoscedasticity). Ideal case: The residuals appear randomly spread around a more or less horizontal fitted line.  -->
<!-- #                         # Residuals vs Leverage: This plot helps us to find influential cases (i.e., subjects) if any. We watch out for outlying values at the upper right corner or at the lower right corner. Those spots are the places where cases can be influential against a regression line. Look for cases outside of a dashed line, Cook’s distance. When cases are outside of the Cook’s distance (meaning they have high Cook’s distance scores), the cases are influential to the regression results. The regression results will be altered if we exclude those cases. -->
<!-- #                         # What does it all mean? So, what does having patterns in residuals mean to your research? It’s not just a go-or-stop sign. It tells you about your model and data. Your current model might not be the best way to understand your data if there’s so much good stuff left in the data. -->
<!-- #                         # DECISION: The normal Q&Q plot and Scale-Location are a bit concerning.  # FANCY DIAGNOSTICS:        -->
<!-- #         # Advanced diagnostic plots from car package http://www.statmethods.net/stats/rdiagnostics.html -->
<!-- #             # Assessing Outliers -->
<!-- #             outlierTest(lm1) # Bonferonni p-value for most extreme obs -->
<!-- #             qqPlot(lm1, main="QQ Plot") #qq plot for studentized resid  -->
<!-- #             leveragePlots(lm1) # leverage plots -->
<!-- #          -->
<!-- #         # Influential Observations -->
<!-- #             # Cook's D plot -->
<!-- #             # identify D values > 4/(n-k-1)  -->
<!-- #             plot(lm1, which=4, cook.levels=cutoff) -->
<!-- #             # Influence Plot  -->
<!-- #             influencePlot(lm1,	id.method="identify", main="Influence Plot", sub="Circle size is proportial to Cook's Distance" ) -->
<!-- #          -->
<!-- #         # Normality of Residuals -->
<!-- #             # qq plot for studentized resid -->
<!-- #             qqPlot(lm1, main="QQ Plot") -->
<!-- #          -->
<!-- #         # Evaluate homoscedasticity -->
<!-- #             # non-constant error variance test -->
<!-- #             ncvTest(lm1) -->
<!-- #             # plot studentized residuals vs. fitted values  -->
<!-- #             spreadLevelPlot(lm1) -->
<!-- #          -->
<!-- #         # Evaluate Collinearity -->
<!-- #             vif(lm2) # variance inflation factors -->
<!-- #             sqrt(vif(lm1)) > 2 # If the vif of a predictor variable were 5.27 (√5.27 = 2.3) this means that the standard error for the coefficient of that predictor variable is 2.3 times as large as it would be if that predictor variable were uncorrelated with the other predictor variables. Acceptable vif < 1. It is OK to have some correlation but anything > 10 is unacceptable.  -->
<!-- #             ?scatterplotmatrix # Use this to verify.  -->
<!-- #              -->
<!-- #              -->
<!-- #         # Nonlinearity -->
<!-- #            # # Evaluate Nonlinearity -->
<!-- #            #  component + residual plot -->
<!-- #              crPlots(lm2) -->
<!-- #        -->
<!-- #         # Test for Autocorrelated Errors -->
<!-- #             durbinWatsonTest(lm1)    -->
<!-- #          -->
<!-- # # CONCLUSION? -->
<!-- ``` -->


# Conclusion?
##### There is a positive relationship between the level of uncertainty_S and the number of species that are sometimes funded. So if there is high uncertainty in S, there are a high number of sometimes funded species. This held true when S was uncertainty on S = 0.88 and when uncertainty on S_runif. Gut check: Does that make sense?? 
