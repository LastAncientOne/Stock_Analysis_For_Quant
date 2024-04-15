library(quantmod)

# Individual symbol
symbol <- "AAPL"

# Set the start and end date of the analysis
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Get the historical data
getSymbols(symbol, from = start_date, to = end_date)
data <- get(symbol)

# Function to calculate High Low Volatility
calculate_HL_volatility <- function(data) {
  n <- nrow(data)
  HL_ratio <- (log(data[, "AAPL.High"]) - log(data[, "AAPL.Low"]))^2
  sum_HL_ratio <- sum(HL_ratio)
  HL_volatility <- sqrt((1/(4 * log(2) * 252/n)) * sum_HL_ratio)
  return(HL_volatility)
}

# Calculate High Low Volatility
HL_volatility <- calculate_HL_volatility(data)
print(paste("High Low Volatility for", symbol, "is:", HL_volatility))