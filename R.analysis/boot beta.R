
# Clear the slate of earlier datasims
rm(datasim)

# It’s extremely easy to use in R, and you don’t even have to supply a density function:
library(simpleboot)

sim_beta<-read.csv("./data/Run 18 - Jun202018/sim_beta.csv")

# # Set up the empty dataframes for each summary result
# beta_results <- list()
# beta_mean_funded <- as.numeric()
# beta_sd_funded <- as.numeric()
# beta_mean_perform <- as.numeric()
# beta_sd_perform <- as.numeric()
# beta_probfund <- data.frame(unique_plan_num = unique(dataSpp$unique_plan_num))  # UPDATED Oct 17 2017

results_sim_beta <- numeric() 

for (t in 1:nrow(sim_beta))
    {
    ##  Give a 'progress bar' to see where you are in the loop
    # cat('sim_beta',t,'/',nrow(sim_beta),'\n')
    
    # results_sim_beta <- numeric()
  
    # Set up possible 1000 values given beta distribution with defined mean and variance
    
    mu <- sim_beta$mu[t]
    simasq <- sim_beta$simasq[t]
    
    a <-    alpha <-((1-sim_beta$mu[t])/sim_beta$simasq[t] - (1/sim_beta$mu[t]))*sim_beta$mu[t]^2
    b <-    beta <- (sim_beta$simasq[t] + sim_beta$mu[t]^2 - sim_beta$mu[t])*(sim_beta$mu[t] - 1)/sim_beta$simasq[t]
    n <- 1000 # how many numbers should this beta distribution have? (should be 100)
    x <- rbeta(n, alpha, beta)
    # curve(dbeta(x,alpha,beta), xlab = "Benefit or Success", ylab = "Frequency")
  
    
    # Bootstrap to get the CI using the adjusted bootstrap percentile (BCa) method, then export the min-max result https://stats.stackexchange.com/questions/82475/calculate-the-confidence-interval-for-the-mean-of-a-beta-distribution
   
    x.boot = one.boot(x, mean, R=10^4)
    # hist(x.boot)                # Looks good
    result<- boot.ci(x.boot, type="bca") # Confidence interval
   
    indices <- c(4,5)
    lowerCI <- as.numeric(result$bca[indices])[1]
    upperCI <- as.numeric(result$bca[indices])[2]
    
    df <- data.frame(mu, simasq, lowerCI, upperCI)
   
    results_sim_beta <- rbind(results_sim_beta, df)
    
    }

# Rearrange data into table format

results_sim_beta2 <- results_sim_beta %>%
    mutate(ConfidenceInterval = paste(round(lowerCI,3), "-", round(upperCI,3))) %>%
    mutate(lowerCI = round(lowerCI,3),
              upperCI = round(upperCI,3)) %>%
    select(-lowerCI, -upperCI)

supp.tableBS <- spread(results_sim_beta2, mu, ConfidenceInterval) 

write.csv(supp.tableBS, )
