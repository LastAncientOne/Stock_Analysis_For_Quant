# Load necessary libraries
library(quantmod)
library(stats)
library(tseries)

# Define your stock symbol and date range
symbol <- "NVDA"  # Change this to your desired stock symbol
start <- as.Date("2022-01-01")
end <- as.Date("2024-01-01")

# Download stock data
getSymbols(symbol, from = start, to = end, auto.assign = TRUE)

# Extract the closing prices from the stock data
closing_prices <- Cl(get(symbol))

# Convert closing_prices to a numeric vector
closing_prices_numeric <- as.numeric(closing_prices)

# Check for Stationarity
adf_test <- adf.test(closing_prices_numeric)
if (adf_test$p.value > 0.05) {
  # If not stationary, difference the series
  closing_prices_numeric <- diff(closing_prices_numeric)
}

# Fit an autoregressive model
ar_model <- ar(closing_prices_numeric)

# Forecast future prices using the AR model
forecast_values <- predict(ar_model, n.ahead = 100)

# Evaluate the Model (Example: Mean Absolute Error)
actual_values <- closing_prices_numeric[(length(closing_prices_numeric) - 99):length(closing_prices_numeric)]
mae <- mean(abs(forecast_values$pred - actual_values))

cat("Mean Absolute Error:", mae, "\n")

# Plot closing prices
plot(closing_prices_numeric, type = "l", col = "blue", xlab = "Time", ylab = "Closing Prices", main = "Closing Prices and Forecast")

# Add forecast values to the plot
lines(length(closing_prices_numeric):(length(closing_prices_numeric) + 99), forecast_values$pred, col = "red")

# Add legend
legend("topright", legend = c("Closing Prices", "Forecast"), col = c("blue", "red"), lty = 1)
