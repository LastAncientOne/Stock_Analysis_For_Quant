library(quantmod)
library(ForecastTB)

# Define your stock symbol and date range
symbol <- "NVDA"  # Change this to your desired stock symbol
start <- "2021-01-01"
end <- "2023-10-11"

# Download stock data
getSymbols(symbol, from = start, to = end)

# Extract the closing prices from the stock data
closing_prices <- Ad(get(symbol))

# Fit an ARIMA model to the closing prices
arima_model <- forecast(closing_prices, method = "arima")

# Print the summary of the ARIMA model
summary(arima_model)

# Make forecasts
forecast_values <- predict(arima_model, n.ahead = 10)  # Change the number of periods as needed

# Print the forecasts
print(forecast_values)

# Plot the forecast
plot(forecast_values, main = "ARIMA Forecast for NVDA Stock", xlab = "Date", ylab = "Price")