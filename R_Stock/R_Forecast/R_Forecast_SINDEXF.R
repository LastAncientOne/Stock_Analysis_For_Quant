# Seasonal Index Values 
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
stock_ts <- ts(stock_data, frequency = 12)  # Assuming monthly data

# Calculate seasonal index
seasonal_index <- sindexf(stock_ts)

# Define the forecast period
forecast_period <- 12   # Example: forecasting for the next 12 periods (adjust as needed)

# Create a forecast object
forecast_result <- forecast(auto.arima(stock_ts), h = forecast_period)

# Add historical data in blue
plot(forecast_result, main = paste(symbol, " Stock Price Forecast"))
lines(stock_ts, col = "blue", lwd = 2)

# Print the forecast result
print(forecast_result)

# Accuracy measures for a forecast model
# Actual values
actual_values <- window(stock_ts, start = end(stock_ts) - forecast_period + 1)

# Forecasted values
forecasted_values <- as.vector(forecast_result$mean)

# Calculate Mean Absolute Error (MAE)
mae <- mean(abs(actual_values - forecasted_values))

# Calculate Mean Squared Error (MSE)
mse <- mean((actual_values - forecasted_values)^2)

# Calculate Root Mean Squared Error (RMSE)
rmse <- sqrt(mse)

# Calculate Mean Absolute Percentage Error (MAPE)
mape <- mean(abs((actual_values - forecasted_values) / actual_values)) * 100

# Print the accuracy measures
cat("Mean Absolute Error (MAE):", mae, "\n")
cat("Mean Squared Error (MSE):", mse, "\n")
cat("Root Mean Squared Error (RMSE):", rmse, "\n")
cat("Mean Absolute Percentage Error (MAPE):", mape, "%\n")
