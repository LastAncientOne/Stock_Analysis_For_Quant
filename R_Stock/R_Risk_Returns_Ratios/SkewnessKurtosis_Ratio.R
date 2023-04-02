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

# Calculate the SkewnessKurtosis Ratio
SkewnessKurtosis_ratio <- SkewnessKurtosisRatio(returns, MAR=0)

# Print the SkewnessKurtosis Ratio
print(symbol)
print(SkewnessKurtosis_ratio)
cat(symbol, ': ', SkewnessKurtosis_ratio)


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

# Calculate the SkewnessKurtosis Ratio for each stock
SkewnessKurtosis_ratios <- data.frame()
for (ticker in tickers) {
  SkewnessKurtosis_ratio <- SkewnessKurtosisRatio(returns[[ticker]], MAR=0)
  SkewnessKurtosis_ratios <- rbind(SkewnessKurtosis_ratios, data.frame(Symbol = ticker, SkewnessKurtosis_Ratio = SkewnessKurtosis_ratio))
}

# Print the table of SkewnessKurtosis Ratios
print(SkewnessKurtosis_ratios)