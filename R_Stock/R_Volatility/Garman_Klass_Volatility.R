# Load the required library
library(quantmod)

# Individual symbol
symbol <- "AAPL"

# Set the start and end date of the analysis
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Get the historical data
getSymbols(symbol, from = start_date, to = end_date)
data <- get(symbol)

# Calculate the Garman Klass volatility

# Calculate the daily high-low range
high_low_range <- data$AAPL.High - data$AAPL.Low

# Calculate the previous day's close to today's open range
prev_close_open_range <- c(NA, data$AAPL.Open[-1] - lag(data$AAPL.Close, default = data$AAPL.Close[1:(length(data$AAPL.Close)-1)]))

# Calculate the volatility
gk_volatility <- sqrt(0.5 * log(data$AAPL.High/data$AAPL.Low)^2 - (2 * log(2) - 1) * log(data$AAPL.Close/data$AAPL.Open)^2)

# Print the Garman Klass volatility
print(gk_volatility)

