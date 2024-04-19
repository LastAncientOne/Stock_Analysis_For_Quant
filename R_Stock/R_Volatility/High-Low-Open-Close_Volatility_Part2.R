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

# Calculate HLOC Volatility
H <- data[, "AAPL.High"]
L <- data[, "AAPL.Low"]
O <- data[, "AAPL.Open"]
C <- data[, "AAPL.Close"]

n <- length(H)

sum_terms <- sum(0.5 * (log(H / L))^2 - (2 * log(2) - 1) * (log(C / O))^2)

sigma_HLOC <- sqrt((252 / n) * sum_terms)

print(sigma_HLOC)
