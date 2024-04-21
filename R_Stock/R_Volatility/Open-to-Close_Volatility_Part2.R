# Load the required library
library(quantmod)

# Individual symbol
symbol <- "AAPL"

# Set the start and end date of the analysis
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Get the historical data
getSymbols(symbol, from = start_date, to = end_date)
data <- Cl(AAPL) / Op(AAPL)  # Closing price divided by opening price

# Calculate log returns
log_returns <- log(data)

# Calculate average log return
avg_log_return <- mean(log_returns)

# Calculate squared differences from the average
squared_diff <- (log_returns - avg_log_return)^2

# Sum up the squared differences
sum_squared_diff <- sum(squared_diff)

# Calculate variance
variance <- sum_squared_diff / (length(log_returns) - 1)

# Calculate volatility
oc_volatility <- sqrt(variance)

# Print Result
oc_volatility