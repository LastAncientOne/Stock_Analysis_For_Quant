# Load necessary libraries
library(tidyquant)
library(prophet)

# Uncertainty in seasonality
# Define your stock symbol and date range
symbol <- "NVDA"  # Change this to your desired stock symbol
start <- as.Date("2020-01-01")
end <- as.Date("2024-01-01")

# Create a tibble with closing prices
stock_data <- tq_get(symbol, from = start, to = end, get = "stock.prices")

# Rename columns to meet Prophet's requirements
stock_data <- stock_data %>%
  rename(ds = date, y = adjusted)

# Fit Prophet model
prophet_model <- prophet(data = stock_data, mcmc.samples = 300)
prophet_model <- fit.prophet(prophet_model, stock_data) # Fit the model with the data

# Define future dates for prediction
future <- make_future_dataframe(prophet_model, periods = 365)  # Forecasting for 1 year beyond the observed data

# Make predictions
forecast <- predict(prophet_model, future)

# Plot the forecast with uncertainty trends
prophet_plot_components(prophet_model, forecast)