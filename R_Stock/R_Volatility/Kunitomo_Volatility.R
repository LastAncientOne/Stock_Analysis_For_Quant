# Load the required library
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

# Function to calculate Kunitomo volatility estimator
kunitomo_volatility <- function(returns) {
  n <- length(returns)
  rs_sum <- cumsum(returns)
  rs2_sum <- cumsum(returns^2)
  kunitomo_vol <- (1/n) * (rs2_sum - (1:n) * (1/n) * (rs_sum^2))
  return(kunitomo_vol)
}

# Calculate Kunitomo volatility estimator
kunitomo_volatility_est <- kunitomo_volatility(returns)

# Print the result
print(kunitomo_volatility_est)
