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

# Calculate the UlcerIndex
UlcerIndex_ratio <- UlcerIndex(returns)

# Print the SUlcerIndex
print(symbol)
print(UlcerIndex_ratio)
cat(symbol, ': ', UlcerIndex_ratio)


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

# Calculate the UlcerIndex for each stock
UlcerIndex_ratios <- data.frame()
for (ticker in tickers) {
  UlcerIndex_ratio <- UlcerIndex(returns[[ticker]])
  UlcerIndex_ratios <- rbind(UlcerIndex_ratios, data.frame(Symbol = ticker, UlcerIndex = UlcerIndex_ratio))
}

# Print the table of UlcerIndex
print(UlcerIndex_ratios)