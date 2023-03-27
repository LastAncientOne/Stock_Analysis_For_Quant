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

# Calculate the Sortino Ratio
sortino_ratio <- SortinoRatio(returns, Rf = 0)

# Print the Sortino Ratio
print(symbol)
print(sortino_ratio)
cat(symbol, ': ', sortino_ratio)


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

# Calculate the Sortino Ratio for each stock
sortino_ratios <- data.frame()
for (ticker in tickers) {
  sortino_ratio <- SortinoRatio(returns[[ticker]], Rf = 0.01)
  sortino_ratios <- rbind(sortino_ratios, data.frame(Symbol = ticker, Sortino_Ratio = sortino_ratio))
}

# Print the table of Sortino Ratios
print(sortino_ratios)
