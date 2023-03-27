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

# Calculate the Omega Sharpe Ratio
omegasharpe_ratio <- OmegaSharpeRatio(returns)

# Print the Omega Sharpe Ratio
print(symbol)
print(omegasharpe_ratio)
cat(symbol, ': ', omegasharpe_ratio)


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

# Calculate the Omega Sharpe Ratio for each stock
omegasharpe_ratios <- data.frame()
for (ticker in tickers) {
  omegasharpe_ratio <- OmegaSharpeRatio(returns[[ticker]])
  omegasharpe_ratios <- rbind(omegasharpe_ratios, data.frame(Symbol = ticker, OmegaSharpe_Ratio = omegasharpe_ratio))
}

# Print the table of Omega Sharpe Ratio
print(omegasharpe_ratios)
