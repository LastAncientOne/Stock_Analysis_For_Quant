# Load the required library
library(quantmod)

# Individual symbol
# Set the start and end date of the analysis
symbol <- "AAPL"

risk_free_rate <- 0.001

# Dates
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Calculate the daily returns
returns <- dailyReturn(Cl(get(symbol)))

# Calculate the excess returns
excess_returns <- returns - risk_free_rate/252

# Calculate the geometric excess return
geometric_excess_return <- prod(1 + excess_returns)^(252/length(excess_returns)) - 1

# Print the result
cat("Geometric Excess Return", symbol, ":", geometric_excess_return, "\n")


# Multiple Stock symbols
# Define the stock symbols of the library
tickers <- c("BAC", "GS", "C", "WFC", "JPM")

# Get the stock data
getSymbols(tickers, from = start_date, to = end_date)

# Calculate the daily returns for each stock
returns <- list()
for (ticker in tickers) {
  returns[[ticker]] <- dailyReturn(Cl(get(ticker)))
}

# Calculate the excess returns over the risk-free rate
excess_returns <- lapply(returns, function(returns_ticker) {
  returns_ticker - risk_free_rate
})

# Calculate the geometric mean of excess returns
geometric_excess_returns <- sapply(excess_returns, function(excess_returns_ticker) {
  exp(mean(log(1 + excess_returns_ticker))) - 1
})

# Print the results
for (i in seq_along(tickers)) {
  cat("Geometric Excess Return for", tickers[i], ":", geometric_excess_returns[i], "\n")
}