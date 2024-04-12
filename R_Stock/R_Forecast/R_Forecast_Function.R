library(quantmod)
library(forecast)

# Function to forecast time series
forecast_timeseries <- function(symbol, start, end) {
  # Download stock data
  stock_data <- getSymbols(symbol, from = start, to = end, auto.assign = FALSE)
  
  # Extract the closing prices from the stock data
  closing_prices <- Cl(stock_data)
  
  # Create a time series object
  ts_data <- ts(closing_prices, frequency = 1)
  
  # Fit an ARIMA model
  arima_model <- auto.arima(ts_data)
  
  # Forecast future values
  forecast_values <- forecast(arima_model, h = 10)  # Change 'h' to the desired number of forecast values
  
  # Plot the forecast
  plot(forecast_values, main = paste("Forecast for", symbol, "Closing Prices"))
  
  # Return the forecast values
  return(forecast_values)
}

# Define your stock symbol and date range
symbol <- "NVDA"  # Change this to your desired stock symbol
start <- "2020-01-01"
end <- "2023-10-01"

# Call the function to forecast the time series
forecast_result <- forecast_timeseries(symbol, start, end)

# Display the forecast values
print(forecast_result)