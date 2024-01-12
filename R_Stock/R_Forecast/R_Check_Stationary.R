library(quantmod)

# Define your stock symbol and date range
symbol <- "NVDA"  # Change this to your desired stock symbol
start <- "2020-01-01"
end <- "2023-10-01"

# Download stock data
stock_data <- getSymbols(symbol, from = start, to = end, auto.assign = FALSE)

# Extract the closing prices from the stock data
closing_prices <- Cl(stock_data)

# Check for stationarity and difference if necessary
adf_test_result <- adf.test(closing_prices)
if (adf_test_result$p.value >= 0.05) {
  closing_diff <- diff(closing_prices)
  cat("Data was non-stationary. Differencing applied.\n")
} else {
  closing_diff <- closing_prices
  cat("Data was stationary. No differencing applied.\n")
}

# Print the result
print(head(closing_diff))