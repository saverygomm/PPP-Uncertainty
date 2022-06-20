```{r Figure5_B_ProbFund_HHM}

# Here we show the prob of funding for each recovery plan. Recovery plans with probfund == 0 or 1 are ranked based on CE from the baseline (no uncertainty). 

# This code merges baseline datasim with Co_probfund so that I can sort Co with prob fund 0 or 1 by the 'true' CE.
datasim.Baseline <- read.csv("./output/Run 18 - May2019/datasim.Baseline.csv")
B_probfund<-read.csv("./output/Run 18 - May2019/B_probfund.csv")
test1 <- left_join(B_probfund, datasim.Baseline, by = "unique_plan_num")

test2 <- test1 %>%
    select(unique_plan_num, HHM, CE, Co) %>%
    arrange(desc(CE)) %>%
    arrange(desc(HHM)) %>%
    mutate(rank = row_number(), 
           CumSum = cumsum(Co))

View(test2)

how_many_plans_for_15M <- nrow(test2 %>% filter(CumSum < 15000000))
how_many_plans_for_15M
    
# This graph has probability on the Y AXIS
Figure5 <- ggplot(test2, aes(x = rank, y = HHM, colour = HHM)) +
    geom_point(size = 2, shape = 16) +
    # scale_colour_gradient(low = "red", high = "green") + # [Reference 10]
    scale_colour_gradient(low = "firebrick", high = "chartreuse4", 
                          name="Probability") + # [Reference 10]
    # scale_colour_gradient(low = "#993333", high = "#99CC66") + # [Reference 10]
    # scale_colour_brewer("RdYlGn") +
    xlab("ESA Recovery Plans") +
    ylab("Probability of inclusion of Recovery Plans\nin funded portfolio") +
    theme_bw() +
    theme(panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          panel.background = element_blank(),
          panel.border = element_blank(),
          axis.line = element_line(colour = "black"),
          axis.text.x = element_text(angle = 0, vjust = 1, hjust=1),
          axis.text = element_text(size=11)) +
    scale_x_continuous(breaks = seq(0,600, by = 100)) +
    theme(legend.key = element_blank(), strip.background = element_blank(), legend.text = element_text(size = 10)) +
    background_grid(major = "none", minor = "none") 


Figure5 

ggsave("./output/Run 18 - May2019/Figure5a.HHM B_probfund vs plan.pdf", width = 15, height = 10, units = "cm")

# Add vertical lines to show where the medium budget threshold is. This will be static when uncertainty ISN'T introduced into Cost. 
# See from how_many_plans_for_15M above.

Figure5redo <- Figure5 + 
    geom_vline(xintercept = c(how_many_plans_for_15M))
    
Figure5redo

ggsave("./output/Run 18 - May2019/Figure5b.HHM_B probfund vs plan, highlight threshold.pdf", width = 20, height = 10, units = "cm")

```
