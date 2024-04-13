# Load the required library
library(quantmod)

# Individual symbol
symbol <- "AAPL"

# Set the start and end date of the analysis
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Calculate Parkinson Volatility
parkinson_volatility <- function(high, low, T) {
  # Calculate the logarithm of high/low ratio
  log_ratio <- log(high / low)
  
  # Calculate the square of log ratio
  log_ratio_sq <- log_ratio^2
  
  # Calculate the sum of squared log ratio
  sum_log_ratio_sq <- sum(log_ratio_sq)
  
  # Calculate the Parkinson Volatility
  parkinson_vol <- sqrt((1 / (4 * T)) * sum_log_ratio_sq)
  
  return(parkinson_vol)
}

# Assuming 'data' contains OHLC data
T <- nrow(data)  # Number of data points (24 in your formula)
high <- data$AAPL.High
low <- data$AAPL.Low

# Calculate Parkinson Volatility
parkinson_vol <- parkinson_volatility(high, low, T)

# Print the result
print(parkinson_vol)
