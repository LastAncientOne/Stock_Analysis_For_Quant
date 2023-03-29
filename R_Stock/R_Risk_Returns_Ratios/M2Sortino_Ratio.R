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

# Calculate the M2 Sortino Ratio
m2sortino_ratio <- M2Sortino(returns, Rb, MAR = 0)

# Print the M2 Sortino Ratio
print(symbol)
print(m2sortino_ratio)
cat(symbol, ': ', m2sortino_ratio)


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

# Calculate the M2 Sortino for each stock
m2sortino_ratios <- data.frame()
for (ticker in tickers) {
  m2sortino_ratio <- M2Sortino(returns[[ticker]], Rb, MAR=0)
  m2sortino_ratios <- rbind(m2sortino_ratios, data.frame(Symbol = ticker, M2Sortino_ratio = m2sortino_ratio))
}

# Print the table of M2 Sortino
print(m2sortino_ratios)
