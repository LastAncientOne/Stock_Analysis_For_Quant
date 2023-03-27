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

# Calculate the Pain Ratio
pain_ratio <- PainRatio(returns, Rf = 0)

# Print the Pain Ratio
print(symbol)
print(pain_ratio)
cat(symbol, ': ', pain_ratio)


# Multiple Stocks
# Define a vector of stock tickers
tickers <- c("BAC", "GS", "C", "WFC", "JPM")

# Dates
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Get the stock data
getSymbols(tickers , from = start_date, to = end_date)

# Calculate the daily returns for each stock
returns <- list()
for (ticker in tickers) {
  returns[[ticker ]] <- dailyReturn(Cl(get(ticker )))
}

# Calculate the Pain Ratio for each stock
pain_ratios <- data.frame()
for (ticker in tickers) {
  pain_ratio <- PainRatio(returns[[ticker]], Rf = 0.01)
  pain_ratios <- rbind(pain_ratios, data.frame(Symbol = ticker, Pain_ratio = pain_ratio))
}

# Print the table of Pain Ratios
print(pain_ratios)
