library(quantmod)
library(tsibble)
library(fable)
library(dplyr)

# Define your stock symbol and date range
symbol <- "AAPL"  # Change this to your desired stock symbol
start <- "2021-01-01"
end <- "2021-12-31"

# Download stock data
getSymbols(symbol, from = start, to = end)

# Extract the closing prices from the stock data
stock_data <- Cl(get(symbol))

# Create a tsibble
stock_tsibble <- tibble(
  Date = time(stock_data),
  Close = stock_data
) %>%
  as_tsibble(index = Date)

# Define your forecasting model
model <- stock_tsibble %>%
  model(ARIMA = ARIMA(Close))

# Forecast future closing prices
forecast_results <- forecast(model, h = 10)  # Forecast for the next 10 periods

# Print the forecast results
print(forecast_results)