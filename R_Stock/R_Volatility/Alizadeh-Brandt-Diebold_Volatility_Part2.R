library(quantmod)

# Individual symbol
symbol <- "AAPL"

# Set the start and end date of the analysis
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Get the historical data
getSymbols(symbol, from = start_date, to = end_date)

# Calculate daily simple returns
returns <- Delt(Cl(AAPL))

# Drop NA values
returns <- returns[!is.na(returns)]

# Number of observations
N <- length(returns)

# Initialize variables for volatility calculation
ABD_volatility <- numeric(N)

# Calculate ABD volatility estimator for each observation
for (t in 1:N) {
  # Time lag between observations
  tau <- seq(1, t)
  
  # Mean return over the observations
  mean_return <- mean(returns[1:t])
  
  # Calculate ABD volatility estimator
  ABD_volatility[t] <- sqrt(sum((1 / tau) * (returns[(t - tau + 1)] - mean_return)^2))
}

# Display ABD volatility estimates
print(ABD_volatility)
