# Load required libraries
library(quantmod)
library(ForecastTB)

# Define your stock symbol and date range
symbol <- "NVDA"  # Change this to your desired stock symbol
start <- "2020-01-01"
end <- "2023-10-11"

# Download stock data
getSymbols(symbol, from = start, to = end)

# Extract the closing prices from the stock data
closing_prices <- Ad(get(symbol))

# Create a time series object
stock_ts <- as.ts(closing_prices)

# Split data into training and testing sets
train_size <- 500  # Choose an appropriate size for your training data
train_data <- head(stock_ts, train_size)
test_data <- tail(stock_ts, length(stock_ts) - train_size)

# Perform time series forecasting (You can choose your forecasting method)
# Example: Using a simple exponential smoothing model
forecast_model <- ets(train_data)

# Forecast future values
forecast_horizon <- 100  # Adjust the number of future periods to forecast
forecast_result <- forecast(forecast_model, h = forecast_horizon)

# Print the forecasted values
print(forecast_result)

# Plot the forecast
plot(forecast_result, main = paste("Forecast for", symbol), xlab = "Time", ylab = "Price")
