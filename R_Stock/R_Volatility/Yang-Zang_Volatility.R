# Load the required library
library(quantmod)

# Individual symbol
symbol <- "AAPL"

# Set the start and end date of the analysis
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Get the historical data
getSymbols(symbol, from = start_date, to = end_date)
data <- get(symbol)

# Calculate the daily returns
returns <- dailyReturn(data$AAPL.Close)

# Calculate the absolute daily returns
abs_returns <- abs(returns)

# Define the lookback window (e.g., 20 days)
lookback_window <- 20

# Calculate the rolling sum of squared returns
rolling_sum_sq_returns <- rollapply(abs_returns^2, lookback_window, sum, align = "right", fill = NA)

# Calculate the Yang-Zhang volatility
YZ_volatility <- sqrt(252 / lookback_window) * sqrt(rolling_sum_sq_returns)

# Print the standard error
cat("Yang-Zhang volatility:", YZ_volatility)

