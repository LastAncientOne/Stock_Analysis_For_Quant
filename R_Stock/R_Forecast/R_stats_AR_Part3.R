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
mse <- mean((forecast_values$pred - actual_values)^2)
rmse <- sqrt(mse)

# Check if the standard deviation is zero
if (sd(forecast_values$pred) == 0) {
  cat("Warning: The standard deviation of forecasted values is zero. R-squared cannot be calculated.\n")
  r2 <- NA
  adjusted_r2 <- NA
} else {
  r2 <- cor(forecast_values$pred, actual_values)^2
  adjusted_r2 <- 1 - (1 - r2) * (length(actual_values) - 1) / (length(actual_values) - length(ar_model$ar))
}

# Print the metrics
cat("Mean Absolute Error:", mae, "\n")
cat("Mean Squared Error (MSE):", mse, "\n")
cat("Root Mean Squared Error (RMSE):", rmse, "\n")
cat("Coefficient of Determination (R-squared):", r2, "\n")
cat("Adjusted R Squared:", adjusted_r2, "\n")

# Plot closing prices
plot(closing_prices_numeric, type = 'l', col = 'blue', xlab = 'Days', ylab = 'Closing Prices', main = 'Stock Prices and Forecast')
lines(c(length(closing_prices_numeric):(length(closing_prices_numeric) + 99)), forecast_values$pred, col = 'red', lty = 2)

# Add legend
legend("topright", legend = c("Closing Prices", "Forecast"), col = c('blue', 'red'), lty = c(1, 2))

