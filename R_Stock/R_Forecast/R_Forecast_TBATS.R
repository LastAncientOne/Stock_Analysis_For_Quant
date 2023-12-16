# TBATS (Trigonometric seasonality, Box-Cox transformation, ARMA errors, Trend and Seasonal)
# Load required libraries
library(quantmod)
library(forecast)
library(ggplot2)

symbol <- 'NVDA'
start <- '2018-01-01'
end <- '2023-08-01'

getSymbols(symbol, from = start, to = end)

stock_data <- Ad(get(symbol))

stock_ts <- ts(stock_data, frequency = 12)  # Assuming monthly data (adjust frequency as needed)

# Fit a TBATS model
tbats_model <- tbats(stock_ts)

forecast_period <- 12  # Example: forecasting for the next 12 periods (adjust as needed)
forecast_result <- forecast(tbats_model, h = forecast_period)

# Plot the forecast
plot(forecast_result, main = paste(symbol, " Stock Price Forecast"))

# Add historical data in blue
lines(stock_ts, col = "blue", lwd = 2)

print(forecast_result)

# Calculate accuracy measures for the forecast
accuracy_measures <- accuracy(forecast_result)

# Print the accuracy measures
print(accuracy_measures)
