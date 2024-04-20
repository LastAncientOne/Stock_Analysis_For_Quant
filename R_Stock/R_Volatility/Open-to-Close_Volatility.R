# Load the required library
library(quantmod)

# Function to calculate Open to Close Volatility
calculate_open_to_close_volatility <- function(data) {
  # Calculate the logarithm of the ratio of open to close prices
  log_ratio <- log(Op(data) / lag(Cl(data), default = NA))
  
  # Calculate the average logarithm of the ratio
  avg_log_ratio <- mean(log_ratio, na.rm = TRUE)
  
  # Calculate the squared differences from the average
  squared_diff <- (log_ratio - avg_log_ratio)^2
  
  # Calculate the sum of squared differences
  sum_squared_diff <- sum(squared_diff, na.rm = TRUE)
  
  # Calculate the Open to Close Volatility
  open_to_close_volatility <- sqrt(sum_squared_diff / (length(log_ratio) - 1))
  
  return(open_to_close_volatility)
}

# Individual symbol
symbol <- "AAPL"

# Set the start and end date of the analysis
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Get the historical data
getSymbols(symbol, from = start_date, to = end_date)
data <- get(symbol)

# Calculate Open to Close Volatility
ov <- calculate_open_to_close_volatility(data)
print(paste("Open to Close Volatility for", symbol, ":", ov))
