# Load the required library
library(quantmod)

# Function to calculate HLOC volatility
calculate_HLOC_volatility <- function(data) {
  n <- nrow(data)
  
  # Calculate the logarithm of the H, L, O, and C prices
  log_H <- log(data$AAPL.High)
  log_L <- log(data$AAPL.Low)
  log_O <- log(data$AAPL.Open)
  log_C <- log(data$AAPL.Close)
  
  # Calculate the summation part of the formula
  sum_part <- sum(0.5 * (log_H/log_L)^2 - (2*log(2) - 1) * (log_C/log_O)^2)
  
  # Calculate the volatility
  volatility <- sqrt((252/n) * sum_part)
  
  return(volatility)
}

# Individual symbol
symbol <- "AAPL"

# Set the start and end date of the analysis
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Get the historical data
getSymbols(symbol, from = start_date, to = end_date)
data <- get(symbol)

# Calculate HLOC volatility
HLOC_volatility <- calculate_HLOC_volatility(data)
print(HLOC_volatility)
