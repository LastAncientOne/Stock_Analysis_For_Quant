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

# Calculate Hodges-Tompkins estimator
hodges_tompkins <- function(returns) {
  n <- length(returns)
  sorted_returns <- sort(returns)
  h <- median(returns)
  w <- 1 - abs((1:(n-1) - (n - 1) / 2) / n)
  ht_estimator <- sum(w * sorted_returns[-n])
  return(ht_estimator)
}

# Apply Hodges-Tompkins estimator to your returns
ht_estimate <- hodges_tompkins(returns)
print(ht_estimate)
