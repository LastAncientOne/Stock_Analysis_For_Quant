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

# Calculate the Adjusted Sharpe Ratio
adjustedsharpe_ratio <- AdjustedSharpeRatio(returns, Rf = 0)

# Print the Adjusted Sharpe Ratio
print(symbol)
print(adjustedsharpe_ratio)
cat(symbol, ': ', adjustedsharpe_ratio)


# Multiple Stock symbols
# Define the stock symbols of the library
tickers <- c("BAC", "GS", "C", "WFC", "JPM")

# Dates
start_date <- as.Date("2020-01-01")
end_date <- Sys.Date()

# Get the stock data
getSymbols(tickers , from = start_date, to = end_date)

# Calculate the daily returns for each stock
returns <- list()
for (ticker in tickers) {
  returns[[ticker]] <- dailyReturn(Cl(get(ticker)))
}

# Calculate the Adjusted Sharpe Ratio for each stock
adjustedsharpe_ratios <- data.frame()
for (ticker in tickers) {
  adjustedsharpe_ratio <- AdjustedSharpeRatio(returns[[ticker]], Rf = 0)
  adjustedsharpe_ratios <- rbind(adjustedsharpe_ratios, data.frame(Symbol = ticker, AdjustedSharpe_Ratio = adjustedsharpe_ratio))
}

# Print the table of Adjusted Sharpe Ratio
print(adjustedsharpe_ratios)
