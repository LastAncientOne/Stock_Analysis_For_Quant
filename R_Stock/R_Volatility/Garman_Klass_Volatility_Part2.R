# Load the required library
library(quantmod)

# Function to calculate Garman Klass Volatility
garman_klass_volatility <- function(high, low, close, open) {
  N <- length(high)
  
  sum_term <- sum((high - low)^2 - (2 * log(2) - 1) * (close - open)^2)
  
  sigma_gk <- sqrt((1/N) * sum_term)
  
  return(sigma_gk)
}

# Individual symbol
symbol <- "AAPL"

# Set the start and end date of the analysis
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Get the historical data
getSymbols(symbol, from = start_date, to = end_date)
data <- get(symbol)

# Extract necessary data
high <- data$AAPL.High
low <- data$AAPL.Low
close <- data$AAPL.Close
open <- data$AAPL.Open

# Calculate Garman Klass Volatility
gk_volatility <- garman_klass_volatility(high, low, close, open)

# Print the result
print(paste("Garman Klass Volatility:", gk_volatility))

