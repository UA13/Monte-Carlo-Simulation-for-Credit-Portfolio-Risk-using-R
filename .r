library(dplyr)

n_loans <- 100        
loan_amount <- 100000 
PD <- 0.0704          
EAD <- 1              
LGD <- 0.75          

EL_per_loan <- loan_amount * PD * EAD * LGD

n_simulations <- 10000
losses <- numeric(n_simulations)  

set.seed(123)  

for (i in 1:n_simulations) {
  default_vector <- rbinom(n_loans, 1, PD)
  total_loss <- sum(default_vector * loan_amount * EAD * LGD)
  losses[i] <- total_loss
}

EL <- mean(losses)  
UL <- sd(losses)    
VaR_99.9 <- quantile(losses, 0.999)  
Capital <- UL - EL

results <- data.frame(
  Metric = c("Expected Loss (EL)", "Unexpected Loss (UL)", "VaR 99.9%", "Capital Requirement"),
  Value = c(EL, UL, VaR_99.9, Capital)
)

print(results)
