# Load the required library
library(quantmod)

# Function to calculate Parkinson Volatility
parkinson_volatility <- function(high, low) {
  N <- length(high)
  log_returns <- log(high / low) ^ 2
  return(sqrt((1/N) * (1/(4 * log(2))) * sum(log_returns)))
}

# Individual symbol
symbol <- "AAPL"

# Set the start and end date of the analysis
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Get the historical data
getSymbols(symbol, from = start_date, to = end_date)
data <- get(symbol)

# Extract high and low prices
high_prices <- as.numeric(data$AAPL.High)
low_prices <- as.numeric(data$AAPL.Low)

# Calculate Parkinson Volatility
parkinson_vol <- parkinson_volatility(high_prices, low_prices)
print(parkinson_vol)
