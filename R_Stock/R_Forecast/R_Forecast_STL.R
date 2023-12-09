# Forecasting with STL
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

# Decompose the time series using STL
stl_decomp <- stl(stock_ts, s.window = "periodic")

# Perform forecasting on the remainder component using ETS
ets_model <- ets(stl_decomp$time.series[, "remainder"])

# Define the forecast period
forecast_period <- 12  # Example: forecasting for the next 12 periods (adjust as needed)

# Forecast the remainder component
forecast_result <- forecast(ets_model, h = forecast_period)

# Add the seasonal and trend components to the forecasted remainder
forecast_result$mean <- forecast_result$mean + stl_decomp$time.series[, "seasonal"] +
  stl_decomp$time.series[, "trend"]

# Plot the forecast
plot(forecast_result, main = paste(symbol, " Stock Price Forecast"))

# Add historical data in blue
lines(stock_ts, col = "blue", lwd = 2)

# Print the forecast result
print(forecast_result)

actual_prices <- stock_ts[(length(stock_ts) - forecast_period + 1):length(stock_ts)]

# Calculate Mean Absolute Error (MAE)
mae <- mean(abs(forecast_result$mean - actual_prices))

# Calculate Mean Squared Error (MSE)
mse <- mean((forecast_result$mean - actual_prices)^2)

# Calculate Root Mean Squared Error (RMSE)
rmse <- sqrt(mse)

# Calculate Mean Absolute Percentage Error (MAPE)
mape <- mean(abs((actual_prices - forecast_result$mean) / actual_prices)) * 100

# Print the accuracy measures
cat("Mean Absolute Error (MAE):", mae, "\n")
cat("Mean Squared Error (MSE):", mse, "\n")
cat("Root Mean Squared Error (RMSE):", rmse, "\n")
cat("Mean Absolute Percentage Error (MAPE):", mape, "%\n")
