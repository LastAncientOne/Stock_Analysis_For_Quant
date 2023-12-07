# ARFIMA (Autoregressive Fractionally Integrated Moving
# Load required libraries
library(fracdiff)
library(quantmod)
library(forecast)
library(ggplot2)

symbol <- 'NVDA'
start <- '2018-01-01'
end <- '2023-08-01'

getSymbols(symbol, from = start, to = end)

stock_data <- Ad(get(symbol))

stock_ts <- ts(stock_data, frequency = 12)  # Assuming monthly data (adjust frequency as needed)

# Estimate ARFIMA model
arfima_model <- arfima(stock_ts)

forecast_period <- 12  # Example: forecasting for the next 12 periods (adjust as needed)
forecast_result <- forecast(arfima_model, h = forecast_period)

# Plot the forecast
plot(forecast_result, main = paste(symbol, " Stock Price Forecast"))

# Add historical data in blue
lines(stock_ts, col = "blue", lwd = 2)

print(forecast_result)

# Calculate the accuracy measures
actual_values <- stock_ts[(length(stock_ts) - forecast_period + 1):length(stock_ts)]  # Actual values for the forecast period

# Mean Absolute Error (MAE)
mae <- mean(abs(forecast_result$mean - actual_values))

# Mean Squared Error (MSE)
mse <- mean((forecast_result$mean - actual_values)^2)

# Root Mean Squared Error (RMSE)
rmse <- sqrt(mse)

# Mean Absolute Percentage Error (MAPE)
mape <- mean(abs((forecast_result$mean - actual_values) / actual_values)) * 100

# Display the accuracy measures
cat("Mean Absolute Error (MAE):", mae, "\n")
cat("Mean Squared Error (MSE):", mse, "\n")
cat("Root Mean Squared Error (RMSE):", rmse, "\n")
cat("Mean Absolute Percentage Error (MAPE):", mape, "%\n")

