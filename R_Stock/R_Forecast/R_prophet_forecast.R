library(quantmod)
library(prophet)

# Define your stock symbol and date range
symbol <- "NVDA"  # Change this to your desired stock symbol
start <- "2020-01-01"
end <- "2023-10-01"

# Download stock data
stock_data <- getSymbols(symbol, from = start, to = end, auto.assign = FALSE)

# Extract the closing prices from the stock data
closing_prices <- Cl(stock_data)

# Create a data frame with 'ds' (date) and 'y' (closing prices)
df <- data.frame(ds = index(closing_prices), y = coredata(closing_prices))

# Rename the columns to match the required format
colnames(df) <- c("ds", "y")

# Fit the prophet model
prophet_model <- prophet(df)

# Create a data frame with future dates
future <- make_future_dataframe(prophet_model, periods = 365)  # 1 year into the future

# Predict using the fitted model
forecast <- predict(prophet_model, future)

# Plot the forecast
plot(prophet_model, forecast)