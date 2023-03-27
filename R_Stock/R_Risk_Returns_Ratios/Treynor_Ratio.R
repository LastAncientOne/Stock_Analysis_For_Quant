library(quantmod)
library(PerformanceAnalytics)

# Individual symbol
# Set the start and end date of the analysis
symbol <- "AAPL"
start_date <- as.Date("2018-01-01")
end_date <- Sys.Date()

# Get Data
getSymbols(symbol, src = "yahoo", from = start_date, to = end_date)

# Get the Benchmark data
benchmark <- getSymbols("SPY", from = start_date, to = end_date)
Rb <- dailyReturn(Cl(get(benchmark)))

# Calculate the daily returns
returns <- dailyReturn(Cl(get(symbol)))

# Calculate the Treynor Ratio
treynor_ratio <- TreynorRatio(returns, Rb, Rf = 0.01)

# Print the Treynor Ratio
print(symbol)
print(treynor_ratio)
cat(symbol, ': ', treynor_ratio)


# Define a vector of stock tickers
tickers <- c("BAC", "GS", "C", "WFC", "JPM")

# Dates
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Get the stock data
getSymbols(tickers , from = start_date, to = end_date)

# Get the Benchmark data
benchmark <- getSymbols("SPY", from = start_date, to = end_date)
Rb <- dailyReturn(Cl(get(benchmark)))

# Calculate the daily returns for each stock
returns <- list()
for (ticker in tickers) {
  returns[[ticker ]] <- dailyReturn(Cl(get(ticker )))
}

# Calculate the Treynor Ratio for each stock
treynor_ratios <- data.frame()
for (ticker in tickers) {
  treynor_ratio <- TreynorRatio(returns[[ticker]], Rb, Rf = 0.01)
  treynor_ratios <- rbind(treynor_ratios, data.frame(Symbol = ticker, Treynor_ratio = treynor_ratio))
}

# Print the table of Treynor Ratios
print(treynor_ratios)
