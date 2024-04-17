# Load the required library
library(quantmod)

# Function to calculate High Low Volatility
calculate_HLV <- function(data, n = 24) {
  high <- Hi(data)
  low <- Lo(data)
  n <- min(n, nrow(data))
  
  HL_ratio <- log(high / low)^2
  
  sigma_HLV <- sqrt((1 / (4 * log(2) * 252 / n)) * sum(tail(HL_ratio, n)))
  
  return(sigma_HLV)
}

# Individual symbol
symbol <- "AAPL"

# Set the start and end date of the analysis
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Get the historical data
getSymbols(symbol, from = start_date, to = end_date)
data <- get(symbol)

# Calculate High Low Volatility
HLV <- calculate_HLV(data)
print(paste("High Low Volatility for", symbol, "is", round(HLV, 4)))
