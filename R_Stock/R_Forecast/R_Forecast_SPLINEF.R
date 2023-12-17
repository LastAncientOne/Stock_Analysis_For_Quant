# Cubic Spline Forecast 
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

# Create a sequence of dates for the forecast period
forecast_dates <- seq(as.Date(end), length.out = forecast_period + 1, by = "months")[2:(forecast_period + 1)]

# Fit a cubic spline to historical data
spline_fit <- smooth.spline(time(stock_ts), stock_ts, spar = 0.5)

# Predict using the cubic spline model for the forecast period
forecast_values <- predict(spline_fit, x = as.numeric(forecast_dates))$y

# Convert the forecasted values to a time series
forecast_ts <- ts(forecast_values, frequency = 12)

# Plot the forecast
plot(forecast_ts, main = paste(symbol, " Stock Price Forecast"), xlab = "Date", ylab = "Price", type = "l", col = "red")
lines(stock_ts, col = "blue", lwd = 2)

# Add a legend
legend("topright", legend = c("Forecast", "Historical"), col = c("red", "blue"), lty = 1, lwd = 2)

# Print the forecast result
print(forecast_ts)

# Calculate the accuracy measures
actual_values <- stock_ts[1:forecast_period]  # Actual values for the forecast period

# Calculate Mean Absolute Error (MAE)
mae <- mean(abs(forecast_values - actual_values))

# Calculate Mean Squared Error (MSE)
mse <- mean((forecast_values - actual_values)^2)

# Calculate Root Mean Squared Error (RMSE)
rmse <- sqrt(mse)

# Calculate Mean Absolute Percentage Error (MAPE)
mape <- mean(abs((forecast_values - actual_values) / actual_values)) * 100

# Print the accuracy measures
cat("Mean Absolute Error (MAE):", mae, "\n")
cat("Mean Squared Error (MSE):", mse, "\n")
cat("Root Mean Squared Error (RMSE):", rmse, "\n")
cat("Mean Absolute Percentage Error (MAPE):", mape, "\n") 