library(quantmod)
library(tseries)

# Define your stock symbol and date range
symbol <- "NVDA"  # Change this to your desired stock symbol
start <- "2018-01-01"
end <- "2024-01-01"

# Download stock data
stock_data <- tryCatch(
  expr = getSymbols(symbol, from = start, to = end, auto.assign = FALSE),
  error = function(e) {
    cat("Error downloading stock data. Check if the symbol and date range are valid.\n")
    return(NULL)
  }
)

# Check if stock_data is not NULL
if (is.null(stock_data)) {
  cat("Exiting due to download error.\n")
  quit(save = "no", status = 1, runLast = FALSE)
}

# Extract the closing prices from the stock data
closing_prices <- Cl(stock_data)

# Check if there are at least 2 periods
if (length(closing_prices) < 2) {
  cat("Not enough data for analysis. Exiting.\n")
  quit(save = "no", status = 1, runLast = FALSE)
}

# Check for strict stationarity
strict_stationary <- all(diff(closing_prices) == diff(closing_prices, lag = 2))
if (strict_stationary) {
  cat("Data satisfies strict stationarity.\n")
} else {
  cat("Data is not strictly stationary.\n")
}

# Check for seasonality
if (length(closing_prices) >= 4) {
  seasonal_stationary <- decompose(ts(closing_prices, frequency = 4))$seasonal
  if (any(!is.na(seasonal_stationary))) {
    cat("Data exhibits seasonality.\n")
  } else {
    cat("Data does not exhibit seasonality.\n")
  }
} else {
  cat("Not enough data for seasonality analysis.\n")
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