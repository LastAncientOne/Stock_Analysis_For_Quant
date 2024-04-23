# Load the required library
library(quantmod)

# Function to calculate Garman-Klass volatility
garman_klass_volatility <- function(high, low, close, T) {
  n <- length(high)
  sum_term <- sum(log(high / low)^2 * (2 * log(2) - 1) / T * (close / close[1])^2)
  sigma_gk <- sqrt(1 / (2 * T) * sum_term)
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

# Calculate Garman-Klass volatility
sigma_gk <- garman_klass_volatility(data$AAPL.High, data$AAPL.Low, data$AAPL.Close, nrow(data))

# Print the result
print(sigma_gk)