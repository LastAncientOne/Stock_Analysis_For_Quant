# Random Walk Forecasts
# Load required libraries
library(quantmod)
library(forecast)
library(ggplot2)

# Define your symbol and time frame
symbol <- 'NVDA'
start <- '2018-01-01'
end <- '2023-08-01'

# Download stock data
getSymbols(symbol, from = start, to = end)
stock_data <- Ad(get(symbol))

# Convert stock data to a time series (assuming monthly data)
stock_ts <- ts(stock_data, frequency = 12)

# Define the forecast period
forecast_period <- 12  # Example: forecasting for the next 12 periods (adjust as needed)

# Fit a Random Walk Forecasts model to the historical data
rvf_forecast <- rwf(stock_ts, h = forecast_period, drift = TRUE)

# Plot the forecast
plot(rvf_forecast, main = paste(symbol, " Stock Price Forecast"), xlab = "Date", ylab = "Price", type = "l", col = "red")
lines(stock_ts, col = "blue", lwd = 2)

# Add a legend
legend("topleft", legend = c("Forecast", "Historical"), col = c("red", "blue"), lty = 1, lwd = 2)

# Print the forecast result
print(rvf_forecast)

# Calculate accuracy measures
actual_values <- tail(stock_ts, forecast_period)  # Actual values for the forecast period
forecast_values <- as.vector(rvf_forecast$mean)    # Forecasted values

# Calculate Mean Absolute Error (MAE)
mae <- mean(abs(actual_values - forecast_values))

# Calculate Mean Squared Error (MSE)
mse <- mean((actual_values - forecast_values)^2)

# Calculate Root Mean Squared Error (RMSE)
rmse <- sqrt(mse)

# Calculate Mean Absolute Percentage Error (MAPE)
mape <- mean(abs((actual_values - forecast_values) / actual_values)) * 100

# Print the accuracy measures
cat("Mean Absolute Error (MAE): ", mae, "\n")
cat("Mean Squared Error (MSE): ", mse, "\n")
cat("Root Mean Squared Error (RMSE): ", rmse, "\n")
cat("Mean Absolute Percentage Error (MAPE): ", mape, "%\n")

