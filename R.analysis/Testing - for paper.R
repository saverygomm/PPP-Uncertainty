# WHAT IS PERFORMANCE of treatment?
# Performance = [benefit with mgmt - benefit without mgmt | Outcome == 1] + [benefit without mgmt FOR ALL PROJECTS]
# B_without_mgmt applies to all recovery plans
benefit_without_management <- sum(datasim$B_without_Mgmt)
# B_with_mgmt calculations should apply only to the projects that were in the funded (7.5M, 15M, 30M) portfolio from the baseline portfolios, respectively. 
# So LOW budget  sim_df[t] == 3, 6, 8
# So MED budget  sim_df[t] == 2, 5, 8
# So HIGH budget  sim_df[t] == 1, 4, 7


if (t %in% c(1, 4, 7)) { # We are in a HIGH BUDGET sim_df loop
    
    datasim_subset <- datasim %>%
        filter(unique_plan_num %in% funded_unique_plan_num_H)
    print(sum(sum(datasim_subset$B*datasim_subset$S), benefit_without_management)) 
    results_perform[i] <- sum(sum(datasim_subset$B*datasim_subset$S), benefit_without_management)   
    
} else if (t %in% c(2, 5, 8)) { # We are in a MED BUDGET sim_df loop
    
    datasim_subset <- datasim %>%
        filter(unique_plan_num %in% funded_unique_plan_num_M)
    print(sum(sum(datasim_subset$B*datasim_subset$S), benefit_without_management)) 
    results_perform[i] <- sum(sum(datasim_subset$B*datasim_subset$S), benefit_without_management)   
    
    
} else if (t %in% c(3, 6, 9)) { # We are in a LOW BUDGET sim_df loop
    
    datasim_subset <- datasim %>%
        filter(unique_plan_num %in% funded_unique_plan_num_L)
    print(sum(sum(datasim_subset$B*datasim_subset$S), benefit_without_management)) 
    results_perform[i] <- sum(sum(datasim_subset$B*datasim_subset$S), benefit_without_management)   
    
} else {
    stop("STOP! Something is wrong with the code!")
}