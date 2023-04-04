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

# Calculate the Timing Ratio
timing_ratio <- TimingRatio(returns, Rb, rf=0)

# Print the Timing Ratio
print(symbol)
print(c(symbol, timing_ratio))
cat(symbol, ': ', timing_ratio)

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
  returns[[ticker ]] <- dailyReturn(Cl(get(ticker)))
}

# Calculate the Timing Ratio for each stock
timing_ratios <- data.frame()
for (ticker in tickers) {
  timing_ratio <- TimingRatio(returns[[ticker]], Rb)
  timing_ratios <- rbind(timing_ratios, data.frame(Symbol = ticker, Timing_ratio = timing_ratio))
}

# Print the table of Timing Ratios
print(timing_ratios)
