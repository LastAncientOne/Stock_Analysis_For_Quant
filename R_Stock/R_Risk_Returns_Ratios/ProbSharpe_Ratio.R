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

# Calculate the Probabilistic Sharpe Ratio
psr_ratio <- ProbSharpeRatio(returns, Rf = 0, refSR = 0)

# Print the Probabilistic Sharpe Ratio
print(symbol)
print(psr_ratio)
#cat(symbol, ': ', psr_ratio)


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

# Calculate the Probabilistic Sharpe Ratio for each stock
psr_ratios <- data.frame()
for (ticker in tickers) {
  psr_ratio <- ProbSharpeRatio(returns[[ticker]], refSR = 0)
  psr_ratios <- rbind(psr_ratios, data.frame(Symbol = ticker, PSR_Ratio = psr_ratio))
}

# Print the table of Probabilistic Sharpe Ratios
print(psr_ratios)