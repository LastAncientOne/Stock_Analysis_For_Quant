# Load necessary libraries
library(quantmod)
library(stats)

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

# Difference the time series to make it stationary
diff_prices <- diff(closing_prices_numeric)

# Fit an autoregressive model on the differenced series
arima_model <- arima(diff_prices, order = c(1, 0, 0))  # Adjust order as needed

# Generate forecast values
forecast_values <- predict(arima_model, n.ahead = 100)

# Integrate the forecast values to obtain predictions on the original scale
forecast_prices <- cumsum(closing_prices_numeric[length(closing_prices_numeric)] + forecast_values$pred)

# Evaluate the Model (Example: Mean Absolute Error)
actual_values <- closing_prices_numeric[(length(closing_prices_numeric) - 99):length(closing_prices_numeric)]
mae <- mean(abs(forecast_prices - actual_values))

cat("Mean Absolute Error:", mae, "\n")

# Plot closing prices
plot(closing_prices_numeric, type = "l", col = "blue", xlab = "Time", ylab = "Closing Prices", main = "Closing Prices and Forecast")

# Add forecast values to the plot
lines(length(closing_prices_numeric):(length(closing_prices_numeric) + 99), forecast_prices, col = "red")

# Add legend
legend("topleft", legend = c("Closing Prices", "Forecast"), col = c("blue", "red"), lty = 1)

