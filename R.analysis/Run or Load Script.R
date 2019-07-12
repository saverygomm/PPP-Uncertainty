
# This script will run, or will load. 
if(run.MCMCglmm == TRUE){
    iterations <- 1150000
    thinning   <- 1000
    burnin     <- 150000 
    
    prior1 <- list(G = list(G1 = list(V = diag(1), n = 0.002)), 
                   R = list(V = diag(1), n = 0.002))
    m1.5.MCMCglmm <- MCMCglmm(logit.F0 ~ Feeding.Method +
                                  Nocturnal.Foraging + Age.Class +
                                  Opportunistic.Inferred, 
                              pedigree = tree.all, # PINEAPPLE. This is the full tree, with 9993 tips, not "tree" which (as of Aug 16 has only 205 tips). SHOULD be JUST tree of seabirds once that is fixed.
                              random = ~animal,
                              data = data.2, family = "gaussian",
                              nitt = iterations, thin = thinning, burnin = burnin, 
                              prior = prior1, 
                              pr=TRUE,
                              verbose = TRUE)
    summary(m1.5.MCMCglmm)
    
    #plot(m1.5.MCMCglmm)
    
    autocorr(m1.5.MCMCglmm$VCV)
    
    #Seabirds for which there are no data
    species.list.2[!species.list.2 %in% species.list]
    
    #Examples of posterior modes and highest posterior density intervals for some
    #species in the tree, but not the data
    
    posterior.mode(m1.5.MCMCglmm$Sol[,"animal.Sternula_lorata"])
    HPDinterval(m1.5.MCMCglmm$Sol[,"animal.Sternula_lorata"])
    
    #And for some species in the data
    
    posterior.mode(m1.5.MCMCglmm$Sol[,"animal.Thalassarche_melanophrys"])
    HPDinterval(m1.5.MCMCglmm$Sol[,"animal.Thalassarche_melanophrys"])
    
    posterior.mode(m1.5.MCMCglmm$Sol[,"animal.Puffinus_bulleri"])
    HPDinterval(m1.5.MCMCglmm$Sol[,"animal.Puffinus_bulleri"])
    
    #A trite example of the summing of posteriors
    
    par(mfrow = c(3,3), mar = c(4,4,2,2)+0.5)
    hist(m1.5.MCMCglmm$Sol[,"animal.Sternula_lorata"], 
         xlim = c(-20,15),
         main = "animal.Sternula_lorata")
    mtext(side = 4, text = "+")
    hist(m1.5.MCMCglmm$Sol[,"(Intercept)"],      
         xlim = c(-20,15),
         main = "Intercept")
    mtext(side = 4, text = "+")
    hist(m1.5.MCMCglmm$Sol[,"Feeding.MethodPursuit.Plunging"],      
         xlim = c(-20,15),
         main = "Pursuit plunging")
    mtext(side = 4, text = "+")
    hist(m1.5.MCMCglmm$Sol[,"Nocturnal.ForagingYes"], 
         xlim = c(-20,15),
         main = "Nocturnal")
    mtext(side = 4, text = "+")
    hist(m1.5.MCMCglmm$Sol[,"Age.ClassA"], 
         xlim = c(-20,15),
         main = "Adult")
    mtext(side = 4, text = "+")
    hist(m1.5.MCMCglmm$Sol[,"Opportunistic.InferredYes"], 
         xlim = c(-20,15),
         main = "Opportunistic")
    mtext(side = 4, text = "=", las = 2)
    hist(m1.5.MCMCglmm$Sol[,"animal.Sternula_lorata"]+
             m1.5.MCMCglmm$Sol[,"Feeding.MethodPursuit.Plunging"]+
             m1.5.MCMCglmm$Sol[,"(Intercept)"]+
             m1.5.MCMCglmm$Sol[,"Nocturnal.ForagingYes"]+
             m1.5.MCMCglmm$Sol[,"Opportunistic.InferredYes"]+
             m1.5.MCMCglmm$Sol[,"Age.ClassA"], 
         xlim = c(-20,15),
         main = "Summed distributions")
    
    test.logit.FO <- m1.5.MCMCglmm$Sol[,"animal.Sternula_lorata"]+
        m1.5.MCMCglmm$Sol[,"Feeding.MethodPursuit.Plunging"]+
        m1.5.MCMCglmm$Sol[,"(Intercept)"]+
        m1.5.MCMCglmm$Sol[,"Nocturnal.ForagingYes"]+
        m1.5.MCMCglmm$Sol[,"Opportunistic.InferredYes"]+
        m1.5.MCMCglmm$Sol[,"Age.ClassA"]
    test.FO <- (logit.delta*exp(test.logit.FO)+logit.delta+exp(test.logit.FO))/(1+exp(test.logit.FO))
    HPDinterval(test.FO)
    mean(test.FO)
    
    hist(test.FO, 
         #xlim = c(0,1),
         main = "Back-transformed FO")
    
    
    # a second trite example, showing a different species
    
    par(mfrow = c(3,3), mar = c(4,4,2,2)+0.5)
    hist(m1.5.MCMCglmm$Sol[,"animal.Puffinus_bulleri"], 
         xlim = c(-20,15),
         main = "animal.Puffinus_bulleri")
    mtext(side = 4, text = "+")
    hist(m1.5.MCMCglmm$Sol[,"(Intercept)"],      
         xlim = c(-20,15),
         main = "Intercept")
    hist(m1.5.MCMCglmm$Sol[,"Feeding.MethodPursuit.Plunging"],
         xlim = c(-20,15),
         main = "Pursuit plunging")
    mtext(side = 4, text = "+")
    hist(m1.5.MCMCglmm$Sol[,"Nocturnal.ForagingYes"], 
         xlim = c(-20,15),
         main = "Nocturnal")
    mtext(side = 4, text = "+")
    hist(m1.5.MCMCglmm$Sol[,"Age.ClassA"], 
         xlim = c(-20,15),
         main = "Adult")
    mtext(side = 4, text = "+")
    hist(m1.5.MCMCglmm$Sol[,"Opportunistic.InferredYes"], 
         xlim = c(-20,15),
         main = "Opportunistic")
    mtext(side = 4, text = "=", las = 2)
    hist(m1.5.MCMCglmm$Sol[,"animal.Puffinus_bulleri"]+
             m1.5.MCMCglmm$Sol[,"Feeding.MethodPursuit.Plunging"]+
             m1.5.MCMCglmm$Sol[,"(Intercept)"]+
             m1.5.MCMCglmm$Sol[,"Nocturnal.ForagingYes"]+
             m1.5.MCMCglmm$Sol[,"Age.ClassA"], 
         xlim = c(-20,15),
         main = "Summed distributions")
    
    test.logit.FO <- m1.5.MCMCglmm$Sol[,"animal.Puffinus_bulleri"]+
        m1.5.MCMCglmm$Sol[,"Feeding.MethodPursuit.Plunging"]+
        m1.5.MCMCglmm$Sol[,"(Intercept)"]+
        m1.5.MCMCglmm$Sol[,"Nocturnal.ForagingYes"]+
        m1.5.MCMCglmm$Sol[,"Age.ClassA"]
    test.FO <- (logit.delta*exp(test.logit.FO)+logit.delta+exp(test.logit.FO))/(1+exp(test.logit.FO))
    HPDinterval(test.FO)
    mean(test.FO)
    
    hist(test.FO, 
         #xlim = c(0,1),
         main = "Back-transformed FO")
    
    
    
    #Estimates for each of the species in the tree ()
    colMeans(m1.5.MCMCglmm$Sol)
    
    #Back transform
    data.2$back.transformed.FO <- (logit.delta*exp(data.2$logit.F0)+logit.delta+exp(data.2$logit.F0))/(1+exp(data.2$logit.F0))
    
    #check back transformation
    subset(data.2, select = c("FO","back.transformed.FO"))[1:10,]
    par(mfrow = c(1,1), mar = c(4,4,0,0)+0.5)
    plot(FO ~ back.transformed.FO, data = data.2)
    
    summary <- data.frame(mean = colMeans(m1.5.MCMCglmm$Sol),
                          posterior.mode = posterior.mode(m1.5.MCMCglmm$Sol),
                          lower.HPD = HPDinterval(m1.5.MCMCglmm$Sol)[,1],
                          upper.HPD = HPDinterval(m1.5.MCMCglmm$Sol)[,2])
    
    save(m1.5.MCMCglmm, file = "m1.5.MCMCglmm.Rdata")
    
}else{
    load(file = "m1.5.MCMCglmm.Rdata")
}

```