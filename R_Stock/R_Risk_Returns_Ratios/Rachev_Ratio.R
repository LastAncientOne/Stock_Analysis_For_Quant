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

# Calculate the Rachev Ratio
rachev_ratio <- RachevRatio(returns, rf = 0)

# Print the Rachev Ratio
print(symbol)
print(rachev_ratio)
cat(symbol, ': ', rachev_ratio)


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

# Calculate the Rachev Ratio for each stock
rachev_ratios <- data.frame()
for (ticker in tickers) {
  rachev_ratio <- RachevRatio(returns[[ticker]])
  rachev_ratios <- rbind(rachev_ratios, data.frame(Symbol = ticker, Rachev_Ratio = rachev_ratio))
}

# Print the table of Rachev Ratio
print(rachev_ratios)
