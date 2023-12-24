# SNaive
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

# Fit a Seasonal Naive (snaive) forecast model to the historical data
snaive_forecast <- snaive(stock_ts, h = forecast_period)

# Plot the forecast
plot(snaive_forecast, main = paste(symbol, " Stock Price Forecast"), xlab = "Date", ylab = "Price", type = "l", col = "red")
lines(stock_ts, col = "blue", lwd = 2)

# Add a legend
legend("topleft", legend = c("Forecast", "Historical"), col = c("red", "blue"), lty = 1, lwd = 2)

# Print the forecast result
print(snaive_forecast)

# Accuracy measures for a forecast model
accuracy(snaive_forecast)
