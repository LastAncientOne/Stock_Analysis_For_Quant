library(quantmod)
library(ForecastTB)
library(forecast)

# Define your stock symbol and date range
symbol <- "NVDA"  # Change this to your desired stock symbol
start <- "2020-01-01"
end <- "2023-10-01"

# Download stock data
stock_data <- getSymbols(symbol, from = start, to = end, auto.assign = FALSE)

# Extract the closing prices from the stock data
closing_prices <- Cl(stock_data)

# Create a time series object
stock_ts <- as.ts(closing_prices)

# Plot the time series data
plot(stock_ts, main = paste("Stock Price for", symbol), ylab = "Price")

# Decompose the time series to check for trends and seasonality
decomposed <- decompose(stock_ts)

# Plot the decomposed time series
plot(decomposed)

# Fit an ARIMA model to the time series
arima_model <- auto.arima(stock_ts)

# Print the ARIMA model summary
print(summary(arima_model))

# Forecast future stock prices
forecast_horizon <- 100  # Change this to your desired forecast horizon
stock_forecast <- forecast(arima_model, h = forecast_horizon)

# Plot the forecast
plot(stock_forecast, main = paste("Stock Price Forecast for", symbol))

# Print the forecasted values
print(stock_forecast)