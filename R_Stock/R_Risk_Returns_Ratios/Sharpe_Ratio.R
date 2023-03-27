# Load the required library
library(quantmod)
library(PerformanceAnalytics)

# Individual symbol
# Set the start and end date of the analysis
symbol <- "AAPL"
start_date <- as.Date("2018-01-01")
end_date <- Sys.Date()

# Get Data
getSymbols(symbol, src = "yahoo", from = start_date, to = end_date)

# Calculate the daily returns
returns <- dailyReturn(Cl(get(symbol)))

# Calculate the Sharpe Ratio
sharpe_ratio <- SharpeRatio(returns, Rf = 0, FUN = "StdDev")

# Print the Sharpe Ratio
print(symbol)
print(sharpe_ratio)
cat(symbol, ': ', sharpe_ratio)


# Multiple Stock symbols
# Define the stock symbols of the library
tickers <- c("BAC", "GS", "C", "WFC", "JPM")

# Dates
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Calculate the daily returns for each stock
returns <- list()
for (ticker in tickers) {
  returns[[ticker]] <- dailyReturn(Cl(get(ticker)))
}

# Calculate the Sharpe Ratio for each stock
sharpe_ratios <- data.frame()
for (ticker in tickers) {
  sharpe_ratio <- mean(returns[[ticker]]) / sd(returns[[ticker]])
  sharpe_ratios <- rbind(sharpe_ratios, data.frame(Symbol = ticker, Sharpe_Ratio = sharpe_ratio))
}

# Print the table of Sharpe Ratios
print(sharpe_ratios)
