library(quantmod)
library(prophet)

# Stock symbol and date range
stock_symbol <- "NVDA"
start_date <- "2020-01-01"
end_date <- "2023-10-11"

# Get stock data
getSymbols(stock_symbol, from = start_date, to = end_date)

# Extract and preprocess the data
stock_data <- Cl(get(stock_symbol))  # Use closing prices
stock_df <- data.frame(ds = index(stock_data), y = stock_data$NVDA.Adjusted)

# Rename the columns for compatibility with Prophet
colnames(stock_df) <- c("ds", "y")

# Create and train the Prophet model
model <- prophet()
model <- add_daily_seasonality(model)
model <- fit.prophet(model, stock_df)

# Make future predictions
future <- make_future_dataframe(model, periods = 365)  # 1 year of future data
forecast <- predict(model, future)

# Plot the forecast
plot(model, forecast)

# Access the forecasted values
forecast_data <- forecast[, c("ds", "yhat", "yhat_lower", "yhat_upper")]
print(forecast_data)