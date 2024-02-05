# Load the required libraries
library(quantmod)
library(tseries)

# Define your stock symbol and date range
symbol <- "NVDA"  # Change this to your desired stock symbol
start <- "2020-01-01"
end <- "2023-10-11"

# Download stock data
getSymbols(symbol, from = start, to = end)

# Extract the stock price data
stock_data <- Ad(get(symbol))

# Convert the data to a time series
stock_ts <- ts(stock_data, frequency = 365)

# Plot the time series data
plot(stock_ts, main = paste("Stock Price for", symbol), ylab = "Price")

# Check for stationarity of the original series
adf_test_result <- adf.test(stock_ts)
cat("ADF Test p-value (Original Series):", adf_test_result$p.value, "\n")

if (adf_test_result$p.value > 0.05) {
  cat("The original series is not stationary. Differencing the series.\n")
  
  # Difference the data to make it stationary (e.g., of order 1)
  differenced_stock_ts <- diff(stock_ts)
  
  # Plot the differenced time series data
  plot(differenced_stock_ts, main = paste("Differenced Stock Price for", symbol), ylab = "Price Difference")
  
  # Check for stationarity of the differenced series
  adf_test_result_diff <- adf.test(differenced_stock_ts)
  cat("ADF Test p-value (Differenced Series):", adf_test_result_diff$p.value, "\n")
  
  # Fit an ARIMA model
  arima_model <- arima(differenced_stock_ts, order = c(1, 1, 1))
  
  # Provide guidance on interpreting ARIMA results
  cat("ARIMA Model Summary:\n")
  print(summary(arima_model))
} else {
  cat("The original series is stationary. No differencing is required.\n")
  
  # Fit an ARIMA model
  arima_model <- arima(stock_ts, order = c(1, 0, 1))
  
  # Provide guidance on interpreting ARIMA results
  cat("ARIMA Model Summary:\n")
  print(summary(arima_model))
}

# Forecast future prices
forecast_period <- 30  # Change this to your desired forecast horizon
forecasted_prices <- forecast(arima_model, h = forecast_period)

# Plot the forecast
plot(forecasted_prices, main = paste("Stock Price Forecast for", symbol), ylab = "Price Forecast")

# Print the forecasted values
print(forecasted_prices)

