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

# Calculate the Martin Ratio
martin_ratio <- MartinRatio(returns, r=0)

# Print the Martin Ratio
print(symbol)
print(martin_ratio)
cat(symbol, ': ', martin_ratio)


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

# Calculate the Martin Ratio for each stock
martin_ratios <- data.frame()
for (ticker in tickers) {
  martin_ratio <- MartinRatio(returns[[ticker]], r=0)
  martin_ratios <- rbind(martin_ratios, data.frame(Symbol = ticker, Martin_Ratio = martin_ratio))
}

# Print the table of Martin Ratio
print(martin_ratios)
