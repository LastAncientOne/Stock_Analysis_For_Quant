# Load necessary libraries
library(tidyquant)
library(prophet)
library(dplyr)  # Add this line to load the dplyr package

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
prophet_model <- prophet(data = stock_data)

# Specify uncertainty in the trend
uncertainty_interval <- 0.95  # Set the uncertainty interval width to 95%
prophet_model$uncertainty <- TRUE
prophet_model$interval_width <- uncertainty_interval

# Fit the model
fitted_prophet_model <- fit.prophet(prophet_model, stock_data)

# Make future predictions
future <- make_future_dataframe(fitted_prophet_model, periods = 365) 

# Forecast
forecast <- predict(fitted_prophet_model, future)

# Plot the forecast with uncertainty intervals
prophet_plot_components(fitted_prophet_model, forecast)

