# Load the required libraries
library(quantmod)
library(smooth)

# Define your stock symbol and date range
symbol <- "NVDA"  # Change this to your desired stock symbol
start <- "2020-01-01"
end <- "2023-10-11"

# Download stock data
getSymbols(symbol, from = start, to = end)

# Extract the stock price data
stock_data <- Ad(get(symbol))

sma(stock_data, h=18, silent=FALSE)

