# Load the required library
library(quantmod)

# Individual symbol
# Set the start and end date of the analysis
symbol <- "AAPL"
start_date <- as.Date("2018-01-01")
end_date <- Sys.Date()

# Get Data
getSymbols(symbol, src = "yahoo", from = start_date, to = end_date)

# Calculate the daily returns
returns <- dailyReturn(Cl(get(symbol)))

# Calculate win rate
positive_returns <- returns[returns > 0]
total_trades <- length(returns)
positive_trades <- length(positive_returns)
win_rate <- (positive_trades / total_trades) * 100

# Display the win rate
print(symbol)
print(win_rate)
cat(symbol, ': ', win_rate)
cat("Win Rate:", win_rate, "%\n")

# Multiple Stock symbols
# Define the stock symbols of the library
tickers <- c("BAC", "GS", "C", "WFC", "JPM")

# Dates
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Get the stock data
getSymbols(tickers, from = start_date, to = end_date)

# Calculate the daily returns for each stock
returns <- list()
for (ticker in tickers) {
  returns[[ticker]] <- dailyReturn(Cl(get(ticker)))
}

# Calculate win rate for each stock
win_rates <- numeric(length(tickers))
for (i in 1:length(tickers)) {
  positive_returns <- returns[[tickers[i]]][returns[[tickers[i]]] > 0]
  win_rates[i] <- length(positive_returns) / length(returns[[tickers[i]]]) * 100
}

# Create a data frame to display the results
result_df <- data.frame(Ticker = tickers, WinRate = win_rates)

print(result_df)
