# ETS forecasts
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

ets_model <- ets(stock_ts)

forecast_period <- 12  # Example: forecasting for the next 12 periods (adjust as needed)
forecast_result <- forecast(ets_model, h = forecast_period)

# Plot the forecast
plot(forecast_result, main = paste(symbol, " Stock Price Forecast"))  # Corrected the paste function

# Add historical data in blue
lines(stock_ts, col = "blue", lwd = 2)

print(forecast_result)