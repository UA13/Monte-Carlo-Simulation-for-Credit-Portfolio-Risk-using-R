set.seed(123)

n_loans <- 100
nominal_amount <- 100000
PD <- 0.0704
LGD <- 0.75
EAD <- 1
n_simulations <- 10000

EL <- n_loans * nominal_amount * PD * LGD

losses <- numeric(n_simulations)

for (i in 1:n_simulations) {
  defaults <- runif(n_loans) < PD
  total_loss <- sum(defaults * nominal_amount * LGD)
  losses[i] <- total_loss
}

VaR_99_9 <- quantile(losses, 0.999)

UL <- VaR_99_9
economic_capital <- UL - EL

cat("Expected Loss (EL):", EL, "\n")
cat("99.9% VaR (UL):", UL, "\n")
cat("Economic Capital:", economic_capital, "\n")
