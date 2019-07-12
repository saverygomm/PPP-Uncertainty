
##### BSCo_sometimes_probfund.
# # Create a table that shows the Number of Recovery Plans (unique_plan_num) that are always/sometimes/never funded for portfolios under HML Uncertainty & 3 Budget Levels, and all Treatments.

Baseline_probfund<-read.csv("./output/Run 18 - May2019/Baseline_probfund.csv")
BSCo_probfund<-read.csv("./output/Run 18 - May2019/BSCo_probfund.csv")

# BSCo_probfund <- mutate(BSCo_probfund, ifelse(Decision == "Always", "Robustly Included",
# ifelse(Decision == "Never", "Robustly Excluded",
# ifelse(Decision == "Sometimes", "Uncertain", "NA"))))

# Create DF. Here I summarize the probfund data for Baseline and Co treatments into a range of decisions based on probfund cut offs (80/10, 80/20, 80/30, 80/40, 80/50). There are no 'sometimes' funded recovery plans for Baseline so I create a dataframe with n = 0 so that I have equal levels for Decision variable for all Treatments.

Baseline <- Baseline_probfund %>%
    select(unique_plan_num, NAM) %>%
    mutate(Decision = ifelse(NAM == 1, "Robustly Included",
                             ifelse(NAM == 0, "Robustly Excluded", "Uncertain"))) %>%
    count(Decision) %>%
    mutate(Treatment = "Baseline") %>%
    droplevels()
# str(Baseline)

# Decision <- c("Uncertain")
# Treatment <- c("Baseline")
# n <- 0

Decision100 <- BSCo_probfund %>%
    select(unique_plan_num, HHM) %>% 
    mutate(Decision = ifelse(HHM >= 1, "Robustly Included",
                             ifelse(HHM <= 0, "Robustly Excluded", "Uncertain"))) %>%
    count(Decision) %>%
    mutate(Treatment = "100%") 

Decision90 <- BSCo_probfund %>%
    select(unique_plan_num, HHM) %>% 
    mutate(Decision = ifelse(HHM >= 0.9, "Robustly Included",
                             ifelse(HHM <= 0, "Robustly Excluded",
                                    ifelse(HHM < 0.9, "Uncertain", NA)))) %>%
    count(Decision) %>%
    mutate(Treatment = "90%") 

Decision80 <- BSCo_probfund %>%
    select(unique_plan_num, HHM) %>% 
    mutate(Decision = ifelse(HHM >= 0.8, "Robustly Included",
                             ifelse(HHM <= 0, "Robustly Excluded",
                                    ifelse(HHM < 0.8, "Uncertain", NA)))) %>%
    count(Decision) %>%
    mutate(Treatment = "80%") 

Decision70 <- BSCo_probfund %>%
    select(unique_plan_num, HHM) %>% 
    mutate(Decision = ifelse(HHM >= 0.7, "Robustly Included",
                             ifelse(HHM <= 0, "Robustly Excluded",
                                    ifelse(HHM < 0.7, "Uncertain", NA)))) %>%
    count(Decision) %>%
    mutate(Treatment = "70%") 


# Bind dataframes together to create a df we can graph
df<- rbind(Baseline, Decision100, Decision90, Decision80, Decision70)

df <- df %>%
    filter(!is.na(Decision)) %>%
    droplevels()

str(df)
unique(df$Treatment)
# View(df)

# # Specify order for Decisions (shouldn't be needed if done above, but here for good measure)
df$Decision <- factor(df$Decision, levels = c("Robustly Included", "Uncertain", "Robustly Excluded"))
df$Decision2<-relevel(df$Decision, "Robustly Included")


# Stacked bar plot of Always/Sometimes/Never for all treatments
# cbbPalette <- c("#99CC66","#FF9933","#993333")
# cbbPalette <- c("green","orange","red")
cbbPalette <- c("chartreuse4","darkorange3","firebrick")

Figure.4.HHM_BSCo<- ggplot(df, aes(x = Treatment, y = n , fill = Decision)) +
    geom_bar(position = "fill",stat = "identity") +
    # or:
    # geom_bar(position = position_fill(), stat = "identity")
    scale_y_continuous(labels = percent_format()) +
    # facet_grid(Treatment ~ Uncertainty) +
    scale_fill_manual(values = cbbPalette) +
    xlab("Probability of Funding Cut-offs") + # set up to match sim_df
    ylab("Number of ESA Recovery Plans \nin the Funded Portfolio") +
    theme_bw() +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank(),
          panel.border = element_blank(),
          axis.line = element_line(colour = "black"),
          axis.text.x = element_text(angle = 45, vjust = 1, hjust=1),
          axis.text = element_text(size=11)) +
    theme(legend.key = element_blank(), strip.background = element_blank(), legend.text = element_text(size = 10)) +
    background_grid(major = "none", minor = "none")


Figure.4.HHM_BSCo

ggsave("./output/Run 18 - May2019/Figure 4. HHM_BSCo Decisions based on different ProbFunds.pdf", width = 20, height = 10, units = "cm")
