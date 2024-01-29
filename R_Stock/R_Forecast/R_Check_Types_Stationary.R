library(quantmod)

# Define your stock symbol and date range
symbol <- "NVDA"  # Change this to your desired stock symbol
start <- "2012-01-01"
end <- "2024-01-01"

# Download stock data
stock_data <- getSymbols(symbol, from = start, to = end, auto.assign = FALSE)

# Extract the closing prices from the stock data
closing_prices <- Cl(stock_data)

# Convert to monthly frequency
monthly_prices <- to.period(closing_prices, period = "months", OHLC = FALSE)

# Check for strict stationarity
strict_stationary <- all(diff(closing_prices) == diff(closing_prices, lag = 2))
if (strict_stationary) {
  cat("Data satisfies strict stationarity.\n")
} else {
  cat("Data is not strictly stationary.\n")
}


# Check for seasonality
seasonal_stationary <- decompose(closing_prices)$seasonal
if (any(!is.na(seasonal_stationary))) {
  cat("Data exhibits seasonality.\n")
} else {
  cat("Data does not exhibit seasonality.\n")
}

# Check for trend stationarity
adf_test_result <- adf.test(closing_prices)
if (adf_test_result$p.value >= 0.05) {
  cat("Data was non-stationary. Trend stationarity not satisfied.\n")
} else {
  cat("Data was stationary. Trend stationarity satisfied.\n")
}

# Print the result
print(head(closing_prices))